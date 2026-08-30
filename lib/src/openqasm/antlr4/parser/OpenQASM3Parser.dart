// Generated from C:\_Projects\github\qartvm\tools\antlr4\\OpenQASM3Parser.g4 by ANTLR 4.12.0
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes
import 'package:antlr4/antlr4.dart';

import 'OpenQASM3ParserListener.dart';
import 'OpenQASM3ParserBaseListener.dart';
import 'OpenQASM3ParserVisitor.dart';
import 'OpenQASM3ParserBaseVisitor.dart';

// ignore_for_file: non_constant_identifier_names, constant_identifier_names, unnecessary_new, file_names, prefer_function_declarations_over_variables, curly_braces_in_flow_control_structures

const int RULE_program = 0, RULE_version = 1, RULE_statement = 2, RULE_annotation = 3, 
          RULE_scope = 4, RULE_pragma = 5, RULE_statementOrScope = 6, RULE_calibrationGrammarStatement = 7, 
          RULE_includeStatement = 8, RULE_breakStatement = 9, RULE_continueStatement = 10, 
          RULE_endStatement = 11, RULE_forStatement = 12, RULE_ifStatement = 13, 
          RULE_returnStatement = 14, RULE_whileStatement = 15, RULE_barrierStatement = 16, 
          RULE_boxStatement = 17, RULE_delayStatement = 18, RULE_gateCallStatement = 19, 
          RULE_measureArrowAssignmentStatement = 20, RULE_resetStatement = 21, 
          RULE_aliasDeclarationStatement = 22, RULE_classicalDeclarationStatement = 23, 
          RULE_constDeclarationStatement = 24, RULE_ioDeclarationStatement = 25, 
          RULE_oldStyleDeclarationStatement = 26, RULE_quantumDeclarationStatement = 27, 
          RULE_defStatement = 28, RULE_externStatement = 29, RULE_gateStatement = 30, 
          RULE_assignmentStatement = 31, RULE_expressionStatement = 32, 
          RULE_calStatement = 33, RULE_defcalStatement = 34, RULE_expression = 35, 
          RULE_aliasExpression = 36, RULE_declarationExpression = 37, RULE_measureExpression = 38, 
          RULE_rangeExpression = 39, RULE_setExpression = 40, RULE_arrayLiteral = 41, 
          RULE_indexOperator = 42, RULE_indexedIdentifier = 43, RULE_returnSignature = 44, 
          RULE_gateModifier = 45, RULE_scalarType = 46, RULE_qubitType = 47, 
          RULE_arrayType = 48, RULE_arrayReferenceType = 49, RULE_designator = 50, 
          RULE_defcalTarget = 51, RULE_defcalArgumentDefinition = 52, RULE_defcalOperand = 53, 
          RULE_gateOperand = 54, RULE_externArgument = 55, RULE_argumentDefinition = 56, 
          RULE_argumentDefinitionList = 57, RULE_defcalArgumentDefinitionList = 58, 
          RULE_defcalOperandList = 59, RULE_expressionList = 60, RULE_identifierList = 61, 
          RULE_gateOperandList = 62, RULE_externArgumentList = 63;
class OpenQASM3Parser extends Parser {
  static final checkVersion = () => RuntimeMetaData.checkVersion('4.12.0', RuntimeMetaData.VERSION);
  static const int TOKEN_EOF = IntStream.EOF;

  static final List<DFA> _decisionToDFA = List.generate(
      _ATN.numberOfDecisions, (i) => DFA(_ATN.getDecisionState(i), i));
  static final PredictionContextCache _sharedContextCache = PredictionContextCache();
  static const int TOKEN_OPENQASM = 1, TOKEN_INCLUDE = 2, TOKEN_DEFCALGRAMMAR = 3, 
                   TOKEN_DEF = 4, TOKEN_CAL = 5, TOKEN_DEFCAL = 6, TOKEN_GATE = 7, 
                   TOKEN_EXTERN = 8, TOKEN_BOX = 9, TOKEN_LET = 10, TOKEN_BREAK = 11, 
                   TOKEN_CONTINUE = 12, TOKEN_IF = 13, TOKEN_ELSE = 14, 
                   TOKEN_END = 15, TOKEN_RETURN = 16, TOKEN_FOR = 17, TOKEN_WHILE = 18, 
                   TOKEN_IN = 19, TOKEN_PRAGMA = 20, TOKEN_AnnotationKeyword = 21, 
                   TOKEN_INPUT = 22, TOKEN_OUTPUT = 23, TOKEN_CONST = 24, 
                   TOKEN_READONLY = 25, TOKEN_MUTABLE = 26, TOKEN_QREG = 27, 
                   TOKEN_QUBIT = 28, TOKEN_CREG = 29, TOKEN_BOOL = 30, TOKEN_BIT = 31, 
                   TOKEN_INT = 32, TOKEN_UINT = 33, TOKEN_FLOAT = 34, TOKEN_ANGLE = 35, 
                   TOKEN_COMPLEX = 36, TOKEN_ARRAY = 37, TOKEN_VOID = 38, 
                   TOKEN_DURATION = 39, TOKEN_STRETCH = 40, TOKEN_STRING = 41, 
                   TOKEN_GPHASE = 42, TOKEN_INV = 43, TOKEN_POW = 44, TOKEN_CTRL = 45, 
                   TOKEN_NEGCTRL = 46, TOKEN_DIM = 47, TOKEN_DURATIONOF = 48, 
                   TOKEN_DELAY = 49, TOKEN_RESET = 50, TOKEN_MEASURE = 51, 
                   TOKEN_BARRIER = 52, TOKEN_BooleanLiteral = 53, TOKEN_LBRACKET = 54, 
                   TOKEN_RBRACKET = 55, TOKEN_LBRACE = 56, TOKEN_RBRACE = 57, 
                   TOKEN_LPAREN = 58, TOKEN_RPAREN = 59, TOKEN_COLON = 60, 
                   TOKEN_SEMICOLON = 61, TOKEN_DOT = 62, TOKEN_COMMA = 63, 
                   TOKEN_EQUALS = 64, TOKEN_ARROW = 65, TOKEN_PLUS = 66, 
                   TOKEN_DOUBLE_PLUS = 67, TOKEN_MINUS = 68, TOKEN_ASTERISK = 69, 
                   TOKEN_DOUBLE_ASTERISK = 70, TOKEN_SLASH = 71, TOKEN_PERCENT = 72, 
                   TOKEN_PIPE = 73, TOKEN_DOUBLE_PIPE = 74, TOKEN_AMPERSAND = 75, 
                   TOKEN_DOUBLE_AMPERSAND = 76, TOKEN_CARET = 77, TOKEN_AT = 78, 
                   TOKEN_TILDE = 79, TOKEN_EXCLAMATION_POINT = 80, TOKEN_EqualityOperator = 81, 
                   TOKEN_CompoundAssignmentOperator = 82, TOKEN_ComparisonOperator = 83, 
                   TOKEN_BitshiftOperator = 84, TOKEN_IMAG = 85, TOKEN_ImaginaryLiteral = 86, 
                   TOKEN_BinaryIntegerLiteral = 87, TOKEN_OctalIntegerLiteral = 88, 
                   TOKEN_DecimalIntegerLiteral = 89, TOKEN_HexIntegerLiteral = 90, 
                   TOKEN_Identifier = 91, TOKEN_HardwareQubit = 92, TOKEN_FloatLiteral = 93, 
                   TOKEN_TimingLiteral = 94, TOKEN_BitstringLiteral = 95, 
                   TOKEN_StringLiteral = 96, TOKEN_Whitespace = 97, TOKEN_Newline = 98, 
                   TOKEN_LineComment = 99, TOKEN_BlockComment = 100, TOKEN_VERSION_IDENTIFER_WHITESPACE = 101, 
                   TOKEN_VersionSpecifier = 102, TOKEN_EAT_INITIAL_SPACE = 103, 
                   TOKEN_EAT_LINE_END = 104, TOKEN_RemainingLineContent = 105, 
                   TOKEN_CAL_PRELUDE_WHITESPACE = 106, TOKEN_CAL_PRELUDE_COMMENT = 107, 
                   TOKEN_DEFCAL_PRELUDE_WHITESPACE = 108, TOKEN_DEFCAL_PRELUDE_COMMENT = 109, 
                   TOKEN_CalibrationBlock = 110;

  @override
  final List<String> ruleNames = [
    'program', 'version', 'statement', 'annotation', 'scope', 'pragma', 
    'statementOrScope', 'calibrationGrammarStatement', 'includeStatement', 
    'breakStatement', 'continueStatement', 'endStatement', 'forStatement', 
    'ifStatement', 'returnStatement', 'whileStatement', 'barrierStatement', 
    'boxStatement', 'delayStatement', 'gateCallStatement', 'measureArrowAssignmentStatement', 
    'resetStatement', 'aliasDeclarationStatement', 'classicalDeclarationStatement', 
    'constDeclarationStatement', 'ioDeclarationStatement', 'oldStyleDeclarationStatement', 
    'quantumDeclarationStatement', 'defStatement', 'externStatement', 'gateStatement', 
    'assignmentStatement', 'expressionStatement', 'calStatement', 'defcalStatement', 
    'expression', 'aliasExpression', 'declarationExpression', 'measureExpression', 
    'rangeExpression', 'setExpression', 'arrayLiteral', 'indexOperator', 
    'indexedIdentifier', 'returnSignature', 'gateModifier', 'scalarType', 
    'qubitType', 'arrayType', 'arrayReferenceType', 'designator', 'defcalTarget', 
    'defcalArgumentDefinition', 'defcalOperand', 'gateOperand', 'externArgument', 
    'argumentDefinition', 'argumentDefinitionList', 'defcalArgumentDefinitionList', 
    'defcalOperandList', 'expressionList', 'identifierList', 'gateOperandList', 
    'externArgumentList'
  ];

  static final List<String?> _LITERAL_NAMES = [
      null, "'OPENQASM'", "'include'", "'defcalgrammar'", "'def'", "'cal'", 
      "'defcal'", "'gate'", "'extern'", "'box'", "'let'", "'break'", "'continue'", 
      "'if'", "'else'", "'end'", "'return'", "'for'", "'while'", "'in'", 
      null, null, "'input'", "'output'", "'const'", "'readonly'", "'mutable'", 
      "'qreg'", "'qubit'", "'creg'", "'bool'", "'bit'", "'int'", "'uint'", 
      "'float'", "'angle'", "'complex'", "'array'", "'void'", "'duration'", 
      "'stretch'", "'string'", "'gphase'", "'inv'", "'pow'", "'ctrl'", "'negctrl'", 
      "'#dim'", "'durationof'", "'delay'", "'reset'", "'measure'", "'barrier'", 
      null, "'['", "']'", "'{'", "'}'", "'('", "')'", "':'", "';'", "'.'", 
      "','", "'='", "'->'", "'+'", "'++'", "'-'", "'*'", "'**'", "'/'", 
      "'%'", "'|'", "'||'", "'&'", "'&&'", "'^'", "'@'", "'~'", "'!'", null, 
      null, null, null, "'im'"
  ];
  static final List<String?> _SYMBOLIC_NAMES = [
      null, "OPENQASM", "INCLUDE", "DEFCALGRAMMAR", "DEF", "CAL", "DEFCAL", 
      "GATE", "EXTERN", "BOX", "LET", "BREAK", "CONTINUE", "IF", "ELSE", 
      "END", "RETURN", "FOR", "WHILE", "IN", "PRAGMA", "AnnotationKeyword", 
      "INPUT", "OUTPUT", "CONST", "READONLY", "MUTABLE", "QREG", "QUBIT", 
      "CREG", "BOOL", "BIT", "INT", "UINT", "FLOAT", "ANGLE", "COMPLEX", 
      "ARRAY", "VOID", "DURATION", "STRETCH", "STRING", "GPHASE", "INV", 
      "POW", "CTRL", "NEGCTRL", "DIM", "DURATIONOF", "DELAY", "RESET", "MEASURE", 
      "BARRIER", "BooleanLiteral", "LBRACKET", "RBRACKET", "LBRACE", "RBRACE", 
      "LPAREN", "RPAREN", "COLON", "SEMICOLON", "DOT", "COMMA", "EQUALS", 
      "ARROW", "PLUS", "DOUBLE_PLUS", "MINUS", "ASTERISK", "DOUBLE_ASTERISK", 
      "SLASH", "PERCENT", "PIPE", "DOUBLE_PIPE", "AMPERSAND", "DOUBLE_AMPERSAND", 
      "CARET", "AT", "TILDE", "EXCLAMATION_POINT", "EqualityOperator", "CompoundAssignmentOperator", 
      "ComparisonOperator", "BitshiftOperator", "IMAG", "ImaginaryLiteral", 
      "BinaryIntegerLiteral", "OctalIntegerLiteral", "DecimalIntegerLiteral", 
      "HexIntegerLiteral", "Identifier", "HardwareQubit", "FloatLiteral", 
      "TimingLiteral", "BitstringLiteral", "StringLiteral", "Whitespace", 
      "Newline", "LineComment", "BlockComment", "VERSION_IDENTIFER_WHITESPACE", 
      "VersionSpecifier", "EAT_INITIAL_SPACE", "EAT_LINE_END", "RemainingLineContent", 
      "CAL_PRELUDE_WHITESPACE", "CAL_PRELUDE_COMMENT", "DEFCAL_PRELUDE_WHITESPACE", 
      "DEFCAL_PRELUDE_COMMENT", "CalibrationBlock"
  ];
  static final Vocabulary VOCABULARY = VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

  @override
  Vocabulary get vocabulary {
    return VOCABULARY;
  }

  @override
  String get grammarFileName => 'OpenQASM3Parser.g4';

  @override
  List<int> get serializedATN => _serializedATN;

  @override
  ATN getATN() {
   return _ATN;
  }

  OpenQASM3Parser(TokenStream input) : super(input) {
    interpreter = ParserATNSimulator(this, _ATN, _decisionToDFA, _sharedContextCache);
  }

  ProgramContext program() {
    dynamic _localctx = ProgramContext(context, state);
    enterRule(_localctx, 0, RULE_program);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 129;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_OPENQASM) {
        state = 128;
        version();
      }

      state = 134;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while ((((_la) & ~0x3f) == 0 && ((1 << _la) & 306103762193727484) != 0) || ((((_la - 68)) & ~0x3f) == 0 && ((1 << (_la - 68)) & 536614913) != 0)) {
        state = 131;
        statement();
        state = 136;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 137;
      match(TOKEN_EOF);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  VersionContext version() {
    dynamic _localctx = VersionContext(context, state);
    enterRule(_localctx, 2, RULE_version);
    try {
      enterOuterAlt(_localctx, 1);
      state = 139;
      match(TOKEN_OPENQASM);
      state = 140;
      match(TOKEN_VersionSpecifier);
      state = 141;
      match(TOKEN_SEMICOLON);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  StatementContext statement() {
    dynamic _localctx = StatementContext(context, state);
    enterRule(_localctx, 4, RULE_statement);
    int _la;
    try {
      state = 180;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_PRAGMA:
        enterOuterAlt(_localctx, 1);
        state = 143;
        pragma();
        break;
      case TOKEN_INCLUDE:
      case TOKEN_DEFCALGRAMMAR:
      case TOKEN_DEF:
      case TOKEN_CAL:
      case TOKEN_DEFCAL:
      case TOKEN_GATE:
      case TOKEN_EXTERN:
      case TOKEN_BOX:
      case TOKEN_LET:
      case TOKEN_BREAK:
      case TOKEN_CONTINUE:
      case TOKEN_IF:
      case TOKEN_END:
      case TOKEN_RETURN:
      case TOKEN_FOR:
      case TOKEN_WHILE:
      case TOKEN_AnnotationKeyword:
      case TOKEN_INPUT:
      case TOKEN_OUTPUT:
      case TOKEN_CONST:
      case TOKEN_QREG:
      case TOKEN_QUBIT:
      case TOKEN_CREG:
      case TOKEN_BOOL:
      case TOKEN_BIT:
      case TOKEN_INT:
      case TOKEN_UINT:
      case TOKEN_FLOAT:
      case TOKEN_ANGLE:
      case TOKEN_COMPLEX:
      case TOKEN_ARRAY:
      case TOKEN_DURATION:
      case TOKEN_STRETCH:
      case TOKEN_STRING:
      case TOKEN_GPHASE:
      case TOKEN_INV:
      case TOKEN_POW:
      case TOKEN_CTRL:
      case TOKEN_NEGCTRL:
      case TOKEN_DURATIONOF:
      case TOKEN_DELAY:
      case TOKEN_RESET:
      case TOKEN_MEASURE:
      case TOKEN_BARRIER:
      case TOKEN_BooleanLiteral:
      case TOKEN_LPAREN:
      case TOKEN_MINUS:
      case TOKEN_TILDE:
      case TOKEN_EXCLAMATION_POINT:
      case TOKEN_ImaginaryLiteral:
      case TOKEN_BinaryIntegerLiteral:
      case TOKEN_OctalIntegerLiteral:
      case TOKEN_DecimalIntegerLiteral:
      case TOKEN_HexIntegerLiteral:
      case TOKEN_Identifier:
      case TOKEN_HardwareQubit:
      case TOKEN_FloatLiteral:
      case TOKEN_TimingLiteral:
      case TOKEN_BitstringLiteral:
      case TOKEN_StringLiteral:
        enterOuterAlt(_localctx, 2);
        state = 147;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        while (_la == TOKEN_AnnotationKeyword) {
          state = 144;
          annotation();
          state = 149;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
        }
        state = 178;
        errorHandler.sync(this);
        switch (interpreter!.adaptivePredict(tokenStream, 3, context)) {
        case 1:
          state = 150;
          aliasDeclarationStatement();
          break;
        case 2:
          state = 151;
          assignmentStatement();
          break;
        case 3:
          state = 152;
          barrierStatement();
          break;
        case 4:
          state = 153;
          boxStatement();
          break;
        case 5:
          state = 154;
          breakStatement();
          break;
        case 6:
          state = 155;
          calStatement();
          break;
        case 7:
          state = 156;
          calibrationGrammarStatement();
          break;
        case 8:
          state = 157;
          classicalDeclarationStatement();
          break;
        case 9:
          state = 158;
          constDeclarationStatement();
          break;
        case 10:
          state = 159;
          continueStatement();
          break;
        case 11:
          state = 160;
          defStatement();
          break;
        case 12:
          state = 161;
          defcalStatement();
          break;
        case 13:
          state = 162;
          delayStatement();
          break;
        case 14:
          state = 163;
          endStatement();
          break;
        case 15:
          state = 164;
          expressionStatement();
          break;
        case 16:
          state = 165;
          externStatement();
          break;
        case 17:
          state = 166;
          forStatement();
          break;
        case 18:
          state = 167;
          gateCallStatement();
          break;
        case 19:
          state = 168;
          gateStatement();
          break;
        case 20:
          state = 169;
          ifStatement();
          break;
        case 21:
          state = 170;
          includeStatement();
          break;
        case 22:
          state = 171;
          ioDeclarationStatement();
          break;
        case 23:
          state = 172;
          measureArrowAssignmentStatement();
          break;
        case 24:
          state = 173;
          oldStyleDeclarationStatement();
          break;
        case 25:
          state = 174;
          quantumDeclarationStatement();
          break;
        case 26:
          state = 175;
          resetStatement();
          break;
        case 27:
          state = 176;
          returnStatement();
          break;
        case 28:
          state = 177;
          whileStatement();
          break;
        }
        break;
      default:
        throw NoViableAltException(this);
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  AnnotationContext annotation() {
    dynamic _localctx = AnnotationContext(context, state);
    enterRule(_localctx, 6, RULE_annotation);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 182;
      match(TOKEN_AnnotationKeyword);
      state = 184;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_RemainingLineContent) {
        state = 183;
        match(TOKEN_RemainingLineContent);
      }

    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ScopeContext scope() {
    dynamic _localctx = ScopeContext(context, state);
    enterRule(_localctx, 8, RULE_scope);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 186;
      match(TOKEN_LBRACE);
      state = 190;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while ((((_la) & ~0x3f) == 0 && ((1 << _la) & 306103762193727484) != 0) || ((((_la - 68)) & ~0x3f) == 0 && ((1 << (_la - 68)) & 536614913) != 0)) {
        state = 187;
        statement();
        state = 192;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
      state = 193;
      match(TOKEN_RBRACE);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  PragmaContext pragma() {
    dynamic _localctx = PragmaContext(context, state);
    enterRule(_localctx, 10, RULE_pragma);
    try {
      enterOuterAlt(_localctx, 1);
      state = 195;
      match(TOKEN_PRAGMA);
      state = 196;
      match(TOKEN_RemainingLineContent);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  StatementOrScopeContext statementOrScope() {
    dynamic _localctx = StatementOrScopeContext(context, state);
    enterRule(_localctx, 12, RULE_statementOrScope);
    try {
      state = 200;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_INCLUDE:
      case TOKEN_DEFCALGRAMMAR:
      case TOKEN_DEF:
      case TOKEN_CAL:
      case TOKEN_DEFCAL:
      case TOKEN_GATE:
      case TOKEN_EXTERN:
      case TOKEN_BOX:
      case TOKEN_LET:
      case TOKEN_BREAK:
      case TOKEN_CONTINUE:
      case TOKEN_IF:
      case TOKEN_END:
      case TOKEN_RETURN:
      case TOKEN_FOR:
      case TOKEN_WHILE:
      case TOKEN_PRAGMA:
      case TOKEN_AnnotationKeyword:
      case TOKEN_INPUT:
      case TOKEN_OUTPUT:
      case TOKEN_CONST:
      case TOKEN_QREG:
      case TOKEN_QUBIT:
      case TOKEN_CREG:
      case TOKEN_BOOL:
      case TOKEN_BIT:
      case TOKEN_INT:
      case TOKEN_UINT:
      case TOKEN_FLOAT:
      case TOKEN_ANGLE:
      case TOKEN_COMPLEX:
      case TOKEN_ARRAY:
      case TOKEN_DURATION:
      case TOKEN_STRETCH:
      case TOKEN_STRING:
      case TOKEN_GPHASE:
      case TOKEN_INV:
      case TOKEN_POW:
      case TOKEN_CTRL:
      case TOKEN_NEGCTRL:
      case TOKEN_DURATIONOF:
      case TOKEN_DELAY:
      case TOKEN_RESET:
      case TOKEN_MEASURE:
      case TOKEN_BARRIER:
      case TOKEN_BooleanLiteral:
      case TOKEN_LPAREN:
      case TOKEN_MINUS:
      case TOKEN_TILDE:
      case TOKEN_EXCLAMATION_POINT:
      case TOKEN_ImaginaryLiteral:
      case TOKEN_BinaryIntegerLiteral:
      case TOKEN_OctalIntegerLiteral:
      case TOKEN_DecimalIntegerLiteral:
      case TOKEN_HexIntegerLiteral:
      case TOKEN_Identifier:
      case TOKEN_HardwareQubit:
      case TOKEN_FloatLiteral:
      case TOKEN_TimingLiteral:
      case TOKEN_BitstringLiteral:
      case TOKEN_StringLiteral:
        enterOuterAlt(_localctx, 1);
        state = 198;
        statement();
        break;
      case TOKEN_LBRACE:
        enterOuterAlt(_localctx, 2);
        state = 199;
        scope();
        break;
      default:
        throw NoViableAltException(this);
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  CalibrationGrammarStatementContext calibrationGrammarStatement() {
    dynamic _localctx = CalibrationGrammarStatementContext(context, state);
    enterRule(_localctx, 14, RULE_calibrationGrammarStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 202;
      match(TOKEN_DEFCALGRAMMAR);
      state = 203;
      match(TOKEN_StringLiteral);
      state = 204;
      match(TOKEN_SEMICOLON);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  IncludeStatementContext includeStatement() {
    dynamic _localctx = IncludeStatementContext(context, state);
    enterRule(_localctx, 16, RULE_includeStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 206;
      match(TOKEN_INCLUDE);
      state = 207;
      match(TOKEN_StringLiteral);
      state = 208;
      match(TOKEN_SEMICOLON);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  BreakStatementContext breakStatement() {
    dynamic _localctx = BreakStatementContext(context, state);
    enterRule(_localctx, 18, RULE_breakStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 210;
      match(TOKEN_BREAK);
      state = 211;
      match(TOKEN_SEMICOLON);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ContinueStatementContext continueStatement() {
    dynamic _localctx = ContinueStatementContext(context, state);
    enterRule(_localctx, 20, RULE_continueStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 213;
      match(TOKEN_CONTINUE);
      state = 214;
      match(TOKEN_SEMICOLON);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  EndStatementContext endStatement() {
    dynamic _localctx = EndStatementContext(context, state);
    enterRule(_localctx, 22, RULE_endStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 216;
      match(TOKEN_END);
      state = 217;
      match(TOKEN_SEMICOLON);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ForStatementContext forStatement() {
    dynamic _localctx = ForStatementContext(context, state);
    enterRule(_localctx, 24, RULE_forStatement);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 219;
      match(TOKEN_FOR);
      state = 221;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 3984655908864) != 0)) {
        state = 220;
        scalarType();
      }

      state = 223;
      match(TOKEN_Identifier);
      state = 224;
      match(TOKEN_IN);
      state = 231;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_LBRACE:
        state = 225;
        setExpression();
        break;
      case TOKEN_LBRACKET:
        state = 226;
        match(TOKEN_LBRACKET);
        state = 227;
        rangeExpression();
        state = 228;
        match(TOKEN_RBRACKET);
        break;
      case TOKEN_BOOL:
      case TOKEN_BIT:
      case TOKEN_INT:
      case TOKEN_UINT:
      case TOKEN_FLOAT:
      case TOKEN_ANGLE:
      case TOKEN_COMPLEX:
      case TOKEN_ARRAY:
      case TOKEN_DURATION:
      case TOKEN_STRETCH:
      case TOKEN_STRING:
      case TOKEN_DURATIONOF:
      case TOKEN_BooleanLiteral:
      case TOKEN_LPAREN:
      case TOKEN_MINUS:
      case TOKEN_TILDE:
      case TOKEN_EXCLAMATION_POINT:
      case TOKEN_ImaginaryLiteral:
      case TOKEN_BinaryIntegerLiteral:
      case TOKEN_OctalIntegerLiteral:
      case TOKEN_DecimalIntegerLiteral:
      case TOKEN_HexIntegerLiteral:
      case TOKEN_Identifier:
      case TOKEN_HardwareQubit:
      case TOKEN_FloatLiteral:
      case TOKEN_TimingLiteral:
      case TOKEN_BitstringLiteral:
      case TOKEN_StringLiteral:
        state = 230;
        expression(0);
        break;
      default:
        throw NoViableAltException(this);
      }
      state = 233;
      _localctx.body = statementOrScope();
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  IfStatementContext ifStatement() {
    dynamic _localctx = IfStatementContext(context, state);
    enterRule(_localctx, 26, RULE_ifStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 235;
      match(TOKEN_IF);
      state = 236;
      match(TOKEN_LPAREN);
      state = 237;
      expression(0);
      state = 238;
      match(TOKEN_RPAREN);
      state = 239;
      _localctx.if_body = statementOrScope();
      state = 242;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 10, context)) {
      case 1:
        state = 240;
        match(TOKEN_ELSE);
        state = 241;
        _localctx.else_body = statementOrScope();
        break;
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ReturnStatementContext returnStatement() {
    dynamic _localctx = ReturnStatementContext(context, state);
    enterRule(_localctx, 28, RULE_returnStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 244;
      match(TOKEN_RETURN);
      state = 247;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_BOOL:
      case TOKEN_BIT:
      case TOKEN_INT:
      case TOKEN_UINT:
      case TOKEN_FLOAT:
      case TOKEN_ANGLE:
      case TOKEN_COMPLEX:
      case TOKEN_ARRAY:
      case TOKEN_DURATION:
      case TOKEN_STRETCH:
      case TOKEN_STRING:
      case TOKEN_DURATIONOF:
      case TOKEN_BooleanLiteral:
      case TOKEN_LPAREN:
      case TOKEN_MINUS:
      case TOKEN_TILDE:
      case TOKEN_EXCLAMATION_POINT:
      case TOKEN_ImaginaryLiteral:
      case TOKEN_BinaryIntegerLiteral:
      case TOKEN_OctalIntegerLiteral:
      case TOKEN_DecimalIntegerLiteral:
      case TOKEN_HexIntegerLiteral:
      case TOKEN_Identifier:
      case TOKEN_HardwareQubit:
      case TOKEN_FloatLiteral:
      case TOKEN_TimingLiteral:
      case TOKEN_BitstringLiteral:
      case TOKEN_StringLiteral:
        state = 245;
        expression(0);
        break;
      case TOKEN_MEASURE:
        state = 246;
        measureExpression();
        break;
      case TOKEN_SEMICOLON:
        break;
      default:
        break;
      }
      state = 249;
      match(TOKEN_SEMICOLON);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  WhileStatementContext whileStatement() {
    dynamic _localctx = WhileStatementContext(context, state);
    enterRule(_localctx, 30, RULE_whileStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 251;
      match(TOKEN_WHILE);
      state = 252;
      match(TOKEN_LPAREN);
      state = 253;
      expression(0);
      state = 254;
      match(TOKEN_RPAREN);
      state = 255;
      _localctx.body = statementOrScope();
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  BarrierStatementContext barrierStatement() {
    dynamic _localctx = BarrierStatementContext(context, state);
    enterRule(_localctx, 32, RULE_barrierStatement);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 257;
      match(TOKEN_BARRIER);
      state = 259;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_Identifier || _la == TOKEN_HardwareQubit) {
        state = 258;
        gateOperandList();
      }

      state = 261;
      match(TOKEN_SEMICOLON);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  BoxStatementContext boxStatement() {
    dynamic _localctx = BoxStatementContext(context, state);
    enterRule(_localctx, 34, RULE_boxStatement);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 263;
      match(TOKEN_BOX);
      state = 265;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_LBRACKET) {
        state = 264;
        designator();
      }

      state = 267;
      scope();
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  DelayStatementContext delayStatement() {
    dynamic _localctx = DelayStatementContext(context, state);
    enterRule(_localctx, 36, RULE_delayStatement);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 269;
      match(TOKEN_DELAY);
      state = 270;
      designator();
      state = 272;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_Identifier || _la == TOKEN_HardwareQubit) {
        state = 271;
        gateOperandList();
      }

      state = 274;
      match(TOKEN_SEMICOLON);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  GateCallStatementContext gateCallStatement() {
    dynamic _localctx = GateCallStatementContext(context, state);
    enterRule(_localctx, 38, RULE_gateCallStatement);
    int _la;
    try {
      state = 317;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 24, context)) {
      case 1:
        enterOuterAlt(_localctx, 1);
        state = 279;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        while ((((_la) & ~0x3f) == 0 && ((1 << _la) & 131941395333120) != 0)) {
          state = 276;
          gateModifier();
          state = 281;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
        }
        state = 282;
        match(TOKEN_Identifier);
        state = 288;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LPAREN) {
          state = 283;
          match(TOKEN_LPAREN);
          state = 285;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 297523172478025728) != 0) || ((((_la - 68)) & ~0x3f) == 0 && ((1 << (_la - 68)) & 536614913) != 0)) {
            state = 284;
            expressionList();
          }

          state = 287;
          match(TOKEN_RPAREN);
        }

        state = 291;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LBRACKET) {
          state = 290;
          designator();
        }

        state = 293;
        gateOperandList();
        state = 294;
        match(TOKEN_SEMICOLON);
        break;
      case 2:
        enterOuterAlt(_localctx, 2);
        state = 299;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        while ((((_la) & ~0x3f) == 0 && ((1 << _la) & 131941395333120) != 0)) {
          state = 296;
          gateModifier();
          state = 301;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
        }
        state = 302;
        match(TOKEN_GPHASE);
        state = 308;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LPAREN) {
          state = 303;
          match(TOKEN_LPAREN);
          state = 305;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 297523172478025728) != 0) || ((((_la - 68)) & ~0x3f) == 0 && ((1 << (_la - 68)) & 536614913) != 0)) {
            state = 304;
            expressionList();
          }

          state = 307;
          match(TOKEN_RPAREN);
        }

        state = 311;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LBRACKET) {
          state = 310;
          designator();
        }

        state = 314;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_Identifier || _la == TOKEN_HardwareQubit) {
          state = 313;
          gateOperandList();
        }

        state = 316;
        match(TOKEN_SEMICOLON);
        break;
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  MeasureArrowAssignmentStatementContext measureArrowAssignmentStatement() {
    dynamic _localctx = MeasureArrowAssignmentStatementContext(context, state);
    enterRule(_localctx, 40, RULE_measureArrowAssignmentStatement);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 319;
      measureExpression();
      state = 322;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_ARROW) {
        state = 320;
        match(TOKEN_ARROW);
        state = 321;
        indexedIdentifier();
      }

      state = 324;
      match(TOKEN_SEMICOLON);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ResetStatementContext resetStatement() {
    dynamic _localctx = ResetStatementContext(context, state);
    enterRule(_localctx, 42, RULE_resetStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 326;
      match(TOKEN_RESET);
      state = 327;
      gateOperand();
      state = 328;
      match(TOKEN_SEMICOLON);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  AliasDeclarationStatementContext aliasDeclarationStatement() {
    dynamic _localctx = AliasDeclarationStatementContext(context, state);
    enterRule(_localctx, 44, RULE_aliasDeclarationStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 330;
      match(TOKEN_LET);
      state = 331;
      match(TOKEN_Identifier);
      state = 332;
      match(TOKEN_EQUALS);
      state = 333;
      aliasExpression();
      state = 334;
      match(TOKEN_SEMICOLON);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ClassicalDeclarationStatementContext classicalDeclarationStatement() {
    dynamic _localctx = ClassicalDeclarationStatementContext(context, state);
    enterRule(_localctx, 46, RULE_classicalDeclarationStatement);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 338;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_BOOL:
      case TOKEN_BIT:
      case TOKEN_INT:
      case TOKEN_UINT:
      case TOKEN_FLOAT:
      case TOKEN_ANGLE:
      case TOKEN_COMPLEX:
      case TOKEN_DURATION:
      case TOKEN_STRETCH:
      case TOKEN_STRING:
        state = 336;
        scalarType();
        break;
      case TOKEN_ARRAY:
        state = 337;
        arrayType();
        break;
      default:
        throw NoViableAltException(this);
      }
      state = 340;
      match(TOKEN_Identifier);
      state = 343;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_EQUALS) {
        state = 341;
        match(TOKEN_EQUALS);
        state = 342;
        declarationExpression();
      }

      state = 345;
      match(TOKEN_SEMICOLON);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ConstDeclarationStatementContext constDeclarationStatement() {
    dynamic _localctx = ConstDeclarationStatementContext(context, state);
    enterRule(_localctx, 48, RULE_constDeclarationStatement);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 347;
      match(TOKEN_CONST);
      state = 348;
      scalarType();
      state = 349;
      match(TOKEN_Identifier);
      state = 352;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_EQUALS) {
        state = 350;
        match(TOKEN_EQUALS);
        state = 351;
        declarationExpression();
      }

      state = 354;
      match(TOKEN_SEMICOLON);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  IoDeclarationStatementContext ioDeclarationStatement() {
    dynamic _localctx = IoDeclarationStatementContext(context, state);
    enterRule(_localctx, 50, RULE_ioDeclarationStatement);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 356;
      _la = tokenStream.LA(1)!;
      if (!(_la == TOKEN_INPUT || _la == TOKEN_OUTPUT)) {
      errorHandler.recoverInline(this);
      } else {
        if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
      state = 359;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_BOOL:
      case TOKEN_BIT:
      case TOKEN_INT:
      case TOKEN_UINT:
      case TOKEN_FLOAT:
      case TOKEN_ANGLE:
      case TOKEN_COMPLEX:
      case TOKEN_DURATION:
      case TOKEN_STRETCH:
      case TOKEN_STRING:
        state = 357;
        scalarType();
        break;
      case TOKEN_ARRAY:
        state = 358;
        arrayType();
        break;
      default:
        throw NoViableAltException(this);
      }
      state = 361;
      match(TOKEN_Identifier);
      state = 362;
      match(TOKEN_SEMICOLON);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  OldStyleDeclarationStatementContext oldStyleDeclarationStatement() {
    dynamic _localctx = OldStyleDeclarationStatementContext(context, state);
    enterRule(_localctx, 52, RULE_oldStyleDeclarationStatement);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 364;
      _la = tokenStream.LA(1)!;
      if (!(_la == TOKEN_QREG || _la == TOKEN_CREG)) {
      errorHandler.recoverInline(this);
      } else {
        if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
      state = 365;
      match(TOKEN_Identifier);
      state = 367;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_LBRACKET) {
        state = 366;
        designator();
      }

      state = 369;
      match(TOKEN_SEMICOLON);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  QuantumDeclarationStatementContext quantumDeclarationStatement() {
    dynamic _localctx = QuantumDeclarationStatementContext(context, state);
    enterRule(_localctx, 54, RULE_quantumDeclarationStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 371;
      qubitType();
      state = 372;
      match(TOKEN_Identifier);
      state = 373;
      match(TOKEN_SEMICOLON);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  DefStatementContext defStatement() {
    dynamic _localctx = DefStatementContext(context, state);
    enterRule(_localctx, 56, RULE_defStatement);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 375;
      match(TOKEN_DEF);
      state = 376;
      match(TOKEN_Identifier);
      state = 377;
      match(TOKEN_LPAREN);
      state = 379;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 3985696096256) != 0)) {
        state = 378;
        argumentDefinitionList();
      }

      state = 381;
      match(TOKEN_RPAREN);
      state = 383;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_ARROW) {
        state = 382;
        returnSignature();
      }

      state = 385;
      scope();
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ExternStatementContext externStatement() {
    dynamic _localctx = ExternStatementContext(context, state);
    enterRule(_localctx, 58, RULE_externStatement);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 387;
      match(TOKEN_EXTERN);
      state = 388;
      match(TOKEN_Identifier);
      state = 389;
      match(TOKEN_LPAREN);
      state = 391;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 3985293443072) != 0)) {
        state = 390;
        externArgumentList();
      }

      state = 393;
      match(TOKEN_RPAREN);
      state = 395;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_ARROW) {
        state = 394;
        returnSignature();
      }

      state = 397;
      match(TOKEN_SEMICOLON);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  GateStatementContext gateStatement() {
    dynamic _localctx = GateStatementContext(context, state);
    enterRule(_localctx, 60, RULE_gateStatement);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 399;
      match(TOKEN_GATE);
      state = 400;
      match(TOKEN_Identifier);
      state = 406;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_LPAREN) {
        state = 401;
        match(TOKEN_LPAREN);
        state = 403;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_Identifier) {
          state = 402;
          _localctx.params = identifierList();
        }

        state = 405;
        match(TOKEN_RPAREN);
      }

      state = 408;
      _localctx.qubits = identifierList();
      state = 409;
      scope();
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  AssignmentStatementContext assignmentStatement() {
    dynamic _localctx = AssignmentStatementContext(context, state);
    enterRule(_localctx, 62, RULE_assignmentStatement);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 411;
      indexedIdentifier();
      state = 412;
      _localctx.op = tokenStream.LT(1);
      _la = tokenStream.LA(1)!;
      if (!(_la == TOKEN_EQUALS || _la == TOKEN_CompoundAssignmentOperator)) {
        _localctx.op = errorHandler.recoverInline(this);
      } else {
        if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
      state = 415;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_BOOL:
      case TOKEN_BIT:
      case TOKEN_INT:
      case TOKEN_UINT:
      case TOKEN_FLOAT:
      case TOKEN_ANGLE:
      case TOKEN_COMPLEX:
      case TOKEN_ARRAY:
      case TOKEN_DURATION:
      case TOKEN_STRETCH:
      case TOKEN_STRING:
      case TOKEN_DURATIONOF:
      case TOKEN_BooleanLiteral:
      case TOKEN_LPAREN:
      case TOKEN_MINUS:
      case TOKEN_TILDE:
      case TOKEN_EXCLAMATION_POINT:
      case TOKEN_ImaginaryLiteral:
      case TOKEN_BinaryIntegerLiteral:
      case TOKEN_OctalIntegerLiteral:
      case TOKEN_DecimalIntegerLiteral:
      case TOKEN_HexIntegerLiteral:
      case TOKEN_Identifier:
      case TOKEN_HardwareQubit:
      case TOKEN_FloatLiteral:
      case TOKEN_TimingLiteral:
      case TOKEN_BitstringLiteral:
      case TOKEN_StringLiteral:
        state = 413;
        expression(0);
        break;
      case TOKEN_MEASURE:
        state = 414;
        measureExpression();
        break;
      default:
        throw NoViableAltException(this);
      }
      state = 417;
      match(TOKEN_SEMICOLON);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ExpressionStatementContext expressionStatement() {
    dynamic _localctx = ExpressionStatementContext(context, state);
    enterRule(_localctx, 64, RULE_expressionStatement);
    try {
      enterOuterAlt(_localctx, 1);
      state = 419;
      expression(0);
      state = 420;
      match(TOKEN_SEMICOLON);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  CalStatementContext calStatement() {
    dynamic _localctx = CalStatementContext(context, state);
    enterRule(_localctx, 66, RULE_calStatement);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 422;
      match(TOKEN_CAL);
      state = 423;
      match(TOKEN_LBRACE);
      state = 425;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_CalibrationBlock) {
        state = 424;
        match(TOKEN_CalibrationBlock);
      }

      state = 427;
      match(TOKEN_RBRACE);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  DefcalStatementContext defcalStatement() {
    dynamic _localctx = DefcalStatementContext(context, state);
    enterRule(_localctx, 68, RULE_defcalStatement);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 429;
      match(TOKEN_DEFCAL);
      state = 430;
      defcalTarget();
      state = 436;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_LPAREN) {
        state = 431;
        match(TOKEN_LPAREN);
        state = 433;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 297523173518213120) != 0) || ((((_la - 68)) & ~0x3f) == 0 && ((1 << (_la - 68)) & 536614913) != 0)) {
          state = 432;
          defcalArgumentDefinitionList();
        }

        state = 435;
        match(TOKEN_RPAREN);
      }

      state = 438;
      defcalOperandList();
      state = 440;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_ARROW) {
        state = 439;
        returnSignature();
      }

      state = 442;
      match(TOKEN_LBRACE);
      state = 444;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_CalibrationBlock) {
        state = 443;
        match(TOKEN_CalibrationBlock);
      }

      state = 446;
      match(TOKEN_RBRACE);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ExpressionContext expression([int _p = 0]) {
    final _parentctx = context;
    final _parentState = state;
    dynamic _localctx = ExpressionContext(context, _parentState);
    var _prevctx = _localctx;
    var _startState = 70;
    enterRecursionRule(_localctx, 70, RULE_expression, _p);
    int _la;
    try {
      int _alt;
      enterOuterAlt(_localctx, 1);
      state = 475;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 45, context)) {
      case 1:
        _localctx = ParenthesisExpressionContext(_localctx);
        context = _localctx;
        _prevctx = _localctx;

        state = 449;
        match(TOKEN_LPAREN);
        state = 450;
        expression(0);
        state = 451;
        match(TOKEN_RPAREN);
        break;
      case 2:
        _localctx = UnaryExpressionContext(_localctx);
        context = _localctx;
        _prevctx = _localctx;
        state = 453;
        _localctx.op = tokenStream.LT(1);
        _la = tokenStream.LA(1)!;
        if (!(((((_la - 68)) & ~0x3f) == 0 && ((1 << (_la - 68)) & 6145) != 0))) {
          _localctx.op = errorHandler.recoverInline(this);
        } else {
          if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
          errorHandler.reportMatch(this);
          consume();
        }
        state = 454;
        expression(15);
        break;
      case 3:
        _localctx = CastExpressionContext(_localctx);
        context = _localctx;
        _prevctx = _localctx;
        state = 457;
        errorHandler.sync(this);
        switch (tokenStream.LA(1)!) {
        case TOKEN_BOOL:
        case TOKEN_BIT:
        case TOKEN_INT:
        case TOKEN_UINT:
        case TOKEN_FLOAT:
        case TOKEN_ANGLE:
        case TOKEN_COMPLEX:
        case TOKEN_DURATION:
        case TOKEN_STRETCH:
        case TOKEN_STRING:
          state = 455;
          scalarType();
          break;
        case TOKEN_ARRAY:
          state = 456;
          arrayType();
          break;
        default:
          throw NoViableAltException(this);
        }
        state = 459;
        match(TOKEN_LPAREN);
        state = 460;
        expression(0);
        state = 461;
        match(TOKEN_RPAREN);
        break;
      case 4:
        _localctx = DurationofExpressionContext(_localctx);
        context = _localctx;
        _prevctx = _localctx;
        state = 463;
        match(TOKEN_DURATIONOF);
        state = 464;
        match(TOKEN_LPAREN);
        state = 465;
        scope();
        state = 466;
        match(TOKEN_RPAREN);
        break;
      case 5:
        _localctx = CallExpressionContext(_localctx);
        context = _localctx;
        _prevctx = _localctx;
        state = 468;
        match(TOKEN_Identifier);
        state = 469;
        match(TOKEN_LPAREN);
        state = 471;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 297523172478025728) != 0) || ((((_la - 68)) & ~0x3f) == 0 && ((1 << (_la - 68)) & 536614913) != 0)) {
          state = 470;
          expressionList();
        }

        state = 473;
        match(TOKEN_RPAREN);
        break;
      case 6:
        _localctx = LiteralExpressionContext(_localctx);
        context = _localctx;
        _prevctx = _localctx;
        state = 474;
        _la = tokenStream.LA(1)!;
        if (!(((((_la - 53)) & ~0x3f) == 0 && ((1 << (_la - 53)) & 17583596109825) != 0))) {
        errorHandler.recoverInline(this);
        } else {
          if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
          errorHandler.reportMatch(this);
          consume();
        }
        break;
      }
      context!.stop = tokenStream.LT(-1);
      state = 514;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 47, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          if (parseListeners != null) triggerExitRuleEvent();
          _prevctx = _localctx;
          state = 512;
          errorHandler.sync(this);
          switch (interpreter!.adaptivePredict(tokenStream, 46, context)) {
          case 1:
            _localctx = PowerExpressionContext(new ExpressionContext(_parentctx, _parentState));
            pushNewRecursionContext(_localctx, _startState, RULE_expression);
            state = 477;
            if (!(precpred(context, 16))) {
              throw FailedPredicateException(this, "precpred(context, 16)");
            }
            state = 478;
            _localctx.op = match(TOKEN_DOUBLE_ASTERISK);
            state = 479;
            expression(16);
            break;
          case 2:
            _localctx = MultiplicativeExpressionContext(new ExpressionContext(_parentctx, _parentState));
            pushNewRecursionContext(_localctx, _startState, RULE_expression);
            state = 480;
            if (!(precpred(context, 14))) {
              throw FailedPredicateException(this, "precpred(context, 14)");
            }
            state = 481;
            _localctx.op = tokenStream.LT(1);
            _la = tokenStream.LA(1)!;
            if (!(((((_la - 69)) & ~0x3f) == 0 && ((1 << (_la - 69)) & 13) != 0))) {
              _localctx.op = errorHandler.recoverInline(this);
            } else {
              if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
              errorHandler.reportMatch(this);
              consume();
            }
            state = 482;
            expression(15);
            break;
          case 3:
            _localctx = AdditiveExpressionContext(new ExpressionContext(_parentctx, _parentState));
            pushNewRecursionContext(_localctx, _startState, RULE_expression);
            state = 483;
            if (!(precpred(context, 13))) {
              throw FailedPredicateException(this, "precpred(context, 13)");
            }
            state = 484;
            _localctx.op = tokenStream.LT(1);
            _la = tokenStream.LA(1)!;
            if (!(_la == TOKEN_PLUS || _la == TOKEN_MINUS)) {
              _localctx.op = errorHandler.recoverInline(this);
            } else {
              if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
              errorHandler.reportMatch(this);
              consume();
            }
            state = 485;
            expression(14);
            break;
          case 4:
            _localctx = BitshiftExpressionContext(new ExpressionContext(_parentctx, _parentState));
            pushNewRecursionContext(_localctx, _startState, RULE_expression);
            state = 486;
            if (!(precpred(context, 12))) {
              throw FailedPredicateException(this, "precpred(context, 12)");
            }
            state = 487;
            _localctx.op = match(TOKEN_BitshiftOperator);
            state = 488;
            expression(13);
            break;
          case 5:
            _localctx = ComparisonExpressionContext(new ExpressionContext(_parentctx, _parentState));
            pushNewRecursionContext(_localctx, _startState, RULE_expression);
            state = 489;
            if (!(precpred(context, 11))) {
              throw FailedPredicateException(this, "precpred(context, 11)");
            }
            state = 490;
            _localctx.op = match(TOKEN_ComparisonOperator);
            state = 491;
            expression(12);
            break;
          case 6:
            _localctx = EqualityExpressionContext(new ExpressionContext(_parentctx, _parentState));
            pushNewRecursionContext(_localctx, _startState, RULE_expression);
            state = 492;
            if (!(precpred(context, 10))) {
              throw FailedPredicateException(this, "precpred(context, 10)");
            }
            state = 493;
            _localctx.op = match(TOKEN_EqualityOperator);
            state = 494;
            expression(11);
            break;
          case 7:
            _localctx = BitwiseAndExpressionContext(new ExpressionContext(_parentctx, _parentState));
            pushNewRecursionContext(_localctx, _startState, RULE_expression);
            state = 495;
            if (!(precpred(context, 9))) {
              throw FailedPredicateException(this, "precpred(context, 9)");
            }
            state = 496;
            _localctx.op = match(TOKEN_AMPERSAND);
            state = 497;
            expression(10);
            break;
          case 8:
            _localctx = BitwiseXorExpressionContext(new ExpressionContext(_parentctx, _parentState));
            pushNewRecursionContext(_localctx, _startState, RULE_expression);
            state = 498;
            if (!(precpred(context, 8))) {
              throw FailedPredicateException(this, "precpred(context, 8)");
            }
            state = 499;
            _localctx.op = match(TOKEN_CARET);
            state = 500;
            expression(9);
            break;
          case 9:
            _localctx = BitwiseOrExpressionContext(new ExpressionContext(_parentctx, _parentState));
            pushNewRecursionContext(_localctx, _startState, RULE_expression);
            state = 501;
            if (!(precpred(context, 7))) {
              throw FailedPredicateException(this, "precpred(context, 7)");
            }
            state = 502;
            _localctx.op = match(TOKEN_PIPE);
            state = 503;
            expression(8);
            break;
          case 10:
            _localctx = LogicalAndExpressionContext(new ExpressionContext(_parentctx, _parentState));
            pushNewRecursionContext(_localctx, _startState, RULE_expression);
            state = 504;
            if (!(precpred(context, 6))) {
              throw FailedPredicateException(this, "precpred(context, 6)");
            }
            state = 505;
            _localctx.op = match(TOKEN_DOUBLE_AMPERSAND);
            state = 506;
            expression(7);
            break;
          case 11:
            _localctx = LogicalOrExpressionContext(new ExpressionContext(_parentctx, _parentState));
            pushNewRecursionContext(_localctx, _startState, RULE_expression);
            state = 507;
            if (!(precpred(context, 5))) {
              throw FailedPredicateException(this, "precpred(context, 5)");
            }
            state = 508;
            _localctx.op = match(TOKEN_DOUBLE_PIPE);
            state = 509;
            expression(6);
            break;
          case 12:
            _localctx = IndexExpressionContext(new ExpressionContext(_parentctx, _parentState));
            pushNewRecursionContext(_localctx, _startState, RULE_expression);
            state = 510;
            if (!(precpred(context, 17))) {
              throw FailedPredicateException(this, "precpred(context, 17)");
            }
            state = 511;
            indexOperator();
            break;
          } 
        }
        state = 516;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 47, context);
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      unrollRecursionContexts(_parentctx);
    }
    return _localctx;
  }

  AliasExpressionContext aliasExpression() {
    dynamic _localctx = AliasExpressionContext(context, state);
    enterRule(_localctx, 72, RULE_aliasExpression);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 517;
      expression(0);
      state = 522;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_DOUBLE_PLUS) {
        state = 518;
        match(TOKEN_DOUBLE_PLUS);
        state = 519;
        expression(0);
        state = 524;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  DeclarationExpressionContext declarationExpression() {
    dynamic _localctx = DeclarationExpressionContext(context, state);
    enterRule(_localctx, 74, RULE_declarationExpression);
    try {
      state = 528;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_LBRACE:
        enterOuterAlt(_localctx, 1);
        state = 525;
        arrayLiteral();
        break;
      case TOKEN_BOOL:
      case TOKEN_BIT:
      case TOKEN_INT:
      case TOKEN_UINT:
      case TOKEN_FLOAT:
      case TOKEN_ANGLE:
      case TOKEN_COMPLEX:
      case TOKEN_ARRAY:
      case TOKEN_DURATION:
      case TOKEN_STRETCH:
      case TOKEN_STRING:
      case TOKEN_DURATIONOF:
      case TOKEN_BooleanLiteral:
      case TOKEN_LPAREN:
      case TOKEN_MINUS:
      case TOKEN_TILDE:
      case TOKEN_EXCLAMATION_POINT:
      case TOKEN_ImaginaryLiteral:
      case TOKEN_BinaryIntegerLiteral:
      case TOKEN_OctalIntegerLiteral:
      case TOKEN_DecimalIntegerLiteral:
      case TOKEN_HexIntegerLiteral:
      case TOKEN_Identifier:
      case TOKEN_HardwareQubit:
      case TOKEN_FloatLiteral:
      case TOKEN_TimingLiteral:
      case TOKEN_BitstringLiteral:
      case TOKEN_StringLiteral:
        enterOuterAlt(_localctx, 2);
        state = 526;
        expression(0);
        break;
      case TOKEN_MEASURE:
        enterOuterAlt(_localctx, 3);
        state = 527;
        measureExpression();
        break;
      default:
        throw NoViableAltException(this);
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  MeasureExpressionContext measureExpression() {
    dynamic _localctx = MeasureExpressionContext(context, state);
    enterRule(_localctx, 76, RULE_measureExpression);
    try {
      enterOuterAlt(_localctx, 1);
      state = 530;
      match(TOKEN_MEASURE);
      state = 531;
      gateOperand();
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  RangeExpressionContext rangeExpression() {
    dynamic _localctx = RangeExpressionContext(context, state);
    enterRule(_localctx, 78, RULE_rangeExpression);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 534;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 297523172478025728) != 0) || ((((_la - 68)) & ~0x3f) == 0 && ((1 << (_la - 68)) & 536614913) != 0)) {
        state = 533;
        _localctx.startExpr = expression(0);
      }

      state = 536;
      match(TOKEN_COLON);
      state = 538;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 297523172478025728) != 0) || ((((_la - 68)) & ~0x3f) == 0 && ((1 << (_la - 68)) & 536614913) != 0)) {
        state = 537;
        _localctx.stepExpr = expression(0);
      }

      state = 542;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COLON) {
        state = 540;
        match(TOKEN_COLON);
        state = 541;
        _localctx.stopExpr = expression(0);
      }

    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  SetExpressionContext setExpression() {
    dynamic _localctx = SetExpressionContext(context, state);
    enterRule(_localctx, 80, RULE_setExpression);
    int _la;
    try {
      int _alt;
      enterOuterAlt(_localctx, 1);
      state = 544;
      match(TOKEN_LBRACE);
      state = 545;
      expression(0);
      state = 550;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 53, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 546;
          match(TOKEN_COMMA);
          state = 547;
          expression(0); 
        }
        state = 552;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 53, context);
      }
      state = 554;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 553;
        match(TOKEN_COMMA);
      }

      state = 556;
      match(TOKEN_RBRACE);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ArrayLiteralContext arrayLiteral() {
    dynamic _localctx = ArrayLiteralContext(context, state);
    enterRule(_localctx, 82, RULE_arrayLiteral);
    int _la;
    try {
      int _alt;
      enterOuterAlt(_localctx, 1);
      state = 558;
      match(TOKEN_LBRACE);
      state = 561;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_BOOL:
      case TOKEN_BIT:
      case TOKEN_INT:
      case TOKEN_UINT:
      case TOKEN_FLOAT:
      case TOKEN_ANGLE:
      case TOKEN_COMPLEX:
      case TOKEN_ARRAY:
      case TOKEN_DURATION:
      case TOKEN_STRETCH:
      case TOKEN_STRING:
      case TOKEN_DURATIONOF:
      case TOKEN_BooleanLiteral:
      case TOKEN_LPAREN:
      case TOKEN_MINUS:
      case TOKEN_TILDE:
      case TOKEN_EXCLAMATION_POINT:
      case TOKEN_ImaginaryLiteral:
      case TOKEN_BinaryIntegerLiteral:
      case TOKEN_OctalIntegerLiteral:
      case TOKEN_DecimalIntegerLiteral:
      case TOKEN_HexIntegerLiteral:
      case TOKEN_Identifier:
      case TOKEN_HardwareQubit:
      case TOKEN_FloatLiteral:
      case TOKEN_TimingLiteral:
      case TOKEN_BitstringLiteral:
      case TOKEN_StringLiteral:
        state = 559;
        expression(0);
        break;
      case TOKEN_LBRACE:
        state = 560;
        arrayLiteral();
        break;
      default:
        throw NoViableAltException(this);
      }
      state = 570;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 57, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 563;
          match(TOKEN_COMMA);
          state = 566;
          errorHandler.sync(this);
          switch (tokenStream.LA(1)!) {
          case TOKEN_BOOL:
          case TOKEN_BIT:
          case TOKEN_INT:
          case TOKEN_UINT:
          case TOKEN_FLOAT:
          case TOKEN_ANGLE:
          case TOKEN_COMPLEX:
          case TOKEN_ARRAY:
          case TOKEN_DURATION:
          case TOKEN_STRETCH:
          case TOKEN_STRING:
          case TOKEN_DURATIONOF:
          case TOKEN_BooleanLiteral:
          case TOKEN_LPAREN:
          case TOKEN_MINUS:
          case TOKEN_TILDE:
          case TOKEN_EXCLAMATION_POINT:
          case TOKEN_ImaginaryLiteral:
          case TOKEN_BinaryIntegerLiteral:
          case TOKEN_OctalIntegerLiteral:
          case TOKEN_DecimalIntegerLiteral:
          case TOKEN_HexIntegerLiteral:
          case TOKEN_Identifier:
          case TOKEN_HardwareQubit:
          case TOKEN_FloatLiteral:
          case TOKEN_TimingLiteral:
          case TOKEN_BitstringLiteral:
          case TOKEN_StringLiteral:
            state = 564;
            expression(0);
            break;
          case TOKEN_LBRACE:
            state = 565;
            arrayLiteral();
            break;
          default:
            throw NoViableAltException(this);
          } 
        }
        state = 572;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 57, context);
      }
      state = 574;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 573;
        match(TOKEN_COMMA);
      }

      state = 576;
      match(TOKEN_RBRACE);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  IndexOperatorContext indexOperator() {
    dynamic _localctx = IndexOperatorContext(context, state);
    enterRule(_localctx, 84, RULE_indexOperator);
    int _la;
    try {
      int _alt;
      enterOuterAlt(_localctx, 1);
      state = 578;
      match(TOKEN_LBRACKET);
      state = 597;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_LBRACE:
        state = 579;
        setExpression();
        break;
      case TOKEN_BOOL:
      case TOKEN_BIT:
      case TOKEN_INT:
      case TOKEN_UINT:
      case TOKEN_FLOAT:
      case TOKEN_ANGLE:
      case TOKEN_COMPLEX:
      case TOKEN_ARRAY:
      case TOKEN_DURATION:
      case TOKEN_STRETCH:
      case TOKEN_STRING:
      case TOKEN_DURATIONOF:
      case TOKEN_BooleanLiteral:
      case TOKEN_LPAREN:
      case TOKEN_COLON:
      case TOKEN_MINUS:
      case TOKEN_TILDE:
      case TOKEN_EXCLAMATION_POINT:
      case TOKEN_ImaginaryLiteral:
      case TOKEN_BinaryIntegerLiteral:
      case TOKEN_OctalIntegerLiteral:
      case TOKEN_DecimalIntegerLiteral:
      case TOKEN_HexIntegerLiteral:
      case TOKEN_Identifier:
      case TOKEN_HardwareQubit:
      case TOKEN_FloatLiteral:
      case TOKEN_TimingLiteral:
      case TOKEN_BitstringLiteral:
      case TOKEN_StringLiteral:
        state = 582;
        errorHandler.sync(this);
        switch (interpreter!.adaptivePredict(tokenStream, 59, context)) {
        case 1:
          state = 580;
          expression(0);
          break;
        case 2:
          state = 581;
          rangeExpression();
          break;
        }
        state = 591;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 61, context);
        while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
          if (_alt == 1) {
            state = 584;
            match(TOKEN_COMMA);
            state = 587;
            errorHandler.sync(this);
            switch (interpreter!.adaptivePredict(tokenStream, 60, context)) {
            case 1:
              state = 585;
              expression(0);
              break;
            case 2:
              state = 586;
              rangeExpression();
              break;
            } 
          }
          state = 593;
          errorHandler.sync(this);
          _alt = interpreter!.adaptivePredict(tokenStream, 61, context);
        }
        state = 595;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_COMMA) {
          state = 594;
          match(TOKEN_COMMA);
        }

        break;
      default:
        throw NoViableAltException(this);
      }
      state = 599;
      match(TOKEN_RBRACKET);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  IndexedIdentifierContext indexedIdentifier() {
    dynamic _localctx = IndexedIdentifierContext(context, state);
    enterRule(_localctx, 86, RULE_indexedIdentifier);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 601;
      match(TOKEN_Identifier);
      state = 605;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_LBRACKET) {
        state = 602;
        indexOperator();
        state = 607;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ReturnSignatureContext returnSignature() {
    dynamic _localctx = ReturnSignatureContext(context, state);
    enterRule(_localctx, 88, RULE_returnSignature);
    try {
      enterOuterAlt(_localctx, 1);
      state = 608;
      match(TOKEN_ARROW);
      state = 609;
      scalarType();
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  GateModifierContext gateModifier() {
    dynamic _localctx = GateModifierContext(context, state);
    enterRule(_localctx, 90, RULE_gateModifier);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 624;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_INV:
        state = 611;
        match(TOKEN_INV);
        break;
      case TOKEN_POW:
        state = 612;
        match(TOKEN_POW);
        state = 613;
        match(TOKEN_LPAREN);
        state = 614;
        expression(0);
        state = 615;
        match(TOKEN_RPAREN);
        break;
      case TOKEN_CTRL:
      case TOKEN_NEGCTRL:
        state = 617;
        _la = tokenStream.LA(1)!;
        if (!(_la == TOKEN_CTRL || _la == TOKEN_NEGCTRL)) {
        errorHandler.recoverInline(this);
        } else {
          if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
          errorHandler.reportMatch(this);
          consume();
        }
        state = 622;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LPAREN) {
          state = 618;
          match(TOKEN_LPAREN);
          state = 619;
          expression(0);
          state = 620;
          match(TOKEN_RPAREN);
        }

        break;
      default:
        throw NoViableAltException(this);
      }
      state = 626;
      match(TOKEN_AT);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ScalarTypeContext scalarType() {
    dynamic _localctx = ScalarTypeContext(context, state);
    enterRule(_localctx, 92, RULE_scalarType);
    int _la;
    try {
      state = 659;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_BIT:
        enterOuterAlt(_localctx, 1);
        state = 628;
        match(TOKEN_BIT);
        state = 630;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LBRACKET) {
          state = 629;
          designator();
        }

        break;
      case TOKEN_INT:
        enterOuterAlt(_localctx, 2);
        state = 632;
        match(TOKEN_INT);
        state = 634;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LBRACKET) {
          state = 633;
          designator();
        }

        break;
      case TOKEN_UINT:
        enterOuterAlt(_localctx, 3);
        state = 636;
        match(TOKEN_UINT);
        state = 638;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LBRACKET) {
          state = 637;
          designator();
        }

        break;
      case TOKEN_FLOAT:
        enterOuterAlt(_localctx, 4);
        state = 640;
        match(TOKEN_FLOAT);
        state = 642;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LBRACKET) {
          state = 641;
          designator();
        }

        break;
      case TOKEN_ANGLE:
        enterOuterAlt(_localctx, 5);
        state = 644;
        match(TOKEN_ANGLE);
        state = 646;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LBRACKET) {
          state = 645;
          designator();
        }

        break;
      case TOKEN_BOOL:
        enterOuterAlt(_localctx, 6);
        state = 648;
        match(TOKEN_BOOL);
        break;
      case TOKEN_DURATION:
        enterOuterAlt(_localctx, 7);
        state = 649;
        match(TOKEN_DURATION);
        break;
      case TOKEN_STRETCH:
        enterOuterAlt(_localctx, 8);
        state = 650;
        match(TOKEN_STRETCH);
        break;
      case TOKEN_COMPLEX:
        enterOuterAlt(_localctx, 9);
        state = 651;
        match(TOKEN_COMPLEX);
        state = 656;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LBRACKET) {
          state = 652;
          match(TOKEN_LBRACKET);
          state = 653;
          scalarType();
          state = 654;
          match(TOKEN_RBRACKET);
        }

        break;
      case TOKEN_STRING:
        enterOuterAlt(_localctx, 10);
        state = 658;
        match(TOKEN_STRING);
        break;
      default:
        throw NoViableAltException(this);
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  QubitTypeContext qubitType() {
    dynamic _localctx = QubitTypeContext(context, state);
    enterRule(_localctx, 94, RULE_qubitType);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 661;
      match(TOKEN_QUBIT);
      state = 663;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_LBRACKET) {
        state = 662;
        designator();
      }

    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ArrayTypeContext arrayType() {
    dynamic _localctx = ArrayTypeContext(context, state);
    enterRule(_localctx, 96, RULE_arrayType);
    try {
      enterOuterAlt(_localctx, 1);
      state = 665;
      match(TOKEN_ARRAY);
      state = 666;
      match(TOKEN_LBRACKET);
      state = 667;
      scalarType();
      state = 668;
      match(TOKEN_COMMA);
      state = 669;
      expressionList();
      state = 670;
      match(TOKEN_RBRACKET);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ArrayReferenceTypeContext arrayReferenceType() {
    dynamic _localctx = ArrayReferenceTypeContext(context, state);
    enterRule(_localctx, 98, RULE_arrayReferenceType);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 672;
      _la = tokenStream.LA(1)!;
      if (!(_la == TOKEN_READONLY || _la == TOKEN_MUTABLE)) {
      errorHandler.recoverInline(this);
      } else {
        if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
      state = 673;
      match(TOKEN_ARRAY);
      state = 674;
      match(TOKEN_LBRACKET);
      state = 675;
      scalarType();
      state = 676;
      match(TOKEN_COMMA);
      state = 681;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_BOOL:
      case TOKEN_BIT:
      case TOKEN_INT:
      case TOKEN_UINT:
      case TOKEN_FLOAT:
      case TOKEN_ANGLE:
      case TOKEN_COMPLEX:
      case TOKEN_ARRAY:
      case TOKEN_DURATION:
      case TOKEN_STRETCH:
      case TOKEN_STRING:
      case TOKEN_DURATIONOF:
      case TOKEN_BooleanLiteral:
      case TOKEN_LPAREN:
      case TOKEN_MINUS:
      case TOKEN_TILDE:
      case TOKEN_EXCLAMATION_POINT:
      case TOKEN_ImaginaryLiteral:
      case TOKEN_BinaryIntegerLiteral:
      case TOKEN_OctalIntegerLiteral:
      case TOKEN_DecimalIntegerLiteral:
      case TOKEN_HexIntegerLiteral:
      case TOKEN_Identifier:
      case TOKEN_HardwareQubit:
      case TOKEN_FloatLiteral:
      case TOKEN_TimingLiteral:
      case TOKEN_BitstringLiteral:
      case TOKEN_StringLiteral:
        state = 677;
        expressionList();
        break;
      case TOKEN_DIM:
        state = 678;
        match(TOKEN_DIM);
        state = 679;
        match(TOKEN_EQUALS);
        state = 680;
        expression(0);
        break;
      default:
        throw NoViableAltException(this);
      }
      state = 683;
      match(TOKEN_RBRACKET);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  DesignatorContext designator() {
    dynamic _localctx = DesignatorContext(context, state);
    enterRule(_localctx, 100, RULE_designator);
    try {
      enterOuterAlt(_localctx, 1);
      state = 685;
      match(TOKEN_LBRACKET);
      state = 686;
      expression(0);
      state = 687;
      match(TOKEN_RBRACKET);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  DefcalTargetContext defcalTarget() {
    dynamic _localctx = DefcalTargetContext(context, state);
    enterRule(_localctx, 102, RULE_defcalTarget);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 689;
      _la = tokenStream.LA(1)!;
      if (!(((((_la - 49)) & ~0x3f) == 0 && ((1 << (_la - 49)) & 4398046511111) != 0))) {
      errorHandler.recoverInline(this);
      } else {
        if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  DefcalArgumentDefinitionContext defcalArgumentDefinition() {
    dynamic _localctx = DefcalArgumentDefinitionContext(context, state);
    enterRule(_localctx, 104, RULE_defcalArgumentDefinition);
    try {
      state = 693;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 76, context)) {
      case 1:
        enterOuterAlt(_localctx, 1);
        state = 691;
        expression(0);
        break;
      case 2:
        enterOuterAlt(_localctx, 2);
        state = 692;
        argumentDefinition();
        break;
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  DefcalOperandContext defcalOperand() {
    dynamic _localctx = DefcalOperandContext(context, state);
    enterRule(_localctx, 106, RULE_defcalOperand);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 695;
      _la = tokenStream.LA(1)!;
      if (!(_la == TOKEN_Identifier || _la == TOKEN_HardwareQubit)) {
      errorHandler.recoverInline(this);
      } else {
        if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  GateOperandContext gateOperand() {
    dynamic _localctx = GateOperandContext(context, state);
    enterRule(_localctx, 108, RULE_gateOperand);
    try {
      state = 699;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_Identifier:
        enterOuterAlt(_localctx, 1);
        state = 697;
        indexedIdentifier();
        break;
      case TOKEN_HardwareQubit:
        enterOuterAlt(_localctx, 2);
        state = 698;
        match(TOKEN_HardwareQubit);
        break;
      default:
        throw NoViableAltException(this);
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ExternArgumentContext externArgument() {
    dynamic _localctx = ExternArgumentContext(context, state);
    enterRule(_localctx, 110, RULE_externArgument);
    int _la;
    try {
      state = 707;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_BOOL:
      case TOKEN_BIT:
      case TOKEN_INT:
      case TOKEN_UINT:
      case TOKEN_FLOAT:
      case TOKEN_ANGLE:
      case TOKEN_COMPLEX:
      case TOKEN_DURATION:
      case TOKEN_STRETCH:
      case TOKEN_STRING:
        enterOuterAlt(_localctx, 1);
        state = 701;
        scalarType();
        break;
      case TOKEN_READONLY:
      case TOKEN_MUTABLE:
        enterOuterAlt(_localctx, 2);
        state = 702;
        arrayReferenceType();
        break;
      case TOKEN_CREG:
        enterOuterAlt(_localctx, 3);
        state = 703;
        match(TOKEN_CREG);
        state = 705;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LBRACKET) {
          state = 704;
          designator();
        }

        break;
      default:
        throw NoViableAltException(this);
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ArgumentDefinitionContext argumentDefinition() {
    dynamic _localctx = ArgumentDefinitionContext(context, state);
    enterRule(_localctx, 112, RULE_argumentDefinition);
    int _la;
    try {
      state = 723;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_BOOL:
      case TOKEN_BIT:
      case TOKEN_INT:
      case TOKEN_UINT:
      case TOKEN_FLOAT:
      case TOKEN_ANGLE:
      case TOKEN_COMPLEX:
      case TOKEN_DURATION:
      case TOKEN_STRETCH:
      case TOKEN_STRING:
        enterOuterAlt(_localctx, 1);
        state = 709;
        scalarType();
        state = 710;
        match(TOKEN_Identifier);
        break;
      case TOKEN_QUBIT:
        enterOuterAlt(_localctx, 2);
        state = 712;
        qubitType();
        state = 713;
        match(TOKEN_Identifier);
        break;
      case TOKEN_QREG:
      case TOKEN_CREG:
        enterOuterAlt(_localctx, 3);
        state = 715;
        _la = tokenStream.LA(1)!;
        if (!(_la == TOKEN_QREG || _la == TOKEN_CREG)) {
        errorHandler.recoverInline(this);
        } else {
          if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
          errorHandler.reportMatch(this);
          consume();
        }
        state = 716;
        match(TOKEN_Identifier);
        state = 718;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LBRACKET) {
          state = 717;
          designator();
        }

        break;
      case TOKEN_READONLY:
      case TOKEN_MUTABLE:
        enterOuterAlt(_localctx, 4);
        state = 720;
        arrayReferenceType();
        state = 721;
        match(TOKEN_Identifier);
        break;
      default:
        throw NoViableAltException(this);
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ArgumentDefinitionListContext argumentDefinitionList() {
    dynamic _localctx = ArgumentDefinitionListContext(context, state);
    enterRule(_localctx, 114, RULE_argumentDefinitionList);
    int _la;
    try {
      int _alt;
      enterOuterAlt(_localctx, 1);
      state = 725;
      argumentDefinition();
      state = 730;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 82, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 726;
          match(TOKEN_COMMA);
          state = 727;
          argumentDefinition(); 
        }
        state = 732;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 82, context);
      }
      state = 734;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 733;
        match(TOKEN_COMMA);
      }

    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  DefcalArgumentDefinitionListContext defcalArgumentDefinitionList() {
    dynamic _localctx = DefcalArgumentDefinitionListContext(context, state);
    enterRule(_localctx, 116, RULE_defcalArgumentDefinitionList);
    int _la;
    try {
      int _alt;
      enterOuterAlt(_localctx, 1);
      state = 736;
      defcalArgumentDefinition();
      state = 741;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 84, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 737;
          match(TOKEN_COMMA);
          state = 738;
          defcalArgumentDefinition(); 
        }
        state = 743;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 84, context);
      }
      state = 745;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 744;
        match(TOKEN_COMMA);
      }

    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  DefcalOperandListContext defcalOperandList() {
    dynamic _localctx = DefcalOperandListContext(context, state);
    enterRule(_localctx, 118, RULE_defcalOperandList);
    int _la;
    try {
      int _alt;
      enterOuterAlt(_localctx, 1);
      state = 747;
      defcalOperand();
      state = 752;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 86, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 748;
          match(TOKEN_COMMA);
          state = 749;
          defcalOperand(); 
        }
        state = 754;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 86, context);
      }
      state = 756;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 755;
        match(TOKEN_COMMA);
      }

    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ExpressionListContext expressionList() {
    dynamic _localctx = ExpressionListContext(context, state);
    enterRule(_localctx, 120, RULE_expressionList);
    int _la;
    try {
      int _alt;
      enterOuterAlt(_localctx, 1);
      state = 758;
      expression(0);
      state = 763;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 88, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 759;
          match(TOKEN_COMMA);
          state = 760;
          expression(0); 
        }
        state = 765;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 88, context);
      }
      state = 767;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 766;
        match(TOKEN_COMMA);
      }

    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  IdentifierListContext identifierList() {
    dynamic _localctx = IdentifierListContext(context, state);
    enterRule(_localctx, 122, RULE_identifierList);
    int _la;
    try {
      int _alt;
      enterOuterAlt(_localctx, 1);
      state = 769;
      match(TOKEN_Identifier);
      state = 774;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 90, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 770;
          match(TOKEN_COMMA);
          state = 771;
          match(TOKEN_Identifier); 
        }
        state = 776;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 90, context);
      }
      state = 778;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 777;
        match(TOKEN_COMMA);
      }

    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  GateOperandListContext gateOperandList() {
    dynamic _localctx = GateOperandListContext(context, state);
    enterRule(_localctx, 124, RULE_gateOperandList);
    int _la;
    try {
      int _alt;
      enterOuterAlt(_localctx, 1);
      state = 780;
      gateOperand();
      state = 785;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 92, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 781;
          match(TOKEN_COMMA);
          state = 782;
          gateOperand(); 
        }
        state = 787;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 92, context);
      }
      state = 789;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 788;
        match(TOKEN_COMMA);
      }

    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  ExternArgumentListContext externArgumentList() {
    dynamic _localctx = ExternArgumentListContext(context, state);
    enterRule(_localctx, 126, RULE_externArgumentList);
    int _la;
    try {
      int _alt;
      enterOuterAlt(_localctx, 1);
      state = 791;
      externArgument();
      state = 796;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 94, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 792;
          match(TOKEN_COMMA);
          state = 793;
          externArgument(); 
        }
        state = 798;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 94, context);
      }
      state = 800;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 799;
        match(TOKEN_COMMA);
      }

    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  @override
  bool sempred(RuleContext? _localctx, int ruleIndex, int predIndex) {
    switch (ruleIndex) {
    case 35:
      return _expression_sempred(_localctx as ExpressionContext?, predIndex);
    }
    return true;
  }
  bool _expression_sempred(dynamic _localctx, int predIndex) {
    switch (predIndex) {
      case 0: return precpred(context, 16);
      case 1: return precpred(context, 14);
      case 2: return precpred(context, 13);
      case 3: return precpred(context, 12);
      case 4: return precpred(context, 11);
      case 5: return precpred(context, 10);
      case 6: return precpred(context, 9);
      case 7: return precpred(context, 8);
      case 8: return precpred(context, 7);
      case 9: return precpred(context, 6);
      case 10: return precpred(context, 5);
      case 11: return precpred(context, 17);
    }
    return true;
  }

  static const List<int> _serializedATN = [
      4,1,110,803,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,
      6,2,7,7,7,2,8,7,8,2,9,7,9,2,10,7,10,2,11,7,11,2,12,7,12,2,13,7,13,
      2,14,7,14,2,15,7,15,2,16,7,16,2,17,7,17,2,18,7,18,2,19,7,19,2,20,7,
      20,2,21,7,21,2,22,7,22,2,23,7,23,2,24,7,24,2,25,7,25,2,26,7,26,2,27,
      7,27,2,28,7,28,2,29,7,29,2,30,7,30,2,31,7,31,2,32,7,32,2,33,7,33,2,
      34,7,34,2,35,7,35,2,36,7,36,2,37,7,37,2,38,7,38,2,39,7,39,2,40,7,40,
      2,41,7,41,2,42,7,42,2,43,7,43,2,44,7,44,2,45,7,45,2,46,7,46,2,47,7,
      47,2,48,7,48,2,49,7,49,2,50,7,50,2,51,7,51,2,52,7,52,2,53,7,53,2,54,
      7,54,2,55,7,55,2,56,7,56,2,57,7,57,2,58,7,58,2,59,7,59,2,60,7,60,2,
      61,7,61,2,62,7,62,2,63,7,63,1,0,3,0,130,8,0,1,0,5,0,133,8,0,10,0,12,
      0,136,9,0,1,0,1,0,1,1,1,1,1,1,1,1,1,2,1,2,5,2,146,8,2,10,2,12,2,149,
      9,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,
      2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,3,2,179,8,2,3,2,
      181,8,2,1,3,1,3,3,3,185,8,3,1,4,1,4,5,4,189,8,4,10,4,12,4,192,9,4,
      1,4,1,4,1,5,1,5,1,5,1,6,1,6,3,6,201,8,6,1,7,1,7,1,7,1,7,1,8,1,8,1,
      8,1,8,1,9,1,9,1,9,1,10,1,10,1,10,1,11,1,11,1,11,1,12,1,12,3,12,222,
      8,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,3,12,232,8,12,1,12,1,
      12,1,13,1,13,1,13,1,13,1,13,1,13,1,13,3,13,243,8,13,1,14,1,14,1,14,
      3,14,248,8,14,1,14,1,14,1,15,1,15,1,15,1,15,1,15,1,15,1,16,1,16,3,
      16,260,8,16,1,16,1,16,1,17,1,17,3,17,266,8,17,1,17,1,17,1,18,1,18,
      1,18,3,18,273,8,18,1,18,1,18,1,19,5,19,278,8,19,10,19,12,19,281,9,
      19,1,19,1,19,1,19,3,19,286,8,19,1,19,3,19,289,8,19,1,19,3,19,292,8,
      19,1,19,1,19,1,19,1,19,5,19,298,8,19,10,19,12,19,301,9,19,1,19,1,19,
      1,19,3,19,306,8,19,1,19,3,19,309,8,19,1,19,3,19,312,8,19,1,19,3,19,
      315,8,19,1,19,3,19,318,8,19,1,20,1,20,1,20,3,20,323,8,20,1,20,1,20,
      1,21,1,21,1,21,1,21,1,22,1,22,1,22,1,22,1,22,1,22,1,23,1,23,3,23,339,
      8,23,1,23,1,23,1,23,3,23,344,8,23,1,23,1,23,1,24,1,24,1,24,1,24,1,
      24,3,24,353,8,24,1,24,1,24,1,25,1,25,1,25,3,25,360,8,25,1,25,1,25,
      1,25,1,26,1,26,1,26,3,26,368,8,26,1,26,1,26,1,27,1,27,1,27,1,27,1,
      28,1,28,1,28,1,28,3,28,380,8,28,1,28,1,28,3,28,384,8,28,1,28,1,28,
      1,29,1,29,1,29,1,29,3,29,392,8,29,1,29,1,29,3,29,396,8,29,1,29,1,29,
      1,30,1,30,1,30,1,30,3,30,404,8,30,1,30,3,30,407,8,30,1,30,1,30,1,30,
      1,31,1,31,1,31,1,31,3,31,416,8,31,1,31,1,31,1,32,1,32,1,32,1,33,1,
      33,1,33,3,33,426,8,33,1,33,1,33,1,34,1,34,1,34,1,34,3,34,434,8,34,
      1,34,3,34,437,8,34,1,34,1,34,3,34,441,8,34,1,34,1,34,3,34,445,8,34,
      1,34,1,34,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,3,35,458,8,
      35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,3,35,
      472,8,35,1,35,1,35,3,35,476,8,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,
      1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,
      35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,
      1,35,5,35,513,8,35,10,35,12,35,516,9,35,1,36,1,36,1,36,5,36,521,8,
      36,10,36,12,36,524,9,36,1,37,1,37,1,37,3,37,529,8,37,1,38,1,38,1,38,
      1,39,3,39,535,8,39,1,39,1,39,3,39,539,8,39,1,39,1,39,3,39,543,8,39,
      1,40,1,40,1,40,1,40,5,40,549,8,40,10,40,12,40,552,9,40,1,40,3,40,555,
      8,40,1,40,1,40,1,41,1,41,1,41,3,41,562,8,41,1,41,1,41,1,41,3,41,567,
      8,41,5,41,569,8,41,10,41,12,41,572,9,41,1,41,3,41,575,8,41,1,41,1,
      41,1,42,1,42,1,42,1,42,3,42,583,8,42,1,42,1,42,1,42,3,42,588,8,42,
      5,42,590,8,42,10,42,12,42,593,9,42,1,42,3,42,596,8,42,3,42,598,8,42,
      1,42,1,42,1,43,1,43,5,43,604,8,43,10,43,12,43,607,9,43,1,44,1,44,1,
      44,1,45,1,45,1,45,1,45,1,45,1,45,1,45,1,45,1,45,1,45,1,45,3,45,623,
      8,45,3,45,625,8,45,1,45,1,45,1,46,1,46,3,46,631,8,46,1,46,1,46,3,46,
      635,8,46,1,46,1,46,3,46,639,8,46,1,46,1,46,3,46,643,8,46,1,46,1,46,
      3,46,647,8,46,1,46,1,46,1,46,1,46,1,46,1,46,1,46,1,46,3,46,657,8,46,
      1,46,3,46,660,8,46,1,47,1,47,3,47,664,8,47,1,48,1,48,1,48,1,48,1,48,
      1,48,1,48,1,49,1,49,1,49,1,49,1,49,1,49,1,49,1,49,1,49,3,49,682,8,
      49,1,49,1,49,1,50,1,50,1,50,1,50,1,51,1,51,1,52,1,52,3,52,694,8,52,
      1,53,1,53,1,54,1,54,3,54,700,8,54,1,55,1,55,1,55,1,55,3,55,706,8,55,
      3,55,708,8,55,1,56,1,56,1,56,1,56,1,56,1,56,1,56,1,56,1,56,3,56,719,
      8,56,1,56,1,56,1,56,3,56,724,8,56,1,57,1,57,1,57,5,57,729,8,57,10,
      57,12,57,732,9,57,1,57,3,57,735,8,57,1,58,1,58,1,58,5,58,740,8,58,
      10,58,12,58,743,9,58,1,58,3,58,746,8,58,1,59,1,59,1,59,5,59,751,8,
      59,10,59,12,59,754,9,59,1,59,3,59,757,8,59,1,60,1,60,1,60,5,60,762,
      8,60,10,60,12,60,765,9,60,1,60,3,60,768,8,60,1,61,1,61,1,61,5,61,773,
      8,61,10,61,12,61,776,9,61,1,61,3,61,779,8,61,1,62,1,62,1,62,5,62,784,
      8,62,10,62,12,62,787,9,62,1,62,3,62,790,8,62,1,63,1,63,1,63,5,63,795,
      8,63,10,63,12,63,798,9,63,1,63,3,63,801,8,63,1,63,0,1,70,64,0,2,4,
      6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,
      52,54,56,58,60,62,64,66,68,70,72,74,76,78,80,82,84,86,88,90,92,94,
      96,98,100,102,104,106,108,110,112,114,116,118,120,122,124,126,0,11,
      1,0,22,23,2,0,27,27,29,29,2,0,64,64,82,82,2,0,68,68,79,80,2,0,53,53,
      86,96,2,0,69,69,71,72,2,0,66,66,68,68,1,0,45,46,1,0,25,26,2,0,49,51,
      91,91,1,0,91,92,889,0,129,1,0,0,0,2,139,1,0,0,0,4,180,1,0,0,0,6,182,
      1,0,0,0,8,186,1,0,0,0,10,195,1,0,0,0,12,200,1,0,0,0,14,202,1,0,0,0,
      16,206,1,0,0,0,18,210,1,0,0,0,20,213,1,0,0,0,22,216,1,0,0,0,24,219,
      1,0,0,0,26,235,1,0,0,0,28,244,1,0,0,0,30,251,1,0,0,0,32,257,1,0,0,
      0,34,263,1,0,0,0,36,269,1,0,0,0,38,317,1,0,0,0,40,319,1,0,0,0,42,326,
      1,0,0,0,44,330,1,0,0,0,46,338,1,0,0,0,48,347,1,0,0,0,50,356,1,0,0,
      0,52,364,1,0,0,0,54,371,1,0,0,0,56,375,1,0,0,0,58,387,1,0,0,0,60,399,
      1,0,0,0,62,411,1,0,0,0,64,419,1,0,0,0,66,422,1,0,0,0,68,429,1,0,0,
      0,70,475,1,0,0,0,72,517,1,0,0,0,74,528,1,0,0,0,76,530,1,0,0,0,78,534,
      1,0,0,0,80,544,1,0,0,0,82,558,1,0,0,0,84,578,1,0,0,0,86,601,1,0,0,
      0,88,608,1,0,0,0,90,624,1,0,0,0,92,659,1,0,0,0,94,661,1,0,0,0,96,665,
      1,0,0,0,98,672,1,0,0,0,100,685,1,0,0,0,102,689,1,0,0,0,104,693,1,0,
      0,0,106,695,1,0,0,0,108,699,1,0,0,0,110,707,1,0,0,0,112,723,1,0,0,
      0,114,725,1,0,0,0,116,736,1,0,0,0,118,747,1,0,0,0,120,758,1,0,0,0,
      122,769,1,0,0,0,124,780,1,0,0,0,126,791,1,0,0,0,128,130,3,2,1,0,129,
      128,1,0,0,0,129,130,1,0,0,0,130,134,1,0,0,0,131,133,3,4,2,0,132,131,
      1,0,0,0,133,136,1,0,0,0,134,132,1,0,0,0,134,135,1,0,0,0,135,137,1,
      0,0,0,136,134,1,0,0,0,137,138,5,0,0,1,138,1,1,0,0,0,139,140,5,1,0,
      0,140,141,5,102,0,0,141,142,5,61,0,0,142,3,1,0,0,0,143,181,3,10,5,
      0,144,146,3,6,3,0,145,144,1,0,0,0,146,149,1,0,0,0,147,145,1,0,0,0,
      147,148,1,0,0,0,148,178,1,0,0,0,149,147,1,0,0,0,150,179,3,44,22,0,
      151,179,3,62,31,0,152,179,3,32,16,0,153,179,3,34,17,0,154,179,3,18,
      9,0,155,179,3,66,33,0,156,179,3,14,7,0,157,179,3,46,23,0,158,179,3,
      48,24,0,159,179,3,20,10,0,160,179,3,56,28,0,161,179,3,68,34,0,162,
      179,3,36,18,0,163,179,3,22,11,0,164,179,3,64,32,0,165,179,3,58,29,
      0,166,179,3,24,12,0,167,179,3,38,19,0,168,179,3,60,30,0,169,179,3,
      26,13,0,170,179,3,16,8,0,171,179,3,50,25,0,172,179,3,40,20,0,173,179,
      3,52,26,0,174,179,3,54,27,0,175,179,3,42,21,0,176,179,3,28,14,0,177,
      179,3,30,15,0,178,150,1,0,0,0,178,151,1,0,0,0,178,152,1,0,0,0,178,
      153,1,0,0,0,178,154,1,0,0,0,178,155,1,0,0,0,178,156,1,0,0,0,178,157,
      1,0,0,0,178,158,1,0,0,0,178,159,1,0,0,0,178,160,1,0,0,0,178,161,1,
      0,0,0,178,162,1,0,0,0,178,163,1,0,0,0,178,164,1,0,0,0,178,165,1,0,
      0,0,178,166,1,0,0,0,178,167,1,0,0,0,178,168,1,0,0,0,178,169,1,0,0,
      0,178,170,1,0,0,0,178,171,1,0,0,0,178,172,1,0,0,0,178,173,1,0,0,0,
      178,174,1,0,0,0,178,175,1,0,0,0,178,176,1,0,0,0,178,177,1,0,0,0,179,
      181,1,0,0,0,180,143,1,0,0,0,180,147,1,0,0,0,181,5,1,0,0,0,182,184,
      5,21,0,0,183,185,5,105,0,0,184,183,1,0,0,0,184,185,1,0,0,0,185,7,1,
      0,0,0,186,190,5,56,0,0,187,189,3,4,2,0,188,187,1,0,0,0,189,192,1,0,
      0,0,190,188,1,0,0,0,190,191,1,0,0,0,191,193,1,0,0,0,192,190,1,0,0,
      0,193,194,5,57,0,0,194,9,1,0,0,0,195,196,5,20,0,0,196,197,5,105,0,
      0,197,11,1,0,0,0,198,201,3,4,2,0,199,201,3,8,4,0,200,198,1,0,0,0,200,
      199,1,0,0,0,201,13,1,0,0,0,202,203,5,3,0,0,203,204,5,96,0,0,204,205,
      5,61,0,0,205,15,1,0,0,0,206,207,5,2,0,0,207,208,5,96,0,0,208,209,5,
      61,0,0,209,17,1,0,0,0,210,211,5,11,0,0,211,212,5,61,0,0,212,19,1,0,
      0,0,213,214,5,12,0,0,214,215,5,61,0,0,215,21,1,0,0,0,216,217,5,15,
      0,0,217,218,5,61,0,0,218,23,1,0,0,0,219,221,5,17,0,0,220,222,3,92,
      46,0,221,220,1,0,0,0,221,222,1,0,0,0,222,223,1,0,0,0,223,224,5,91,
      0,0,224,231,5,19,0,0,225,232,3,80,40,0,226,227,5,54,0,0,227,228,3,
      78,39,0,228,229,5,55,0,0,229,232,1,0,0,0,230,232,3,70,35,0,231,225,
      1,0,0,0,231,226,1,0,0,0,231,230,1,0,0,0,232,233,1,0,0,0,233,234,3,
      12,6,0,234,25,1,0,0,0,235,236,5,13,0,0,236,237,5,58,0,0,237,238,3,
      70,35,0,238,239,5,59,0,0,239,242,3,12,6,0,240,241,5,14,0,0,241,243,
      3,12,6,0,242,240,1,0,0,0,242,243,1,0,0,0,243,27,1,0,0,0,244,247,5,
      16,0,0,245,248,3,70,35,0,246,248,3,76,38,0,247,245,1,0,0,0,247,246,
      1,0,0,0,247,248,1,0,0,0,248,249,1,0,0,0,249,250,5,61,0,0,250,29,1,
      0,0,0,251,252,5,18,0,0,252,253,5,58,0,0,253,254,3,70,35,0,254,255,
      5,59,0,0,255,256,3,12,6,0,256,31,1,0,0,0,257,259,5,52,0,0,258,260,
      3,124,62,0,259,258,1,0,0,0,259,260,1,0,0,0,260,261,1,0,0,0,261,262,
      5,61,0,0,262,33,1,0,0,0,263,265,5,9,0,0,264,266,3,100,50,0,265,264,
      1,0,0,0,265,266,1,0,0,0,266,267,1,0,0,0,267,268,3,8,4,0,268,35,1,0,
      0,0,269,270,5,49,0,0,270,272,3,100,50,0,271,273,3,124,62,0,272,271,
      1,0,0,0,272,273,1,0,0,0,273,274,1,0,0,0,274,275,5,61,0,0,275,37,1,
      0,0,0,276,278,3,90,45,0,277,276,1,0,0,0,278,281,1,0,0,0,279,277,1,
      0,0,0,279,280,1,0,0,0,280,282,1,0,0,0,281,279,1,0,0,0,282,288,5,91,
      0,0,283,285,5,58,0,0,284,286,3,120,60,0,285,284,1,0,0,0,285,286,1,
      0,0,0,286,287,1,0,0,0,287,289,5,59,0,0,288,283,1,0,0,0,288,289,1,0,
      0,0,289,291,1,0,0,0,290,292,3,100,50,0,291,290,1,0,0,0,291,292,1,0,
      0,0,292,293,1,0,0,0,293,294,3,124,62,0,294,295,5,61,0,0,295,318,1,
      0,0,0,296,298,3,90,45,0,297,296,1,0,0,0,298,301,1,0,0,0,299,297,1,
      0,0,0,299,300,1,0,0,0,300,302,1,0,0,0,301,299,1,0,0,0,302,308,5,42,
      0,0,303,305,5,58,0,0,304,306,3,120,60,0,305,304,1,0,0,0,305,306,1,
      0,0,0,306,307,1,0,0,0,307,309,5,59,0,0,308,303,1,0,0,0,308,309,1,0,
      0,0,309,311,1,0,0,0,310,312,3,100,50,0,311,310,1,0,0,0,311,312,1,0,
      0,0,312,314,1,0,0,0,313,315,3,124,62,0,314,313,1,0,0,0,314,315,1,0,
      0,0,315,316,1,0,0,0,316,318,5,61,0,0,317,279,1,0,0,0,317,299,1,0,0,
      0,318,39,1,0,0,0,319,322,3,76,38,0,320,321,5,65,0,0,321,323,3,86,43,
      0,322,320,1,0,0,0,322,323,1,0,0,0,323,324,1,0,0,0,324,325,5,61,0,0,
      325,41,1,0,0,0,326,327,5,50,0,0,327,328,3,108,54,0,328,329,5,61,0,
      0,329,43,1,0,0,0,330,331,5,10,0,0,331,332,5,91,0,0,332,333,5,64,0,
      0,333,334,3,72,36,0,334,335,5,61,0,0,335,45,1,0,0,0,336,339,3,92,46,
      0,337,339,3,96,48,0,338,336,1,0,0,0,338,337,1,0,0,0,339,340,1,0,0,
      0,340,343,5,91,0,0,341,342,5,64,0,0,342,344,3,74,37,0,343,341,1,0,
      0,0,343,344,1,0,0,0,344,345,1,0,0,0,345,346,5,61,0,0,346,47,1,0,0,
      0,347,348,5,24,0,0,348,349,3,92,46,0,349,352,5,91,0,0,350,351,5,64,
      0,0,351,353,3,74,37,0,352,350,1,0,0,0,352,353,1,0,0,0,353,354,1,0,
      0,0,354,355,5,61,0,0,355,49,1,0,0,0,356,359,7,0,0,0,357,360,3,92,46,
      0,358,360,3,96,48,0,359,357,1,0,0,0,359,358,1,0,0,0,360,361,1,0,0,
      0,361,362,5,91,0,0,362,363,5,61,0,0,363,51,1,0,0,0,364,365,7,1,0,0,
      365,367,5,91,0,0,366,368,3,100,50,0,367,366,1,0,0,0,367,368,1,0,0,
      0,368,369,1,0,0,0,369,370,5,61,0,0,370,53,1,0,0,0,371,372,3,94,47,
      0,372,373,5,91,0,0,373,374,5,61,0,0,374,55,1,0,0,0,375,376,5,4,0,0,
      376,377,5,91,0,0,377,379,5,58,0,0,378,380,3,114,57,0,379,378,1,0,0,
      0,379,380,1,0,0,0,380,381,1,0,0,0,381,383,5,59,0,0,382,384,3,88,44,
      0,383,382,1,0,0,0,383,384,1,0,0,0,384,385,1,0,0,0,385,386,3,8,4,0,
      386,57,1,0,0,0,387,388,5,8,0,0,388,389,5,91,0,0,389,391,5,58,0,0,390,
      392,3,126,63,0,391,390,1,0,0,0,391,392,1,0,0,0,392,393,1,0,0,0,393,
      395,5,59,0,0,394,396,3,88,44,0,395,394,1,0,0,0,395,396,1,0,0,0,396,
      397,1,0,0,0,397,398,5,61,0,0,398,59,1,0,0,0,399,400,5,7,0,0,400,406,
      5,91,0,0,401,403,5,58,0,0,402,404,3,122,61,0,403,402,1,0,0,0,403,404,
      1,0,0,0,404,405,1,0,0,0,405,407,5,59,0,0,406,401,1,0,0,0,406,407,1,
      0,0,0,407,408,1,0,0,0,408,409,3,122,61,0,409,410,3,8,4,0,410,61,1,
      0,0,0,411,412,3,86,43,0,412,415,7,2,0,0,413,416,3,70,35,0,414,416,
      3,76,38,0,415,413,1,0,0,0,415,414,1,0,0,0,416,417,1,0,0,0,417,418,
      5,61,0,0,418,63,1,0,0,0,419,420,3,70,35,0,420,421,5,61,0,0,421,65,
      1,0,0,0,422,423,5,5,0,0,423,425,5,56,0,0,424,426,5,110,0,0,425,424,
      1,0,0,0,425,426,1,0,0,0,426,427,1,0,0,0,427,428,5,57,0,0,428,67,1,
      0,0,0,429,430,5,6,0,0,430,436,3,102,51,0,431,433,5,58,0,0,432,434,
      3,116,58,0,433,432,1,0,0,0,433,434,1,0,0,0,434,435,1,0,0,0,435,437,
      5,59,0,0,436,431,1,0,0,0,436,437,1,0,0,0,437,438,1,0,0,0,438,440,3,
      118,59,0,439,441,3,88,44,0,440,439,1,0,0,0,440,441,1,0,0,0,441,442,
      1,0,0,0,442,444,5,56,0,0,443,445,5,110,0,0,444,443,1,0,0,0,444,445,
      1,0,0,0,445,446,1,0,0,0,446,447,5,57,0,0,447,69,1,0,0,0,448,449,6,
      35,-1,0,449,450,5,58,0,0,450,451,3,70,35,0,451,452,5,59,0,0,452,476,
      1,0,0,0,453,454,7,3,0,0,454,476,3,70,35,15,455,458,3,92,46,0,456,458,
      3,96,48,0,457,455,1,0,0,0,457,456,1,0,0,0,458,459,1,0,0,0,459,460,
      5,58,0,0,460,461,3,70,35,0,461,462,5,59,0,0,462,476,1,0,0,0,463,464,
      5,48,0,0,464,465,5,58,0,0,465,466,3,8,4,0,466,467,5,59,0,0,467,476,
      1,0,0,0,468,469,5,91,0,0,469,471,5,58,0,0,470,472,3,120,60,0,471,470,
      1,0,0,0,471,472,1,0,0,0,472,473,1,0,0,0,473,476,5,59,0,0,474,476,7,
      4,0,0,475,448,1,0,0,0,475,453,1,0,0,0,475,457,1,0,0,0,475,463,1,0,
      0,0,475,468,1,0,0,0,475,474,1,0,0,0,476,514,1,0,0,0,477,478,10,16,
      0,0,478,479,5,70,0,0,479,513,3,70,35,16,480,481,10,14,0,0,481,482,
      7,5,0,0,482,513,3,70,35,15,483,484,10,13,0,0,484,485,7,6,0,0,485,513,
      3,70,35,14,486,487,10,12,0,0,487,488,5,84,0,0,488,513,3,70,35,13,489,
      490,10,11,0,0,490,491,5,83,0,0,491,513,3,70,35,12,492,493,10,10,0,
      0,493,494,5,81,0,0,494,513,3,70,35,11,495,496,10,9,0,0,496,497,5,75,
      0,0,497,513,3,70,35,10,498,499,10,8,0,0,499,500,5,77,0,0,500,513,3,
      70,35,9,501,502,10,7,0,0,502,503,5,73,0,0,503,513,3,70,35,8,504,505,
      10,6,0,0,505,506,5,76,0,0,506,513,3,70,35,7,507,508,10,5,0,0,508,509,
      5,74,0,0,509,513,3,70,35,6,510,511,10,17,0,0,511,513,3,84,42,0,512,
      477,1,0,0,0,512,480,1,0,0,0,512,483,1,0,0,0,512,486,1,0,0,0,512,489,
      1,0,0,0,512,492,1,0,0,0,512,495,1,0,0,0,512,498,1,0,0,0,512,501,1,
      0,0,0,512,504,1,0,0,0,512,507,1,0,0,0,512,510,1,0,0,0,513,516,1,0,
      0,0,514,512,1,0,0,0,514,515,1,0,0,0,515,71,1,0,0,0,516,514,1,0,0,0,
      517,522,3,70,35,0,518,519,5,67,0,0,519,521,3,70,35,0,520,518,1,0,0,
      0,521,524,1,0,0,0,522,520,1,0,0,0,522,523,1,0,0,0,523,73,1,0,0,0,524,
      522,1,0,0,0,525,529,3,82,41,0,526,529,3,70,35,0,527,529,3,76,38,0,
      528,525,1,0,0,0,528,526,1,0,0,0,528,527,1,0,0,0,529,75,1,0,0,0,530,
      531,5,51,0,0,531,532,3,108,54,0,532,77,1,0,0,0,533,535,3,70,35,0,534,
      533,1,0,0,0,534,535,1,0,0,0,535,536,1,0,0,0,536,538,5,60,0,0,537,539,
      3,70,35,0,538,537,1,0,0,0,538,539,1,0,0,0,539,542,1,0,0,0,540,541,
      5,60,0,0,541,543,3,70,35,0,542,540,1,0,0,0,542,543,1,0,0,0,543,79,
      1,0,0,0,544,545,5,56,0,0,545,550,3,70,35,0,546,547,5,63,0,0,547,549,
      3,70,35,0,548,546,1,0,0,0,549,552,1,0,0,0,550,548,1,0,0,0,550,551,
      1,0,0,0,551,554,1,0,0,0,552,550,1,0,0,0,553,555,5,63,0,0,554,553,1,
      0,0,0,554,555,1,0,0,0,555,556,1,0,0,0,556,557,5,57,0,0,557,81,1,0,
      0,0,558,561,5,56,0,0,559,562,3,70,35,0,560,562,3,82,41,0,561,559,1,
      0,0,0,561,560,1,0,0,0,562,570,1,0,0,0,563,566,5,63,0,0,564,567,3,70,
      35,0,565,567,3,82,41,0,566,564,1,0,0,0,566,565,1,0,0,0,567,569,1,0,
      0,0,568,563,1,0,0,0,569,572,1,0,0,0,570,568,1,0,0,0,570,571,1,0,0,
      0,571,574,1,0,0,0,572,570,1,0,0,0,573,575,5,63,0,0,574,573,1,0,0,0,
      574,575,1,0,0,0,575,576,1,0,0,0,576,577,5,57,0,0,577,83,1,0,0,0,578,
      597,5,54,0,0,579,598,3,80,40,0,580,583,3,70,35,0,581,583,3,78,39,0,
      582,580,1,0,0,0,582,581,1,0,0,0,583,591,1,0,0,0,584,587,5,63,0,0,585,
      588,3,70,35,0,586,588,3,78,39,0,587,585,1,0,0,0,587,586,1,0,0,0,588,
      590,1,0,0,0,589,584,1,0,0,0,590,593,1,0,0,0,591,589,1,0,0,0,591,592,
      1,0,0,0,592,595,1,0,0,0,593,591,1,0,0,0,594,596,5,63,0,0,595,594,1,
      0,0,0,595,596,1,0,0,0,596,598,1,0,0,0,597,579,1,0,0,0,597,582,1,0,
      0,0,598,599,1,0,0,0,599,600,5,55,0,0,600,85,1,0,0,0,601,605,5,91,0,
      0,602,604,3,84,42,0,603,602,1,0,0,0,604,607,1,0,0,0,605,603,1,0,0,
      0,605,606,1,0,0,0,606,87,1,0,0,0,607,605,1,0,0,0,608,609,5,65,0,0,
      609,610,3,92,46,0,610,89,1,0,0,0,611,625,5,43,0,0,612,613,5,44,0,0,
      613,614,5,58,0,0,614,615,3,70,35,0,615,616,5,59,0,0,616,625,1,0,0,
      0,617,622,7,7,0,0,618,619,5,58,0,0,619,620,3,70,35,0,620,621,5,59,
      0,0,621,623,1,0,0,0,622,618,1,0,0,0,622,623,1,0,0,0,623,625,1,0,0,
      0,624,611,1,0,0,0,624,612,1,0,0,0,624,617,1,0,0,0,625,626,1,0,0,0,
      626,627,5,78,0,0,627,91,1,0,0,0,628,630,5,31,0,0,629,631,3,100,50,
      0,630,629,1,0,0,0,630,631,1,0,0,0,631,660,1,0,0,0,632,634,5,32,0,0,
      633,635,3,100,50,0,634,633,1,0,0,0,634,635,1,0,0,0,635,660,1,0,0,0,
      636,638,5,33,0,0,637,639,3,100,50,0,638,637,1,0,0,0,638,639,1,0,0,
      0,639,660,1,0,0,0,640,642,5,34,0,0,641,643,3,100,50,0,642,641,1,0,
      0,0,642,643,1,0,0,0,643,660,1,0,0,0,644,646,5,35,0,0,645,647,3,100,
      50,0,646,645,1,0,0,0,646,647,1,0,0,0,647,660,1,0,0,0,648,660,5,30,
      0,0,649,660,5,39,0,0,650,660,5,40,0,0,651,656,5,36,0,0,652,653,5,54,
      0,0,653,654,3,92,46,0,654,655,5,55,0,0,655,657,1,0,0,0,656,652,1,0,
      0,0,656,657,1,0,0,0,657,660,1,0,0,0,658,660,5,41,0,0,659,628,1,0,0,
      0,659,632,1,0,0,0,659,636,1,0,0,0,659,640,1,0,0,0,659,644,1,0,0,0,
      659,648,1,0,0,0,659,649,1,0,0,0,659,650,1,0,0,0,659,651,1,0,0,0,659,
      658,1,0,0,0,660,93,1,0,0,0,661,663,5,28,0,0,662,664,3,100,50,0,663,
      662,1,0,0,0,663,664,1,0,0,0,664,95,1,0,0,0,665,666,5,37,0,0,666,667,
      5,54,0,0,667,668,3,92,46,0,668,669,5,63,0,0,669,670,3,120,60,0,670,
      671,5,55,0,0,671,97,1,0,0,0,672,673,7,8,0,0,673,674,5,37,0,0,674,675,
      5,54,0,0,675,676,3,92,46,0,676,681,5,63,0,0,677,682,3,120,60,0,678,
      679,5,47,0,0,679,680,5,64,0,0,680,682,3,70,35,0,681,677,1,0,0,0,681,
      678,1,0,0,0,682,683,1,0,0,0,683,684,5,55,0,0,684,99,1,0,0,0,685,686,
      5,54,0,0,686,687,3,70,35,0,687,688,5,55,0,0,688,101,1,0,0,0,689,690,
      7,9,0,0,690,103,1,0,0,0,691,694,3,70,35,0,692,694,3,112,56,0,693,691,
      1,0,0,0,693,692,1,0,0,0,694,105,1,0,0,0,695,696,7,10,0,0,696,107,1,
      0,0,0,697,700,3,86,43,0,698,700,5,92,0,0,699,697,1,0,0,0,699,698,1,
      0,0,0,700,109,1,0,0,0,701,708,3,92,46,0,702,708,3,98,49,0,703,705,
      5,29,0,0,704,706,3,100,50,0,705,704,1,0,0,0,705,706,1,0,0,0,706,708,
      1,0,0,0,707,701,1,0,0,0,707,702,1,0,0,0,707,703,1,0,0,0,708,111,1,
      0,0,0,709,710,3,92,46,0,710,711,5,91,0,0,711,724,1,0,0,0,712,713,3,
      94,47,0,713,714,5,91,0,0,714,724,1,0,0,0,715,716,7,1,0,0,716,718,5,
      91,0,0,717,719,3,100,50,0,718,717,1,0,0,0,718,719,1,0,0,0,719,724,
      1,0,0,0,720,721,3,98,49,0,721,722,5,91,0,0,722,724,1,0,0,0,723,709,
      1,0,0,0,723,712,1,0,0,0,723,715,1,0,0,0,723,720,1,0,0,0,724,113,1,
      0,0,0,725,730,3,112,56,0,726,727,5,63,0,0,727,729,3,112,56,0,728,726,
      1,0,0,0,729,732,1,0,0,0,730,728,1,0,0,0,730,731,1,0,0,0,731,734,1,
      0,0,0,732,730,1,0,0,0,733,735,5,63,0,0,734,733,1,0,0,0,734,735,1,0,
      0,0,735,115,1,0,0,0,736,741,3,104,52,0,737,738,5,63,0,0,738,740,3,
      104,52,0,739,737,1,0,0,0,740,743,1,0,0,0,741,739,1,0,0,0,741,742,1,
      0,0,0,742,745,1,0,0,0,743,741,1,0,0,0,744,746,5,63,0,0,745,744,1,0,
      0,0,745,746,1,0,0,0,746,117,1,0,0,0,747,752,3,106,53,0,748,749,5,63,
      0,0,749,751,3,106,53,0,750,748,1,0,0,0,751,754,1,0,0,0,752,750,1,0,
      0,0,752,753,1,0,0,0,753,756,1,0,0,0,754,752,1,0,0,0,755,757,5,63,0,
      0,756,755,1,0,0,0,756,757,1,0,0,0,757,119,1,0,0,0,758,763,3,70,35,
      0,759,760,5,63,0,0,760,762,3,70,35,0,761,759,1,0,0,0,762,765,1,0,0,
      0,763,761,1,0,0,0,763,764,1,0,0,0,764,767,1,0,0,0,765,763,1,0,0,0,
      766,768,5,63,0,0,767,766,1,0,0,0,767,768,1,0,0,0,768,121,1,0,0,0,769,
      774,5,91,0,0,770,771,5,63,0,0,771,773,5,91,0,0,772,770,1,0,0,0,773,
      776,1,0,0,0,774,772,1,0,0,0,774,775,1,0,0,0,775,778,1,0,0,0,776,774,
      1,0,0,0,777,779,5,63,0,0,778,777,1,0,0,0,778,779,1,0,0,0,779,123,1,
      0,0,0,780,785,3,108,54,0,781,782,5,63,0,0,782,784,3,108,54,0,783,781,
      1,0,0,0,784,787,1,0,0,0,785,783,1,0,0,0,785,786,1,0,0,0,786,789,1,
      0,0,0,787,785,1,0,0,0,788,790,5,63,0,0,789,788,1,0,0,0,789,790,1,0,
      0,0,790,125,1,0,0,0,791,796,3,110,55,0,792,793,5,63,0,0,793,795,3,
      110,55,0,794,792,1,0,0,0,795,798,1,0,0,0,796,794,1,0,0,0,796,797,1,
      0,0,0,797,800,1,0,0,0,798,796,1,0,0,0,799,801,5,63,0,0,800,799,1,0,
      0,0,800,801,1,0,0,0,801,127,1,0,0,0,96,129,134,147,178,180,184,190,
      200,221,231,242,247,259,265,272,279,285,288,291,299,305,308,311,314,
      317,322,338,343,352,359,367,379,383,391,395,403,406,415,425,433,436,
      440,444,457,471,475,512,514,522,528,534,538,542,550,554,561,566,570,
      574,582,587,591,595,597,605,622,624,630,634,638,642,646,656,659,663,
      681,693,699,705,707,718,723,730,734,741,745,752,756,763,767,774,778,
      785,789,796,800
  ];

  static final ATN _ATN =
      ATNDeserializer().deserialize(_serializedATN);
}
class ProgramContext extends ParserRuleContext {
  TerminalNode? EOF() => getToken(OpenQASM3Parser.TOKEN_EOF, 0);
  VersionContext? version() => getRuleContext<VersionContext>(0);
  List<StatementContext> statements() => getRuleContexts<StatementContext>();
  StatementContext? statement(int i) => getRuleContext<StatementContext>(i);
  ProgramContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_program;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterProgram(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitProgram(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitProgram(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class VersionContext extends ParserRuleContext {
  TerminalNode? OPENQASM() => getToken(OpenQASM3Parser.TOKEN_OPENQASM, 0);
  TerminalNode? VersionSpecifier() => getToken(OpenQASM3Parser.TOKEN_VersionSpecifier, 0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  VersionContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_version;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterVersion(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitVersion(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitVersion(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class StatementContext extends ParserRuleContext {
  PragmaContext? pragma() => getRuleContext<PragmaContext>(0);
  AliasDeclarationStatementContext? aliasDeclarationStatement() => getRuleContext<AliasDeclarationStatementContext>(0);
  AssignmentStatementContext? assignmentStatement() => getRuleContext<AssignmentStatementContext>(0);
  BarrierStatementContext? barrierStatement() => getRuleContext<BarrierStatementContext>(0);
  BoxStatementContext? boxStatement() => getRuleContext<BoxStatementContext>(0);
  BreakStatementContext? breakStatement() => getRuleContext<BreakStatementContext>(0);
  CalStatementContext? calStatement() => getRuleContext<CalStatementContext>(0);
  CalibrationGrammarStatementContext? calibrationGrammarStatement() => getRuleContext<CalibrationGrammarStatementContext>(0);
  ClassicalDeclarationStatementContext? classicalDeclarationStatement() => getRuleContext<ClassicalDeclarationStatementContext>(0);
  ConstDeclarationStatementContext? constDeclarationStatement() => getRuleContext<ConstDeclarationStatementContext>(0);
  ContinueStatementContext? continueStatement() => getRuleContext<ContinueStatementContext>(0);
  DefStatementContext? defStatement() => getRuleContext<DefStatementContext>(0);
  DefcalStatementContext? defcalStatement() => getRuleContext<DefcalStatementContext>(0);
  DelayStatementContext? delayStatement() => getRuleContext<DelayStatementContext>(0);
  EndStatementContext? endStatement() => getRuleContext<EndStatementContext>(0);
  ExpressionStatementContext? expressionStatement() => getRuleContext<ExpressionStatementContext>(0);
  ExternStatementContext? externStatement() => getRuleContext<ExternStatementContext>(0);
  ForStatementContext? forStatement() => getRuleContext<ForStatementContext>(0);
  GateCallStatementContext? gateCallStatement() => getRuleContext<GateCallStatementContext>(0);
  GateStatementContext? gateStatement() => getRuleContext<GateStatementContext>(0);
  IfStatementContext? ifStatement() => getRuleContext<IfStatementContext>(0);
  IncludeStatementContext? includeStatement() => getRuleContext<IncludeStatementContext>(0);
  IoDeclarationStatementContext? ioDeclarationStatement() => getRuleContext<IoDeclarationStatementContext>(0);
  MeasureArrowAssignmentStatementContext? measureArrowAssignmentStatement() => getRuleContext<MeasureArrowAssignmentStatementContext>(0);
  OldStyleDeclarationStatementContext? oldStyleDeclarationStatement() => getRuleContext<OldStyleDeclarationStatementContext>(0);
  QuantumDeclarationStatementContext? quantumDeclarationStatement() => getRuleContext<QuantumDeclarationStatementContext>(0);
  ResetStatementContext? resetStatement() => getRuleContext<ResetStatementContext>(0);
  ReturnStatementContext? returnStatement() => getRuleContext<ReturnStatementContext>(0);
  WhileStatementContext? whileStatement() => getRuleContext<WhileStatementContext>(0);
  List<AnnotationContext> annotations() => getRuleContexts<AnnotationContext>();
  AnnotationContext? annotation(int i) => getRuleContext<AnnotationContext>(i);
  StatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_statement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class AnnotationContext extends ParserRuleContext {
  TerminalNode? AnnotationKeyword() => getToken(OpenQASM3Parser.TOKEN_AnnotationKeyword, 0);
  TerminalNode? RemainingLineContent() => getToken(OpenQASM3Parser.TOKEN_RemainingLineContent, 0);
  AnnotationContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_annotation;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterAnnotation(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitAnnotation(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitAnnotation(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ScopeContext extends ParserRuleContext {
  TerminalNode? LBRACE() => getToken(OpenQASM3Parser.TOKEN_LBRACE, 0);
  TerminalNode? RBRACE() => getToken(OpenQASM3Parser.TOKEN_RBRACE, 0);
  List<StatementContext> statements() => getRuleContexts<StatementContext>();
  StatementContext? statement(int i) => getRuleContext<StatementContext>(i);
  ScopeContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_scope;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterScope(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitScope(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitScope(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class PragmaContext extends ParserRuleContext {
  TerminalNode? PRAGMA() => getToken(OpenQASM3Parser.TOKEN_PRAGMA, 0);
  TerminalNode? RemainingLineContent() => getToken(OpenQASM3Parser.TOKEN_RemainingLineContent, 0);
  PragmaContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_pragma;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterPragma(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitPragma(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitPragma(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class StatementOrScopeContext extends ParserRuleContext {
  StatementContext? statement() => getRuleContext<StatementContext>(0);
  ScopeContext? scope() => getRuleContext<ScopeContext>(0);
  StatementOrScopeContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_statementOrScope;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterStatementOrScope(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitStatementOrScope(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitStatementOrScope(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class CalibrationGrammarStatementContext extends ParserRuleContext {
  TerminalNode? DEFCALGRAMMAR() => getToken(OpenQASM3Parser.TOKEN_DEFCALGRAMMAR, 0);
  TerminalNode? StringLiteral() => getToken(OpenQASM3Parser.TOKEN_StringLiteral, 0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  CalibrationGrammarStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_calibrationGrammarStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterCalibrationGrammarStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitCalibrationGrammarStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitCalibrationGrammarStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class IncludeStatementContext extends ParserRuleContext {
  TerminalNode? INCLUDE() => getToken(OpenQASM3Parser.TOKEN_INCLUDE, 0);
  TerminalNode? StringLiteral() => getToken(OpenQASM3Parser.TOKEN_StringLiteral, 0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  IncludeStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_includeStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterIncludeStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitIncludeStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitIncludeStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class BreakStatementContext extends ParserRuleContext {
  TerminalNode? BREAK() => getToken(OpenQASM3Parser.TOKEN_BREAK, 0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  BreakStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_breakStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterBreakStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitBreakStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitBreakStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ContinueStatementContext extends ParserRuleContext {
  TerminalNode? CONTINUE() => getToken(OpenQASM3Parser.TOKEN_CONTINUE, 0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  ContinueStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_continueStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterContinueStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitContinueStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitContinueStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class EndStatementContext extends ParserRuleContext {
  TerminalNode? END() => getToken(OpenQASM3Parser.TOKEN_END, 0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  EndStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_endStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterEndStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitEndStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitEndStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ForStatementContext extends ParserRuleContext {
  StatementOrScopeContext? body;
  TerminalNode? FOR() => getToken(OpenQASM3Parser.TOKEN_FOR, 0);
  TerminalNode? Identifier() => getToken(OpenQASM3Parser.TOKEN_Identifier, 0);
  TerminalNode? IN() => getToken(OpenQASM3Parser.TOKEN_IN, 0);
  StatementOrScopeContext? statementOrScope() => getRuleContext<StatementOrScopeContext>(0);
  SetExpressionContext? setExpression() => getRuleContext<SetExpressionContext>(0);
  TerminalNode? LBRACKET() => getToken(OpenQASM3Parser.TOKEN_LBRACKET, 0);
  RangeExpressionContext? rangeExpression() => getRuleContext<RangeExpressionContext>(0);
  TerminalNode? RBRACKET() => getToken(OpenQASM3Parser.TOKEN_RBRACKET, 0);
  ExpressionContext? expression() => getRuleContext<ExpressionContext>(0);
  ScalarTypeContext? scalarType() => getRuleContext<ScalarTypeContext>(0);
  ForStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_forStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterForStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitForStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitForStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class IfStatementContext extends ParserRuleContext {
  StatementOrScopeContext? if_body;
  StatementOrScopeContext? else_body;
  TerminalNode? IF() => getToken(OpenQASM3Parser.TOKEN_IF, 0);
  TerminalNode? LPAREN() => getToken(OpenQASM3Parser.TOKEN_LPAREN, 0);
  ExpressionContext? expression() => getRuleContext<ExpressionContext>(0);
  TerminalNode? RPAREN() => getToken(OpenQASM3Parser.TOKEN_RPAREN, 0);
  List<StatementOrScopeContext> statementOrScopes() => getRuleContexts<StatementOrScopeContext>();
  StatementOrScopeContext? statementOrScope(int i) => getRuleContext<StatementOrScopeContext>(i);
  TerminalNode? ELSE() => getToken(OpenQASM3Parser.TOKEN_ELSE, 0);
  IfStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_ifStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterIfStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitIfStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitIfStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ReturnStatementContext extends ParserRuleContext {
  TerminalNode? RETURN() => getToken(OpenQASM3Parser.TOKEN_RETURN, 0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  ExpressionContext? expression() => getRuleContext<ExpressionContext>(0);
  MeasureExpressionContext? measureExpression() => getRuleContext<MeasureExpressionContext>(0);
  ReturnStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_returnStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterReturnStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitReturnStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitReturnStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class WhileStatementContext extends ParserRuleContext {
  StatementOrScopeContext? body;
  TerminalNode? WHILE() => getToken(OpenQASM3Parser.TOKEN_WHILE, 0);
  TerminalNode? LPAREN() => getToken(OpenQASM3Parser.TOKEN_LPAREN, 0);
  ExpressionContext? expression() => getRuleContext<ExpressionContext>(0);
  TerminalNode? RPAREN() => getToken(OpenQASM3Parser.TOKEN_RPAREN, 0);
  StatementOrScopeContext? statementOrScope() => getRuleContext<StatementOrScopeContext>(0);
  WhileStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_whileStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterWhileStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitWhileStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitWhileStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class BarrierStatementContext extends ParserRuleContext {
  TerminalNode? BARRIER() => getToken(OpenQASM3Parser.TOKEN_BARRIER, 0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  GateOperandListContext? gateOperandList() => getRuleContext<GateOperandListContext>(0);
  BarrierStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_barrierStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterBarrierStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitBarrierStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitBarrierStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class BoxStatementContext extends ParserRuleContext {
  TerminalNode? BOX() => getToken(OpenQASM3Parser.TOKEN_BOX, 0);
  ScopeContext? scope() => getRuleContext<ScopeContext>(0);
  DesignatorContext? designator() => getRuleContext<DesignatorContext>(0);
  BoxStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_boxStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterBoxStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitBoxStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitBoxStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class DelayStatementContext extends ParserRuleContext {
  TerminalNode? DELAY() => getToken(OpenQASM3Parser.TOKEN_DELAY, 0);
  DesignatorContext? designator() => getRuleContext<DesignatorContext>(0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  GateOperandListContext? gateOperandList() => getRuleContext<GateOperandListContext>(0);
  DelayStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_delayStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterDelayStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitDelayStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitDelayStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class GateCallStatementContext extends ParserRuleContext {
  TerminalNode? Identifier() => getToken(OpenQASM3Parser.TOKEN_Identifier, 0);
  GateOperandListContext? gateOperandList() => getRuleContext<GateOperandListContext>(0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  List<GateModifierContext> gateModifiers() => getRuleContexts<GateModifierContext>();
  GateModifierContext? gateModifier(int i) => getRuleContext<GateModifierContext>(i);
  TerminalNode? LPAREN() => getToken(OpenQASM3Parser.TOKEN_LPAREN, 0);
  TerminalNode? RPAREN() => getToken(OpenQASM3Parser.TOKEN_RPAREN, 0);
  DesignatorContext? designator() => getRuleContext<DesignatorContext>(0);
  ExpressionListContext? expressionList() => getRuleContext<ExpressionListContext>(0);
  TerminalNode? GPHASE() => getToken(OpenQASM3Parser.TOKEN_GPHASE, 0);
  GateCallStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_gateCallStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterGateCallStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitGateCallStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitGateCallStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class MeasureArrowAssignmentStatementContext extends ParserRuleContext {
  MeasureExpressionContext? measureExpression() => getRuleContext<MeasureExpressionContext>(0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  TerminalNode? ARROW() => getToken(OpenQASM3Parser.TOKEN_ARROW, 0);
  IndexedIdentifierContext? indexedIdentifier() => getRuleContext<IndexedIdentifierContext>(0);
  MeasureArrowAssignmentStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_measureArrowAssignmentStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterMeasureArrowAssignmentStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitMeasureArrowAssignmentStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitMeasureArrowAssignmentStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ResetStatementContext extends ParserRuleContext {
  TerminalNode? RESET() => getToken(OpenQASM3Parser.TOKEN_RESET, 0);
  GateOperandContext? gateOperand() => getRuleContext<GateOperandContext>(0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  ResetStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_resetStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterResetStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitResetStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitResetStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class AliasDeclarationStatementContext extends ParserRuleContext {
  TerminalNode? LET() => getToken(OpenQASM3Parser.TOKEN_LET, 0);
  TerminalNode? Identifier() => getToken(OpenQASM3Parser.TOKEN_Identifier, 0);
  TerminalNode? EQUALS() => getToken(OpenQASM3Parser.TOKEN_EQUALS, 0);
  AliasExpressionContext? aliasExpression() => getRuleContext<AliasExpressionContext>(0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  AliasDeclarationStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_aliasDeclarationStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterAliasDeclarationStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitAliasDeclarationStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitAliasDeclarationStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ClassicalDeclarationStatementContext extends ParserRuleContext {
  TerminalNode? Identifier() => getToken(OpenQASM3Parser.TOKEN_Identifier, 0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  ScalarTypeContext? scalarType() => getRuleContext<ScalarTypeContext>(0);
  ArrayTypeContext? arrayType() => getRuleContext<ArrayTypeContext>(0);
  TerminalNode? EQUALS() => getToken(OpenQASM3Parser.TOKEN_EQUALS, 0);
  DeclarationExpressionContext? declarationExpression() => getRuleContext<DeclarationExpressionContext>(0);
  ClassicalDeclarationStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_classicalDeclarationStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterClassicalDeclarationStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitClassicalDeclarationStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitClassicalDeclarationStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ConstDeclarationStatementContext extends ParserRuleContext {
  TerminalNode? CONST() => getToken(OpenQASM3Parser.TOKEN_CONST, 0);
  ScalarTypeContext? scalarType() => getRuleContext<ScalarTypeContext>(0);
  TerminalNode? Identifier() => getToken(OpenQASM3Parser.TOKEN_Identifier, 0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  TerminalNode? EQUALS() => getToken(OpenQASM3Parser.TOKEN_EQUALS, 0);
  DeclarationExpressionContext? declarationExpression() => getRuleContext<DeclarationExpressionContext>(0);
  ConstDeclarationStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_constDeclarationStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterConstDeclarationStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitConstDeclarationStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitConstDeclarationStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class IoDeclarationStatementContext extends ParserRuleContext {
  TerminalNode? Identifier() => getToken(OpenQASM3Parser.TOKEN_Identifier, 0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  TerminalNode? INPUT() => getToken(OpenQASM3Parser.TOKEN_INPUT, 0);
  TerminalNode? OUTPUT() => getToken(OpenQASM3Parser.TOKEN_OUTPUT, 0);
  ScalarTypeContext? scalarType() => getRuleContext<ScalarTypeContext>(0);
  ArrayTypeContext? arrayType() => getRuleContext<ArrayTypeContext>(0);
  IoDeclarationStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_ioDeclarationStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterIoDeclarationStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitIoDeclarationStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitIoDeclarationStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class OldStyleDeclarationStatementContext extends ParserRuleContext {
  TerminalNode? Identifier() => getToken(OpenQASM3Parser.TOKEN_Identifier, 0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  TerminalNode? CREG() => getToken(OpenQASM3Parser.TOKEN_CREG, 0);
  TerminalNode? QREG() => getToken(OpenQASM3Parser.TOKEN_QREG, 0);
  DesignatorContext? designator() => getRuleContext<DesignatorContext>(0);
  OldStyleDeclarationStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_oldStyleDeclarationStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterOldStyleDeclarationStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitOldStyleDeclarationStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitOldStyleDeclarationStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class QuantumDeclarationStatementContext extends ParserRuleContext {
  QubitTypeContext? qubitType() => getRuleContext<QubitTypeContext>(0);
  TerminalNode? Identifier() => getToken(OpenQASM3Parser.TOKEN_Identifier, 0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  QuantumDeclarationStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_quantumDeclarationStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterQuantumDeclarationStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitQuantumDeclarationStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitQuantumDeclarationStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class DefStatementContext extends ParserRuleContext {
  TerminalNode? DEF() => getToken(OpenQASM3Parser.TOKEN_DEF, 0);
  TerminalNode? Identifier() => getToken(OpenQASM3Parser.TOKEN_Identifier, 0);
  TerminalNode? LPAREN() => getToken(OpenQASM3Parser.TOKEN_LPAREN, 0);
  TerminalNode? RPAREN() => getToken(OpenQASM3Parser.TOKEN_RPAREN, 0);
  ScopeContext? scope() => getRuleContext<ScopeContext>(0);
  ArgumentDefinitionListContext? argumentDefinitionList() => getRuleContext<ArgumentDefinitionListContext>(0);
  ReturnSignatureContext? returnSignature() => getRuleContext<ReturnSignatureContext>(0);
  DefStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_defStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterDefStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitDefStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitDefStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ExternStatementContext extends ParserRuleContext {
  TerminalNode? EXTERN() => getToken(OpenQASM3Parser.TOKEN_EXTERN, 0);
  TerminalNode? Identifier() => getToken(OpenQASM3Parser.TOKEN_Identifier, 0);
  TerminalNode? LPAREN() => getToken(OpenQASM3Parser.TOKEN_LPAREN, 0);
  TerminalNode? RPAREN() => getToken(OpenQASM3Parser.TOKEN_RPAREN, 0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  ExternArgumentListContext? externArgumentList() => getRuleContext<ExternArgumentListContext>(0);
  ReturnSignatureContext? returnSignature() => getRuleContext<ReturnSignatureContext>(0);
  ExternStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_externStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterExternStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitExternStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitExternStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class GateStatementContext extends ParserRuleContext {
  IdentifierListContext? params;
  IdentifierListContext? qubits;
  TerminalNode? GATE() => getToken(OpenQASM3Parser.TOKEN_GATE, 0);
  TerminalNode? Identifier() => getToken(OpenQASM3Parser.TOKEN_Identifier, 0);
  ScopeContext? scope() => getRuleContext<ScopeContext>(0);
  List<IdentifierListContext> identifierLists() => getRuleContexts<IdentifierListContext>();
  IdentifierListContext? identifierList(int i) => getRuleContext<IdentifierListContext>(i);
  TerminalNode? LPAREN() => getToken(OpenQASM3Parser.TOKEN_LPAREN, 0);
  TerminalNode? RPAREN() => getToken(OpenQASM3Parser.TOKEN_RPAREN, 0);
  GateStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_gateStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterGateStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitGateStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitGateStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class AssignmentStatementContext extends ParserRuleContext {
  Token? op;
  IndexedIdentifierContext? indexedIdentifier() => getRuleContext<IndexedIdentifierContext>(0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  TerminalNode? EQUALS() => getToken(OpenQASM3Parser.TOKEN_EQUALS, 0);
  TerminalNode? CompoundAssignmentOperator() => getToken(OpenQASM3Parser.TOKEN_CompoundAssignmentOperator, 0);
  ExpressionContext? expression() => getRuleContext<ExpressionContext>(0);
  MeasureExpressionContext? measureExpression() => getRuleContext<MeasureExpressionContext>(0);
  AssignmentStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_assignmentStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterAssignmentStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitAssignmentStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitAssignmentStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ExpressionStatementContext extends ParserRuleContext {
  ExpressionContext? expression() => getRuleContext<ExpressionContext>(0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  ExpressionStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_expressionStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterExpressionStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitExpressionStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitExpressionStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class CalStatementContext extends ParserRuleContext {
  TerminalNode? CAL() => getToken(OpenQASM3Parser.TOKEN_CAL, 0);
  TerminalNode? LBRACE() => getToken(OpenQASM3Parser.TOKEN_LBRACE, 0);
  TerminalNode? RBRACE() => getToken(OpenQASM3Parser.TOKEN_RBRACE, 0);
  TerminalNode? CalibrationBlock() => getToken(OpenQASM3Parser.TOKEN_CalibrationBlock, 0);
  CalStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_calStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterCalStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitCalStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitCalStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class DefcalStatementContext extends ParserRuleContext {
  TerminalNode? DEFCAL() => getToken(OpenQASM3Parser.TOKEN_DEFCAL, 0);
  DefcalTargetContext? defcalTarget() => getRuleContext<DefcalTargetContext>(0);
  DefcalOperandListContext? defcalOperandList() => getRuleContext<DefcalOperandListContext>(0);
  TerminalNode? LBRACE() => getToken(OpenQASM3Parser.TOKEN_LBRACE, 0);
  TerminalNode? RBRACE() => getToken(OpenQASM3Parser.TOKEN_RBRACE, 0);
  TerminalNode? LPAREN() => getToken(OpenQASM3Parser.TOKEN_LPAREN, 0);
  TerminalNode? RPAREN() => getToken(OpenQASM3Parser.TOKEN_RPAREN, 0);
  ReturnSignatureContext? returnSignature() => getRuleContext<ReturnSignatureContext>(0);
  TerminalNode? CalibrationBlock() => getToken(OpenQASM3Parser.TOKEN_CalibrationBlock, 0);
  DefcalArgumentDefinitionListContext? defcalArgumentDefinitionList() => getRuleContext<DefcalArgumentDefinitionListContext>(0);
  DefcalStatementContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_defcalStatement;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterDefcalStatement(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitDefcalStatement(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitDefcalStatement(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ExpressionContext extends ParserRuleContext {
  ExpressionContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_expression;
 
  @override
  void copyFrom(ParserRuleContext ctx) {
    super.copyFrom(ctx);
  }
}

class AliasExpressionContext extends ParserRuleContext {
  List<ExpressionContext> expressions() => getRuleContexts<ExpressionContext>();
  ExpressionContext? expression(int i) => getRuleContext<ExpressionContext>(i);
  List<TerminalNode> DOUBLE_PLUSs() => getTokens(OpenQASM3Parser.TOKEN_DOUBLE_PLUS);
  TerminalNode? DOUBLE_PLUS(int i) => getToken(OpenQASM3Parser.TOKEN_DOUBLE_PLUS, i);
  AliasExpressionContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_aliasExpression;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterAliasExpression(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitAliasExpression(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitAliasExpression(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class DeclarationExpressionContext extends ParserRuleContext {
  ArrayLiteralContext? arrayLiteral() => getRuleContext<ArrayLiteralContext>(0);
  ExpressionContext? expression() => getRuleContext<ExpressionContext>(0);
  MeasureExpressionContext? measureExpression() => getRuleContext<MeasureExpressionContext>(0);
  DeclarationExpressionContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_declarationExpression;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterDeclarationExpression(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitDeclarationExpression(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitDeclarationExpression(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class MeasureExpressionContext extends ParserRuleContext {
  TerminalNode? MEASURE() => getToken(OpenQASM3Parser.TOKEN_MEASURE, 0);
  GateOperandContext? gateOperand() => getRuleContext<GateOperandContext>(0);
  MeasureExpressionContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_measureExpression;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterMeasureExpression(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitMeasureExpression(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitMeasureExpression(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class RangeExpressionContext extends ParserRuleContext {
  ExpressionContext? startExpr;
  ExpressionContext? stepExpr;
  ExpressionContext? stopExpr;
  List<TerminalNode> COLONs() => getTokens(OpenQASM3Parser.TOKEN_COLON);
  TerminalNode? COLON(int i) => getToken(OpenQASM3Parser.TOKEN_COLON, i);
  List<ExpressionContext> expressions() => getRuleContexts<ExpressionContext>();
  ExpressionContext? expression(int i) => getRuleContext<ExpressionContext>(i);
  RangeExpressionContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_rangeExpression;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterRangeExpression(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitRangeExpression(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitRangeExpression(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class SetExpressionContext extends ParserRuleContext {
  TerminalNode? LBRACE() => getToken(OpenQASM3Parser.TOKEN_LBRACE, 0);
  List<ExpressionContext> expressions() => getRuleContexts<ExpressionContext>();
  ExpressionContext? expression(int i) => getRuleContext<ExpressionContext>(i);
  TerminalNode? RBRACE() => getToken(OpenQASM3Parser.TOKEN_RBRACE, 0);
  List<TerminalNode> COMMAs() => getTokens(OpenQASM3Parser.TOKEN_COMMA);
  TerminalNode? COMMA(int i) => getToken(OpenQASM3Parser.TOKEN_COMMA, i);
  SetExpressionContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_setExpression;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterSetExpression(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitSetExpression(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitSetExpression(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ArrayLiteralContext extends ParserRuleContext {
  TerminalNode? LBRACE() => getToken(OpenQASM3Parser.TOKEN_LBRACE, 0);
  TerminalNode? RBRACE() => getToken(OpenQASM3Parser.TOKEN_RBRACE, 0);
  List<ExpressionContext> expressions() => getRuleContexts<ExpressionContext>();
  ExpressionContext? expression(int i) => getRuleContext<ExpressionContext>(i);
  List<ArrayLiteralContext> arrayLiterals() => getRuleContexts<ArrayLiteralContext>();
  ArrayLiteralContext? arrayLiteral(int i) => getRuleContext<ArrayLiteralContext>(i);
  List<TerminalNode> COMMAs() => getTokens(OpenQASM3Parser.TOKEN_COMMA);
  TerminalNode? COMMA(int i) => getToken(OpenQASM3Parser.TOKEN_COMMA, i);
  ArrayLiteralContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_arrayLiteral;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterArrayLiteral(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitArrayLiteral(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitArrayLiteral(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class IndexOperatorContext extends ParserRuleContext {
  TerminalNode? LBRACKET() => getToken(OpenQASM3Parser.TOKEN_LBRACKET, 0);
  TerminalNode? RBRACKET() => getToken(OpenQASM3Parser.TOKEN_RBRACKET, 0);
  SetExpressionContext? setExpression() => getRuleContext<SetExpressionContext>(0);
  List<ExpressionContext> expressions() => getRuleContexts<ExpressionContext>();
  ExpressionContext? expression(int i) => getRuleContext<ExpressionContext>(i);
  List<RangeExpressionContext> rangeExpressions() => getRuleContexts<RangeExpressionContext>();
  RangeExpressionContext? rangeExpression(int i) => getRuleContext<RangeExpressionContext>(i);
  List<TerminalNode> COMMAs() => getTokens(OpenQASM3Parser.TOKEN_COMMA);
  TerminalNode? COMMA(int i) => getToken(OpenQASM3Parser.TOKEN_COMMA, i);
  IndexOperatorContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_indexOperator;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterIndexOperator(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitIndexOperator(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitIndexOperator(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class IndexedIdentifierContext extends ParserRuleContext {
  TerminalNode? Identifier() => getToken(OpenQASM3Parser.TOKEN_Identifier, 0);
  List<IndexOperatorContext> indexOperators() => getRuleContexts<IndexOperatorContext>();
  IndexOperatorContext? indexOperator(int i) => getRuleContext<IndexOperatorContext>(i);
  IndexedIdentifierContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_indexedIdentifier;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterIndexedIdentifier(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitIndexedIdentifier(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitIndexedIdentifier(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ReturnSignatureContext extends ParserRuleContext {
  TerminalNode? ARROW() => getToken(OpenQASM3Parser.TOKEN_ARROW, 0);
  ScalarTypeContext? scalarType() => getRuleContext<ScalarTypeContext>(0);
  ReturnSignatureContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_returnSignature;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterReturnSignature(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitReturnSignature(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitReturnSignature(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class GateModifierContext extends ParserRuleContext {
  TerminalNode? AT() => getToken(OpenQASM3Parser.TOKEN_AT, 0);
  TerminalNode? INV() => getToken(OpenQASM3Parser.TOKEN_INV, 0);
  TerminalNode? POW() => getToken(OpenQASM3Parser.TOKEN_POW, 0);
  TerminalNode? LPAREN() => getToken(OpenQASM3Parser.TOKEN_LPAREN, 0);
  ExpressionContext? expression() => getRuleContext<ExpressionContext>(0);
  TerminalNode? RPAREN() => getToken(OpenQASM3Parser.TOKEN_RPAREN, 0);
  TerminalNode? CTRL() => getToken(OpenQASM3Parser.TOKEN_CTRL, 0);
  TerminalNode? NEGCTRL() => getToken(OpenQASM3Parser.TOKEN_NEGCTRL, 0);
  GateModifierContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_gateModifier;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterGateModifier(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitGateModifier(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitGateModifier(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ScalarTypeContext extends ParserRuleContext {
  TerminalNode? BIT() => getToken(OpenQASM3Parser.TOKEN_BIT, 0);
  DesignatorContext? designator() => getRuleContext<DesignatorContext>(0);
  TerminalNode? INT() => getToken(OpenQASM3Parser.TOKEN_INT, 0);
  TerminalNode? UINT() => getToken(OpenQASM3Parser.TOKEN_UINT, 0);
  TerminalNode? FLOAT() => getToken(OpenQASM3Parser.TOKEN_FLOAT, 0);
  TerminalNode? ANGLE() => getToken(OpenQASM3Parser.TOKEN_ANGLE, 0);
  TerminalNode? BOOL() => getToken(OpenQASM3Parser.TOKEN_BOOL, 0);
  TerminalNode? DURATION() => getToken(OpenQASM3Parser.TOKEN_DURATION, 0);
  TerminalNode? STRETCH() => getToken(OpenQASM3Parser.TOKEN_STRETCH, 0);
  TerminalNode? COMPLEX() => getToken(OpenQASM3Parser.TOKEN_COMPLEX, 0);
  TerminalNode? LBRACKET() => getToken(OpenQASM3Parser.TOKEN_LBRACKET, 0);
  ScalarTypeContext? scalarType() => getRuleContext<ScalarTypeContext>(0);
  TerminalNode? RBRACKET() => getToken(OpenQASM3Parser.TOKEN_RBRACKET, 0);
  TerminalNode? STRING() => getToken(OpenQASM3Parser.TOKEN_STRING, 0);
  ScalarTypeContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_scalarType;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterScalarType(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitScalarType(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitScalarType(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class QubitTypeContext extends ParserRuleContext {
  TerminalNode? QUBIT() => getToken(OpenQASM3Parser.TOKEN_QUBIT, 0);
  DesignatorContext? designator() => getRuleContext<DesignatorContext>(0);
  QubitTypeContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_qubitType;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterQubitType(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitQubitType(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitQubitType(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ArrayTypeContext extends ParserRuleContext {
  TerminalNode? ARRAY() => getToken(OpenQASM3Parser.TOKEN_ARRAY, 0);
  TerminalNode? LBRACKET() => getToken(OpenQASM3Parser.TOKEN_LBRACKET, 0);
  ScalarTypeContext? scalarType() => getRuleContext<ScalarTypeContext>(0);
  TerminalNode? COMMA() => getToken(OpenQASM3Parser.TOKEN_COMMA, 0);
  ExpressionListContext? expressionList() => getRuleContext<ExpressionListContext>(0);
  TerminalNode? RBRACKET() => getToken(OpenQASM3Parser.TOKEN_RBRACKET, 0);
  ArrayTypeContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_arrayType;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterArrayType(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitArrayType(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitArrayType(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ArrayReferenceTypeContext extends ParserRuleContext {
  TerminalNode? ARRAY() => getToken(OpenQASM3Parser.TOKEN_ARRAY, 0);
  TerminalNode? LBRACKET() => getToken(OpenQASM3Parser.TOKEN_LBRACKET, 0);
  ScalarTypeContext? scalarType() => getRuleContext<ScalarTypeContext>(0);
  TerminalNode? COMMA() => getToken(OpenQASM3Parser.TOKEN_COMMA, 0);
  TerminalNode? RBRACKET() => getToken(OpenQASM3Parser.TOKEN_RBRACKET, 0);
  TerminalNode? READONLY() => getToken(OpenQASM3Parser.TOKEN_READONLY, 0);
  TerminalNode? MUTABLE() => getToken(OpenQASM3Parser.TOKEN_MUTABLE, 0);
  ExpressionListContext? expressionList() => getRuleContext<ExpressionListContext>(0);
  TerminalNode? DIM() => getToken(OpenQASM3Parser.TOKEN_DIM, 0);
  TerminalNode? EQUALS() => getToken(OpenQASM3Parser.TOKEN_EQUALS, 0);
  ExpressionContext? expression() => getRuleContext<ExpressionContext>(0);
  ArrayReferenceTypeContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_arrayReferenceType;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterArrayReferenceType(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitArrayReferenceType(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitArrayReferenceType(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class DesignatorContext extends ParserRuleContext {
  TerminalNode? LBRACKET() => getToken(OpenQASM3Parser.TOKEN_LBRACKET, 0);
  ExpressionContext? expression() => getRuleContext<ExpressionContext>(0);
  TerminalNode? RBRACKET() => getToken(OpenQASM3Parser.TOKEN_RBRACKET, 0);
  DesignatorContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_designator;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterDesignator(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitDesignator(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitDesignator(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class DefcalTargetContext extends ParserRuleContext {
  TerminalNode? MEASURE() => getToken(OpenQASM3Parser.TOKEN_MEASURE, 0);
  TerminalNode? RESET() => getToken(OpenQASM3Parser.TOKEN_RESET, 0);
  TerminalNode? DELAY() => getToken(OpenQASM3Parser.TOKEN_DELAY, 0);
  TerminalNode? Identifier() => getToken(OpenQASM3Parser.TOKEN_Identifier, 0);
  DefcalTargetContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_defcalTarget;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterDefcalTarget(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitDefcalTarget(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitDefcalTarget(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class DefcalArgumentDefinitionContext extends ParserRuleContext {
  ExpressionContext? expression() => getRuleContext<ExpressionContext>(0);
  ArgumentDefinitionContext? argumentDefinition() => getRuleContext<ArgumentDefinitionContext>(0);
  DefcalArgumentDefinitionContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_defcalArgumentDefinition;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterDefcalArgumentDefinition(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitDefcalArgumentDefinition(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitDefcalArgumentDefinition(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class DefcalOperandContext extends ParserRuleContext {
  TerminalNode? HardwareQubit() => getToken(OpenQASM3Parser.TOKEN_HardwareQubit, 0);
  TerminalNode? Identifier() => getToken(OpenQASM3Parser.TOKEN_Identifier, 0);
  DefcalOperandContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_defcalOperand;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterDefcalOperand(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitDefcalOperand(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitDefcalOperand(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class GateOperandContext extends ParserRuleContext {
  IndexedIdentifierContext? indexedIdentifier() => getRuleContext<IndexedIdentifierContext>(0);
  TerminalNode? HardwareQubit() => getToken(OpenQASM3Parser.TOKEN_HardwareQubit, 0);
  GateOperandContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_gateOperand;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterGateOperand(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitGateOperand(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitGateOperand(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ExternArgumentContext extends ParserRuleContext {
  ScalarTypeContext? scalarType() => getRuleContext<ScalarTypeContext>(0);
  ArrayReferenceTypeContext? arrayReferenceType() => getRuleContext<ArrayReferenceTypeContext>(0);
  TerminalNode? CREG() => getToken(OpenQASM3Parser.TOKEN_CREG, 0);
  DesignatorContext? designator() => getRuleContext<DesignatorContext>(0);
  ExternArgumentContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_externArgument;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterExternArgument(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitExternArgument(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitExternArgument(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ArgumentDefinitionContext extends ParserRuleContext {
  ScalarTypeContext? scalarType() => getRuleContext<ScalarTypeContext>(0);
  TerminalNode? Identifier() => getToken(OpenQASM3Parser.TOKEN_Identifier, 0);
  QubitTypeContext? qubitType() => getRuleContext<QubitTypeContext>(0);
  TerminalNode? CREG() => getToken(OpenQASM3Parser.TOKEN_CREG, 0);
  TerminalNode? QREG() => getToken(OpenQASM3Parser.TOKEN_QREG, 0);
  DesignatorContext? designator() => getRuleContext<DesignatorContext>(0);
  ArrayReferenceTypeContext? arrayReferenceType() => getRuleContext<ArrayReferenceTypeContext>(0);
  ArgumentDefinitionContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_argumentDefinition;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterArgumentDefinition(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitArgumentDefinition(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitArgumentDefinition(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ArgumentDefinitionListContext extends ParserRuleContext {
  List<ArgumentDefinitionContext> argumentDefinitions() => getRuleContexts<ArgumentDefinitionContext>();
  ArgumentDefinitionContext? argumentDefinition(int i) => getRuleContext<ArgumentDefinitionContext>(i);
  List<TerminalNode> COMMAs() => getTokens(OpenQASM3Parser.TOKEN_COMMA);
  TerminalNode? COMMA(int i) => getToken(OpenQASM3Parser.TOKEN_COMMA, i);
  ArgumentDefinitionListContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_argumentDefinitionList;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterArgumentDefinitionList(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitArgumentDefinitionList(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitArgumentDefinitionList(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class DefcalArgumentDefinitionListContext extends ParserRuleContext {
  List<DefcalArgumentDefinitionContext> defcalArgumentDefinitions() => getRuleContexts<DefcalArgumentDefinitionContext>();
  DefcalArgumentDefinitionContext? defcalArgumentDefinition(int i) => getRuleContext<DefcalArgumentDefinitionContext>(i);
  List<TerminalNode> COMMAs() => getTokens(OpenQASM3Parser.TOKEN_COMMA);
  TerminalNode? COMMA(int i) => getToken(OpenQASM3Parser.TOKEN_COMMA, i);
  DefcalArgumentDefinitionListContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_defcalArgumentDefinitionList;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterDefcalArgumentDefinitionList(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitDefcalArgumentDefinitionList(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitDefcalArgumentDefinitionList(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class DefcalOperandListContext extends ParserRuleContext {
  List<DefcalOperandContext> defcalOperands() => getRuleContexts<DefcalOperandContext>();
  DefcalOperandContext? defcalOperand(int i) => getRuleContext<DefcalOperandContext>(i);
  List<TerminalNode> COMMAs() => getTokens(OpenQASM3Parser.TOKEN_COMMA);
  TerminalNode? COMMA(int i) => getToken(OpenQASM3Parser.TOKEN_COMMA, i);
  DefcalOperandListContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_defcalOperandList;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterDefcalOperandList(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitDefcalOperandList(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitDefcalOperandList(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ExpressionListContext extends ParserRuleContext {
  List<ExpressionContext> expressions() => getRuleContexts<ExpressionContext>();
  ExpressionContext? expression(int i) => getRuleContext<ExpressionContext>(i);
  List<TerminalNode> COMMAs() => getTokens(OpenQASM3Parser.TOKEN_COMMA);
  TerminalNode? COMMA(int i) => getToken(OpenQASM3Parser.TOKEN_COMMA, i);
  ExpressionListContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_expressionList;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterExpressionList(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitExpressionList(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitExpressionList(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class IdentifierListContext extends ParserRuleContext {
  List<TerminalNode> Identifiers() => getTokens(OpenQASM3Parser.TOKEN_Identifier);
  TerminalNode? Identifier(int i) => getToken(OpenQASM3Parser.TOKEN_Identifier, i);
  List<TerminalNode> COMMAs() => getTokens(OpenQASM3Parser.TOKEN_COMMA);
  TerminalNode? COMMA(int i) => getToken(OpenQASM3Parser.TOKEN_COMMA, i);
  IdentifierListContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_identifierList;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterIdentifierList(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitIdentifierList(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitIdentifierList(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class GateOperandListContext extends ParserRuleContext {
  List<GateOperandContext> gateOperands() => getRuleContexts<GateOperandContext>();
  GateOperandContext? gateOperand(int i) => getRuleContext<GateOperandContext>(i);
  List<TerminalNode> COMMAs() => getTokens(OpenQASM3Parser.TOKEN_COMMA);
  TerminalNode? COMMA(int i) => getToken(OpenQASM3Parser.TOKEN_COMMA, i);
  GateOperandListContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_gateOperandList;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterGateOperandList(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitGateOperandList(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitGateOperandList(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ExternArgumentListContext extends ParserRuleContext {
  List<ExternArgumentContext> externArguments() => getRuleContexts<ExternArgumentContext>();
  ExternArgumentContext? externArgument(int i) => getRuleContext<ExternArgumentContext>(i);
  List<TerminalNode> COMMAs() => getTokens(OpenQASM3Parser.TOKEN_COMMA);
  TerminalNode? COMMA(int i) => getToken(OpenQASM3Parser.TOKEN_COMMA, i);
  ExternArgumentListContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_externArgumentList;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterExternArgumentList(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitExternArgumentList(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitExternArgumentList(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class BitwiseXorExpressionContext extends ExpressionContext {
  Token? op;
  List<ExpressionContext> expressions() => getRuleContexts<ExpressionContext>();
  ExpressionContext? expression(int i) => getRuleContext<ExpressionContext>(i);
  TerminalNode? CARET() => getToken(OpenQASM3Parser.TOKEN_CARET, 0);
  BitwiseXorExpressionContext(ExpressionContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterBitwiseXorExpression(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitBitwiseXorExpression(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitBitwiseXorExpression(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class AdditiveExpressionContext extends ExpressionContext {
  Token? op;
  List<ExpressionContext> expressions() => getRuleContexts<ExpressionContext>();
  ExpressionContext? expression(int i) => getRuleContext<ExpressionContext>(i);
  TerminalNode? PLUS() => getToken(OpenQASM3Parser.TOKEN_PLUS, 0);
  TerminalNode? MINUS() => getToken(OpenQASM3Parser.TOKEN_MINUS, 0);
  AdditiveExpressionContext(ExpressionContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterAdditiveExpression(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitAdditiveExpression(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitAdditiveExpression(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class DurationofExpressionContext extends ExpressionContext {
  TerminalNode? DURATIONOF() => getToken(OpenQASM3Parser.TOKEN_DURATIONOF, 0);
  TerminalNode? LPAREN() => getToken(OpenQASM3Parser.TOKEN_LPAREN, 0);
  ScopeContext? scope() => getRuleContext<ScopeContext>(0);
  TerminalNode? RPAREN() => getToken(OpenQASM3Parser.TOKEN_RPAREN, 0);
  DurationofExpressionContext(ExpressionContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterDurationofExpression(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitDurationofExpression(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitDurationofExpression(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ParenthesisExpressionContext extends ExpressionContext {
  TerminalNode? LPAREN() => getToken(OpenQASM3Parser.TOKEN_LPAREN, 0);
  ExpressionContext? expression() => getRuleContext<ExpressionContext>(0);
  TerminalNode? RPAREN() => getToken(OpenQASM3Parser.TOKEN_RPAREN, 0);
  ParenthesisExpressionContext(ExpressionContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterParenthesisExpression(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitParenthesisExpression(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitParenthesisExpression(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class ComparisonExpressionContext extends ExpressionContext {
  Token? op;
  List<ExpressionContext> expressions() => getRuleContexts<ExpressionContext>();
  ExpressionContext? expression(int i) => getRuleContext<ExpressionContext>(i);
  TerminalNode? ComparisonOperator() => getToken(OpenQASM3Parser.TOKEN_ComparisonOperator, 0);
  ComparisonExpressionContext(ExpressionContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterComparisonExpression(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitComparisonExpression(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitComparisonExpression(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class MultiplicativeExpressionContext extends ExpressionContext {
  Token? op;
  List<ExpressionContext> expressions() => getRuleContexts<ExpressionContext>();
  ExpressionContext? expression(int i) => getRuleContext<ExpressionContext>(i);
  TerminalNode? ASTERISK() => getToken(OpenQASM3Parser.TOKEN_ASTERISK, 0);
  TerminalNode? SLASH() => getToken(OpenQASM3Parser.TOKEN_SLASH, 0);
  TerminalNode? PERCENT() => getToken(OpenQASM3Parser.TOKEN_PERCENT, 0);
  MultiplicativeExpressionContext(ExpressionContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterMultiplicativeExpression(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitMultiplicativeExpression(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitMultiplicativeExpression(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class LogicalOrExpressionContext extends ExpressionContext {
  Token? op;
  List<ExpressionContext> expressions() => getRuleContexts<ExpressionContext>();
  ExpressionContext? expression(int i) => getRuleContext<ExpressionContext>(i);
  TerminalNode? DOUBLE_PIPE() => getToken(OpenQASM3Parser.TOKEN_DOUBLE_PIPE, 0);
  LogicalOrExpressionContext(ExpressionContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterLogicalOrExpression(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitLogicalOrExpression(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitLogicalOrExpression(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class CastExpressionContext extends ExpressionContext {
  TerminalNode? LPAREN() => getToken(OpenQASM3Parser.TOKEN_LPAREN, 0);
  ExpressionContext? expression() => getRuleContext<ExpressionContext>(0);
  TerminalNode? RPAREN() => getToken(OpenQASM3Parser.TOKEN_RPAREN, 0);
  ScalarTypeContext? scalarType() => getRuleContext<ScalarTypeContext>(0);
  ArrayTypeContext? arrayType() => getRuleContext<ArrayTypeContext>(0);
  CastExpressionContext(ExpressionContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterCastExpression(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitCastExpression(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitCastExpression(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class PowerExpressionContext extends ExpressionContext {
  Token? op;
  List<ExpressionContext> expressions() => getRuleContexts<ExpressionContext>();
  ExpressionContext? expression(int i) => getRuleContext<ExpressionContext>(i);
  TerminalNode? DOUBLE_ASTERISK() => getToken(OpenQASM3Parser.TOKEN_DOUBLE_ASTERISK, 0);
  PowerExpressionContext(ExpressionContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterPowerExpression(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitPowerExpression(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitPowerExpression(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class BitwiseOrExpressionContext extends ExpressionContext {
  Token? op;
  List<ExpressionContext> expressions() => getRuleContexts<ExpressionContext>();
  ExpressionContext? expression(int i) => getRuleContext<ExpressionContext>(i);
  TerminalNode? PIPE() => getToken(OpenQASM3Parser.TOKEN_PIPE, 0);
  BitwiseOrExpressionContext(ExpressionContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterBitwiseOrExpression(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitBitwiseOrExpression(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitBitwiseOrExpression(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class CallExpressionContext extends ExpressionContext {
  TerminalNode? Identifier() => getToken(OpenQASM3Parser.TOKEN_Identifier, 0);
  TerminalNode? LPAREN() => getToken(OpenQASM3Parser.TOKEN_LPAREN, 0);
  TerminalNode? RPAREN() => getToken(OpenQASM3Parser.TOKEN_RPAREN, 0);
  ExpressionListContext? expressionList() => getRuleContext<ExpressionListContext>(0);
  CallExpressionContext(ExpressionContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterCallExpression(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitCallExpression(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitCallExpression(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class BitshiftExpressionContext extends ExpressionContext {
  Token? op;
  List<ExpressionContext> expressions() => getRuleContexts<ExpressionContext>();
  ExpressionContext? expression(int i) => getRuleContext<ExpressionContext>(i);
  TerminalNode? BitshiftOperator() => getToken(OpenQASM3Parser.TOKEN_BitshiftOperator, 0);
  BitshiftExpressionContext(ExpressionContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterBitshiftExpression(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitBitshiftExpression(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitBitshiftExpression(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class BitwiseAndExpressionContext extends ExpressionContext {
  Token? op;
  List<ExpressionContext> expressions() => getRuleContexts<ExpressionContext>();
  ExpressionContext? expression(int i) => getRuleContext<ExpressionContext>(i);
  TerminalNode? AMPERSAND() => getToken(OpenQASM3Parser.TOKEN_AMPERSAND, 0);
  BitwiseAndExpressionContext(ExpressionContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterBitwiseAndExpression(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitBitwiseAndExpression(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitBitwiseAndExpression(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class EqualityExpressionContext extends ExpressionContext {
  Token? op;
  List<ExpressionContext> expressions() => getRuleContexts<ExpressionContext>();
  ExpressionContext? expression(int i) => getRuleContext<ExpressionContext>(i);
  TerminalNode? EqualityOperator() => getToken(OpenQASM3Parser.TOKEN_EqualityOperator, 0);
  EqualityExpressionContext(ExpressionContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterEqualityExpression(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitEqualityExpression(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitEqualityExpression(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class LogicalAndExpressionContext extends ExpressionContext {
  Token? op;
  List<ExpressionContext> expressions() => getRuleContexts<ExpressionContext>();
  ExpressionContext? expression(int i) => getRuleContext<ExpressionContext>(i);
  TerminalNode? DOUBLE_AMPERSAND() => getToken(OpenQASM3Parser.TOKEN_DOUBLE_AMPERSAND, 0);
  LogicalAndExpressionContext(ExpressionContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterLogicalAndExpression(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitLogicalAndExpression(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitLogicalAndExpression(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class IndexExpressionContext extends ExpressionContext {
  ExpressionContext? expression() => getRuleContext<ExpressionContext>(0);
  IndexOperatorContext? indexOperator() => getRuleContext<IndexOperatorContext>(0);
  IndexExpressionContext(ExpressionContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterIndexExpression(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitIndexExpression(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitIndexExpression(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class UnaryExpressionContext extends ExpressionContext {
  Token? op;
  ExpressionContext? expression() => getRuleContext<ExpressionContext>(0);
  TerminalNode? TILDE() => getToken(OpenQASM3Parser.TOKEN_TILDE, 0);
  TerminalNode? EXCLAMATION_POINT() => getToken(OpenQASM3Parser.TOKEN_EXCLAMATION_POINT, 0);
  TerminalNode? MINUS() => getToken(OpenQASM3Parser.TOKEN_MINUS, 0);
  UnaryExpressionContext(ExpressionContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterUnaryExpression(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitUnaryExpression(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitUnaryExpression(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}

class LiteralExpressionContext extends ExpressionContext {
  TerminalNode? Identifier() => getToken(OpenQASM3Parser.TOKEN_Identifier, 0);
  TerminalNode? BinaryIntegerLiteral() => getToken(OpenQASM3Parser.TOKEN_BinaryIntegerLiteral, 0);
  TerminalNode? OctalIntegerLiteral() => getToken(OpenQASM3Parser.TOKEN_OctalIntegerLiteral, 0);
  TerminalNode? DecimalIntegerLiteral() => getToken(OpenQASM3Parser.TOKEN_DecimalIntegerLiteral, 0);
  TerminalNode? HexIntegerLiteral() => getToken(OpenQASM3Parser.TOKEN_HexIntegerLiteral, 0);
  TerminalNode? FloatLiteral() => getToken(OpenQASM3Parser.TOKEN_FloatLiteral, 0);
  TerminalNode? ImaginaryLiteral() => getToken(OpenQASM3Parser.TOKEN_ImaginaryLiteral, 0);
  TerminalNode? BooleanLiteral() => getToken(OpenQASM3Parser.TOKEN_BooleanLiteral, 0);
  TerminalNode? BitstringLiteral() => getToken(OpenQASM3Parser.TOKEN_BitstringLiteral, 0);
  TerminalNode? StringLiteral() => getToken(OpenQASM3Parser.TOKEN_StringLiteral, 0);
  TerminalNode? TimingLiteral() => getToken(OpenQASM3Parser.TOKEN_TimingLiteral, 0);
  TerminalNode? HardwareQubit() => getToken(OpenQASM3Parser.TOKEN_HardwareQubit, 0);
  LiteralExpressionContext(ExpressionContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.enterLiteralExpression(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is OpenQASM3ParserListener) listener.exitLiteralExpression(this);
  }
  @override
  T? accept<T>(ParseTreeVisitor<T> visitor) {
    if (visitor is OpenQASM3ParserVisitor<T>) {
     return visitor.visitLiteralExpression(this);
    } else {
    	return visitor.visitChildren(this);
    }
  }
}