// Generated from C:\_Projects\github\qartvm\tools\antlr4\\OpenQASM3Parser.g4 by ANTLR 4.12.0
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes
import 'package:antlr4/antlr4.dart';

import 'OpenQASM3ParserListener.dart';
import 'OpenQASM3ParserBaseListener.dart';
import 'OpenQASM3ParserVisitor.dart';
import 'OpenQASM3ParserBaseVisitor.dart';
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
    try {
      enterOuterAlt(_localctx, 1);
      state = 219;
      match(TOKEN_FOR);
      state = 220;
      scalarType();
      state = 221;
      match(TOKEN_Identifier);
      state = 222;
      match(TOKEN_IN);
      state = 229;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_LBRACE:
        state = 223;
        setExpression();
        break;
      case TOKEN_LBRACKET:
        state = 224;
        match(TOKEN_LBRACKET);
        state = 225;
        rangeExpression();
        state = 226;
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
        state = 228;
        expression(0);
        break;
      default:
        throw NoViableAltException(this);
      }
      state = 231;
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
      state = 233;
      match(TOKEN_IF);
      state = 234;
      match(TOKEN_LPAREN);
      state = 235;
      expression(0);
      state = 236;
      match(TOKEN_RPAREN);
      state = 237;
      _localctx.if_body = statementOrScope();
      state = 240;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 9, context)) {
      case 1:
        state = 238;
        match(TOKEN_ELSE);
        state = 239;
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
      state = 242;
      match(TOKEN_RETURN);
      state = 245;
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
        state = 243;
        expression(0);
        break;
      case TOKEN_MEASURE:
        state = 244;
        measureExpression();
        break;
      case TOKEN_SEMICOLON:
        break;
      default:
        break;
      }
      state = 247;
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
      state = 249;
      match(TOKEN_WHILE);
      state = 250;
      match(TOKEN_LPAREN);
      state = 251;
      expression(0);
      state = 252;
      match(TOKEN_RPAREN);
      state = 253;
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
      state = 255;
      match(TOKEN_BARRIER);
      state = 257;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_Identifier || _la == TOKEN_HardwareQubit) {
        state = 256;
        gateOperandList();
      }

      state = 259;
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
      state = 261;
      match(TOKEN_BOX);
      state = 263;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_LBRACKET) {
        state = 262;
        designator();
      }

      state = 265;
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
      state = 267;
      match(TOKEN_DELAY);
      state = 268;
      designator();
      state = 270;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_Identifier || _la == TOKEN_HardwareQubit) {
        state = 269;
        gateOperandList();
      }

      state = 272;
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
      state = 315;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 23, context)) {
      case 1:
        enterOuterAlt(_localctx, 1);
        state = 277;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        while ((((_la) & ~0x3f) == 0 && ((1 << _la) & 131941395333120) != 0)) {
          state = 274;
          gateModifier();
          state = 279;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
        }
        state = 280;
        match(TOKEN_Identifier);
        state = 286;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LPAREN) {
          state = 281;
          match(TOKEN_LPAREN);
          state = 283;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 297523172478025728) != 0) || ((((_la - 68)) & ~0x3f) == 0 && ((1 << (_la - 68)) & 536614913) != 0)) {
            state = 282;
            expressionList();
          }

          state = 285;
          match(TOKEN_RPAREN);
        }

        state = 289;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LBRACKET) {
          state = 288;
          designator();
        }

        state = 291;
        gateOperandList();
        state = 292;
        match(TOKEN_SEMICOLON);
        break;
      case 2:
        enterOuterAlt(_localctx, 2);
        state = 297;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        while ((((_la) & ~0x3f) == 0 && ((1 << _la) & 131941395333120) != 0)) {
          state = 294;
          gateModifier();
          state = 299;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
        }
        state = 300;
        match(TOKEN_GPHASE);
        state = 306;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LPAREN) {
          state = 301;
          match(TOKEN_LPAREN);
          state = 303;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 297523172478025728) != 0) || ((((_la - 68)) & ~0x3f) == 0 && ((1 << (_la - 68)) & 536614913) != 0)) {
            state = 302;
            expressionList();
          }

          state = 305;
          match(TOKEN_RPAREN);
        }

        state = 309;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LBRACKET) {
          state = 308;
          designator();
        }

        state = 312;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_Identifier || _la == TOKEN_HardwareQubit) {
          state = 311;
          gateOperandList();
        }

        state = 314;
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
      state = 317;
      measureExpression();
      state = 320;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_ARROW) {
        state = 318;
        match(TOKEN_ARROW);
        state = 319;
        indexedIdentifier();
      }

      state = 322;
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
      state = 324;
      match(TOKEN_RESET);
      state = 325;
      gateOperand();
      state = 326;
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
      state = 328;
      match(TOKEN_LET);
      state = 329;
      match(TOKEN_Identifier);
      state = 330;
      match(TOKEN_EQUALS);
      state = 331;
      aliasExpression();
      state = 332;
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
      state = 336;
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
        state = 334;
        scalarType();
        break;
      case TOKEN_ARRAY:
        state = 335;
        arrayType();
        break;
      default:
        throw NoViableAltException(this);
      }
      state = 338;
      match(TOKEN_Identifier);
      state = 341;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_EQUALS) {
        state = 339;
        match(TOKEN_EQUALS);
        state = 340;
        declarationExpression();
      }

      state = 343;
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
    try {
      enterOuterAlt(_localctx, 1);
      state = 345;
      match(TOKEN_CONST);
      state = 346;
      scalarType();
      state = 347;
      match(TOKEN_Identifier);
      state = 348;
      match(TOKEN_EQUALS);
      state = 349;
      declarationExpression();
      state = 350;
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
      state = 352;
      _la = tokenStream.LA(1)!;
      if (!(_la == TOKEN_INPUT || _la == TOKEN_OUTPUT)) {
      errorHandler.recoverInline(this);
      } else {
        if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
      state = 355;
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
        state = 353;
        scalarType();
        break;
      case TOKEN_ARRAY:
        state = 354;
        arrayType();
        break;
      default:
        throw NoViableAltException(this);
      }
      state = 357;
      match(TOKEN_Identifier);
      state = 358;
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
      state = 360;
      _la = tokenStream.LA(1)!;
      if (!(_la == TOKEN_QREG || _la == TOKEN_CREG)) {
      errorHandler.recoverInline(this);
      } else {
        if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
      state = 361;
      match(TOKEN_Identifier);
      state = 363;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_LBRACKET) {
        state = 362;
        designator();
      }

      state = 365;
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
      state = 367;
      qubitType();
      state = 368;
      match(TOKEN_Identifier);
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

  DefStatementContext defStatement() {
    dynamic _localctx = DefStatementContext(context, state);
    enterRule(_localctx, 56, RULE_defStatement);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 371;
      match(TOKEN_DEF);
      state = 372;
      match(TOKEN_Identifier);
      state = 373;
      match(TOKEN_LPAREN);
      state = 375;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 3985696096256) != 0)) {
        state = 374;
        argumentDefinitionList();
      }

      state = 377;
      match(TOKEN_RPAREN);
      state = 379;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_ARROW) {
        state = 378;
        returnSignature();
      }

      state = 381;
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
      state = 383;
      match(TOKEN_EXTERN);
      state = 384;
      match(TOKEN_Identifier);
      state = 385;
      match(TOKEN_LPAREN);
      state = 387;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 3985293443072) != 0)) {
        state = 386;
        externArgumentList();
      }

      state = 389;
      match(TOKEN_RPAREN);
      state = 391;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_ARROW) {
        state = 390;
        returnSignature();
      }

      state = 393;
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
      state = 395;
      match(TOKEN_GATE);
      state = 396;
      match(TOKEN_Identifier);
      state = 402;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_LPAREN) {
        state = 397;
        match(TOKEN_LPAREN);
        state = 399;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_Identifier) {
          state = 398;
          _localctx.params = identifierList();
        }

        state = 401;
        match(TOKEN_RPAREN);
      }

      state = 404;
      _localctx.qubits = identifierList();
      state = 405;
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
      state = 407;
      indexedIdentifier();
      state = 408;
      _localctx.op = tokenStream.LT(1);
      _la = tokenStream.LA(1)!;
      if (!(_la == TOKEN_EQUALS || _la == TOKEN_CompoundAssignmentOperator)) {
        _localctx.op = errorHandler.recoverInline(this);
      } else {
        if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
      state = 411;
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
        state = 409;
        expression(0);
        break;
      case TOKEN_MEASURE:
        state = 410;
        measureExpression();
        break;
      default:
        throw NoViableAltException(this);
      }
      state = 413;
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
      state = 415;
      expression(0);
      state = 416;
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
      state = 418;
      match(TOKEN_CAL);
      state = 419;
      match(TOKEN_LBRACE);
      state = 421;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_CalibrationBlock) {
        state = 420;
        match(TOKEN_CalibrationBlock);
      }

      state = 423;
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
      state = 425;
      match(TOKEN_DEFCAL);
      state = 426;
      defcalTarget();
      state = 432;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_LPAREN) {
        state = 427;
        match(TOKEN_LPAREN);
        state = 429;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 297523173518213120) != 0) || ((((_la - 68)) & ~0x3f) == 0 && ((1 << (_la - 68)) & 536614913) != 0)) {
          state = 428;
          defcalArgumentDefinitionList();
        }

        state = 431;
        match(TOKEN_RPAREN);
      }

      state = 434;
      defcalOperandList();
      state = 436;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_ARROW) {
        state = 435;
        returnSignature();
      }

      state = 438;
      match(TOKEN_LBRACE);
      state = 440;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_CalibrationBlock) {
        state = 439;
        match(TOKEN_CalibrationBlock);
      }

      state = 442;
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
      state = 471;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 43, context)) {
      case 1:
        _localctx = ParenthesisExpressionContext(_localctx);
        context = _localctx;
        _prevctx = _localctx;

        state = 445;
        match(TOKEN_LPAREN);
        state = 446;
        expression(0);
        state = 447;
        match(TOKEN_RPAREN);
        break;
      case 2:
        _localctx = UnaryExpressionContext(_localctx);
        context = _localctx;
        _prevctx = _localctx;
        state = 449;
        _localctx.op = tokenStream.LT(1);
        _la = tokenStream.LA(1)!;
        if (!(((((_la - 68)) & ~0x3f) == 0 && ((1 << (_la - 68)) & 6145) != 0))) {
          _localctx.op = errorHandler.recoverInline(this);
        } else {
          if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
          errorHandler.reportMatch(this);
          consume();
        }
        state = 450;
        expression(15);
        break;
      case 3:
        _localctx = CastExpressionContext(_localctx);
        context = _localctx;
        _prevctx = _localctx;
        state = 453;
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
          state = 451;
          scalarType();
          break;
        case TOKEN_ARRAY:
          state = 452;
          arrayType();
          break;
        default:
          throw NoViableAltException(this);
        }
        state = 455;
        match(TOKEN_LPAREN);
        state = 456;
        expression(0);
        state = 457;
        match(TOKEN_RPAREN);
        break;
      case 4:
        _localctx = DurationofExpressionContext(_localctx);
        context = _localctx;
        _prevctx = _localctx;
        state = 459;
        match(TOKEN_DURATIONOF);
        state = 460;
        match(TOKEN_LPAREN);
        state = 461;
        scope();
        state = 462;
        match(TOKEN_RPAREN);
        break;
      case 5:
        _localctx = CallExpressionContext(_localctx);
        context = _localctx;
        _prevctx = _localctx;
        state = 464;
        match(TOKEN_Identifier);
        state = 465;
        match(TOKEN_LPAREN);
        state = 467;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 297523172478025728) != 0) || ((((_la - 68)) & ~0x3f) == 0 && ((1 << (_la - 68)) & 536614913) != 0)) {
          state = 466;
          expressionList();
        }

        state = 469;
        match(TOKEN_RPAREN);
        break;
      case 6:
        _localctx = LiteralExpressionContext(_localctx);
        context = _localctx;
        _prevctx = _localctx;
        state = 470;
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
      state = 510;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 45, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          if (parseListeners != null) triggerExitRuleEvent();
          _prevctx = _localctx;
          state = 508;
          errorHandler.sync(this);
          switch (interpreter!.adaptivePredict(tokenStream, 44, context)) {
          case 1:
            _localctx = PowerExpressionContext(new ExpressionContext(_parentctx, _parentState));
            pushNewRecursionContext(_localctx, _startState, RULE_expression);
            state = 473;
            if (!(precpred(context, 16))) {
              throw FailedPredicateException(this, "precpred(context, 16)");
            }
            state = 474;
            _localctx.op = match(TOKEN_DOUBLE_ASTERISK);
            state = 475;
            expression(16);
            break;
          case 2:
            _localctx = MultiplicativeExpressionContext(new ExpressionContext(_parentctx, _parentState));
            pushNewRecursionContext(_localctx, _startState, RULE_expression);
            state = 476;
            if (!(precpred(context, 14))) {
              throw FailedPredicateException(this, "precpred(context, 14)");
            }
            state = 477;
            _localctx.op = tokenStream.LT(1);
            _la = tokenStream.LA(1)!;
            if (!(((((_la - 69)) & ~0x3f) == 0 && ((1 << (_la - 69)) & 13) != 0))) {
              _localctx.op = errorHandler.recoverInline(this);
            } else {
              if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
              errorHandler.reportMatch(this);
              consume();
            }
            state = 478;
            expression(15);
            break;
          case 3:
            _localctx = AdditiveExpressionContext(new ExpressionContext(_parentctx, _parentState));
            pushNewRecursionContext(_localctx, _startState, RULE_expression);
            state = 479;
            if (!(precpred(context, 13))) {
              throw FailedPredicateException(this, "precpred(context, 13)");
            }
            state = 480;
            _localctx.op = tokenStream.LT(1);
            _la = tokenStream.LA(1)!;
            if (!(_la == TOKEN_PLUS || _la == TOKEN_MINUS)) {
              _localctx.op = errorHandler.recoverInline(this);
            } else {
              if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
              errorHandler.reportMatch(this);
              consume();
            }
            state = 481;
            expression(14);
            break;
          case 4:
            _localctx = BitshiftExpressionContext(new ExpressionContext(_parentctx, _parentState));
            pushNewRecursionContext(_localctx, _startState, RULE_expression);
            state = 482;
            if (!(precpred(context, 12))) {
              throw FailedPredicateException(this, "precpred(context, 12)");
            }
            state = 483;
            _localctx.op = match(TOKEN_BitshiftOperator);
            state = 484;
            expression(13);
            break;
          case 5:
            _localctx = ComparisonExpressionContext(new ExpressionContext(_parentctx, _parentState));
            pushNewRecursionContext(_localctx, _startState, RULE_expression);
            state = 485;
            if (!(precpred(context, 11))) {
              throw FailedPredicateException(this, "precpred(context, 11)");
            }
            state = 486;
            _localctx.op = match(TOKEN_ComparisonOperator);
            state = 487;
            expression(12);
            break;
          case 6:
            _localctx = EqualityExpressionContext(new ExpressionContext(_parentctx, _parentState));
            pushNewRecursionContext(_localctx, _startState, RULE_expression);
            state = 488;
            if (!(precpred(context, 10))) {
              throw FailedPredicateException(this, "precpred(context, 10)");
            }
            state = 489;
            _localctx.op = match(TOKEN_EqualityOperator);
            state = 490;
            expression(11);
            break;
          case 7:
            _localctx = BitwiseAndExpressionContext(new ExpressionContext(_parentctx, _parentState));
            pushNewRecursionContext(_localctx, _startState, RULE_expression);
            state = 491;
            if (!(precpred(context, 9))) {
              throw FailedPredicateException(this, "precpred(context, 9)");
            }
            state = 492;
            _localctx.op = match(TOKEN_AMPERSAND);
            state = 493;
            expression(10);
            break;
          case 8:
            _localctx = BitwiseXorExpressionContext(new ExpressionContext(_parentctx, _parentState));
            pushNewRecursionContext(_localctx, _startState, RULE_expression);
            state = 494;
            if (!(precpred(context, 8))) {
              throw FailedPredicateException(this, "precpred(context, 8)");
            }
            state = 495;
            _localctx.op = match(TOKEN_CARET);
            state = 496;
            expression(9);
            break;
          case 9:
            _localctx = BitwiseOrExpressionContext(new ExpressionContext(_parentctx, _parentState));
            pushNewRecursionContext(_localctx, _startState, RULE_expression);
            state = 497;
            if (!(precpred(context, 7))) {
              throw FailedPredicateException(this, "precpred(context, 7)");
            }
            state = 498;
            _localctx.op = match(TOKEN_PIPE);
            state = 499;
            expression(8);
            break;
          case 10:
            _localctx = LogicalAndExpressionContext(new ExpressionContext(_parentctx, _parentState));
            pushNewRecursionContext(_localctx, _startState, RULE_expression);
            state = 500;
            if (!(precpred(context, 6))) {
              throw FailedPredicateException(this, "precpred(context, 6)");
            }
            state = 501;
            _localctx.op = match(TOKEN_DOUBLE_AMPERSAND);
            state = 502;
            expression(7);
            break;
          case 11:
            _localctx = LogicalOrExpressionContext(new ExpressionContext(_parentctx, _parentState));
            pushNewRecursionContext(_localctx, _startState, RULE_expression);
            state = 503;
            if (!(precpred(context, 5))) {
              throw FailedPredicateException(this, "precpred(context, 5)");
            }
            state = 504;
            _localctx.op = match(TOKEN_DOUBLE_PIPE);
            state = 505;
            expression(6);
            break;
          case 12:
            _localctx = IndexExpressionContext(new ExpressionContext(_parentctx, _parentState));
            pushNewRecursionContext(_localctx, _startState, RULE_expression);
            state = 506;
            if (!(precpred(context, 17))) {
              throw FailedPredicateException(this, "precpred(context, 17)");
            }
            state = 507;
            indexOperator();
            break;
          } 
        }
        state = 512;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 45, context);
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
      state = 513;
      expression(0);
      state = 518;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_DOUBLE_PLUS) {
        state = 514;
        match(TOKEN_DOUBLE_PLUS);
        state = 515;
        expression(0);
        state = 520;
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
      state = 524;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_LBRACE:
        enterOuterAlt(_localctx, 1);
        state = 521;
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
        state = 522;
        expression(0);
        break;
      case TOKEN_MEASURE:
        enterOuterAlt(_localctx, 3);
        state = 523;
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
      state = 526;
      match(TOKEN_MEASURE);
      state = 527;
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
      state = 530;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 297523172478025728) != 0) || ((((_la - 68)) & ~0x3f) == 0 && ((1 << (_la - 68)) & 536614913) != 0)) {
        state = 529;
        _localctx.startExpr = expression(0);
      }

      state = 532;
      match(TOKEN_COLON);
      state = 534;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 297523172478025728) != 0) || ((((_la - 68)) & ~0x3f) == 0 && ((1 << (_la - 68)) & 536614913) != 0)) {
        state = 533;
        _localctx.stepExpr = expression(0);
      }

      state = 538;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COLON) {
        state = 536;
        match(TOKEN_COLON);
        state = 537;
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
      state = 540;
      match(TOKEN_LBRACE);
      state = 541;
      expression(0);
      state = 546;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 51, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 542;
          match(TOKEN_COMMA);
          state = 543;
          expression(0); 
        }
        state = 548;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 51, context);
      }
      state = 550;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 549;
        match(TOKEN_COMMA);
      }

      state = 552;
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
      state = 554;
      match(TOKEN_LBRACE);
      state = 557;
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
        state = 555;
        expression(0);
        break;
      case TOKEN_LBRACE:
        state = 556;
        arrayLiteral();
        break;
      default:
        throw NoViableAltException(this);
      }
      state = 566;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 55, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 559;
          match(TOKEN_COMMA);
          state = 562;
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
            state = 560;
            expression(0);
            break;
          case TOKEN_LBRACE:
            state = 561;
            arrayLiteral();
            break;
          default:
            throw NoViableAltException(this);
          } 
        }
        state = 568;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 55, context);
      }
      state = 570;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 569;
        match(TOKEN_COMMA);
      }

      state = 572;
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
      state = 574;
      match(TOKEN_LBRACKET);
      state = 593;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_LBRACE:
        state = 575;
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
        state = 578;
        errorHandler.sync(this);
        switch (interpreter!.adaptivePredict(tokenStream, 57, context)) {
        case 1:
          state = 576;
          expression(0);
          break;
        case 2:
          state = 577;
          rangeExpression();
          break;
        }
        state = 587;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 59, context);
        while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
          if (_alt == 1) {
            state = 580;
            match(TOKEN_COMMA);
            state = 583;
            errorHandler.sync(this);
            switch (interpreter!.adaptivePredict(tokenStream, 58, context)) {
            case 1:
              state = 581;
              expression(0);
              break;
            case 2:
              state = 582;
              rangeExpression();
              break;
            } 
          }
          state = 589;
          errorHandler.sync(this);
          _alt = interpreter!.adaptivePredict(tokenStream, 59, context);
        }
        state = 591;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_COMMA) {
          state = 590;
          match(TOKEN_COMMA);
        }

        break;
      default:
        throw NoViableAltException(this);
      }
      state = 595;
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
      state = 597;
      match(TOKEN_Identifier);
      state = 601;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_LBRACKET) {
        state = 598;
        indexOperator();
        state = 603;
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
      state = 604;
      match(TOKEN_ARROW);
      state = 605;
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
      state = 620;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_INV:
        state = 607;
        match(TOKEN_INV);
        break;
      case TOKEN_POW:
        state = 608;
        match(TOKEN_POW);
        state = 609;
        match(TOKEN_LPAREN);
        state = 610;
        expression(0);
        state = 611;
        match(TOKEN_RPAREN);
        break;
      case TOKEN_CTRL:
      case TOKEN_NEGCTRL:
        state = 613;
        _la = tokenStream.LA(1)!;
        if (!(_la == TOKEN_CTRL || _la == TOKEN_NEGCTRL)) {
        errorHandler.recoverInline(this);
        } else {
          if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
          errorHandler.reportMatch(this);
          consume();
        }
        state = 618;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LPAREN) {
          state = 614;
          match(TOKEN_LPAREN);
          state = 615;
          expression(0);
          state = 616;
          match(TOKEN_RPAREN);
        }

        break;
      default:
        throw NoViableAltException(this);
      }
      state = 622;
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
      state = 655;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_BIT:
        enterOuterAlt(_localctx, 1);
        state = 624;
        match(TOKEN_BIT);
        state = 626;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LBRACKET) {
          state = 625;
          designator();
        }

        break;
      case TOKEN_INT:
        enterOuterAlt(_localctx, 2);
        state = 628;
        match(TOKEN_INT);
        state = 630;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LBRACKET) {
          state = 629;
          designator();
        }

        break;
      case TOKEN_UINT:
        enterOuterAlt(_localctx, 3);
        state = 632;
        match(TOKEN_UINT);
        state = 634;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LBRACKET) {
          state = 633;
          designator();
        }

        break;
      case TOKEN_FLOAT:
        enterOuterAlt(_localctx, 4);
        state = 636;
        match(TOKEN_FLOAT);
        state = 638;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LBRACKET) {
          state = 637;
          designator();
        }

        break;
      case TOKEN_ANGLE:
        enterOuterAlt(_localctx, 5);
        state = 640;
        match(TOKEN_ANGLE);
        state = 642;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LBRACKET) {
          state = 641;
          designator();
        }

        break;
      case TOKEN_BOOL:
        enterOuterAlt(_localctx, 6);
        state = 644;
        match(TOKEN_BOOL);
        break;
      case TOKEN_DURATION:
        enterOuterAlt(_localctx, 7);
        state = 645;
        match(TOKEN_DURATION);
        break;
      case TOKEN_STRETCH:
        enterOuterAlt(_localctx, 8);
        state = 646;
        match(TOKEN_STRETCH);
        break;
      case TOKEN_COMPLEX:
        enterOuterAlt(_localctx, 9);
        state = 647;
        match(TOKEN_COMPLEX);
        state = 652;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LBRACKET) {
          state = 648;
          match(TOKEN_LBRACKET);
          state = 649;
          scalarType();
          state = 650;
          match(TOKEN_RBRACKET);
        }

        break;
      case TOKEN_STRING:
        enterOuterAlt(_localctx, 10);
        state = 654;
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
      state = 657;
      match(TOKEN_QUBIT);
      state = 659;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_LBRACKET) {
        state = 658;
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
      state = 661;
      match(TOKEN_ARRAY);
      state = 662;
      match(TOKEN_LBRACKET);
      state = 663;
      scalarType();
      state = 664;
      match(TOKEN_COMMA);
      state = 665;
      expressionList();
      state = 666;
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
      state = 668;
      _la = tokenStream.LA(1)!;
      if (!(_la == TOKEN_READONLY || _la == TOKEN_MUTABLE)) {
      errorHandler.recoverInline(this);
      } else {
        if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
      state = 669;
      match(TOKEN_ARRAY);
      state = 670;
      match(TOKEN_LBRACKET);
      state = 671;
      scalarType();
      state = 672;
      match(TOKEN_COMMA);
      state = 677;
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
        state = 673;
        expressionList();
        break;
      case TOKEN_DIM:
        state = 674;
        match(TOKEN_DIM);
        state = 675;
        match(TOKEN_EQUALS);
        state = 676;
        expression(0);
        break;
      default:
        throw NoViableAltException(this);
      }
      state = 679;
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
      state = 681;
      match(TOKEN_LBRACKET);
      state = 682;
      expression(0);
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

  DefcalTargetContext defcalTarget() {
    dynamic _localctx = DefcalTargetContext(context, state);
    enterRule(_localctx, 102, RULE_defcalTarget);
    int _la;
    try {
      enterOuterAlt(_localctx, 1);
      state = 685;
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
      state = 689;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 74, context)) {
      case 1:
        enterOuterAlt(_localctx, 1);
        state = 687;
        expression(0);
        break;
      case 2:
        enterOuterAlt(_localctx, 2);
        state = 688;
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
      state = 691;
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
      state = 695;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_Identifier:
        enterOuterAlt(_localctx, 1);
        state = 693;
        indexedIdentifier();
        break;
      case TOKEN_HardwareQubit:
        enterOuterAlt(_localctx, 2);
        state = 694;
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
      state = 703;
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
        state = 697;
        scalarType();
        break;
      case TOKEN_READONLY:
      case TOKEN_MUTABLE:
        enterOuterAlt(_localctx, 2);
        state = 698;
        arrayReferenceType();
        break;
      case TOKEN_CREG:
        enterOuterAlt(_localctx, 3);
        state = 699;
        match(TOKEN_CREG);
        state = 701;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LBRACKET) {
          state = 700;
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
      state = 719;
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
        state = 705;
        scalarType();
        state = 706;
        match(TOKEN_Identifier);
        break;
      case TOKEN_QUBIT:
        enterOuterAlt(_localctx, 2);
        state = 708;
        qubitType();
        state = 709;
        match(TOKEN_Identifier);
        break;
      case TOKEN_QREG:
      case TOKEN_CREG:
        enterOuterAlt(_localctx, 3);
        state = 711;
        _la = tokenStream.LA(1)!;
        if (!(_la == TOKEN_QREG || _la == TOKEN_CREG)) {
        errorHandler.recoverInline(this);
        } else {
          if ( tokenStream.LA(1)! == IntStream.EOF ) matchedEOF = true;
          errorHandler.reportMatch(this);
          consume();
        }
        state = 712;
        match(TOKEN_Identifier);
        state = 714;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_LBRACKET) {
          state = 713;
          designator();
        }

        break;
      case TOKEN_READONLY:
      case TOKEN_MUTABLE:
        enterOuterAlt(_localctx, 4);
        state = 716;
        arrayReferenceType();
        state = 717;
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
      state = 721;
      argumentDefinition();
      state = 726;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 80, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 722;
          match(TOKEN_COMMA);
          state = 723;
          argumentDefinition(); 
        }
        state = 728;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 80, context);
      }
      state = 730;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 729;
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
      state = 732;
      defcalArgumentDefinition();
      state = 737;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 82, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 733;
          match(TOKEN_COMMA);
          state = 734;
          defcalArgumentDefinition(); 
        }
        state = 739;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 82, context);
      }
      state = 741;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 740;
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
      state = 743;
      defcalOperand();
      state = 748;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 84, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 744;
          match(TOKEN_COMMA);
          state = 745;
          defcalOperand(); 
        }
        state = 750;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 84, context);
      }
      state = 752;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 751;
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
      state = 754;
      expression(0);
      state = 759;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 86, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 755;
          match(TOKEN_COMMA);
          state = 756;
          expression(0); 
        }
        state = 761;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 86, context);
      }
      state = 763;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 762;
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
      state = 765;
      match(TOKEN_Identifier);
      state = 770;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 88, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 766;
          match(TOKEN_COMMA);
          state = 767;
          match(TOKEN_Identifier); 
        }
        state = 772;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 88, context);
      }
      state = 774;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 773;
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
      state = 776;
      gateOperand();
      state = 781;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 90, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 777;
          match(TOKEN_COMMA);
          state = 778;
          gateOperand(); 
        }
        state = 783;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 90, context);
      }
      state = 785;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 784;
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
      state = 787;
      externArgument();
      state = 792;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 92, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 788;
          match(TOKEN_COMMA);
          state = 789;
          externArgument(); 
        }
        state = 794;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 92, context);
      }
      state = 796;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 795;
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
      4,1,110,799,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,
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
      8,1,8,1,9,1,9,1,9,1,10,1,10,1,10,1,11,1,11,1,11,1,12,1,12,1,12,1,12,
      1,12,1,12,1,12,1,12,1,12,1,12,3,12,230,8,12,1,12,1,12,1,13,1,13,1,
      13,1,13,1,13,1,13,1,13,3,13,241,8,13,1,14,1,14,1,14,3,14,246,8,14,
      1,14,1,14,1,15,1,15,1,15,1,15,1,15,1,15,1,16,1,16,3,16,258,8,16,1,
      16,1,16,1,17,1,17,3,17,264,8,17,1,17,1,17,1,18,1,18,1,18,3,18,271,
      8,18,1,18,1,18,1,19,5,19,276,8,19,10,19,12,19,279,9,19,1,19,1,19,1,
      19,3,19,284,8,19,1,19,3,19,287,8,19,1,19,3,19,290,8,19,1,19,1,19,1,
      19,1,19,5,19,296,8,19,10,19,12,19,299,9,19,1,19,1,19,1,19,3,19,304,
      8,19,1,19,3,19,307,8,19,1,19,3,19,310,8,19,1,19,3,19,313,8,19,1,19,
      3,19,316,8,19,1,20,1,20,1,20,3,20,321,8,20,1,20,1,20,1,21,1,21,1,21,
      1,21,1,22,1,22,1,22,1,22,1,22,1,22,1,23,1,23,3,23,337,8,23,1,23,1,
      23,1,23,3,23,342,8,23,1,23,1,23,1,24,1,24,1,24,1,24,1,24,1,24,1,24,
      1,25,1,25,1,25,3,25,356,8,25,1,25,1,25,1,25,1,26,1,26,1,26,3,26,364,
      8,26,1,26,1,26,1,27,1,27,1,27,1,27,1,28,1,28,1,28,1,28,3,28,376,8,
      28,1,28,1,28,3,28,380,8,28,1,28,1,28,1,29,1,29,1,29,1,29,3,29,388,
      8,29,1,29,1,29,3,29,392,8,29,1,29,1,29,1,30,1,30,1,30,1,30,3,30,400,
      8,30,1,30,3,30,403,8,30,1,30,1,30,1,30,1,31,1,31,1,31,1,31,3,31,412,
      8,31,1,31,1,31,1,32,1,32,1,32,1,33,1,33,1,33,3,33,422,8,33,1,33,1,
      33,1,34,1,34,1,34,1,34,3,34,430,8,34,1,34,3,34,433,8,34,1,34,1,34,
      3,34,437,8,34,1,34,1,34,3,34,441,8,34,1,34,1,34,1,35,1,35,1,35,1,35,
      1,35,1,35,1,35,1,35,1,35,3,35,454,8,35,1,35,1,35,1,35,1,35,1,35,1,
      35,1,35,1,35,1,35,1,35,1,35,1,35,3,35,468,8,35,1,35,1,35,3,35,472,
      8,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,
      35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,
      1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,1,35,5,35,509,8,35,10,35,12,
      35,512,9,35,1,36,1,36,1,36,5,36,517,8,36,10,36,12,36,520,9,36,1,37,
      1,37,1,37,3,37,525,8,37,1,38,1,38,1,38,1,39,3,39,531,8,39,1,39,1,39,
      3,39,535,8,39,1,39,1,39,3,39,539,8,39,1,40,1,40,1,40,1,40,5,40,545,
      8,40,10,40,12,40,548,9,40,1,40,3,40,551,8,40,1,40,1,40,1,41,1,41,1,
      41,3,41,558,8,41,1,41,1,41,1,41,3,41,563,8,41,5,41,565,8,41,10,41,
      12,41,568,9,41,1,41,3,41,571,8,41,1,41,1,41,1,42,1,42,1,42,1,42,3,
      42,579,8,42,1,42,1,42,1,42,3,42,584,8,42,5,42,586,8,42,10,42,12,42,
      589,9,42,1,42,3,42,592,8,42,3,42,594,8,42,1,42,1,42,1,43,1,43,5,43,
      600,8,43,10,43,12,43,603,9,43,1,44,1,44,1,44,1,45,1,45,1,45,1,45,1,
      45,1,45,1,45,1,45,1,45,1,45,1,45,3,45,619,8,45,3,45,621,8,45,1,45,
      1,45,1,46,1,46,3,46,627,8,46,1,46,1,46,3,46,631,8,46,1,46,1,46,3,46,
      635,8,46,1,46,1,46,3,46,639,8,46,1,46,1,46,3,46,643,8,46,1,46,1,46,
      1,46,1,46,1,46,1,46,1,46,1,46,3,46,653,8,46,1,46,3,46,656,8,46,1,47,
      1,47,3,47,660,8,47,1,48,1,48,1,48,1,48,1,48,1,48,1,48,1,49,1,49,1,
      49,1,49,1,49,1,49,1,49,1,49,1,49,3,49,678,8,49,1,49,1,49,1,50,1,50,
      1,50,1,50,1,51,1,51,1,52,1,52,3,52,690,8,52,1,53,1,53,1,54,1,54,3,
      54,696,8,54,1,55,1,55,1,55,1,55,3,55,702,8,55,3,55,704,8,55,1,56,1,
      56,1,56,1,56,1,56,1,56,1,56,1,56,1,56,3,56,715,8,56,1,56,1,56,1,56,
      3,56,720,8,56,1,57,1,57,1,57,5,57,725,8,57,10,57,12,57,728,9,57,1,
      57,3,57,731,8,57,1,58,1,58,1,58,5,58,736,8,58,10,58,12,58,739,9,58,
      1,58,3,58,742,8,58,1,59,1,59,1,59,5,59,747,8,59,10,59,12,59,750,9,
      59,1,59,3,59,753,8,59,1,60,1,60,1,60,5,60,758,8,60,10,60,12,60,761,
      9,60,1,60,3,60,764,8,60,1,61,1,61,1,61,5,61,769,8,61,10,61,12,61,772,
      9,61,1,61,3,61,775,8,61,1,62,1,62,1,62,5,62,780,8,62,10,62,12,62,783,
      9,62,1,62,3,62,786,8,62,1,63,1,63,1,63,5,63,791,8,63,10,63,12,63,794,
      9,63,1,63,3,63,797,8,63,1,63,0,1,70,64,0,2,4,6,8,10,12,14,16,18,20,
      22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,
      66,68,70,72,74,76,78,80,82,84,86,88,90,92,94,96,98,100,102,104,106,
      108,110,112,114,116,118,120,122,124,126,0,11,1,0,22,23,2,0,27,27,29,
      29,2,0,64,64,82,82,2,0,68,68,79,80,2,0,53,53,86,96,2,0,69,69,71,72,
      2,0,66,66,68,68,1,0,45,46,1,0,25,26,2,0,49,51,91,91,1,0,91,92,883,
      0,129,1,0,0,0,2,139,1,0,0,0,4,180,1,0,0,0,6,182,1,0,0,0,8,186,1,0,
      0,0,10,195,1,0,0,0,12,200,1,0,0,0,14,202,1,0,0,0,16,206,1,0,0,0,18,
      210,1,0,0,0,20,213,1,0,0,0,22,216,1,0,0,0,24,219,1,0,0,0,26,233,1,
      0,0,0,28,242,1,0,0,0,30,249,1,0,0,0,32,255,1,0,0,0,34,261,1,0,0,0,
      36,267,1,0,0,0,38,315,1,0,0,0,40,317,1,0,0,0,42,324,1,0,0,0,44,328,
      1,0,0,0,46,336,1,0,0,0,48,345,1,0,0,0,50,352,1,0,0,0,52,360,1,0,0,
      0,54,367,1,0,0,0,56,371,1,0,0,0,58,383,1,0,0,0,60,395,1,0,0,0,62,407,
      1,0,0,0,64,415,1,0,0,0,66,418,1,0,0,0,68,425,1,0,0,0,70,471,1,0,0,
      0,72,513,1,0,0,0,74,524,1,0,0,0,76,526,1,0,0,0,78,530,1,0,0,0,80,540,
      1,0,0,0,82,554,1,0,0,0,84,574,1,0,0,0,86,597,1,0,0,0,88,604,1,0,0,
      0,90,620,1,0,0,0,92,655,1,0,0,0,94,657,1,0,0,0,96,661,1,0,0,0,98,668,
      1,0,0,0,100,681,1,0,0,0,102,685,1,0,0,0,104,689,1,0,0,0,106,691,1,
      0,0,0,108,695,1,0,0,0,110,703,1,0,0,0,112,719,1,0,0,0,114,721,1,0,
      0,0,116,732,1,0,0,0,118,743,1,0,0,0,120,754,1,0,0,0,122,765,1,0,0,
      0,124,776,1,0,0,0,126,787,1,0,0,0,128,130,3,2,1,0,129,128,1,0,0,0,
      129,130,1,0,0,0,130,134,1,0,0,0,131,133,3,4,2,0,132,131,1,0,0,0,133,
      136,1,0,0,0,134,132,1,0,0,0,134,135,1,0,0,0,135,137,1,0,0,0,136,134,
      1,0,0,0,137,138,5,0,0,1,138,1,1,0,0,0,139,140,5,1,0,0,140,141,5,102,
      0,0,141,142,5,61,0,0,142,3,1,0,0,0,143,181,3,10,5,0,144,146,3,6,3,
      0,145,144,1,0,0,0,146,149,1,0,0,0,147,145,1,0,0,0,147,148,1,0,0,0,
      148,178,1,0,0,0,149,147,1,0,0,0,150,179,3,44,22,0,151,179,3,62,31,
      0,152,179,3,32,16,0,153,179,3,34,17,0,154,179,3,18,9,0,155,179,3,66,
      33,0,156,179,3,14,7,0,157,179,3,46,23,0,158,179,3,48,24,0,159,179,
      3,20,10,0,160,179,3,56,28,0,161,179,3,68,34,0,162,179,3,36,18,0,163,
      179,3,22,11,0,164,179,3,64,32,0,165,179,3,58,29,0,166,179,3,24,12,
      0,167,179,3,38,19,0,168,179,3,60,30,0,169,179,3,26,13,0,170,179,3,
      16,8,0,171,179,3,50,25,0,172,179,3,40,20,0,173,179,3,52,26,0,174,179,
      3,54,27,0,175,179,3,42,21,0,176,179,3,28,14,0,177,179,3,30,15,0,178,
      150,1,0,0,0,178,151,1,0,0,0,178,152,1,0,0,0,178,153,1,0,0,0,178,154,
      1,0,0,0,178,155,1,0,0,0,178,156,1,0,0,0,178,157,1,0,0,0,178,158,1,
      0,0,0,178,159,1,0,0,0,178,160,1,0,0,0,178,161,1,0,0,0,178,162,1,0,
      0,0,178,163,1,0,0,0,178,164,1,0,0,0,178,165,1,0,0,0,178,166,1,0,0,
      0,178,167,1,0,0,0,178,168,1,0,0,0,178,169,1,0,0,0,178,170,1,0,0,0,
      178,171,1,0,0,0,178,172,1,0,0,0,178,173,1,0,0,0,178,174,1,0,0,0,178,
      175,1,0,0,0,178,176,1,0,0,0,178,177,1,0,0,0,179,181,1,0,0,0,180,143,
      1,0,0,0,180,147,1,0,0,0,181,5,1,0,0,0,182,184,5,21,0,0,183,185,5,105,
      0,0,184,183,1,0,0,0,184,185,1,0,0,0,185,7,1,0,0,0,186,190,5,56,0,0,
      187,189,3,4,2,0,188,187,1,0,0,0,189,192,1,0,0,0,190,188,1,0,0,0,190,
      191,1,0,0,0,191,193,1,0,0,0,192,190,1,0,0,0,193,194,5,57,0,0,194,9,
      1,0,0,0,195,196,5,20,0,0,196,197,5,105,0,0,197,11,1,0,0,0,198,201,
      3,4,2,0,199,201,3,8,4,0,200,198,1,0,0,0,200,199,1,0,0,0,201,13,1,0,
      0,0,202,203,5,3,0,0,203,204,5,96,0,0,204,205,5,61,0,0,205,15,1,0,0,
      0,206,207,5,2,0,0,207,208,5,96,0,0,208,209,5,61,0,0,209,17,1,0,0,0,
      210,211,5,11,0,0,211,212,5,61,0,0,212,19,1,0,0,0,213,214,5,12,0,0,
      214,215,5,61,0,0,215,21,1,0,0,0,216,217,5,15,0,0,217,218,5,61,0,0,
      218,23,1,0,0,0,219,220,5,17,0,0,220,221,3,92,46,0,221,222,5,91,0,0,
      222,229,5,19,0,0,223,230,3,80,40,0,224,225,5,54,0,0,225,226,3,78,39,
      0,226,227,5,55,0,0,227,230,1,0,0,0,228,230,3,70,35,0,229,223,1,0,0,
      0,229,224,1,0,0,0,229,228,1,0,0,0,230,231,1,0,0,0,231,232,3,12,6,0,
      232,25,1,0,0,0,233,234,5,13,0,0,234,235,5,58,0,0,235,236,3,70,35,0,
      236,237,5,59,0,0,237,240,3,12,6,0,238,239,5,14,0,0,239,241,3,12,6,
      0,240,238,1,0,0,0,240,241,1,0,0,0,241,27,1,0,0,0,242,245,5,16,0,0,
      243,246,3,70,35,0,244,246,3,76,38,0,245,243,1,0,0,0,245,244,1,0,0,
      0,245,246,1,0,0,0,246,247,1,0,0,0,247,248,5,61,0,0,248,29,1,0,0,0,
      249,250,5,18,0,0,250,251,5,58,0,0,251,252,3,70,35,0,252,253,5,59,0,
      0,253,254,3,12,6,0,254,31,1,0,0,0,255,257,5,52,0,0,256,258,3,124,62,
      0,257,256,1,0,0,0,257,258,1,0,0,0,258,259,1,0,0,0,259,260,5,61,0,0,
      260,33,1,0,0,0,261,263,5,9,0,0,262,264,3,100,50,0,263,262,1,0,0,0,
      263,264,1,0,0,0,264,265,1,0,0,0,265,266,3,8,4,0,266,35,1,0,0,0,267,
      268,5,49,0,0,268,270,3,100,50,0,269,271,3,124,62,0,270,269,1,0,0,0,
      270,271,1,0,0,0,271,272,1,0,0,0,272,273,5,61,0,0,273,37,1,0,0,0,274,
      276,3,90,45,0,275,274,1,0,0,0,276,279,1,0,0,0,277,275,1,0,0,0,277,
      278,1,0,0,0,278,280,1,0,0,0,279,277,1,0,0,0,280,286,5,91,0,0,281,283,
      5,58,0,0,282,284,3,120,60,0,283,282,1,0,0,0,283,284,1,0,0,0,284,285,
      1,0,0,0,285,287,5,59,0,0,286,281,1,0,0,0,286,287,1,0,0,0,287,289,1,
      0,0,0,288,290,3,100,50,0,289,288,1,0,0,0,289,290,1,0,0,0,290,291,1,
      0,0,0,291,292,3,124,62,0,292,293,5,61,0,0,293,316,1,0,0,0,294,296,
      3,90,45,0,295,294,1,0,0,0,296,299,1,0,0,0,297,295,1,0,0,0,297,298,
      1,0,0,0,298,300,1,0,0,0,299,297,1,0,0,0,300,306,5,42,0,0,301,303,5,
      58,0,0,302,304,3,120,60,0,303,302,1,0,0,0,303,304,1,0,0,0,304,305,
      1,0,0,0,305,307,5,59,0,0,306,301,1,0,0,0,306,307,1,0,0,0,307,309,1,
      0,0,0,308,310,3,100,50,0,309,308,1,0,0,0,309,310,1,0,0,0,310,312,1,
      0,0,0,311,313,3,124,62,0,312,311,1,0,0,0,312,313,1,0,0,0,313,314,1,
      0,0,0,314,316,5,61,0,0,315,277,1,0,0,0,315,297,1,0,0,0,316,39,1,0,
      0,0,317,320,3,76,38,0,318,319,5,65,0,0,319,321,3,86,43,0,320,318,1,
      0,0,0,320,321,1,0,0,0,321,322,1,0,0,0,322,323,5,61,0,0,323,41,1,0,
      0,0,324,325,5,50,0,0,325,326,3,108,54,0,326,327,5,61,0,0,327,43,1,
      0,0,0,328,329,5,10,0,0,329,330,5,91,0,0,330,331,5,64,0,0,331,332,3,
      72,36,0,332,333,5,61,0,0,333,45,1,0,0,0,334,337,3,92,46,0,335,337,
      3,96,48,0,336,334,1,0,0,0,336,335,1,0,0,0,337,338,1,0,0,0,338,341,
      5,91,0,0,339,340,5,64,0,0,340,342,3,74,37,0,341,339,1,0,0,0,341,342,
      1,0,0,0,342,343,1,0,0,0,343,344,5,61,0,0,344,47,1,0,0,0,345,346,5,
      24,0,0,346,347,3,92,46,0,347,348,5,91,0,0,348,349,5,64,0,0,349,350,
      3,74,37,0,350,351,5,61,0,0,351,49,1,0,0,0,352,355,7,0,0,0,353,356,
      3,92,46,0,354,356,3,96,48,0,355,353,1,0,0,0,355,354,1,0,0,0,356,357,
      1,0,0,0,357,358,5,91,0,0,358,359,5,61,0,0,359,51,1,0,0,0,360,361,7,
      1,0,0,361,363,5,91,0,0,362,364,3,100,50,0,363,362,1,0,0,0,363,364,
      1,0,0,0,364,365,1,0,0,0,365,366,5,61,0,0,366,53,1,0,0,0,367,368,3,
      94,47,0,368,369,5,91,0,0,369,370,5,61,0,0,370,55,1,0,0,0,371,372,5,
      4,0,0,372,373,5,91,0,0,373,375,5,58,0,0,374,376,3,114,57,0,375,374,
      1,0,0,0,375,376,1,0,0,0,376,377,1,0,0,0,377,379,5,59,0,0,378,380,3,
      88,44,0,379,378,1,0,0,0,379,380,1,0,0,0,380,381,1,0,0,0,381,382,3,
      8,4,0,382,57,1,0,0,0,383,384,5,8,0,0,384,385,5,91,0,0,385,387,5,58,
      0,0,386,388,3,126,63,0,387,386,1,0,0,0,387,388,1,0,0,0,388,389,1,0,
      0,0,389,391,5,59,0,0,390,392,3,88,44,0,391,390,1,0,0,0,391,392,1,0,
      0,0,392,393,1,0,0,0,393,394,5,61,0,0,394,59,1,0,0,0,395,396,5,7,0,
      0,396,402,5,91,0,0,397,399,5,58,0,0,398,400,3,122,61,0,399,398,1,0,
      0,0,399,400,1,0,0,0,400,401,1,0,0,0,401,403,5,59,0,0,402,397,1,0,0,
      0,402,403,1,0,0,0,403,404,1,0,0,0,404,405,3,122,61,0,405,406,3,8,4,
      0,406,61,1,0,0,0,407,408,3,86,43,0,408,411,7,2,0,0,409,412,3,70,35,
      0,410,412,3,76,38,0,411,409,1,0,0,0,411,410,1,0,0,0,412,413,1,0,0,
      0,413,414,5,61,0,0,414,63,1,0,0,0,415,416,3,70,35,0,416,417,5,61,0,
      0,417,65,1,0,0,0,418,419,5,5,0,0,419,421,5,56,0,0,420,422,5,110,0,
      0,421,420,1,0,0,0,421,422,1,0,0,0,422,423,1,0,0,0,423,424,5,57,0,0,
      424,67,1,0,0,0,425,426,5,6,0,0,426,432,3,102,51,0,427,429,5,58,0,0,
      428,430,3,116,58,0,429,428,1,0,0,0,429,430,1,0,0,0,430,431,1,0,0,0,
      431,433,5,59,0,0,432,427,1,0,0,0,432,433,1,0,0,0,433,434,1,0,0,0,434,
      436,3,118,59,0,435,437,3,88,44,0,436,435,1,0,0,0,436,437,1,0,0,0,437,
      438,1,0,0,0,438,440,5,56,0,0,439,441,5,110,0,0,440,439,1,0,0,0,440,
      441,1,0,0,0,441,442,1,0,0,0,442,443,5,57,0,0,443,69,1,0,0,0,444,445,
      6,35,-1,0,445,446,5,58,0,0,446,447,3,70,35,0,447,448,5,59,0,0,448,
      472,1,0,0,0,449,450,7,3,0,0,450,472,3,70,35,15,451,454,3,92,46,0,452,
      454,3,96,48,0,453,451,1,0,0,0,453,452,1,0,0,0,454,455,1,0,0,0,455,
      456,5,58,0,0,456,457,3,70,35,0,457,458,5,59,0,0,458,472,1,0,0,0,459,
      460,5,48,0,0,460,461,5,58,0,0,461,462,3,8,4,0,462,463,5,59,0,0,463,
      472,1,0,0,0,464,465,5,91,0,0,465,467,5,58,0,0,466,468,3,120,60,0,467,
      466,1,0,0,0,467,468,1,0,0,0,468,469,1,0,0,0,469,472,5,59,0,0,470,472,
      7,4,0,0,471,444,1,0,0,0,471,449,1,0,0,0,471,453,1,0,0,0,471,459,1,
      0,0,0,471,464,1,0,0,0,471,470,1,0,0,0,472,510,1,0,0,0,473,474,10,16,
      0,0,474,475,5,70,0,0,475,509,3,70,35,16,476,477,10,14,0,0,477,478,
      7,5,0,0,478,509,3,70,35,15,479,480,10,13,0,0,480,481,7,6,0,0,481,509,
      3,70,35,14,482,483,10,12,0,0,483,484,5,84,0,0,484,509,3,70,35,13,485,
      486,10,11,0,0,486,487,5,83,0,0,487,509,3,70,35,12,488,489,10,10,0,
      0,489,490,5,81,0,0,490,509,3,70,35,11,491,492,10,9,0,0,492,493,5,75,
      0,0,493,509,3,70,35,10,494,495,10,8,0,0,495,496,5,77,0,0,496,509,3,
      70,35,9,497,498,10,7,0,0,498,499,5,73,0,0,499,509,3,70,35,8,500,501,
      10,6,0,0,501,502,5,76,0,0,502,509,3,70,35,7,503,504,10,5,0,0,504,505,
      5,74,0,0,505,509,3,70,35,6,506,507,10,17,0,0,507,509,3,84,42,0,508,
      473,1,0,0,0,508,476,1,0,0,0,508,479,1,0,0,0,508,482,1,0,0,0,508,485,
      1,0,0,0,508,488,1,0,0,0,508,491,1,0,0,0,508,494,1,0,0,0,508,497,1,
      0,0,0,508,500,1,0,0,0,508,503,1,0,0,0,508,506,1,0,0,0,509,512,1,0,
      0,0,510,508,1,0,0,0,510,511,1,0,0,0,511,71,1,0,0,0,512,510,1,0,0,0,
      513,518,3,70,35,0,514,515,5,67,0,0,515,517,3,70,35,0,516,514,1,0,0,
      0,517,520,1,0,0,0,518,516,1,0,0,0,518,519,1,0,0,0,519,73,1,0,0,0,520,
      518,1,0,0,0,521,525,3,82,41,0,522,525,3,70,35,0,523,525,3,76,38,0,
      524,521,1,0,0,0,524,522,1,0,0,0,524,523,1,0,0,0,525,75,1,0,0,0,526,
      527,5,51,0,0,527,528,3,108,54,0,528,77,1,0,0,0,529,531,3,70,35,0,530,
      529,1,0,0,0,530,531,1,0,0,0,531,532,1,0,0,0,532,534,5,60,0,0,533,535,
      3,70,35,0,534,533,1,0,0,0,534,535,1,0,0,0,535,538,1,0,0,0,536,537,
      5,60,0,0,537,539,3,70,35,0,538,536,1,0,0,0,538,539,1,0,0,0,539,79,
      1,0,0,0,540,541,5,56,0,0,541,546,3,70,35,0,542,543,5,63,0,0,543,545,
      3,70,35,0,544,542,1,0,0,0,545,548,1,0,0,0,546,544,1,0,0,0,546,547,
      1,0,0,0,547,550,1,0,0,0,548,546,1,0,0,0,549,551,5,63,0,0,550,549,1,
      0,0,0,550,551,1,0,0,0,551,552,1,0,0,0,552,553,5,57,0,0,553,81,1,0,
      0,0,554,557,5,56,0,0,555,558,3,70,35,0,556,558,3,82,41,0,557,555,1,
      0,0,0,557,556,1,0,0,0,558,566,1,0,0,0,559,562,5,63,0,0,560,563,3,70,
      35,0,561,563,3,82,41,0,562,560,1,0,0,0,562,561,1,0,0,0,563,565,1,0,
      0,0,564,559,1,0,0,0,565,568,1,0,0,0,566,564,1,0,0,0,566,567,1,0,0,
      0,567,570,1,0,0,0,568,566,1,0,0,0,569,571,5,63,0,0,570,569,1,0,0,0,
      570,571,1,0,0,0,571,572,1,0,0,0,572,573,5,57,0,0,573,83,1,0,0,0,574,
      593,5,54,0,0,575,594,3,80,40,0,576,579,3,70,35,0,577,579,3,78,39,0,
      578,576,1,0,0,0,578,577,1,0,0,0,579,587,1,0,0,0,580,583,5,63,0,0,581,
      584,3,70,35,0,582,584,3,78,39,0,583,581,1,0,0,0,583,582,1,0,0,0,584,
      586,1,0,0,0,585,580,1,0,0,0,586,589,1,0,0,0,587,585,1,0,0,0,587,588,
      1,0,0,0,588,591,1,0,0,0,589,587,1,0,0,0,590,592,5,63,0,0,591,590,1,
      0,0,0,591,592,1,0,0,0,592,594,1,0,0,0,593,575,1,0,0,0,593,578,1,0,
      0,0,594,595,1,0,0,0,595,596,5,55,0,0,596,85,1,0,0,0,597,601,5,91,0,
      0,598,600,3,84,42,0,599,598,1,0,0,0,600,603,1,0,0,0,601,599,1,0,0,
      0,601,602,1,0,0,0,602,87,1,0,0,0,603,601,1,0,0,0,604,605,5,65,0,0,
      605,606,3,92,46,0,606,89,1,0,0,0,607,621,5,43,0,0,608,609,5,44,0,0,
      609,610,5,58,0,0,610,611,3,70,35,0,611,612,5,59,0,0,612,621,1,0,0,
      0,613,618,7,7,0,0,614,615,5,58,0,0,615,616,3,70,35,0,616,617,5,59,
      0,0,617,619,1,0,0,0,618,614,1,0,0,0,618,619,1,0,0,0,619,621,1,0,0,
      0,620,607,1,0,0,0,620,608,1,0,0,0,620,613,1,0,0,0,621,622,1,0,0,0,
      622,623,5,78,0,0,623,91,1,0,0,0,624,626,5,31,0,0,625,627,3,100,50,
      0,626,625,1,0,0,0,626,627,1,0,0,0,627,656,1,0,0,0,628,630,5,32,0,0,
      629,631,3,100,50,0,630,629,1,0,0,0,630,631,1,0,0,0,631,656,1,0,0,0,
      632,634,5,33,0,0,633,635,3,100,50,0,634,633,1,0,0,0,634,635,1,0,0,
      0,635,656,1,0,0,0,636,638,5,34,0,0,637,639,3,100,50,0,638,637,1,0,
      0,0,638,639,1,0,0,0,639,656,1,0,0,0,640,642,5,35,0,0,641,643,3,100,
      50,0,642,641,1,0,0,0,642,643,1,0,0,0,643,656,1,0,0,0,644,656,5,30,
      0,0,645,656,5,39,0,0,646,656,5,40,0,0,647,652,5,36,0,0,648,649,5,54,
      0,0,649,650,3,92,46,0,650,651,5,55,0,0,651,653,1,0,0,0,652,648,1,0,
      0,0,652,653,1,0,0,0,653,656,1,0,0,0,654,656,5,41,0,0,655,624,1,0,0,
      0,655,628,1,0,0,0,655,632,1,0,0,0,655,636,1,0,0,0,655,640,1,0,0,0,
      655,644,1,0,0,0,655,645,1,0,0,0,655,646,1,0,0,0,655,647,1,0,0,0,655,
      654,1,0,0,0,656,93,1,0,0,0,657,659,5,28,0,0,658,660,3,100,50,0,659,
      658,1,0,0,0,659,660,1,0,0,0,660,95,1,0,0,0,661,662,5,37,0,0,662,663,
      5,54,0,0,663,664,3,92,46,0,664,665,5,63,0,0,665,666,3,120,60,0,666,
      667,5,55,0,0,667,97,1,0,0,0,668,669,7,8,0,0,669,670,5,37,0,0,670,671,
      5,54,0,0,671,672,3,92,46,0,672,677,5,63,0,0,673,678,3,120,60,0,674,
      675,5,47,0,0,675,676,5,64,0,0,676,678,3,70,35,0,677,673,1,0,0,0,677,
      674,1,0,0,0,678,679,1,0,0,0,679,680,5,55,0,0,680,99,1,0,0,0,681,682,
      5,54,0,0,682,683,3,70,35,0,683,684,5,55,0,0,684,101,1,0,0,0,685,686,
      7,9,0,0,686,103,1,0,0,0,687,690,3,70,35,0,688,690,3,112,56,0,689,687,
      1,0,0,0,689,688,1,0,0,0,690,105,1,0,0,0,691,692,7,10,0,0,692,107,1,
      0,0,0,693,696,3,86,43,0,694,696,5,92,0,0,695,693,1,0,0,0,695,694,1,
      0,0,0,696,109,1,0,0,0,697,704,3,92,46,0,698,704,3,98,49,0,699,701,
      5,29,0,0,700,702,3,100,50,0,701,700,1,0,0,0,701,702,1,0,0,0,702,704,
      1,0,0,0,703,697,1,0,0,0,703,698,1,0,0,0,703,699,1,0,0,0,704,111,1,
      0,0,0,705,706,3,92,46,0,706,707,5,91,0,0,707,720,1,0,0,0,708,709,3,
      94,47,0,709,710,5,91,0,0,710,720,1,0,0,0,711,712,7,1,0,0,712,714,5,
      91,0,0,713,715,3,100,50,0,714,713,1,0,0,0,714,715,1,0,0,0,715,720,
      1,0,0,0,716,717,3,98,49,0,717,718,5,91,0,0,718,720,1,0,0,0,719,705,
      1,0,0,0,719,708,1,0,0,0,719,711,1,0,0,0,719,716,1,0,0,0,720,113,1,
      0,0,0,721,726,3,112,56,0,722,723,5,63,0,0,723,725,3,112,56,0,724,722,
      1,0,0,0,725,728,1,0,0,0,726,724,1,0,0,0,726,727,1,0,0,0,727,730,1,
      0,0,0,728,726,1,0,0,0,729,731,5,63,0,0,730,729,1,0,0,0,730,731,1,0,
      0,0,731,115,1,0,0,0,732,737,3,104,52,0,733,734,5,63,0,0,734,736,3,
      104,52,0,735,733,1,0,0,0,736,739,1,0,0,0,737,735,1,0,0,0,737,738,1,
      0,0,0,738,741,1,0,0,0,739,737,1,0,0,0,740,742,5,63,0,0,741,740,1,0,
      0,0,741,742,1,0,0,0,742,117,1,0,0,0,743,748,3,106,53,0,744,745,5,63,
      0,0,745,747,3,106,53,0,746,744,1,0,0,0,747,750,1,0,0,0,748,746,1,0,
      0,0,748,749,1,0,0,0,749,752,1,0,0,0,750,748,1,0,0,0,751,753,5,63,0,
      0,752,751,1,0,0,0,752,753,1,0,0,0,753,119,1,0,0,0,754,759,3,70,35,
      0,755,756,5,63,0,0,756,758,3,70,35,0,757,755,1,0,0,0,758,761,1,0,0,
      0,759,757,1,0,0,0,759,760,1,0,0,0,760,763,1,0,0,0,761,759,1,0,0,0,
      762,764,5,63,0,0,763,762,1,0,0,0,763,764,1,0,0,0,764,121,1,0,0,0,765,
      770,5,91,0,0,766,767,5,63,0,0,767,769,5,91,0,0,768,766,1,0,0,0,769,
      772,1,0,0,0,770,768,1,0,0,0,770,771,1,0,0,0,771,774,1,0,0,0,772,770,
      1,0,0,0,773,775,5,63,0,0,774,773,1,0,0,0,774,775,1,0,0,0,775,123,1,
      0,0,0,776,781,3,108,54,0,777,778,5,63,0,0,778,780,3,108,54,0,779,777,
      1,0,0,0,780,783,1,0,0,0,781,779,1,0,0,0,781,782,1,0,0,0,782,785,1,
      0,0,0,783,781,1,0,0,0,784,786,5,63,0,0,785,784,1,0,0,0,785,786,1,0,
      0,0,786,125,1,0,0,0,787,792,3,110,55,0,788,789,5,63,0,0,789,791,3,
      110,55,0,790,788,1,0,0,0,791,794,1,0,0,0,792,790,1,0,0,0,792,793,1,
      0,0,0,793,796,1,0,0,0,794,792,1,0,0,0,795,797,5,63,0,0,796,795,1,0,
      0,0,796,797,1,0,0,0,797,127,1,0,0,0,94,129,134,147,178,180,184,190,
      200,229,240,245,257,263,270,277,283,286,289,297,303,306,309,312,315,
      320,336,341,355,363,375,379,387,391,399,402,411,421,429,432,436,440,
      453,467,471,508,510,518,524,530,534,538,546,550,557,562,566,570,578,
      583,587,591,593,601,618,620,626,630,634,638,642,652,655,659,677,689,
      695,701,703,714,719,726,730,737,741,748,752,759,763,770,774,781,785,
      792,796
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
  ScalarTypeContext? scalarType() => getRuleContext<ScalarTypeContext>(0);
  TerminalNode? Identifier() => getToken(OpenQASM3Parser.TOKEN_Identifier, 0);
  TerminalNode? IN() => getToken(OpenQASM3Parser.TOKEN_IN, 0);
  StatementOrScopeContext? statementOrScope() => getRuleContext<StatementOrScopeContext>(0);
  SetExpressionContext? setExpression() => getRuleContext<SetExpressionContext>(0);
  TerminalNode? LBRACKET() => getToken(OpenQASM3Parser.TOKEN_LBRACKET, 0);
  RangeExpressionContext? rangeExpression() => getRuleContext<RangeExpressionContext>(0);
  TerminalNode? RBRACKET() => getToken(OpenQASM3Parser.TOKEN_RBRACKET, 0);
  ExpressionContext? expression() => getRuleContext<ExpressionContext>(0);
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
  TerminalNode? EQUALS() => getToken(OpenQASM3Parser.TOKEN_EQUALS, 0);
  DeclarationExpressionContext? declarationExpression() => getRuleContext<DeclarationExpressionContext>(0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
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