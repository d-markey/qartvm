# Multi-Measurement Branching Spec

## Objective

The goal is to support a single OpenQASM interpreter execution that can yield multiple interpreter results when a measurement occurs during execution.

The desired behavior is:

- a single call to `execute()` may produce multiple final execution states
- each measurement causes execution to branch into one or more forked `StateContext` instances
- the interpreter returns one `InterpreterResult` per branch
- the number of expected measurements is supplied to the interpreter
- if no value is supplied, the default remains `1`, which preserves the current single-result behavior

This is the semantics we want to support:

- `execute(program, expectedMeasurements: 1)` behaves like the current implementation
- `execute(program, expectedMeasurements: N)` means: whenever the interpreter reaches a measurement gate, it performs `N` sequential measurements in a row, creating the necessary forked execution contexts for each branch, and then continues executing the remainder of the algorithm for each of those new execution contexts
- if there are `N` measurement gates in the program, this yields `2^N` execution contexts / interpreter results in the fully branched case
- the final result set represents all possible post-measurement branches produced by the execution

## Current state

We have implemented `StateContext.fork()` as the first primitive needed for branch execution.

The `fork()` method creates a deep copy of the execution context so that a measurement branch can continue independently from the original context without mutating the source state.

This is the key building block for the multi-measure model because measurement is inherently branch-producing in quantum execution.

## Important architectural finding

The current `StateContext` is best understood as a branch-local state container, not as the full interpreter runtime.

It stores:

- quantum memory
- symbol table and variable values
- runtime variables
- measurement history
- scope state

By contrast, the interpreter machinery in `OpenQASMInterpreter` is composed of derived runtime objects:

- `_evaluator`
- `_gateMapper`
- `_qbitResolver`

These are not standalone branch state; they are execution helpers that are created from and depend on the active execution context. As such, they must be rebuilt for each forked branch, or else different branches will share mutable execution state.

This has two important implications:

1. `StateContext` should be treated as the mutable branch state object.
2. The evaluator, gate mapper, and qubit resolver should be treated as branch-local execution machinery and recreated per branch.

### Note on program scanning

The `ProgramScanner` pre-scan computes the total number of qubits required by the program. This is a **static analysis** of the program structure and does not depend on runtime state or measurement outcomes. Therefore:

- A single scan at the beginning of `execute()` is sufficient for the entire execution, including all branches.
- Forked contexts share the same quantum memory size (computed once by the scanner).
- Measurement-driven branching does not require re-scanning or recomputing qubit requirements.
- Each forked context operates on the same pre-allocated `QMemorySpace` instance (or its deep copy via `fork()`).


## Why branching belongs in the interpreter

The measurement model is not a simple value readout in a single state vector. A measurement is a branch point in the execution tree:

- one execution context represents one world/state realization
- a measurement creates multiple possible futures
- each future must continue independently with its own classical state and quantum memory

The interpreter owns the branching control flow: it decides when a measurement creates new execution branches, and it continues each branch independently with its own state snapshot.

`QMemorySpace` remains the runtime state for one branch; the interpreter coordinates the branch lifecycle around that state.

## Design approach

### 1. Single execution, multiple results

The interpreter should return a list of results as the canonical contract:

- `Future<List<InterpreterResult>>` for all execution modes

The single-measure case becomes a list with one element, which preserves the current semantics without requiring a separate single-result code path.

A practical model is:

- add an optional parameter like `expectedMeasurements` or `maxMeasurements`
- when the value is `1`, the interpreter executes a single branch and returns a one-item list
- when the value is greater than `1`, the interpreter creates and evaluates forks

### 2. Branch state vs execution engine

The system should be split conceptually into:

- a branch state object: `StateContext`
- a branch-bound execution engine: evaluator + gate mapper + qubit resolver + scan helpers

Each branch should be represented by an independent state instance.

A branch must carry:

- quantum memory state
- symbol/classical variables
- measurements already recorded
- runtime variables
- any loop or scope-level state relevant to the current execution path

The execution engine should be rebuilt for each branch from that state, because it depends on the live context and cannot safely be shared across branch mutations.

`StateContext.fork()` provides the ability to clone this state so each possible measurement outcome can continue separately.

### 3. Measurement behavior

When a measurement statement is reached:

1. determine the measured qubit(s) and their current probabilities from the branch memory
2. compute the possible outcomes
3. create one forked context per possible outcome
   - Even if two branches would have identical quantum memory after measurement,
     they may have different classical state (variables, measurement history, etc.)
   - Create separate branches for each outcome without deduplication
4. assign the measured result to each forked context
5. continue executing the remainder of the program on each branch independently

This matches the intended "measure, branch, continue" semantics.

**Note**: Deduplication of branches with identical full state (quantum + classical) may occur at result aggregation time (Phase 4), but NOT during execution. Eliminating branches too early risks losing execution paths that may diverge later due to classical state differences, future measurements, or conditional control flow that depends on measurement history.

## Proposed public API

The following shape is the intended direction and is the canonical API:

```dart
Future<List<InterpreterResult>> execute(
  Program program, {
  StateContext? stateContext,
  Map<String, dynamic>? initialVariables,
  int expectedMeasurements = 1,
});
```

Behavior:

- `expectedMeasurements == 1` executes a single branch and returns a list containing one `InterpreterResult`
- `expectedMeasurements > 1` means the interpreter branches at measurement sites and collects the resulting execution futures for each forked branch
- the interpreter continues executing the remainder of the program for each new branch independently

No separate compatibility wrapper is required; the list-returning form is the new contract.

## Implementation roadmap

### Phase 1: branch-ready interpreter primitives

- [x] **change the signature of `execute()` to return `Future<List<InterpreterResult>>`**; when `expectedMeasurements == 1`, wrap the single result as `[result]`
- [x] confirm `StateContext.fork()` deep-copies the needed state
- [ ] add a branch queue or worklist to the interpreter
- [ ] define a data structure for active execution contexts
- [ ] extract or isolate branch-local execution engine state (`_evaluator`, `_gateMapper`, `_qbitResolver`) so it can be recreated per fork

### Phase 2: measurement branching

- [ ] modify measurement execution so it does not simply mutate one context
- [ ] on measurement, fork the current context into outcome-specific contexts
- [ ] rebuild execution machinery for each forked context
- [ ] keep only the chosen measurement result in each branch
- [ ] continue remaining statements for each branch independently

### Phase 3: control-flow correctness

- [ ] verify loops and conditions behave correctly across forks
- [ ] ensure scope and classical variables do not leak across branches
- [ ] make sure measurement history is branch-local rather than global

### Phase 4: result aggregation and limits

- [ ] collect final `InterpreterResult` objects from every live branch
- [ ] support “expected measurements” as a stopping/validation target
- [ ] protect against exponential branch explosion with `maxBranches` / guardrail logic if needed

### Phase 5: regression tests

- [ ] one measurement remains single-result behavior
- [ ] multiple measurement outcomes produce multiple result branches
- [ ] same QASM program with forked execution yields expected measurement combinations
- [ ] control flow inside branches remains correct

## Notes and constraints

- The current implementation still uses a single `StateContext` and a single final `InterpreterResult` as the default model, but this is replaced by the list-based branch model in the multi-measure implementation.
- The number of measurements is supplied by the caller to the interpreter.
- `StateContext.fork()` is the implemented primitive that enables multi-measure branching.
- The interpreter defaults to `expectedMeasurements = 1`, which yields a one-item list rather than a separate compatibility path.
- The evaluator, gate mapper, and qubit resolver should not be treated as global interpreter state; they must be branch-local.

## Summary

This feature is implemented as a branch-execution model in the interpreter. The required root primitive is already in place with `StateContext.fork()`, and the remaining work is to separate branch state from branch-local execution machinery, then wire actual measurement-driven branching into `execute()` and aggregate the resulting branch states into a `List<InterpreterResult>`.
