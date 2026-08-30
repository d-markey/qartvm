# Plan d'abstraction et d'optimisation des matrices complexes

## 1. Objectif

Introduire une abstraction `ComplexMatrix` permettant d'utiliser plusieurs représentations internes tout en conservant l'API actuelle de qartvm.

Les représentations sont les suivantes :

```text
ComplexMatrix        abstraction publique
ComplexDenseMatrix   implémentation dense actuelle
ComplexSparseMatrix  implémentation creuse
ComplexVector        vecteur dense dérivé de ComplexDenseMatrix
```

La politique de représentation est portée par `QGateBuilder` et propagée à ses sous-builders. Les matrices produites par un builder respectent son `matrixType`.

La priorité de performance est l'application des portes quantiques, en particulier la multiplication matrice-vecteur. Les résultats numériques et les comportements mutables de l'API actuelle sont conservés.

## 2. État actuel

### 2.1 `ComplexMatrix`

`lib/src/math/complex_matrix.dart` contient actuellement :

- les constructeurs et la validation des dimensions ;
- le stockage dense via `ComplexArray` ;
- les opérations scalaires et matricielles ;
- le produit tensoriel ;
- l'égalité et la comparaison avec précision ;
- la transposition et la conjugaison ;
- le déterminant et l'inversion par élimination de Gauss ;
- la sérialisation et la désérialisation.

L'implémentation dense accède directement à `_values`, ce qui lie les algorithmes au stockage `ComplexArray`.

### 2.2 Consommateurs

Les principaux consommateurs utilisent déjà `ComplexMatrix` comme type :

- `lib/src/qgate_builder.dart` construit les matrices de portes et les met en cache ;
- `lib/src/qcircuit.dart` compose les portes ;
- `lib/src/qcircuit_gate.dart` clone les matrices des portes ;
- `lib/src/qmemory_space.dart` applique une matrice à l'état quantique ;
- `lib/src/math/complex_vector.dart` dérive actuellement de `ComplexMatrix` ;
- les tests, exemples et services Squadron échangent des `ComplexMatrix`.

Cette utilisation par abstraction limite les changements requis dans le code applicatif.

### 2.3 `ComplexVector`

`ComplexVector` dérivera de `ComplexDenseMatrix` :

```dart
class ComplexVector extends ComplexDenseMatrix {
  // constructeurs de vecteur
}
```

Le vecteur conserve ainsi son stockage dense et ses constructeurs actuels, indépendamment du `matrixType` des builders.

## 3. Architecture cible

### 3.1 Contrat public

`ComplexMatrix` devient une classe abstraite qui expose le contrat commun :

- `rows`, `columns`, `square` ;
- `get(row, column)` et les mutations nécessaires ;
- `clone`, `copy`, `copyFrom`, `copyTo` ;
- `add`, `sub`, `neg`, `mul`, `div` ;
- `det`, `inverse`, `transpose`, `dagger`, `conjugate` ;
- `equals`, `hashCode`, `toStringIndent`, `serialize` ;
- les opérateurs `+`, `-`, `*`, `/`.

Les factories publiques de `ComplexMatrix` conservent les appels existants et délèguent vers une implémentation concrète adaptée au contexte de construction.

### 3.2 Sélection d'implémentation

La sélection est définie par un enum porté par `QGateBuilder` :

```dart
enum ComplexMatrixType { dense, sparse }

class QGateBuilder {
  QGateBuilder(this.size, {this.matrixType = ComplexMatrixType.dense});

  final int size;
  final ComplexMatrixType matrixType;
}
```

`ParallelGateBuilder`, `ControlledGateBuilder` et `HighLevelGateBuilder` reçoivent la même valeur. Toutes les matrices créées par ces builders utilisent `ComplexDenseMatrix` ou `ComplexSparseMatrix` selon cette valeur.

La clé de cache de `QGateBuilder.get` inclut `matrixType`. Deux builders de même taille et de même politique de cache, mais de représentations différentes, ne partagent jamais leurs matrices.

Cette conception ne dépend d'aucun état global et permet d'utiliser plusieurs représentations dans un même isolate. Elle fonctionne de la même manière dans les workers Web et VM.

### 3.3 Matrice dense

Le contenu actuel devient `ComplexDenseMatrix`. `ComplexArray` est conservé comme stockage dense optimisé par `Float64x2List`.

`ComplexVector` hérite de cette classe afin de conserver ses constructeurs génératifs et son comportement actuel.

### 3.4 Matrice creuse

`ComplexSparseMatrix` utilise un stockage CSR/CRS :

```text
rowOffsets    longueur rows + 1
columnIndices longueur du nombre de valeurs non nulles
values        longueur du nombre de valeurs non nulles
```

Invariant : une valeur nulle n'est jamais conservée dans `values`.

Le stockage permet :

- la lecture rapide d'une ligne ;
- l'insertion, le remplacement et la suppression d'une valeur ;
- le parcours des seules valeurs non nulles ;
- la construction efficace des matrices zéro et identité ;
- la conversion temporaire en dense pour les algorithmes qui l'exigent.

## 4. Compatibilité de l'API

### 4.1 Constructeurs

Les appels suivants restent valides :

```dart
ComplexMatrix(values)
ComplexMatrix.generate(rows, columns, generator)
ComplexMatrix.zero(rows, columns)
ComplexMatrix.filled(rows, columns, value)
ComplexMatrix.identity(rows)
```

Les validations actuelles sont conservées : dimensions non nulles et lignes de taille uniforme.

### 4.2 Opérations mutables

Les méthodes `add`, `sub`, `neg`, `mul` et `div` mutent l'objet courant et le retournent. Ce comportement, notamment `identical(a, a.add(b))`, reste garanti.

Chaque implémentation supprime les valeurs devenues nulles. Les résultats d'une opération conservent la représentation du receveur, sauf lorsqu'une conversion dense est explicitement requise par un algorithme.

### 4.3 Opérations statiques et builders

`ComplexMatrix.tensor(a, b)` reste compatible avec l'API publique. Les constructions internes qui doivent respecter une représentation utilisent les opérations contextualisées du builder, notamment `builder.tensor(a, b)`, `builder.identity(size)` et les factories internes associées.

Le produit tensoriel creux ne parcourt que les valeurs non nulles de ses opérandes.

### 4.4 Égalité et précision

`equals` compare les dimensions et les valeurs logiques, sans dépendre du stockage. Une matrice dense et une matrice creuse mathématiquement identiques sont donc égales avec la précision demandée.

`operator ==` conserve sa sémantique exacte actuelle. Les tests tolérants utilisent `equals`.

### 4.5 Sérialisation

La sérialisation adopte un format versionné contenant un discriminant de représentation. Ce discriminant permet de désérialiser une matrice dans son implémentation d'origine, indépendamment du `matrixType` du builder local ou du worker.

Les fichiers Squadron générés ne sont pas modifiés manuellement. Ils sont régénérés, puis le marshaling de `ComplexMatrix` est testé avec les représentations dense et creuse.

## 5. Stratégie d'implémentation par phases

### Phase 0 - Référence

- Exécuter `dart test` avant toute modification.
- Exécuter `dart analyze`.
- Mesurer les benchmarks existants dans `test/benchmark.dart` avant les
  modifications. Cette mesure n'est plus disponible après le refactor.
- Documenter le comportement actuel de la sérialisation et de `ComplexVector`.

**Livrable :** référence de correction et d'analyse; aucune baseline de
performance avant refactor ne sera disponible.

### Phase 1 - Extraction de l'implémentation dense

- Renommer l'implémentation actuelle en `ComplexDenseMatrix`.
- Mettre à jour les références internes nécessaires.
- Faire dériver `ComplexVector` de `ComplexDenseMatrix`.
- Conserver les signatures publiques et les résultats existants.
- Ne pas exécuter la validation globale à cette étape : les consommateurs utilisent encore le symbole `ComplexMatrix`, qui est temporairement absent pendant le renommage.

**Validation :** vérifier localement les renommages et les constructeurs de `ComplexDenseMatrix`. La compilation et les tests reprennent après la phase 2.

### Phase 2 - Introduction de l'abstraction

- Déclarer le contrat abstrait `ComplexMatrix`.
- Ajouter les factories de façade.
- Ajouter `ComplexMatrixType` et le paramètre `matrixType` de `QGateBuilder`.
- Propager `matrixType` aux trois sous-builders.
- Inclure `matrixType` dans la clé du cache.
- Adapter `tensor`, `deserialize` et les signatures dépendant de l'ancien stockage privé.
- Rétablir le symbole public `ComplexMatrix` et toutes les références des consommateurs.

**Validation :** exécuter `dart analyze`, puis `dart test`. Ajouter ensuite les tests vérifiant le type concret produit par chaque builder.

### Phase 3 - Matrice creuse minimale

- Ajouter `ComplexSparseMatrix`.
- Implémenter les constructeurs, `get`, `set`, `clone`, `copy`, `equals` et la sérialisation.
- Implémenter zéro et identité sans allocation dense.
- Implémenter les opérations scalaires, la conjugaison et la transposition.
- Exposer un indicateur interne du nombre de valeurs non nulles pour les tests et benchmarks.

**Validation :** tests de parité dense/creuse sur de petites matrices, avec valeurs complexes et annulations.

### Phase 4 - Opérations creuses critiques

Implémenter les chemins optimisés suivants :

1. multiplication creuse par vecteur ;
2. multiplication creuse par matrice ;
3. addition et soustraction par fusion de lignes CSR ;
4. produit tensoriel creux ;
5. `mul` in-place via un résultat temporaire compatible.

Pour la multiplication matrice-vecteur :

```text
pour chaque ligne r :
    résultat[r] = somme(values[k] * vecteur[columnIndices[k]])
```

La complexité cible est proportionnelle au nombre de valeurs non nulles, et non à `rows * columns`.

### Phase 5 - Intégration dans la simulation

- Modifier `ComplexVector.transform` ou le chemin appelé par `QMemorySpace.applyGate` pour exploiter la multiplication matrice-vecteur de l'implémentation.
- Éviter toute matrice dense intermédiaire pour une porte creuse.
- Vérifier les portes simples, contrôlées, SWAP, Toffoli, QFT et les circuits compilés.
- Vérifier les états de superposition et d'intrication.

**Validation :** tests de simulation et tests de parité dense/creuse sur des circuits représentatifs.

### Phase 6 - Déterminant et inverse

- Utiliser directement l'algorithme dense pour `ComplexDenseMatrix`.
- Convertir temporairement `ComplexSparseMatrix` en dense pour `det` et `inverse`.
- Documenter le coût mémoire de cette conversion.
- Ajouter une élimination creuse uniquement dans une évolution ultérieure justifiée par les benchmarks.

Cette stratégie tient compte du fill-in, qui peut rendre une matrice creuse dense pendant l'élimination de Gauss.

### Phase 7 - Sérialisation, workers et documentation

- Finaliser le format versionné et son discriminant.
- Ajouter `matrixType` aux arguments de construction de `ShorBuilders`.
- Régénérer les fichiers Squadron.
- Tester les appels `ShorBuilders` en local et via worker.
- Mettre à jour `README.md`, `doc/backend.md` et `CHANGELOG.md`.
- Documenter la sélection par builder et le stockage dense de `ComplexVector`.

### Phase 8 - Benchmarks

Les benchmarks seront exécutés uniquement après l'implémentation complète et
compareront les représentations dense et creuse. Ils ne fourniront pas de
comparaison avec une version dense antérieure au refactor.

Comparer dense et creux sur plusieurs tailles et densités :

- matrices zéro et identité ;
- portes à un et deux qubits ;
- portes contrôlées ;
- QFT ;
- matrice aléatoire dense ;
- multiplication matrice-matrice ;
- multiplication matrice-vecteur ;
- application répétée d'une porte.

Les benchmarks documentent le domaine de pertinence de chaque représentation avant toute modification de la représentation par défaut.

## 6. Tests à ajouter

### Tests de contrat

- chaque builder produit l'implémentation correspondant à son `matrixType` ;
- les dimensions invalides lèvent les mêmes exceptions ;
- les opérateurs préservent leurs résultats et leur mutabilité ;
- `clone` ne partage pas le stockage mutable ;
- `copy` refuse les dimensions incompatibles.

### Tests de représentation

- une matrice zéro creuse n'enregistre aucune valeur ;
- une matrice identité creuse n'enregistre que la diagonale ;
- `set(row, column, Complex.zero)` supprime une entrée ;
- les deux représentations donnent les mêmes valeurs via `get` ;
- le nombre de valeurs non nulles est cohérent après chaque opération.

### Tests numériques

- nombres complexes avec partie imaginaire ;
- addition et soustraction avec annulation ;
- multiplication et produit tensoriel ;
- transpose, dagger et conjugate ;
- déterminant et inverse ;
- comparaison dense/creuse avec tolérance `1e-9`.

### Tests quantiques

- superposition par Hadamard ;
- état de Bell ;
- portes contrôlées ;
- SWAP, Toffoli et Fredkin ;
- QFT et inverse QFT ;
- mesures après exécution ;
- tests OpenQASM existants avec des builders dense et creux.

### Tests workers

- construction locale avec chaque `matrixType` ;
- transport d'une matrice dense et d'une matrice creuse ;
- restauration de la représentation indiquée par le discriminant ;
- appels `ShorBuilders` en VM et dans le scénario Web pris en charge par le projet.

## 7. Risques et mesures

### Accès au stockage privé

Les algorithmes communs ne doivent plus accéder à `_values`. Ils utilisent le contrat public ou un protocole interne commun aux implémentations.

### Densification des résultats

Les additions, produits tensoriels et compositions peuvent augmenter rapidement le nombre de valeurs non nulles. Le stockage CSR supprime les zéros et les benchmarks mesurent l'évolution du taux de remplissage.

### Élimination de Gauss

Le fill-in peut annuler l'avantage de CSR pendant `det` et `inverse`. La conversion temporaire en dense est donc la stratégie de la première version et son coût mémoire est documenté.

### Justification du choix par builder

Le `matrixType` appartient à chaque `QGateBuilder`, ce qui élimine la dépendance à une configuration globale et permet de sélectionner dense ou creux sans recompilation, notamment dans les applications Web. Le discriminant de sérialisation garantit en complément qu'une matrice transportée entre isolates conserve sa représentation d'origine.

## 8. Critères d'acceptation

Le travail est terminé lorsque :

- tous les appels publics actuels à `ComplexMatrix` compilent sans changement fonctionnel ;
- `ComplexVector` dérive de `ComplexDenseMatrix` et ses tests passent ;
- le mode dense produit les mêmes résultats qu'avant ;
- le mode creux passe les tests de parité numérique ;
- les matrices creuses n'allouent pas de tableau dense pour les opérations principales ;
- `QMemorySpace.applyGate` utilise effectivement un chemin matrice-vecteur creux ;
- les circuits de test et OpenQASM passent avec les deux types de builder ;
- la sérialisation fonctionne dans le processus principal et via Squadron ;
- les workers reconstruisent la représentation indiquée par le discriminant ;
- les benchmarks documentent le domaine de pertinence des deux représentations ;
- la documentation et le changelog décrivent la nouvelle architecture.

## 9. Décisions retenues

1. Utiliser les noms `ComplexMatrix`, `ComplexDenseMatrix`, `ComplexSparseMatrix` et `ComplexVector`.
2. Faire dériver `ComplexVector` de `ComplexDenseMatrix`.
3. Utiliser un enum `ComplexMatrixType` porté par `QGateBuilder`.
4. Propager `matrixType` aux trois sous-builders et l'inclure dans la clé du cache.
5. Utiliser CSR pour la matrice creuse.
6. Optimiser d'abord matrice-vecteur, produit tensoriel et multiplication.
7. Convertir temporairement en dense pour `det` et `inverse`.
8. Sérialiser un format versionné avec discriminant de représentation.
9. Transmettre `matrixType` aux builders des workers.
10. Ne pas modifier manuellement les fichiers générés Squadron.

## 10. Suivi d'implémentation

Légende des sous-étapes :

- `[ ]` à faire
- `[-]` en cours
- `[x]` fait

Légende des phases :

- `[ ]` à faire
- `[-]` en cours
- `[+]` à valider, sauf pour la phase 1
- `[!]` terminé mais non validé, reprise de l'implémentation nécessaire
- `[x]` terminé et validé

### [x] Phase 0 - Référence

- `[x]` Établir la référence de correction et d'analyse; la baseline de
  performance avant refactor est indisponible et explicitement exclue.

### [x] Phase 1 - Extraction de l'implémentation dense

- `[x]` Renommer l'implémentation actuelle en `ComplexDenseMatrix`.
- `[x]` Mettre à jour les références internes nécessaires.
- `[x]` Faire dériver `ComplexVector` de `ComplexDenseMatrix`.
- `[x]` Conserver les signatures publiques et les résultats existants.
- `[x]` Vérifier localement les renommages et les constructeurs de `ComplexDenseMatrix`.

### [x] Phase 2 - Introduction de l'abstraction

- `[x]` Déclarer le contrat abstrait `ComplexMatrix`.
- `[x]` Ajouter les factories de façade.
- `[x]` Ajouter `ComplexMatrixType` et le paramètre `matrixType` de `QGateBuilder`.
- `[x]` Propager `matrixType` aux trois sous-builders.
- `[x]` Inclure `matrixType` dans la clé du cache.
- `[x]` Rétablir le symbole public `ComplexMatrix` et les références des consommateurs.
- `[x]` Adapter `tensor`, `deserialize` et les signatures dépendant de l'ancien stockage privé.
- `[x]` Exécuter `dart analyze`.
- `[x]` Exécuter `dart test`.
- `[x]` Ajouter les tests vérifiant le type concret produit par chaque builder.

### [x] Phase 3 - Matrice creuse minimale

- `[x]` Ajouter `ComplexSparseMatrix`.
- `[x]` Implémenter les constructeurs et la validation des dimensions.
- `[x]` Implémenter le stockage CSR/CRS et l'invariant d'absence des zéros.
- `[x]` Implémenter `get`, `set`, `clone`, `copy` et `equals`.
- `[x]` Implémenter la sérialisation creuse.
- `[x]` Implémenter zéro et identité sans allocation dense.
- `[x]` Implémenter les opérations scalaires, la conjugaison et la transposition.
- `[x]` Ajouter l'indicateur interne du nombre de valeurs non nulles.
- `[x]` Exécuter les tests de parité dense/creuse sur de petites matrices.

### [x] Phase 4 - Opérations creuses critiques

- `[x]` Implémenter la multiplication creuse par vecteur.
- `[x]` Implémenter la multiplication creuse par matrice.
- `[x]` Implémenter l'addition et la soustraction par fusion de lignes CSR.
- `[x]` Implémenter le produit tensoriel creux.
- `[x]` Implémenter `mul` in-place avec un résultat temporaire compatible.
- `[x]` Vérifier la complexité en fonction du nombre de valeurs non nulles.
- `[x]` Ajouter les tests numériques des opérations creuses.

### [ ] Phase 5 - Intégration dans la simulation

- `[ ]` Adapter `ComplexVector.transform` ou `QMemorySpace.applyGate` à la multiplication matrice-vecteur creuse.
- `[ ]` Éviter les matrices denses intermédiaires pour les portes creuses.
- `[ ]` Vérifier les portes simples et contrôlées.
- `[ ]` Vérifier SWAP, Toffoli, Fredkin, QFT et les circuits compilés.
- `[ ]` Vérifier les états de superposition et d'intrication.
- `[ ]` Exécuter les tests de simulation et de parité dense/creuse.

### [!] Phase 6 - Déterminant et inverse

- `[x]` Conserver l'algorithme dense pour `ComplexDenseMatrix`.
- `[x]` Implémenter la conversion temporaire de `ComplexSparseMatrix` en dense.
- `[x]` Utiliser cette conversion pour `det` et `inverse`.
- `[x]` Vérifier les matrices inversibles et non inversibles.
- `[ ]` Documenter le coût mémoire de la conversion.

### [!] Phase 7 - Sérialisation, workers et documentation

- `[x]` Finaliser le format versionné avec discriminateur de représentation.
- `[ ]` Ajouter `matrixType` aux arguments de construction de `ShorBuilders`.
- `[ ]` Régénérer les fichiers Squadron.
- `[ ]` Tester le transport et la restauration des matrices dense et creuse.
- `[ ]` Tester `ShorBuilders` en local et via worker.
- `[ ]` Vérifier le scénario Web pris en charge par le projet.
- `[ ]` Mettre à jour `README.md`, `doc/backend.md` et `CHANGELOG.md`.

### [ ] Phase 8 - Benchmarks

- `[ ]` Mesurer la mémoire des matrices dense et creuse.
- `[ ]` Mesurer le temps de construction selon la densité.
- `[ ]` Comparer la multiplication matrice-matrice.
- `[ ]` Comparer la multiplication matrice-vecteur.
- `[ ]` Comparer l'application répétée de portes.
- `[ ]` Comparer les matrices zéro, identité, contrôlées, QFT et aléatoires denses.
- `[ ]` Documenter le domaine de pertinence des deux représentations.
