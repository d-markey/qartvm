// Generated from c:/_Projects/github/qartvm/tools/antlr4/OpenQASM3Parser.g4 by ANTLR 4.13.1
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes
import 'package:antlr4/antlr4.dart';

import 'OpenQASM3ParserVisitor.dart';
import 'OpenQASM3ParserBaseVisitor.dart';

const int RULE_program = 0,
    RULE_version = 1,
    RULE_statement = 2,
    RULE_annotation = 3,
    RULE_scope = 4,
    RULE_pragma = 5,
    RULE_statementOrScope = 6,
    RULE_calibrationGrammarStatement = 7,
    RULE_includeStatement = 8,
    RULE_breakStatement = 9,
    RULE_continueStatement = 10,
    RULE_endStatement = 11,
    RULE_forStatement = 12,
    RULE_ifStatement = 13,
    RULE_returnStatement = 14,
    RULE_whileStatement = 15,
    RULE_barrierStatement = 16,
    RULE_boxStatement = 17,
    RULE_delayStatement = 18,
    RULE_gateCallStatement = 19,
    RULE_measureArrowAssignmentStatement = 20,
    RULE_resetStatement = 21,
    RULE_aliasDeclarationStatement = 22,
    RULE_classicalDeclarationStatement = 23,
    RULE_constDeclarationStatement = 24,
    RULE_ioDeclarationStatement = 25,
    RULE_oldStyleDeclarationStatement = 26,
    RULE_quantumDeclarationStatement = 27,
    RULE_defStatement = 28,
    RULE_externStatement = 29,
    RULE_gateStatement = 30,
    RULE_assignmentStatement = 31,
    RULE_expressionStatement = 32,
    RULE_calStatement = 33,
    RULE_defcalStatement = 34,
    RULE_expression = 35,
    RULE_aliasExpression = 36,
    RULE_declarationExpression = 37,
    RULE_measureExpression = 38,
    RULE_rangeExpression = 39,
    RULE_setExpression = 40,
    RULE_arrayLiteral = 41,
    RULE_indexOperator = 42,
    RULE_indexedIdentifier = 43,
    RULE_returnSignature = 44,
    RULE_gateModifier = 45,
    RULE_scalarType = 46,
    RULE_qubitType = 47,
    RULE_arrayType = 48,
    RULE_arrayReferenceType = 49,
    RULE_designator = 50,
    RULE_defcalTarget = 51,
    RULE_defcalArgumentDefinition = 52,
    RULE_defcalOperand = 53,
    RULE_gateOperand = 54,
    RULE_externArgument = 55,
    RULE_argumentDefinition = 56,
    RULE_argumentDefinitionList = 57,
    RULE_defcalArgumentDefinitionList = 58,
    RULE_defcalOperandList = 59,
    RULE_expressionList = 60,
    RULE_identifierList = 61,
    RULE_gateOperandList = 62,
    RULE_externArgumentList = 63;

class OpenQASM3Parser extends Parser {
  static final checkVersion = () =>
      RuntimeMetaData.checkVersion('4.13.1', RuntimeMetaData.VERSION);
  static const int TOKEN_EOF = IntStream.EOF;

  static final List<DFA> _decisionToDFA = List.generate(
    _ATN.numberOfDecisions,
    (i) => DFA(_ATN.getDecisionState(i), i),
  );
  static final PredictionContextCache _sharedContextCache =
      PredictionContextCache();
  static const int TOKEN_OPENQASM = 1,
      TOKEN_INCLUDE = 2,
      TOKEN_DEFCALGRAMMAR = 3,
      TOKEN_DEF = 4,
      TOKEN_CAL = 5,
      TOKEN_DEFCAL = 6,
      TOKEN_GATE = 7,
      TOKEN_EXTERN = 8,
      TOKEN_BOX = 9,
      TOKEN_LET = 10,
      TOKEN_BREAK = 11,
      TOKEN_CONTINUE = 12,
      TOKEN_IF = 13,
      TOKEN_ELSE = 14,
      TOKEN_END = 15,
      TOKEN_RETURN = 16,
      TOKEN_FOR = 17,
      TOKEN_WHILE = 18,
      TOKEN_IN = 19,
      TOKEN_PRAGMA = 20,
      TOKEN_AnnotationKeyword = 21,
      TOKEN_INPUT = 22,
      TOKEN_OUTPUT = 23,
      TOKEN_CONST = 24,
      TOKEN_READONLY = 25,
      TOKEN_MUTABLE = 26,
      TOKEN_QREG = 27,
      TOKEN_QUBIT = 28,
      TOKEN_CREG = 29,
      TOKEN_BOOL = 30,
      TOKEN_BIT = 31,
      TOKEN_INT = 32,
      TOKEN_UINT = 33,
      TOKEN_FLOAT = 34,
      TOKEN_ANGLE = 35,
      TOKEN_COMPLEX = 36,
      TOKEN_ARRAY = 37,
      TOKEN_VOID = 38,
      TOKEN_DURATION = 39,
      TOKEN_STRETCH = 40,
      TOKEN_STRING = 41,
      TOKEN_GPHASE = 42,
      TOKEN_INV = 43,
      TOKEN_POW = 44,
      TOKEN_CTRL = 45,
      TOKEN_NEGCTRL = 46,
      TOKEN_DIM = 47,
      TOKEN_DURATIONOF = 48,
      TOKEN_DELAY = 49,
      TOKEN_RESET = 50,
      TOKEN_MEASURE = 51,
      TOKEN_BARRIER = 52,
      TOKEN_BooleanLiteral = 53,
      TOKEN_LBRACKET = 54,
      TOKEN_RBRACKET = 55,
      TOKEN_LBRACE = 56,
      TOKEN_RBRACE = 57,
      TOKEN_LPAREN = 58,
      TOKEN_RPAREN = 59,
      TOKEN_COLON = 60,
      TOKEN_SEMICOLON = 61,
      TOKEN_DOT = 62,
      TOKEN_COMMA = 63,
      TOKEN_EQUALS = 64,
      TOKEN_ARROW = 65,
      TOKEN_PLUS = 66,
      TOKEN_DOUBLE_PLUS = 67,
      TOKEN_MINUS = 68,
      TOKEN_ASTERISK = 69,
      TOKEN_DOUBLE_ASTERISK = 70,
      TOKEN_SLASH = 71,
      TOKEN_PERCENT = 72,
      TOKEN_PIPE = 73,
      TOKEN_DOUBLE_PIPE = 74,
      TOKEN_AMPERSAND = 75,
      TOKEN_DOUBLE_AMPERSAND = 76,
      TOKEN_CARET = 77,
      TOKEN_AT = 78,
      TOKEN_TILDE = 79,
      TOKEN_EXCLAMATION_POINT = 80,
      TOKEN_EqualityOperator = 81,
      TOKEN_CompoundAssignmentOperator = 82,
      TOKEN_ComparisonOperator = 83,
      TOKEN_BitshiftOperator = 84,
      TOKEN_IMAG = 85,
      TOKEN_ImaginaryLiteral = 86,
      TOKEN_BinaryIntegerLiteral = 87,
      TOKEN_OctalIntegerLiteral = 88,
      TOKEN_DecimalIntegerLiteral = 89,
      TOKEN_HexIntegerLiteral = 90,
      TOKEN_Identifier = 91,
      TOKEN_HardwareQubit = 92,
      TOKEN_FloatLiteral = 93,
      TOKEN_TimingLiteral = 94,
      TOKEN_BitstringLiteral = 95,
      TOKEN_StringLiteral = 96,
      TOKEN_Whitespace = 97,
      TOKEN_Newline = 98,
      TOKEN_LineComment = 99,
      TOKEN_BlockComment = 100,
      TOKEN_VERSION_IDENTIFER_WHITESPACE = 101,
      TOKEN_VersionSpecifier = 102,
      TOKEN_EAT_INITIAL_SPACE = 103,
      TOKEN_EAT_LINE_END = 104,
      TOKEN_RemainingLineContent = 105,
      TOKEN_CAL_PRELUDE_WHITESPACE = 106,
      TOKEN_CAL_PRELUDE_COMMENT = 107,
      TOKEN_DEFCAL_PRELUDE_WHITESPACE = 108,
      TOKEN_DEFCAL_PRELUDE_COMMENT = 109,
      TOKEN_CalibrationBlock = 110;

  @override
  final List<String> ruleNames = [
    'program',
    'version',
    'statement',
    'annotation',
    'scope',
    'pragma',
    'statementOrScope',
    'calibrationGrammarStatement',
    'includeStatement',
    'breakStatement',
    'continueStatement',
    'endStatement',
    'forStatement',
    'ifStatement',
    'returnStatement',
    'whileStatement',
    'barrierStatement',
    'boxStatement',
    'delayStatement',
    'gateCallStatement',
    'measureArrowAssignmentStatement',
    'resetStatement',
    'aliasDeclarationStatement',
    'classicalDeclarationStatement',
    'constDeclarationStatement',
    'ioDeclarationStatement',
    'oldStyleDeclarationStatement',
    'quantumDeclarationStatement',
    'defStatement',
    'externStatement',
    'gateStatement',
    'assignmentStatement',
    'expressionStatement',
    'calStatement',
    'defcalStatement',
    'expression',
    'aliasExpression',
    'declarationExpression',
    'measureExpression',
    'rangeExpression',
    'setExpression',
    'arrayLiteral',
    'indexOperator',
    'indexedIdentifier',
    'returnSignature',
    'gateModifier',
    'scalarType',
    'qubitType',
    'arrayType',
    'arrayReferenceType',
    'designator',
    'defcalTarget',
    'defcalArgumentDefinition',
    'defcalOperand',
    'gateOperand',
    'externArgument',
    'argumentDefinition',
    'argumentDefinitionList',
    'defcalArgumentDefinitionList',
    'defcalOperandList',
    'expressionList',
    'identifierList',
    'gateOperandList',
    'externArgumentList',
  ];

  static final List<String?> _LITERAL_NAMES = [
    null,
    "'OPENQASM'",
    "'include'",
    "'defcalgrammar'",
    "'def'",
    "'cal'",
    "'defcal'",
    "'gate'",
    "'extern'",
    "'box'",
    "'let'",
    "'break'",
    "'continue'",
    "'if'",
    "'else'",
    "'end'",
    "'return'",
    "'for'",
    "'while'",
    "'in'",
    null,
    null,
    "'input'",
    "'output'",
    "'const'",
    "'readonly'",
    "'mutable'",
    "'qreg'",
    "'qubit'",
    "'creg'",
    "'bool'",
    "'bit'",
    "'int'",
    "'uint'",
    "'float'",
    "'angle'",
    "'complex'",
    "'array'",
    "'void'",
    "'duration'",
    "'stretch'",
    "'string'",
    "'gphase'",
    "'inv'",
    "'pow'",
    "'ctrl'",
    "'negctrl'",
    "'#dim'",
    "'durationof'",
    "'delay'",
    "'reset'",
    "'measure'",
    "'barrier'",
    null,
    "'['",
    "']'",
    "'{'",
    "'}'",
    "'('",
    "')'",
    "':'",
    "';'",
    "'.'",
    "','",
    "'='",
    "'->'",
    "'+'",
    "'++'",
    "'-'",
    "'*'",
    "'**'",
    "'/'",
    "'%'",
    "'|'",
    "'||'",
    "'&'",
    "'&&'",
    "'^'",
    "'@'",
    "'~'",
    "'!'",
    null,
    null,
    null,
    null,
    "'im'",
  ];
  static final List<String?> _SYMBOLIC_NAMES = [
    null,
    "OPENQASM",
    "INCLUDE",
    "DEFCALGRAMMAR",
    "DEF",
    "CAL",
    "DEFCAL",
    "GATE",
    "EXTERN",
    "BOX",
    "LET",
    "BREAK",
    "CONTINUE",
    "IF",
    "ELSE",
    "END",
    "RETURN",
    "FOR",
    "WHILE",
    "IN",
    "PRAGMA",
    "AnnotationKeyword",
    "INPUT",
    "OUTPUT",
    "CONST",
    "READONLY",
    "MUTABLE",
    "QREG",
    "QUBIT",
    "CREG",
    "BOOL",
    "BIT",
    "INT",
    "UINT",
    "FLOAT",
    "ANGLE",
    "COMPLEX",
    "ARRAY",
    "VOID",
    "DURATION",
    "STRETCH",
    "STRING",
    "GPHASE",
    "INV",
    "POW",
    "CTRL",
    "NEGCTRL",
    "DIM",
    "DURATIONOF",
    "DELAY",
    "RESET",
    "MEASURE",
    "BARRIER",
    "BooleanLiteral",
    "LBRACKET",
    "RBRACKET",
    "LBRACE",
    "RBRACE",
    "LPAREN",
    "RPAREN",
    "COLON",
    "SEMICOLON",
    "DOT",
    "COMMA",
    "EQUALS",
    "ARROW",
    "PLUS",
    "DOUBLE_PLUS",
    "MINUS",
    "ASTERISK",
    "DOUBLE_ASTERISK",
    "SLASH",
    "PERCENT",
    "PIPE",
    "DOUBLE_PIPE",
    "AMPERSAND",
    "DOUBLE_AMPERSAND",
    "CARET",
    "AT",
    "TILDE",
    "EXCLAMATION_POINT",
    "EqualityOperator",
    "CompoundAssignmentOperator",
    "ComparisonOperator",
    "BitshiftOperator",
    "IMAG",
    "ImaginaryLiteral",
    "BinaryIntegerLiteral",
    "OctalIntegerLiteral",
    "DecimalIntegerLiteral",
    "HexIntegerLiteral",
    "Identifier",
    "HardwareQubit",
    "FloatLiteral",
    "TimingLiteral",
    "BitstringLiteral",
    "StringLiteral",
    "Whitespace",
    "Newline",
    "LineComment",
    "BlockComment",
    "VERSION_IDENTIFER_WHITESPACE",
    "VersionSpecifier",
    "EAT_INITIAL_SPACE",
    "EAT_LINE_END",
    "RemainingLineContent",
    "CAL_PRELUDE_WHITESPACE",
    "CAL_PRELUDE_COMMENT",
    "DEFCAL_PRELUDE_WHITESPACE",
    "DEFCAL_PRELUDE_COMMENT",
    "CalibrationBlock",
  ];
  static final Vocabulary VOCABULARY = VocabularyImpl(
    _LITERAL_NAMES,
    _SYMBOLIC_NAMES,
  );

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
    interpreter = ParserATNSimulator(
      this,
      _ATN,
      _decisionToDFA,
      _sharedContextCache,
    );
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
      while ((((_la) & ~0x3f) == 0 && ((1 << _la) & 306103762193727484) != 0) ||
          ((((_la - 68)) & ~0x3f) == 0 &&
              ((1 << (_la - 68)) & 536614913) != 0)) {
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
      while ((((_la) & ~0x3f) == 0 && ((1 << _la) & 306103762193727484) != 0) ||
          ((((_la - 68)) & ~0x3f) == 0 &&
              ((1 << (_la - 68)) & 536614913) != 0)) {
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
          while ((((_la) & ~0x3f) == 0 &&
              ((1 << _la) & 131941395333120) != 0)) {
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
            if ((((_la) & ~0x3f) == 0 &&
                    ((1 << _la) & 297523172478025728) != 0) ||
                ((((_la - 68)) & ~0x3f) == 0 &&
                    ((1 << (_la - 68)) & 536614913) != 0)) {
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
          while ((((_la) & ~0x3f) == 0 &&
              ((1 << _la) & 131941395333120) != 0)) {
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
            if ((((_la) & ~0x3f) == 0 &&
                    ((1 << _la) & 297523172478025728) != 0) ||
                ((((_la - 68)) & ~0x3f) == 0 &&
                    ((1 << (_la - 68)) & 536614913) != 0)) {
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
    try {
      enterOuterAlt(_localctx, 1);
      state = 347;
      match(TOKEN_CONST);
      state = 348;
      scalarType();
      state = 349;
      match(TOKEN_Identifier);
      state = 350;
      match(TOKEN_EQUALS);
      state = 351;
      declarationExpression();
      state = 352;
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
      state = 354;
      _la = tokenStream.LA(1)!;
      if (!(_la == TOKEN_INPUT || _la == TOKEN_OUTPUT)) {
        errorHandler.recoverInline(this);
      } else {
        if (tokenStream.LA(1)! == IntStream.EOF) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
      state = 357;
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
          state = 355;
          scalarType();
          break;
        case TOKEN_ARRAY:
          state = 356;
          arrayType();
          break;
        default:
          throw NoViableAltException(this);
      }
      state = 359;
      match(TOKEN_Identifier);
      state = 360;
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
      state = 362;
      _la = tokenStream.LA(1)!;
      if (!(_la == TOKEN_QREG || _la == TOKEN_CREG)) {
        errorHandler.recoverInline(this);
      } else {
        if (tokenStream.LA(1)! == IntStream.EOF) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
      state = 363;
      match(TOKEN_Identifier);
      state = 365;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_LBRACKET) {
        state = 364;
        designator();
      }

      state = 367;
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
      state = 369;
      qubitType();
      state = 370;
      match(TOKEN_Identifier);
      state = 371;
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
      state = 373;
      match(TOKEN_DEF);
      state = 374;
      match(TOKEN_Identifier);
      state = 375;
      match(TOKEN_LPAREN);
      state = 377;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 3985696096256) != 0)) {
        state = 376;
        argumentDefinitionList();
      }

      state = 379;
      match(TOKEN_RPAREN);
      state = 381;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_ARROW) {
        state = 380;
        returnSignature();
      }

      state = 383;
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
      state = 385;
      match(TOKEN_EXTERN);
      state = 386;
      match(TOKEN_Identifier);
      state = 387;
      match(TOKEN_LPAREN);
      state = 389;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 3985293443072) != 0)) {
        state = 388;
        externArgumentList();
      }

      state = 391;
      match(TOKEN_RPAREN);
      state = 393;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_ARROW) {
        state = 392;
        returnSignature();
      }

      state = 395;
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
      state = 397;
      match(TOKEN_GATE);
      state = 398;
      match(TOKEN_Identifier);
      state = 404;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_LPAREN) {
        state = 399;
        match(TOKEN_LPAREN);
        state = 401;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if (_la == TOKEN_Identifier) {
          state = 400;
          _localctx.params = identifierList();
        }

        state = 403;
        match(TOKEN_RPAREN);
      }

      state = 406;
      _localctx.qubits = identifierList();
      state = 407;
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
      state = 409;
      indexedIdentifier();
      state = 410;
      _localctx.op = tokenStream.LT(1);
      _la = tokenStream.LA(1)!;
      if (!(_la == TOKEN_EQUALS || _la == TOKEN_CompoundAssignmentOperator)) {
        _localctx.op = errorHandler.recoverInline(this);
      } else {
        if (tokenStream.LA(1)! == IntStream.EOF) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
      state = 413;
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
          state = 411;
          expression(0);
          break;
        case TOKEN_MEASURE:
          state = 412;
          measureExpression();
          break;
        default:
          throw NoViableAltException(this);
      }
      state = 415;
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
      state = 417;
      expression(0);
      state = 418;
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
      state = 420;
      match(TOKEN_CAL);
      state = 421;
      match(TOKEN_LBRACE);
      state = 423;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_CalibrationBlock) {
        state = 422;
        match(TOKEN_CalibrationBlock);
      }

      state = 425;
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
      state = 427;
      match(TOKEN_DEFCAL);
      state = 428;
      defcalTarget();
      state = 434;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_LPAREN) {
        state = 429;
        match(TOKEN_LPAREN);
        state = 431;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 297523173518213120) != 0) ||
            ((((_la - 68)) & ~0x3f) == 0 &&
                ((1 << (_la - 68)) & 536614913) != 0)) {
          state = 430;
          defcalArgumentDefinitionList();
        }

        state = 433;
        match(TOKEN_RPAREN);
      }

      state = 436;
      defcalOperandList();
      state = 438;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_ARROW) {
        state = 437;
        returnSignature();
      }

      state = 440;
      match(TOKEN_LBRACE);
      state = 442;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_CalibrationBlock) {
        state = 441;
        match(TOKEN_CalibrationBlock);
      }

      state = 444;
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
      state = 473;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 44, context)) {
        case 1:
          _localctx = ParenthesisExpressionContext(_localctx);
          context = _localctx;
          _prevctx = _localctx;

          state = 447;
          match(TOKEN_LPAREN);
          state = 448;
          expression(0);
          state = 449;
          match(TOKEN_RPAREN);
          break;
        case 2:
          _localctx = UnaryExpressionContext(_localctx);
          context = _localctx;
          _prevctx = _localctx;
          state = 451;
          _localctx.op = tokenStream.LT(1);
          _la = tokenStream.LA(1)!;
          if (!(((((_la - 68)) & ~0x3f) == 0 &&
              ((1 << (_la - 68)) & 6145) != 0))) {
            _localctx.op = errorHandler.recoverInline(this);
          } else {
            if (tokenStream.LA(1)! == IntStream.EOF) matchedEOF = true;
            errorHandler.reportMatch(this);
            consume();
          }
          state = 452;
          expression(15);
          break;
        case 3:
          _localctx = CastExpressionContext(_localctx);
          context = _localctx;
          _prevctx = _localctx;
          state = 455;
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
              state = 453;
              scalarType();
              break;
            case TOKEN_ARRAY:
              state = 454;
              arrayType();
              break;
            default:
              throw NoViableAltException(this);
          }
          state = 457;
          match(TOKEN_LPAREN);
          state = 458;
          expression(0);
          state = 459;
          match(TOKEN_RPAREN);
          break;
        case 4:
          _localctx = DurationofExpressionContext(_localctx);
          context = _localctx;
          _prevctx = _localctx;
          state = 461;
          match(TOKEN_DURATIONOF);
          state = 462;
          match(TOKEN_LPAREN);
          state = 463;
          scope();
          state = 464;
          match(TOKEN_RPAREN);
          break;
        case 5:
          _localctx = CallExpressionContext(_localctx);
          context = _localctx;
          _prevctx = _localctx;
          state = 466;
          match(TOKEN_Identifier);
          state = 467;
          match(TOKEN_LPAREN);
          state = 469;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if ((((_la) & ~0x3f) == 0 &&
                  ((1 << _la) & 297523172478025728) != 0) ||
              ((((_la - 68)) & ~0x3f) == 0 &&
                  ((1 << (_la - 68)) & 536614913) != 0)) {
            state = 468;
            expressionList();
          }

          state = 471;
          match(TOKEN_RPAREN);
          break;
        case 6:
          _localctx = LiteralExpressionContext(_localctx);
          context = _localctx;
          _prevctx = _localctx;
          state = 472;
          _la = tokenStream.LA(1)!;
          if (!(((((_la - 53)) & ~0x3f) == 0 &&
              ((1 << (_la - 53)) & 17583596109825) != 0))) {
            errorHandler.recoverInline(this);
          } else {
            if (tokenStream.LA(1)! == IntStream.EOF) matchedEOF = true;
            errorHandler.reportMatch(this);
            consume();
          }
          break;
      }
      context!.stop = tokenStream.LT(-1);
      state = 512;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 46, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          if (parseListeners != null) triggerExitRuleEvent();
          _prevctx = _localctx;
          state = 510;
          errorHandler.sync(this);
          switch (interpreter!.adaptivePredict(tokenStream, 45, context)) {
            case 1:
              _localctx = PowerExpressionContext(
                new ExpressionContext(_parentctx, _parentState),
              );
              pushNewRecursionContext(_localctx, _startState, RULE_expression);
              state = 475;
              if (!(precpred(context, 16))) {
                throw FailedPredicateException(this, "precpred(context, 16)");
              }
              state = 476;
              _localctx.op = match(TOKEN_DOUBLE_ASTERISK);
              state = 477;
              expression(16);
              break;
            case 2:
              _localctx = MultiplicativeExpressionContext(
                new ExpressionContext(_parentctx, _parentState),
              );
              pushNewRecursionContext(_localctx, _startState, RULE_expression);
              state = 478;
              if (!(precpred(context, 14))) {
                throw FailedPredicateException(this, "precpred(context, 14)");
              }
              state = 479;
              _localctx.op = tokenStream.LT(1);
              _la = tokenStream.LA(1)!;
              if (!(((((_la - 69)) & ~0x3f) == 0 &&
                  ((1 << (_la - 69)) & 13) != 0))) {
                _localctx.op = errorHandler.recoverInline(this);
              } else {
                if (tokenStream.LA(1)! == IntStream.EOF) matchedEOF = true;
                errorHandler.reportMatch(this);
                consume();
              }
              state = 480;
              expression(15);
              break;
            case 3:
              _localctx = AdditiveExpressionContext(
                new ExpressionContext(_parentctx, _parentState),
              );
              pushNewRecursionContext(_localctx, _startState, RULE_expression);
              state = 481;
              if (!(precpred(context, 13))) {
                throw FailedPredicateException(this, "precpred(context, 13)");
              }
              state = 482;
              _localctx.op = tokenStream.LT(1);
              _la = tokenStream.LA(1)!;
              if (!(_la == TOKEN_PLUS || _la == TOKEN_MINUS)) {
                _localctx.op = errorHandler.recoverInline(this);
              } else {
                if (tokenStream.LA(1)! == IntStream.EOF) matchedEOF = true;
                errorHandler.reportMatch(this);
                consume();
              }
              state = 483;
              expression(14);
              break;
            case 4:
              _localctx = BitshiftExpressionContext(
                new ExpressionContext(_parentctx, _parentState),
              );
              pushNewRecursionContext(_localctx, _startState, RULE_expression);
              state = 484;
              if (!(precpred(context, 12))) {
                throw FailedPredicateException(this, "precpred(context, 12)");
              }
              state = 485;
              _localctx.op = match(TOKEN_BitshiftOperator);
              state = 486;
              expression(13);
              break;
            case 5:
              _localctx = ComparisonExpressionContext(
                new ExpressionContext(_parentctx, _parentState),
              );
              pushNewRecursionContext(_localctx, _startState, RULE_expression);
              state = 487;
              if (!(precpred(context, 11))) {
                throw FailedPredicateException(this, "precpred(context, 11)");
              }
              state = 488;
              _localctx.op = match(TOKEN_ComparisonOperator);
              state = 489;
              expression(12);
              break;
            case 6:
              _localctx = EqualityExpressionContext(
                new ExpressionContext(_parentctx, _parentState),
              );
              pushNewRecursionContext(_localctx, _startState, RULE_expression);
              state = 490;
              if (!(precpred(context, 10))) {
                throw FailedPredicateException(this, "precpred(context, 10)");
              }
              state = 491;
              _localctx.op = match(TOKEN_EqualityOperator);
              state = 492;
              expression(11);
              break;
            case 7:
              _localctx = BitwiseAndExpressionContext(
                new ExpressionContext(_parentctx, _parentState),
              );
              pushNewRecursionContext(_localctx, _startState, RULE_expression);
              state = 493;
              if (!(precpred(context, 9))) {
                throw FailedPredicateException(this, "precpred(context, 9)");
              }
              state = 494;
              _localctx.op = match(TOKEN_AMPERSAND);
              state = 495;
              expression(10);
              break;
            case 8:
              _localctx = BitwiseXorExpressionContext(
                new ExpressionContext(_parentctx, _parentState),
              );
              pushNewRecursionContext(_localctx, _startState, RULE_expression);
              state = 496;
              if (!(precpred(context, 8))) {
                throw FailedPredicateException(this, "precpred(context, 8)");
              }
              state = 497;
              _localctx.op = match(TOKEN_CARET);
              state = 498;
              expression(9);
              break;
            case 9:
              _localctx = BitwiseOrExpressionContext(
                new ExpressionContext(_parentctx, _parentState),
              );
              pushNewRecursionContext(_localctx, _startState, RULE_expression);
              state = 499;
              if (!(precpred(context, 7))) {
                throw FailedPredicateException(this, "precpred(context, 7)");
              }
              state = 500;
              _localctx.op = match(TOKEN_PIPE);
              state = 501;
              expression(8);
              break;
            case 10:
              _localctx = LogicalAndExpressionContext(
                new ExpressionContext(_parentctx, _parentState),
              );
              pushNewRecursionContext(_localctx, _startState, RULE_expression);
              state = 502;
              if (!(precpred(context, 6))) {
                throw FailedPredicateException(this, "precpred(context, 6)");
              }
              state = 503;
              _localctx.op = match(TOKEN_DOUBLE_AMPERSAND);
              state = 504;
              expression(7);
              break;
            case 11:
              _localctx = LogicalOrExpressionContext(
                new ExpressionContext(_parentctx, _parentState),
              );
              pushNewRecursionContext(_localctx, _startState, RULE_expression);
              state = 505;
              if (!(precpred(context, 5))) {
                throw FailedPredicateException(this, "precpred(context, 5)");
              }
              state = 506;
              _localctx.op = match(TOKEN_DOUBLE_PIPE);
              state = 507;
              expression(6);
              break;
            case 12:
              _localctx = IndexExpressionContext(
                new ExpressionContext(_parentctx, _parentState),
              );
              pushNewRecursionContext(_localctx, _startState, RULE_expression);
              state = 508;
              if (!(precpred(context, 17))) {
                throw FailedPredicateException(this, "precpred(context, 17)");
              }
              state = 509;
              indexOperator();
              break;
          }
        }
        state = 514;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 46, context);
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
      state = 515;
      expression(0);
      state = 520;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_DOUBLE_PLUS) {
        state = 516;
        match(TOKEN_DOUBLE_PLUS);
        state = 517;
        expression(0);
        state = 522;
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
      state = 526;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
        case TOKEN_LBRACE:
          enterOuterAlt(_localctx, 1);
          state = 523;
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
          state = 524;
          expression(0);
          break;
        case TOKEN_MEASURE:
          enterOuterAlt(_localctx, 3);
          state = 525;
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
      state = 528;
      match(TOKEN_MEASURE);
      state = 529;
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
      state = 532;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 297523172478025728) != 0) ||
          ((((_la - 68)) & ~0x3f) == 0 &&
              ((1 << (_la - 68)) & 536614913) != 0)) {
        state = 531;
        _localctx.startExpr = expression(0);
      }

      state = 534;
      match(TOKEN_COLON);
      state = 536;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if ((((_la) & ~0x3f) == 0 && ((1 << _la) & 297523172478025728) != 0) ||
          ((((_la - 68)) & ~0x3f) == 0 &&
              ((1 << (_la - 68)) & 536614913) != 0)) {
        state = 535;
        _localctx.stepExpr = expression(0);
      }

      state = 540;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COLON) {
        state = 538;
        match(TOKEN_COLON);
        state = 539;
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
      state = 542;
      match(TOKEN_LBRACE);
      state = 543;
      expression(0);
      state = 548;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 52, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 544;
          match(TOKEN_COMMA);
          state = 545;
          expression(0);
        }
        state = 550;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 52, context);
      }
      state = 552;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 551;
        match(TOKEN_COMMA);
      }

      state = 554;
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
      state = 556;
      match(TOKEN_LBRACE);
      state = 559;
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
          state = 557;
          expression(0);
          break;
        case TOKEN_LBRACE:
          state = 558;
          arrayLiteral();
          break;
        default:
          throw NoViableAltException(this);
      }
      state = 568;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 56, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 561;
          match(TOKEN_COMMA);
          state = 564;
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
              state = 562;
              expression(0);
              break;
            case TOKEN_LBRACE:
              state = 563;
              arrayLiteral();
              break;
            default:
              throw NoViableAltException(this);
          }
        }
        state = 570;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 56, context);
      }
      state = 572;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 571;
        match(TOKEN_COMMA);
      }

      state = 574;
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
      state = 576;
      match(TOKEN_LBRACKET);
      state = 595;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
        case TOKEN_LBRACE:
          state = 577;
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
          state = 580;
          errorHandler.sync(this);
          switch (interpreter!.adaptivePredict(tokenStream, 58, context)) {
            case 1:
              state = 578;
              expression(0);
              break;
            case 2:
              state = 579;
              rangeExpression();
              break;
          }
          state = 589;
          errorHandler.sync(this);
          _alt = interpreter!.adaptivePredict(tokenStream, 60, context);
          while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
            if (_alt == 1) {
              state = 582;
              match(TOKEN_COMMA);
              state = 585;
              errorHandler.sync(this);
              switch (interpreter!.adaptivePredict(tokenStream, 59, context)) {
                case 1:
                  state = 583;
                  expression(0);
                  break;
                case 2:
                  state = 584;
                  rangeExpression();
                  break;
              }
            }
            state = 591;
            errorHandler.sync(this);
            _alt = interpreter!.adaptivePredict(tokenStream, 60, context);
          }
          state = 593;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if (_la == TOKEN_COMMA) {
            state = 592;
            match(TOKEN_COMMA);
          }

          break;
        default:
          throw NoViableAltException(this);
      }
      state = 597;
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
      state = 599;
      match(TOKEN_Identifier);
      state = 603;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      while (_la == TOKEN_LBRACKET) {
        state = 600;
        indexOperator();
        state = 605;
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
      state = 606;
      match(TOKEN_ARROW);
      state = 607;
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
      state = 622;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
        case TOKEN_INV:
          state = 609;
          match(TOKEN_INV);
          break;
        case TOKEN_POW:
          state = 610;
          match(TOKEN_POW);
          state = 611;
          match(TOKEN_LPAREN);
          state = 612;
          expression(0);
          state = 613;
          match(TOKEN_RPAREN);
          break;
        case TOKEN_CTRL:
        case TOKEN_NEGCTRL:
          state = 615;
          _la = tokenStream.LA(1)!;
          if (!(_la == TOKEN_CTRL || _la == TOKEN_NEGCTRL)) {
            errorHandler.recoverInline(this);
          } else {
            if (tokenStream.LA(1)! == IntStream.EOF) matchedEOF = true;
            errorHandler.reportMatch(this);
            consume();
          }
          state = 620;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if (_la == TOKEN_LPAREN) {
            state = 616;
            match(TOKEN_LPAREN);
            state = 617;
            expression(0);
            state = 618;
            match(TOKEN_RPAREN);
          }

          break;
        default:
          throw NoViableAltException(this);
      }
      state = 624;
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
      state = 657;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
        case TOKEN_BIT:
          enterOuterAlt(_localctx, 1);
          state = 626;
          match(TOKEN_BIT);
          state = 628;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if (_la == TOKEN_LBRACKET) {
            state = 627;
            designator();
          }

          break;
        case TOKEN_INT:
          enterOuterAlt(_localctx, 2);
          state = 630;
          match(TOKEN_INT);
          state = 632;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if (_la == TOKEN_LBRACKET) {
            state = 631;
            designator();
          }

          break;
        case TOKEN_UINT:
          enterOuterAlt(_localctx, 3);
          state = 634;
          match(TOKEN_UINT);
          state = 636;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if (_la == TOKEN_LBRACKET) {
            state = 635;
            designator();
          }

          break;
        case TOKEN_FLOAT:
          enterOuterAlt(_localctx, 4);
          state = 638;
          match(TOKEN_FLOAT);
          state = 640;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if (_la == TOKEN_LBRACKET) {
            state = 639;
            designator();
          }

          break;
        case TOKEN_ANGLE:
          enterOuterAlt(_localctx, 5);
          state = 642;
          match(TOKEN_ANGLE);
          state = 644;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if (_la == TOKEN_LBRACKET) {
            state = 643;
            designator();
          }

          break;
        case TOKEN_BOOL:
          enterOuterAlt(_localctx, 6);
          state = 646;
          match(TOKEN_BOOL);
          break;
        case TOKEN_DURATION:
          enterOuterAlt(_localctx, 7);
          state = 647;
          match(TOKEN_DURATION);
          break;
        case TOKEN_STRETCH:
          enterOuterAlt(_localctx, 8);
          state = 648;
          match(TOKEN_STRETCH);
          break;
        case TOKEN_COMPLEX:
          enterOuterAlt(_localctx, 9);
          state = 649;
          match(TOKEN_COMPLEX);
          state = 654;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if (_la == TOKEN_LBRACKET) {
            state = 650;
            match(TOKEN_LBRACKET);
            state = 651;
            scalarType();
            state = 652;
            match(TOKEN_RBRACKET);
          }

          break;
        case TOKEN_STRING:
          enterOuterAlt(_localctx, 10);
          state = 656;
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
      state = 659;
      match(TOKEN_QUBIT);
      state = 661;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_LBRACKET) {
        state = 660;
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
      state = 663;
      match(TOKEN_ARRAY);
      state = 664;
      match(TOKEN_LBRACKET);
      state = 665;
      scalarType();
      state = 666;
      match(TOKEN_COMMA);
      state = 667;
      expressionList();
      state = 668;
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
      state = 670;
      _la = tokenStream.LA(1)!;
      if (!(_la == TOKEN_READONLY || _la == TOKEN_MUTABLE)) {
        errorHandler.recoverInline(this);
      } else {
        if (tokenStream.LA(1)! == IntStream.EOF) matchedEOF = true;
        errorHandler.reportMatch(this);
        consume();
      }
      state = 671;
      match(TOKEN_ARRAY);
      state = 672;
      match(TOKEN_LBRACKET);
      state = 673;
      scalarType();
      state = 674;
      match(TOKEN_COMMA);
      state = 679;
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
          state = 675;
          expressionList();
          break;
        case TOKEN_DIM:
          state = 676;
          match(TOKEN_DIM);
          state = 677;
          match(TOKEN_EQUALS);
          state = 678;
          expression(0);
          break;
        default:
          throw NoViableAltException(this);
      }
      state = 681;
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
      state = 683;
      match(TOKEN_LBRACKET);
      state = 684;
      expression(0);
      state = 685;
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
      state = 687;
      _la = tokenStream.LA(1)!;
      if (!(((((_la - 49)) & ~0x3f) == 0 &&
          ((1 << (_la - 49)) & 4398046511111) != 0))) {
        errorHandler.recoverInline(this);
      } else {
        if (tokenStream.LA(1)! == IntStream.EOF) matchedEOF = true;
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
      state = 691;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 75, context)) {
        case 1:
          enterOuterAlt(_localctx, 1);
          state = 689;
          expression(0);
          break;
        case 2:
          enterOuterAlt(_localctx, 2);
          state = 690;
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
      state = 693;
      _la = tokenStream.LA(1)!;
      if (!(_la == TOKEN_Identifier || _la == TOKEN_HardwareQubit)) {
        errorHandler.recoverInline(this);
      } else {
        if (tokenStream.LA(1)! == IntStream.EOF) matchedEOF = true;
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
      state = 697;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
        case TOKEN_Identifier:
          enterOuterAlt(_localctx, 1);
          state = 695;
          indexedIdentifier();
          break;
        case TOKEN_HardwareQubit:
          enterOuterAlt(_localctx, 2);
          state = 696;
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
      state = 705;
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
          state = 699;
          scalarType();
          break;
        case TOKEN_READONLY:
        case TOKEN_MUTABLE:
          enterOuterAlt(_localctx, 2);
          state = 700;
          arrayReferenceType();
          break;
        case TOKEN_CREG:
          enterOuterAlt(_localctx, 3);
          state = 701;
          match(TOKEN_CREG);
          state = 703;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if (_la == TOKEN_LBRACKET) {
            state = 702;
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
      state = 721;
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
          state = 707;
          scalarType();
          state = 708;
          match(TOKEN_Identifier);
          break;
        case TOKEN_QUBIT:
          enterOuterAlt(_localctx, 2);
          state = 710;
          qubitType();
          state = 711;
          match(TOKEN_Identifier);
          break;
        case TOKEN_QREG:
        case TOKEN_CREG:
          enterOuterAlt(_localctx, 3);
          state = 713;
          _la = tokenStream.LA(1)!;
          if (!(_la == TOKEN_QREG || _la == TOKEN_CREG)) {
            errorHandler.recoverInline(this);
          } else {
            if (tokenStream.LA(1)! == IntStream.EOF) matchedEOF = true;
            errorHandler.reportMatch(this);
            consume();
          }
          state = 714;
          match(TOKEN_Identifier);
          state = 716;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
          if (_la == TOKEN_LBRACKET) {
            state = 715;
            designator();
          }

          break;
        case TOKEN_READONLY:
        case TOKEN_MUTABLE:
          enterOuterAlt(_localctx, 4);
          state = 718;
          arrayReferenceType();
          state = 719;
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
      state = 723;
      argumentDefinition();
      state = 728;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 81, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 724;
          match(TOKEN_COMMA);
          state = 725;
          argumentDefinition();
        }
        state = 730;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 81, context);
      }
      state = 732;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 731;
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
      state = 734;
      defcalArgumentDefinition();
      state = 739;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 83, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 735;
          match(TOKEN_COMMA);
          state = 736;
          defcalArgumentDefinition();
        }
        state = 741;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 83, context);
      }
      state = 743;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 742;
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
      state = 745;
      defcalOperand();
      state = 750;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 85, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 746;
          match(TOKEN_COMMA);
          state = 747;
          defcalOperand();
        }
        state = 752;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 85, context);
      }
      state = 754;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 753;
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
      state = 756;
      expression(0);
      state = 761;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 87, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 757;
          match(TOKEN_COMMA);
          state = 758;
          expression(0);
        }
        state = 763;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 87, context);
      }
      state = 765;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 764;
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
      state = 767;
      match(TOKEN_Identifier);
      state = 772;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 89, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 768;
          match(TOKEN_COMMA);
          state = 769;
          match(TOKEN_Identifier);
        }
        state = 774;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 89, context);
      }
      state = 776;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 775;
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
      state = 778;
      gateOperand();
      state = 783;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 91, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 779;
          match(TOKEN_COMMA);
          state = 780;
          gateOperand();
        }
        state = 785;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 91, context);
      }
      state = 787;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 786;
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
      state = 789;
      externArgument();
      state = 794;
      errorHandler.sync(this);
      _alt = interpreter!.adaptivePredict(tokenStream, 93, context);
      while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
        if (_alt == 1) {
          state = 790;
          match(TOKEN_COMMA);
          state = 791;
          externArgument();
        }
        state = 796;
        errorHandler.sync(this);
        _alt = interpreter!.adaptivePredict(tokenStream, 93, context);
      }
      state = 798;
      errorHandler.sync(this);
      _la = tokenStream.LA(1)!;
      if (_la == TOKEN_COMMA) {
        state = 797;
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
      case 0:
        return precpred(context, 16);
      case 1:
        return precpred(context, 14);
      case 2:
        return precpred(context, 13);
      case 3:
        return precpred(context, 12);
      case 4:
        return precpred(context, 11);
      case 5:
        return precpred(context, 10);
      case 6:
        return precpred(context, 9);
      case 7:
        return precpred(context, 8);
      case 8:
        return precpred(context, 7);
      case 9:
        return precpred(context, 6);
      case 10:
        return precpred(context, 5);
      case 11:
        return precpred(context, 17);
    }
    return true;
  }

  static const List<int> _serializedATN = [
    4,
    1,
    110,
    801,
    2,
    0,
    7,
    0,
    2,
    1,
    7,
    1,
    2,
    2,
    7,
    2,
    2,
    3,
    7,
    3,
    2,
    4,
    7,
    4,
    2,
    5,
    7,
    5,
    2,
    6,
    7,
    6,
    2,
    7,
    7,
    7,
    2,
    8,
    7,
    8,
    2,
    9,
    7,
    9,
    2,
    10,
    7,
    10,
    2,
    11,
    7,
    11,
    2,
    12,
    7,
    12,
    2,
    13,
    7,
    13,
    2,
    14,
    7,
    14,
    2,
    15,
    7,
    15,
    2,
    16,
    7,
    16,
    2,
    17,
    7,
    17,
    2,
    18,
    7,
    18,
    2,
    19,
    7,
    19,
    2,
    20,
    7,
    20,
    2,
    21,
    7,
    21,
    2,
    22,
    7,
    22,
    2,
    23,
    7,
    23,
    2,
    24,
    7,
    24,
    2,
    25,
    7,
    25,
    2,
    26,
    7,
    26,
    2,
    27,
    7,
    27,
    2,
    28,
    7,
    28,
    2,
    29,
    7,
    29,
    2,
    30,
    7,
    30,
    2,
    31,
    7,
    31,
    2,
    32,
    7,
    32,
    2,
    33,
    7,
    33,
    2,
    34,
    7,
    34,
    2,
    35,
    7,
    35,
    2,
    36,
    7,
    36,
    2,
    37,
    7,
    37,
    2,
    38,
    7,
    38,
    2,
    39,
    7,
    39,
    2,
    40,
    7,
    40,
    2,
    41,
    7,
    41,
    2,
    42,
    7,
    42,
    2,
    43,
    7,
    43,
    2,
    44,
    7,
    44,
    2,
    45,
    7,
    45,
    2,
    46,
    7,
    46,
    2,
    47,
    7,
    47,
    2,
    48,
    7,
    48,
    2,
    49,
    7,
    49,
    2,
    50,
    7,
    50,
    2,
    51,
    7,
    51,
    2,
    52,
    7,
    52,
    2,
    53,
    7,
    53,
    2,
    54,
    7,
    54,
    2,
    55,
    7,
    55,
    2,
    56,
    7,
    56,
    2,
    57,
    7,
    57,
    2,
    58,
    7,
    58,
    2,
    59,
    7,
    59,
    2,
    60,
    7,
    60,
    2,
    61,
    7,
    61,
    2,
    62,
    7,
    62,
    2,
    63,
    7,
    63,
    1,
    0,
    3,
    0,
    130,
    8,
    0,
    1,
    0,
    5,
    0,
    133,
    8,
    0,
    10,
    0,
    12,
    0,
    136,
    9,
    0,
    1,
    0,
    1,
    0,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    1,
    2,
    1,
    2,
    5,
    2,
    146,
    8,
    2,
    10,
    2,
    12,
    2,
    149,
    9,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    1,
    2,
    3,
    2,
    179,
    8,
    2,
    3,
    2,
    181,
    8,
    2,
    1,
    3,
    1,
    3,
    3,
    3,
    185,
    8,
    3,
    1,
    4,
    1,
    4,
    5,
    4,
    189,
    8,
    4,
    10,
    4,
    12,
    4,
    192,
    9,
    4,
    1,
    4,
    1,
    4,
    1,
    5,
    1,
    5,
    1,
    5,
    1,
    6,
    1,
    6,
    3,
    6,
    201,
    8,
    6,
    1,
    7,
    1,
    7,
    1,
    7,
    1,
    7,
    1,
    8,
    1,
    8,
    1,
    8,
    1,
    8,
    1,
    9,
    1,
    9,
    1,
    9,
    1,
    10,
    1,
    10,
    1,
    10,
    1,
    11,
    1,
    11,
    1,
    11,
    1,
    12,
    1,
    12,
    3,
    12,
    222,
    8,
    12,
    1,
    12,
    1,
    12,
    1,
    12,
    1,
    12,
    1,
    12,
    1,
    12,
    1,
    12,
    1,
    12,
    3,
    12,
    232,
    8,
    12,
    1,
    12,
    1,
    12,
    1,
    13,
    1,
    13,
    1,
    13,
    1,
    13,
    1,
    13,
    1,
    13,
    1,
    13,
    3,
    13,
    243,
    8,
    13,
    1,
    14,
    1,
    14,
    1,
    14,
    3,
    14,
    248,
    8,
    14,
    1,
    14,
    1,
    14,
    1,
    15,
    1,
    15,
    1,
    15,
    1,
    15,
    1,
    15,
    1,
    15,
    1,
    16,
    1,
    16,
    3,
    16,
    260,
    8,
    16,
    1,
    16,
    1,
    16,
    1,
    17,
    1,
    17,
    3,
    17,
    266,
    8,
    17,
    1,
    17,
    1,
    17,
    1,
    18,
    1,
    18,
    1,
    18,
    3,
    18,
    273,
    8,
    18,
    1,
    18,
    1,
    18,
    1,
    19,
    5,
    19,
    278,
    8,
    19,
    10,
    19,
    12,
    19,
    281,
    9,
    19,
    1,
    19,
    1,
    19,
    1,
    19,
    3,
    19,
    286,
    8,
    19,
    1,
    19,
    3,
    19,
    289,
    8,
    19,
    1,
    19,
    3,
    19,
    292,
    8,
    19,
    1,
    19,
    1,
    19,
    1,
    19,
    1,
    19,
    5,
    19,
    298,
    8,
    19,
    10,
    19,
    12,
    19,
    301,
    9,
    19,
    1,
    19,
    1,
    19,
    1,
    19,
    3,
    19,
    306,
    8,
    19,
    1,
    19,
    3,
    19,
    309,
    8,
    19,
    1,
    19,
    3,
    19,
    312,
    8,
    19,
    1,
    19,
    3,
    19,
    315,
    8,
    19,
    1,
    19,
    3,
    19,
    318,
    8,
    19,
    1,
    20,
    1,
    20,
    1,
    20,
    3,
    20,
    323,
    8,
    20,
    1,
    20,
    1,
    20,
    1,
    21,
    1,
    21,
    1,
    21,
    1,
    21,
    1,
    22,
    1,
    22,
    1,
    22,
    1,
    22,
    1,
    22,
    1,
    22,
    1,
    23,
    1,
    23,
    3,
    23,
    339,
    8,
    23,
    1,
    23,
    1,
    23,
    1,
    23,
    3,
    23,
    344,
    8,
    23,
    1,
    23,
    1,
    23,
    1,
    24,
    1,
    24,
    1,
    24,
    1,
    24,
    1,
    24,
    1,
    24,
    1,
    24,
    1,
    25,
    1,
    25,
    1,
    25,
    3,
    25,
    358,
    8,
    25,
    1,
    25,
    1,
    25,
    1,
    25,
    1,
    26,
    1,
    26,
    1,
    26,
    3,
    26,
    366,
    8,
    26,
    1,
    26,
    1,
    26,
    1,
    27,
    1,
    27,
    1,
    27,
    1,
    27,
    1,
    28,
    1,
    28,
    1,
    28,
    1,
    28,
    3,
    28,
    378,
    8,
    28,
    1,
    28,
    1,
    28,
    3,
    28,
    382,
    8,
    28,
    1,
    28,
    1,
    28,
    1,
    29,
    1,
    29,
    1,
    29,
    1,
    29,
    3,
    29,
    390,
    8,
    29,
    1,
    29,
    1,
    29,
    3,
    29,
    394,
    8,
    29,
    1,
    29,
    1,
    29,
    1,
    30,
    1,
    30,
    1,
    30,
    1,
    30,
    3,
    30,
    402,
    8,
    30,
    1,
    30,
    3,
    30,
    405,
    8,
    30,
    1,
    30,
    1,
    30,
    1,
    30,
    1,
    31,
    1,
    31,
    1,
    31,
    1,
    31,
    3,
    31,
    414,
    8,
    31,
    1,
    31,
    1,
    31,
    1,
    32,
    1,
    32,
    1,
    32,
    1,
    33,
    1,
    33,
    1,
    33,
    3,
    33,
    424,
    8,
    33,
    1,
    33,
    1,
    33,
    1,
    34,
    1,
    34,
    1,
    34,
    1,
    34,
    3,
    34,
    432,
    8,
    34,
    1,
    34,
    3,
    34,
    435,
    8,
    34,
    1,
    34,
    1,
    34,
    3,
    34,
    439,
    8,
    34,
    1,
    34,
    1,
    34,
    3,
    34,
    443,
    8,
    34,
    1,
    34,
    1,
    34,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    3,
    35,
    456,
    8,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    3,
    35,
    470,
    8,
    35,
    1,
    35,
    1,
    35,
    3,
    35,
    474,
    8,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    1,
    35,
    5,
    35,
    511,
    8,
    35,
    10,
    35,
    12,
    35,
    514,
    9,
    35,
    1,
    36,
    1,
    36,
    1,
    36,
    5,
    36,
    519,
    8,
    36,
    10,
    36,
    12,
    36,
    522,
    9,
    36,
    1,
    37,
    1,
    37,
    1,
    37,
    3,
    37,
    527,
    8,
    37,
    1,
    38,
    1,
    38,
    1,
    38,
    1,
    39,
    3,
    39,
    533,
    8,
    39,
    1,
    39,
    1,
    39,
    3,
    39,
    537,
    8,
    39,
    1,
    39,
    1,
    39,
    3,
    39,
    541,
    8,
    39,
    1,
    40,
    1,
    40,
    1,
    40,
    1,
    40,
    5,
    40,
    547,
    8,
    40,
    10,
    40,
    12,
    40,
    550,
    9,
    40,
    1,
    40,
    3,
    40,
    553,
    8,
    40,
    1,
    40,
    1,
    40,
    1,
    41,
    1,
    41,
    1,
    41,
    3,
    41,
    560,
    8,
    41,
    1,
    41,
    1,
    41,
    1,
    41,
    3,
    41,
    565,
    8,
    41,
    5,
    41,
    567,
    8,
    41,
    10,
    41,
    12,
    41,
    570,
    9,
    41,
    1,
    41,
    3,
    41,
    573,
    8,
    41,
    1,
    41,
    1,
    41,
    1,
    42,
    1,
    42,
    1,
    42,
    1,
    42,
    3,
    42,
    581,
    8,
    42,
    1,
    42,
    1,
    42,
    1,
    42,
    3,
    42,
    586,
    8,
    42,
    5,
    42,
    588,
    8,
    42,
    10,
    42,
    12,
    42,
    591,
    9,
    42,
    1,
    42,
    3,
    42,
    594,
    8,
    42,
    3,
    42,
    596,
    8,
    42,
    1,
    42,
    1,
    42,
    1,
    43,
    1,
    43,
    5,
    43,
    602,
    8,
    43,
    10,
    43,
    12,
    43,
    605,
    9,
    43,
    1,
    44,
    1,
    44,
    1,
    44,
    1,
    45,
    1,
    45,
    1,
    45,
    1,
    45,
    1,
    45,
    1,
    45,
    1,
    45,
    1,
    45,
    1,
    45,
    1,
    45,
    1,
    45,
    3,
    45,
    621,
    8,
    45,
    3,
    45,
    623,
    8,
    45,
    1,
    45,
    1,
    45,
    1,
    46,
    1,
    46,
    3,
    46,
    629,
    8,
    46,
    1,
    46,
    1,
    46,
    3,
    46,
    633,
    8,
    46,
    1,
    46,
    1,
    46,
    3,
    46,
    637,
    8,
    46,
    1,
    46,
    1,
    46,
    3,
    46,
    641,
    8,
    46,
    1,
    46,
    1,
    46,
    3,
    46,
    645,
    8,
    46,
    1,
    46,
    1,
    46,
    1,
    46,
    1,
    46,
    1,
    46,
    1,
    46,
    1,
    46,
    1,
    46,
    3,
    46,
    655,
    8,
    46,
    1,
    46,
    3,
    46,
    658,
    8,
    46,
    1,
    47,
    1,
    47,
    3,
    47,
    662,
    8,
    47,
    1,
    48,
    1,
    48,
    1,
    48,
    1,
    48,
    1,
    48,
    1,
    48,
    1,
    48,
    1,
    49,
    1,
    49,
    1,
    49,
    1,
    49,
    1,
    49,
    1,
    49,
    1,
    49,
    1,
    49,
    1,
    49,
    3,
    49,
    680,
    8,
    49,
    1,
    49,
    1,
    49,
    1,
    50,
    1,
    50,
    1,
    50,
    1,
    50,
    1,
    51,
    1,
    51,
    1,
    52,
    1,
    52,
    3,
    52,
    692,
    8,
    52,
    1,
    53,
    1,
    53,
    1,
    54,
    1,
    54,
    3,
    54,
    698,
    8,
    54,
    1,
    55,
    1,
    55,
    1,
    55,
    1,
    55,
    3,
    55,
    704,
    8,
    55,
    3,
    55,
    706,
    8,
    55,
    1,
    56,
    1,
    56,
    1,
    56,
    1,
    56,
    1,
    56,
    1,
    56,
    1,
    56,
    1,
    56,
    1,
    56,
    3,
    56,
    717,
    8,
    56,
    1,
    56,
    1,
    56,
    1,
    56,
    3,
    56,
    722,
    8,
    56,
    1,
    57,
    1,
    57,
    1,
    57,
    5,
    57,
    727,
    8,
    57,
    10,
    57,
    12,
    57,
    730,
    9,
    57,
    1,
    57,
    3,
    57,
    733,
    8,
    57,
    1,
    58,
    1,
    58,
    1,
    58,
    5,
    58,
    738,
    8,
    58,
    10,
    58,
    12,
    58,
    741,
    9,
    58,
    1,
    58,
    3,
    58,
    744,
    8,
    58,
    1,
    59,
    1,
    59,
    1,
    59,
    5,
    59,
    749,
    8,
    59,
    10,
    59,
    12,
    59,
    752,
    9,
    59,
    1,
    59,
    3,
    59,
    755,
    8,
    59,
    1,
    60,
    1,
    60,
    1,
    60,
    5,
    60,
    760,
    8,
    60,
    10,
    60,
    12,
    60,
    763,
    9,
    60,
    1,
    60,
    3,
    60,
    766,
    8,
    60,
    1,
    61,
    1,
    61,
    1,
    61,
    5,
    61,
    771,
    8,
    61,
    10,
    61,
    12,
    61,
    774,
    9,
    61,
    1,
    61,
    3,
    61,
    777,
    8,
    61,
    1,
    62,
    1,
    62,
    1,
    62,
    5,
    62,
    782,
    8,
    62,
    10,
    62,
    12,
    62,
    785,
    9,
    62,
    1,
    62,
    3,
    62,
    788,
    8,
    62,
    1,
    63,
    1,
    63,
    1,
    63,
    5,
    63,
    793,
    8,
    63,
    10,
    63,
    12,
    63,
    796,
    9,
    63,
    1,
    63,
    3,
    63,
    799,
    8,
    63,
    1,
    63,
    0,
    1,
    70,
    64,
    0,
    2,
    4,
    6,
    8,
    10,
    12,
    14,
    16,
    18,
    20,
    22,
    24,
    26,
    28,
    30,
    32,
    34,
    36,
    38,
    40,
    42,
    44,
    46,
    48,
    50,
    52,
    54,
    56,
    58,
    60,
    62,
    64,
    66,
    68,
    70,
    72,
    74,
    76,
    78,
    80,
    82,
    84,
    86,
    88,
    90,
    92,
    94,
    96,
    98,
    100,
    102,
    104,
    106,
    108,
    110,
    112,
    114,
    116,
    118,
    120,
    122,
    124,
    126,
    0,
    11,
    1,
    0,
    22,
    23,
    2,
    0,
    27,
    27,
    29,
    29,
    2,
    0,
    64,
    64,
    82,
    82,
    2,
    0,
    68,
    68,
    79,
    80,
    2,
    0,
    53,
    53,
    86,
    96,
    2,
    0,
    69,
    69,
    71,
    72,
    2,
    0,
    66,
    66,
    68,
    68,
    1,
    0,
    45,
    46,
    1,
    0,
    25,
    26,
    2,
    0,
    49,
    51,
    91,
    91,
    1,
    0,
    91,
    92,
    886,
    0,
    129,
    1,
    0,
    0,
    0,
    2,
    139,
    1,
    0,
    0,
    0,
    4,
    180,
    1,
    0,
    0,
    0,
    6,
    182,
    1,
    0,
    0,
    0,
    8,
    186,
    1,
    0,
    0,
    0,
    10,
    195,
    1,
    0,
    0,
    0,
    12,
    200,
    1,
    0,
    0,
    0,
    14,
    202,
    1,
    0,
    0,
    0,
    16,
    206,
    1,
    0,
    0,
    0,
    18,
    210,
    1,
    0,
    0,
    0,
    20,
    213,
    1,
    0,
    0,
    0,
    22,
    216,
    1,
    0,
    0,
    0,
    24,
    219,
    1,
    0,
    0,
    0,
    26,
    235,
    1,
    0,
    0,
    0,
    28,
    244,
    1,
    0,
    0,
    0,
    30,
    251,
    1,
    0,
    0,
    0,
    32,
    257,
    1,
    0,
    0,
    0,
    34,
    263,
    1,
    0,
    0,
    0,
    36,
    269,
    1,
    0,
    0,
    0,
    38,
    317,
    1,
    0,
    0,
    0,
    40,
    319,
    1,
    0,
    0,
    0,
    42,
    326,
    1,
    0,
    0,
    0,
    44,
    330,
    1,
    0,
    0,
    0,
    46,
    338,
    1,
    0,
    0,
    0,
    48,
    347,
    1,
    0,
    0,
    0,
    50,
    354,
    1,
    0,
    0,
    0,
    52,
    362,
    1,
    0,
    0,
    0,
    54,
    369,
    1,
    0,
    0,
    0,
    56,
    373,
    1,
    0,
    0,
    0,
    58,
    385,
    1,
    0,
    0,
    0,
    60,
    397,
    1,
    0,
    0,
    0,
    62,
    409,
    1,
    0,
    0,
    0,
    64,
    417,
    1,
    0,
    0,
    0,
    66,
    420,
    1,
    0,
    0,
    0,
    68,
    427,
    1,
    0,
    0,
    0,
    70,
    473,
    1,
    0,
    0,
    0,
    72,
    515,
    1,
    0,
    0,
    0,
    74,
    526,
    1,
    0,
    0,
    0,
    76,
    528,
    1,
    0,
    0,
    0,
    78,
    532,
    1,
    0,
    0,
    0,
    80,
    542,
    1,
    0,
    0,
    0,
    82,
    556,
    1,
    0,
    0,
    0,
    84,
    576,
    1,
    0,
    0,
    0,
    86,
    599,
    1,
    0,
    0,
    0,
    88,
    606,
    1,
    0,
    0,
    0,
    90,
    622,
    1,
    0,
    0,
    0,
    92,
    657,
    1,
    0,
    0,
    0,
    94,
    659,
    1,
    0,
    0,
    0,
    96,
    663,
    1,
    0,
    0,
    0,
    98,
    670,
    1,
    0,
    0,
    0,
    100,
    683,
    1,
    0,
    0,
    0,
    102,
    687,
    1,
    0,
    0,
    0,
    104,
    691,
    1,
    0,
    0,
    0,
    106,
    693,
    1,
    0,
    0,
    0,
    108,
    697,
    1,
    0,
    0,
    0,
    110,
    705,
    1,
    0,
    0,
    0,
    112,
    721,
    1,
    0,
    0,
    0,
    114,
    723,
    1,
    0,
    0,
    0,
    116,
    734,
    1,
    0,
    0,
    0,
    118,
    745,
    1,
    0,
    0,
    0,
    120,
    756,
    1,
    0,
    0,
    0,
    122,
    767,
    1,
    0,
    0,
    0,
    124,
    778,
    1,
    0,
    0,
    0,
    126,
    789,
    1,
    0,
    0,
    0,
    128,
    130,
    3,
    2,
    1,
    0,
    129,
    128,
    1,
    0,
    0,
    0,
    129,
    130,
    1,
    0,
    0,
    0,
    130,
    134,
    1,
    0,
    0,
    0,
    131,
    133,
    3,
    4,
    2,
    0,
    132,
    131,
    1,
    0,
    0,
    0,
    133,
    136,
    1,
    0,
    0,
    0,
    134,
    132,
    1,
    0,
    0,
    0,
    134,
    135,
    1,
    0,
    0,
    0,
    135,
    137,
    1,
    0,
    0,
    0,
    136,
    134,
    1,
    0,
    0,
    0,
    137,
    138,
    5,
    0,
    0,
    1,
    138,
    1,
    1,
    0,
    0,
    0,
    139,
    140,
    5,
    1,
    0,
    0,
    140,
    141,
    5,
    102,
    0,
    0,
    141,
    142,
    5,
    61,
    0,
    0,
    142,
    3,
    1,
    0,
    0,
    0,
    143,
    181,
    3,
    10,
    5,
    0,
    144,
    146,
    3,
    6,
    3,
    0,
    145,
    144,
    1,
    0,
    0,
    0,
    146,
    149,
    1,
    0,
    0,
    0,
    147,
    145,
    1,
    0,
    0,
    0,
    147,
    148,
    1,
    0,
    0,
    0,
    148,
    178,
    1,
    0,
    0,
    0,
    149,
    147,
    1,
    0,
    0,
    0,
    150,
    179,
    3,
    44,
    22,
    0,
    151,
    179,
    3,
    62,
    31,
    0,
    152,
    179,
    3,
    32,
    16,
    0,
    153,
    179,
    3,
    34,
    17,
    0,
    154,
    179,
    3,
    18,
    9,
    0,
    155,
    179,
    3,
    66,
    33,
    0,
    156,
    179,
    3,
    14,
    7,
    0,
    157,
    179,
    3,
    46,
    23,
    0,
    158,
    179,
    3,
    48,
    24,
    0,
    159,
    179,
    3,
    20,
    10,
    0,
    160,
    179,
    3,
    56,
    28,
    0,
    161,
    179,
    3,
    68,
    34,
    0,
    162,
    179,
    3,
    36,
    18,
    0,
    163,
    179,
    3,
    22,
    11,
    0,
    164,
    179,
    3,
    64,
    32,
    0,
    165,
    179,
    3,
    58,
    29,
    0,
    166,
    179,
    3,
    24,
    12,
    0,
    167,
    179,
    3,
    38,
    19,
    0,
    168,
    179,
    3,
    60,
    30,
    0,
    169,
    179,
    3,
    26,
    13,
    0,
    170,
    179,
    3,
    16,
    8,
    0,
    171,
    179,
    3,
    50,
    25,
    0,
    172,
    179,
    3,
    40,
    20,
    0,
    173,
    179,
    3,
    52,
    26,
    0,
    174,
    179,
    3,
    54,
    27,
    0,
    175,
    179,
    3,
    42,
    21,
    0,
    176,
    179,
    3,
    28,
    14,
    0,
    177,
    179,
    3,
    30,
    15,
    0,
    178,
    150,
    1,
    0,
    0,
    0,
    178,
    151,
    1,
    0,
    0,
    0,
    178,
    152,
    1,
    0,
    0,
    0,
    178,
    153,
    1,
    0,
    0,
    0,
    178,
    154,
    1,
    0,
    0,
    0,
    178,
    155,
    1,
    0,
    0,
    0,
    178,
    156,
    1,
    0,
    0,
    0,
    178,
    157,
    1,
    0,
    0,
    0,
    178,
    158,
    1,
    0,
    0,
    0,
    178,
    159,
    1,
    0,
    0,
    0,
    178,
    160,
    1,
    0,
    0,
    0,
    178,
    161,
    1,
    0,
    0,
    0,
    178,
    162,
    1,
    0,
    0,
    0,
    178,
    163,
    1,
    0,
    0,
    0,
    178,
    164,
    1,
    0,
    0,
    0,
    178,
    165,
    1,
    0,
    0,
    0,
    178,
    166,
    1,
    0,
    0,
    0,
    178,
    167,
    1,
    0,
    0,
    0,
    178,
    168,
    1,
    0,
    0,
    0,
    178,
    169,
    1,
    0,
    0,
    0,
    178,
    170,
    1,
    0,
    0,
    0,
    178,
    171,
    1,
    0,
    0,
    0,
    178,
    172,
    1,
    0,
    0,
    0,
    178,
    173,
    1,
    0,
    0,
    0,
    178,
    174,
    1,
    0,
    0,
    0,
    178,
    175,
    1,
    0,
    0,
    0,
    178,
    176,
    1,
    0,
    0,
    0,
    178,
    177,
    1,
    0,
    0,
    0,
    179,
    181,
    1,
    0,
    0,
    0,
    180,
    143,
    1,
    0,
    0,
    0,
    180,
    147,
    1,
    0,
    0,
    0,
    181,
    5,
    1,
    0,
    0,
    0,
    182,
    184,
    5,
    21,
    0,
    0,
    183,
    185,
    5,
    105,
    0,
    0,
    184,
    183,
    1,
    0,
    0,
    0,
    184,
    185,
    1,
    0,
    0,
    0,
    185,
    7,
    1,
    0,
    0,
    0,
    186,
    190,
    5,
    56,
    0,
    0,
    187,
    189,
    3,
    4,
    2,
    0,
    188,
    187,
    1,
    0,
    0,
    0,
    189,
    192,
    1,
    0,
    0,
    0,
    190,
    188,
    1,
    0,
    0,
    0,
    190,
    191,
    1,
    0,
    0,
    0,
    191,
    193,
    1,
    0,
    0,
    0,
    192,
    190,
    1,
    0,
    0,
    0,
    193,
    194,
    5,
    57,
    0,
    0,
    194,
    9,
    1,
    0,
    0,
    0,
    195,
    196,
    5,
    20,
    0,
    0,
    196,
    197,
    5,
    105,
    0,
    0,
    197,
    11,
    1,
    0,
    0,
    0,
    198,
    201,
    3,
    4,
    2,
    0,
    199,
    201,
    3,
    8,
    4,
    0,
    200,
    198,
    1,
    0,
    0,
    0,
    200,
    199,
    1,
    0,
    0,
    0,
    201,
    13,
    1,
    0,
    0,
    0,
    202,
    203,
    5,
    3,
    0,
    0,
    203,
    204,
    5,
    96,
    0,
    0,
    204,
    205,
    5,
    61,
    0,
    0,
    205,
    15,
    1,
    0,
    0,
    0,
    206,
    207,
    5,
    2,
    0,
    0,
    207,
    208,
    5,
    96,
    0,
    0,
    208,
    209,
    5,
    61,
    0,
    0,
    209,
    17,
    1,
    0,
    0,
    0,
    210,
    211,
    5,
    11,
    0,
    0,
    211,
    212,
    5,
    61,
    0,
    0,
    212,
    19,
    1,
    0,
    0,
    0,
    213,
    214,
    5,
    12,
    0,
    0,
    214,
    215,
    5,
    61,
    0,
    0,
    215,
    21,
    1,
    0,
    0,
    0,
    216,
    217,
    5,
    15,
    0,
    0,
    217,
    218,
    5,
    61,
    0,
    0,
    218,
    23,
    1,
    0,
    0,
    0,
    219,
    221,
    5,
    17,
    0,
    0,
    220,
    222,
    3,
    92,
    46,
    0,
    221,
    220,
    1,
    0,
    0,
    0,
    221,
    222,
    1,
    0,
    0,
    0,
    222,
    223,
    1,
    0,
    0,
    0,
    223,
    224,
    5,
    91,
    0,
    0,
    224,
    231,
    5,
    19,
    0,
    0,
    225,
    232,
    3,
    80,
    40,
    0,
    226,
    227,
    5,
    54,
    0,
    0,
    227,
    228,
    3,
    78,
    39,
    0,
    228,
    229,
    5,
    55,
    0,
    0,
    229,
    232,
    1,
    0,
    0,
    0,
    230,
    232,
    3,
    70,
    35,
    0,
    231,
    225,
    1,
    0,
    0,
    0,
    231,
    226,
    1,
    0,
    0,
    0,
    231,
    230,
    1,
    0,
    0,
    0,
    232,
    233,
    1,
    0,
    0,
    0,
    233,
    234,
    3,
    12,
    6,
    0,
    234,
    25,
    1,
    0,
    0,
    0,
    235,
    236,
    5,
    13,
    0,
    0,
    236,
    237,
    5,
    58,
    0,
    0,
    237,
    238,
    3,
    70,
    35,
    0,
    238,
    239,
    5,
    59,
    0,
    0,
    239,
    242,
    3,
    12,
    6,
    0,
    240,
    241,
    5,
    14,
    0,
    0,
    241,
    243,
    3,
    12,
    6,
    0,
    242,
    240,
    1,
    0,
    0,
    0,
    242,
    243,
    1,
    0,
    0,
    0,
    243,
    27,
    1,
    0,
    0,
    0,
    244,
    247,
    5,
    16,
    0,
    0,
    245,
    248,
    3,
    70,
    35,
    0,
    246,
    248,
    3,
    76,
    38,
    0,
    247,
    245,
    1,
    0,
    0,
    0,
    247,
    246,
    1,
    0,
    0,
    0,
    247,
    248,
    1,
    0,
    0,
    0,
    248,
    249,
    1,
    0,
    0,
    0,
    249,
    250,
    5,
    61,
    0,
    0,
    250,
    29,
    1,
    0,
    0,
    0,
    251,
    252,
    5,
    18,
    0,
    0,
    252,
    253,
    5,
    58,
    0,
    0,
    253,
    254,
    3,
    70,
    35,
    0,
    254,
    255,
    5,
    59,
    0,
    0,
    255,
    256,
    3,
    12,
    6,
    0,
    256,
    31,
    1,
    0,
    0,
    0,
    257,
    259,
    5,
    52,
    0,
    0,
    258,
    260,
    3,
    124,
    62,
    0,
    259,
    258,
    1,
    0,
    0,
    0,
    259,
    260,
    1,
    0,
    0,
    0,
    260,
    261,
    1,
    0,
    0,
    0,
    261,
    262,
    5,
    61,
    0,
    0,
    262,
    33,
    1,
    0,
    0,
    0,
    263,
    265,
    5,
    9,
    0,
    0,
    264,
    266,
    3,
    100,
    50,
    0,
    265,
    264,
    1,
    0,
    0,
    0,
    265,
    266,
    1,
    0,
    0,
    0,
    266,
    267,
    1,
    0,
    0,
    0,
    267,
    268,
    3,
    8,
    4,
    0,
    268,
    35,
    1,
    0,
    0,
    0,
    269,
    270,
    5,
    49,
    0,
    0,
    270,
    272,
    3,
    100,
    50,
    0,
    271,
    273,
    3,
    124,
    62,
    0,
    272,
    271,
    1,
    0,
    0,
    0,
    272,
    273,
    1,
    0,
    0,
    0,
    273,
    274,
    1,
    0,
    0,
    0,
    274,
    275,
    5,
    61,
    0,
    0,
    275,
    37,
    1,
    0,
    0,
    0,
    276,
    278,
    3,
    90,
    45,
    0,
    277,
    276,
    1,
    0,
    0,
    0,
    278,
    281,
    1,
    0,
    0,
    0,
    279,
    277,
    1,
    0,
    0,
    0,
    279,
    280,
    1,
    0,
    0,
    0,
    280,
    282,
    1,
    0,
    0,
    0,
    281,
    279,
    1,
    0,
    0,
    0,
    282,
    288,
    5,
    91,
    0,
    0,
    283,
    285,
    5,
    58,
    0,
    0,
    284,
    286,
    3,
    120,
    60,
    0,
    285,
    284,
    1,
    0,
    0,
    0,
    285,
    286,
    1,
    0,
    0,
    0,
    286,
    287,
    1,
    0,
    0,
    0,
    287,
    289,
    5,
    59,
    0,
    0,
    288,
    283,
    1,
    0,
    0,
    0,
    288,
    289,
    1,
    0,
    0,
    0,
    289,
    291,
    1,
    0,
    0,
    0,
    290,
    292,
    3,
    100,
    50,
    0,
    291,
    290,
    1,
    0,
    0,
    0,
    291,
    292,
    1,
    0,
    0,
    0,
    292,
    293,
    1,
    0,
    0,
    0,
    293,
    294,
    3,
    124,
    62,
    0,
    294,
    295,
    5,
    61,
    0,
    0,
    295,
    318,
    1,
    0,
    0,
    0,
    296,
    298,
    3,
    90,
    45,
    0,
    297,
    296,
    1,
    0,
    0,
    0,
    298,
    301,
    1,
    0,
    0,
    0,
    299,
    297,
    1,
    0,
    0,
    0,
    299,
    300,
    1,
    0,
    0,
    0,
    300,
    302,
    1,
    0,
    0,
    0,
    301,
    299,
    1,
    0,
    0,
    0,
    302,
    308,
    5,
    42,
    0,
    0,
    303,
    305,
    5,
    58,
    0,
    0,
    304,
    306,
    3,
    120,
    60,
    0,
    305,
    304,
    1,
    0,
    0,
    0,
    305,
    306,
    1,
    0,
    0,
    0,
    306,
    307,
    1,
    0,
    0,
    0,
    307,
    309,
    5,
    59,
    0,
    0,
    308,
    303,
    1,
    0,
    0,
    0,
    308,
    309,
    1,
    0,
    0,
    0,
    309,
    311,
    1,
    0,
    0,
    0,
    310,
    312,
    3,
    100,
    50,
    0,
    311,
    310,
    1,
    0,
    0,
    0,
    311,
    312,
    1,
    0,
    0,
    0,
    312,
    314,
    1,
    0,
    0,
    0,
    313,
    315,
    3,
    124,
    62,
    0,
    314,
    313,
    1,
    0,
    0,
    0,
    314,
    315,
    1,
    0,
    0,
    0,
    315,
    316,
    1,
    0,
    0,
    0,
    316,
    318,
    5,
    61,
    0,
    0,
    317,
    279,
    1,
    0,
    0,
    0,
    317,
    299,
    1,
    0,
    0,
    0,
    318,
    39,
    1,
    0,
    0,
    0,
    319,
    322,
    3,
    76,
    38,
    0,
    320,
    321,
    5,
    65,
    0,
    0,
    321,
    323,
    3,
    86,
    43,
    0,
    322,
    320,
    1,
    0,
    0,
    0,
    322,
    323,
    1,
    0,
    0,
    0,
    323,
    324,
    1,
    0,
    0,
    0,
    324,
    325,
    5,
    61,
    0,
    0,
    325,
    41,
    1,
    0,
    0,
    0,
    326,
    327,
    5,
    50,
    0,
    0,
    327,
    328,
    3,
    108,
    54,
    0,
    328,
    329,
    5,
    61,
    0,
    0,
    329,
    43,
    1,
    0,
    0,
    0,
    330,
    331,
    5,
    10,
    0,
    0,
    331,
    332,
    5,
    91,
    0,
    0,
    332,
    333,
    5,
    64,
    0,
    0,
    333,
    334,
    3,
    72,
    36,
    0,
    334,
    335,
    5,
    61,
    0,
    0,
    335,
    45,
    1,
    0,
    0,
    0,
    336,
    339,
    3,
    92,
    46,
    0,
    337,
    339,
    3,
    96,
    48,
    0,
    338,
    336,
    1,
    0,
    0,
    0,
    338,
    337,
    1,
    0,
    0,
    0,
    339,
    340,
    1,
    0,
    0,
    0,
    340,
    343,
    5,
    91,
    0,
    0,
    341,
    342,
    5,
    64,
    0,
    0,
    342,
    344,
    3,
    74,
    37,
    0,
    343,
    341,
    1,
    0,
    0,
    0,
    343,
    344,
    1,
    0,
    0,
    0,
    344,
    345,
    1,
    0,
    0,
    0,
    345,
    346,
    5,
    61,
    0,
    0,
    346,
    47,
    1,
    0,
    0,
    0,
    347,
    348,
    5,
    24,
    0,
    0,
    348,
    349,
    3,
    92,
    46,
    0,
    349,
    350,
    5,
    91,
    0,
    0,
    350,
    351,
    5,
    64,
    0,
    0,
    351,
    352,
    3,
    74,
    37,
    0,
    352,
    353,
    5,
    61,
    0,
    0,
    353,
    49,
    1,
    0,
    0,
    0,
    354,
    357,
    7,
    0,
    0,
    0,
    355,
    358,
    3,
    92,
    46,
    0,
    356,
    358,
    3,
    96,
    48,
    0,
    357,
    355,
    1,
    0,
    0,
    0,
    357,
    356,
    1,
    0,
    0,
    0,
    358,
    359,
    1,
    0,
    0,
    0,
    359,
    360,
    5,
    91,
    0,
    0,
    360,
    361,
    5,
    61,
    0,
    0,
    361,
    51,
    1,
    0,
    0,
    0,
    362,
    363,
    7,
    1,
    0,
    0,
    363,
    365,
    5,
    91,
    0,
    0,
    364,
    366,
    3,
    100,
    50,
    0,
    365,
    364,
    1,
    0,
    0,
    0,
    365,
    366,
    1,
    0,
    0,
    0,
    366,
    367,
    1,
    0,
    0,
    0,
    367,
    368,
    5,
    61,
    0,
    0,
    368,
    53,
    1,
    0,
    0,
    0,
    369,
    370,
    3,
    94,
    47,
    0,
    370,
    371,
    5,
    91,
    0,
    0,
    371,
    372,
    5,
    61,
    0,
    0,
    372,
    55,
    1,
    0,
    0,
    0,
    373,
    374,
    5,
    4,
    0,
    0,
    374,
    375,
    5,
    91,
    0,
    0,
    375,
    377,
    5,
    58,
    0,
    0,
    376,
    378,
    3,
    114,
    57,
    0,
    377,
    376,
    1,
    0,
    0,
    0,
    377,
    378,
    1,
    0,
    0,
    0,
    378,
    379,
    1,
    0,
    0,
    0,
    379,
    381,
    5,
    59,
    0,
    0,
    380,
    382,
    3,
    88,
    44,
    0,
    381,
    380,
    1,
    0,
    0,
    0,
    381,
    382,
    1,
    0,
    0,
    0,
    382,
    383,
    1,
    0,
    0,
    0,
    383,
    384,
    3,
    8,
    4,
    0,
    384,
    57,
    1,
    0,
    0,
    0,
    385,
    386,
    5,
    8,
    0,
    0,
    386,
    387,
    5,
    91,
    0,
    0,
    387,
    389,
    5,
    58,
    0,
    0,
    388,
    390,
    3,
    126,
    63,
    0,
    389,
    388,
    1,
    0,
    0,
    0,
    389,
    390,
    1,
    0,
    0,
    0,
    390,
    391,
    1,
    0,
    0,
    0,
    391,
    393,
    5,
    59,
    0,
    0,
    392,
    394,
    3,
    88,
    44,
    0,
    393,
    392,
    1,
    0,
    0,
    0,
    393,
    394,
    1,
    0,
    0,
    0,
    394,
    395,
    1,
    0,
    0,
    0,
    395,
    396,
    5,
    61,
    0,
    0,
    396,
    59,
    1,
    0,
    0,
    0,
    397,
    398,
    5,
    7,
    0,
    0,
    398,
    404,
    5,
    91,
    0,
    0,
    399,
    401,
    5,
    58,
    0,
    0,
    400,
    402,
    3,
    122,
    61,
    0,
    401,
    400,
    1,
    0,
    0,
    0,
    401,
    402,
    1,
    0,
    0,
    0,
    402,
    403,
    1,
    0,
    0,
    0,
    403,
    405,
    5,
    59,
    0,
    0,
    404,
    399,
    1,
    0,
    0,
    0,
    404,
    405,
    1,
    0,
    0,
    0,
    405,
    406,
    1,
    0,
    0,
    0,
    406,
    407,
    3,
    122,
    61,
    0,
    407,
    408,
    3,
    8,
    4,
    0,
    408,
    61,
    1,
    0,
    0,
    0,
    409,
    410,
    3,
    86,
    43,
    0,
    410,
    413,
    7,
    2,
    0,
    0,
    411,
    414,
    3,
    70,
    35,
    0,
    412,
    414,
    3,
    76,
    38,
    0,
    413,
    411,
    1,
    0,
    0,
    0,
    413,
    412,
    1,
    0,
    0,
    0,
    414,
    415,
    1,
    0,
    0,
    0,
    415,
    416,
    5,
    61,
    0,
    0,
    416,
    63,
    1,
    0,
    0,
    0,
    417,
    418,
    3,
    70,
    35,
    0,
    418,
    419,
    5,
    61,
    0,
    0,
    419,
    65,
    1,
    0,
    0,
    0,
    420,
    421,
    5,
    5,
    0,
    0,
    421,
    423,
    5,
    56,
    0,
    0,
    422,
    424,
    5,
    110,
    0,
    0,
    423,
    422,
    1,
    0,
    0,
    0,
    423,
    424,
    1,
    0,
    0,
    0,
    424,
    425,
    1,
    0,
    0,
    0,
    425,
    426,
    5,
    57,
    0,
    0,
    426,
    67,
    1,
    0,
    0,
    0,
    427,
    428,
    5,
    6,
    0,
    0,
    428,
    434,
    3,
    102,
    51,
    0,
    429,
    431,
    5,
    58,
    0,
    0,
    430,
    432,
    3,
    116,
    58,
    0,
    431,
    430,
    1,
    0,
    0,
    0,
    431,
    432,
    1,
    0,
    0,
    0,
    432,
    433,
    1,
    0,
    0,
    0,
    433,
    435,
    5,
    59,
    0,
    0,
    434,
    429,
    1,
    0,
    0,
    0,
    434,
    435,
    1,
    0,
    0,
    0,
    435,
    436,
    1,
    0,
    0,
    0,
    436,
    438,
    3,
    118,
    59,
    0,
    437,
    439,
    3,
    88,
    44,
    0,
    438,
    437,
    1,
    0,
    0,
    0,
    438,
    439,
    1,
    0,
    0,
    0,
    439,
    440,
    1,
    0,
    0,
    0,
    440,
    442,
    5,
    56,
    0,
    0,
    441,
    443,
    5,
    110,
    0,
    0,
    442,
    441,
    1,
    0,
    0,
    0,
    442,
    443,
    1,
    0,
    0,
    0,
    443,
    444,
    1,
    0,
    0,
    0,
    444,
    445,
    5,
    57,
    0,
    0,
    445,
    69,
    1,
    0,
    0,
    0,
    446,
    447,
    6,
    35,
    -1,
    0,
    447,
    448,
    5,
    58,
    0,
    0,
    448,
    449,
    3,
    70,
    35,
    0,
    449,
    450,
    5,
    59,
    0,
    0,
    450,
    474,
    1,
    0,
    0,
    0,
    451,
    452,
    7,
    3,
    0,
    0,
    452,
    474,
    3,
    70,
    35,
    15,
    453,
    456,
    3,
    92,
    46,
    0,
    454,
    456,
    3,
    96,
    48,
    0,
    455,
    453,
    1,
    0,
    0,
    0,
    455,
    454,
    1,
    0,
    0,
    0,
    456,
    457,
    1,
    0,
    0,
    0,
    457,
    458,
    5,
    58,
    0,
    0,
    458,
    459,
    3,
    70,
    35,
    0,
    459,
    460,
    5,
    59,
    0,
    0,
    460,
    474,
    1,
    0,
    0,
    0,
    461,
    462,
    5,
    48,
    0,
    0,
    462,
    463,
    5,
    58,
    0,
    0,
    463,
    464,
    3,
    8,
    4,
    0,
    464,
    465,
    5,
    59,
    0,
    0,
    465,
    474,
    1,
    0,
    0,
    0,
    466,
    467,
    5,
    91,
    0,
    0,
    467,
    469,
    5,
    58,
    0,
    0,
    468,
    470,
    3,
    120,
    60,
    0,
    469,
    468,
    1,
    0,
    0,
    0,
    469,
    470,
    1,
    0,
    0,
    0,
    470,
    471,
    1,
    0,
    0,
    0,
    471,
    474,
    5,
    59,
    0,
    0,
    472,
    474,
    7,
    4,
    0,
    0,
    473,
    446,
    1,
    0,
    0,
    0,
    473,
    451,
    1,
    0,
    0,
    0,
    473,
    455,
    1,
    0,
    0,
    0,
    473,
    461,
    1,
    0,
    0,
    0,
    473,
    466,
    1,
    0,
    0,
    0,
    473,
    472,
    1,
    0,
    0,
    0,
    474,
    512,
    1,
    0,
    0,
    0,
    475,
    476,
    10,
    16,
    0,
    0,
    476,
    477,
    5,
    70,
    0,
    0,
    477,
    511,
    3,
    70,
    35,
    16,
    478,
    479,
    10,
    14,
    0,
    0,
    479,
    480,
    7,
    5,
    0,
    0,
    480,
    511,
    3,
    70,
    35,
    15,
    481,
    482,
    10,
    13,
    0,
    0,
    482,
    483,
    7,
    6,
    0,
    0,
    483,
    511,
    3,
    70,
    35,
    14,
    484,
    485,
    10,
    12,
    0,
    0,
    485,
    486,
    5,
    84,
    0,
    0,
    486,
    511,
    3,
    70,
    35,
    13,
    487,
    488,
    10,
    11,
    0,
    0,
    488,
    489,
    5,
    83,
    0,
    0,
    489,
    511,
    3,
    70,
    35,
    12,
    490,
    491,
    10,
    10,
    0,
    0,
    491,
    492,
    5,
    81,
    0,
    0,
    492,
    511,
    3,
    70,
    35,
    11,
    493,
    494,
    10,
    9,
    0,
    0,
    494,
    495,
    5,
    75,
    0,
    0,
    495,
    511,
    3,
    70,
    35,
    10,
    496,
    497,
    10,
    8,
    0,
    0,
    497,
    498,
    5,
    77,
    0,
    0,
    498,
    511,
    3,
    70,
    35,
    9,
    499,
    500,
    10,
    7,
    0,
    0,
    500,
    501,
    5,
    73,
    0,
    0,
    501,
    511,
    3,
    70,
    35,
    8,
    502,
    503,
    10,
    6,
    0,
    0,
    503,
    504,
    5,
    76,
    0,
    0,
    504,
    511,
    3,
    70,
    35,
    7,
    505,
    506,
    10,
    5,
    0,
    0,
    506,
    507,
    5,
    74,
    0,
    0,
    507,
    511,
    3,
    70,
    35,
    6,
    508,
    509,
    10,
    17,
    0,
    0,
    509,
    511,
    3,
    84,
    42,
    0,
    510,
    475,
    1,
    0,
    0,
    0,
    510,
    478,
    1,
    0,
    0,
    0,
    510,
    481,
    1,
    0,
    0,
    0,
    510,
    484,
    1,
    0,
    0,
    0,
    510,
    487,
    1,
    0,
    0,
    0,
    510,
    490,
    1,
    0,
    0,
    0,
    510,
    493,
    1,
    0,
    0,
    0,
    510,
    496,
    1,
    0,
    0,
    0,
    510,
    499,
    1,
    0,
    0,
    0,
    510,
    502,
    1,
    0,
    0,
    0,
    510,
    505,
    1,
    0,
    0,
    0,
    510,
    508,
    1,
    0,
    0,
    0,
    511,
    514,
    1,
    0,
    0,
    0,
    512,
    510,
    1,
    0,
    0,
    0,
    512,
    513,
    1,
    0,
    0,
    0,
    513,
    71,
    1,
    0,
    0,
    0,
    514,
    512,
    1,
    0,
    0,
    0,
    515,
    520,
    3,
    70,
    35,
    0,
    516,
    517,
    5,
    67,
    0,
    0,
    517,
    519,
    3,
    70,
    35,
    0,
    518,
    516,
    1,
    0,
    0,
    0,
    519,
    522,
    1,
    0,
    0,
    0,
    520,
    518,
    1,
    0,
    0,
    0,
    520,
    521,
    1,
    0,
    0,
    0,
    521,
    73,
    1,
    0,
    0,
    0,
    522,
    520,
    1,
    0,
    0,
    0,
    523,
    527,
    3,
    82,
    41,
    0,
    524,
    527,
    3,
    70,
    35,
    0,
    525,
    527,
    3,
    76,
    38,
    0,
    526,
    523,
    1,
    0,
    0,
    0,
    526,
    524,
    1,
    0,
    0,
    0,
    526,
    525,
    1,
    0,
    0,
    0,
    527,
    75,
    1,
    0,
    0,
    0,
    528,
    529,
    5,
    51,
    0,
    0,
    529,
    530,
    3,
    108,
    54,
    0,
    530,
    77,
    1,
    0,
    0,
    0,
    531,
    533,
    3,
    70,
    35,
    0,
    532,
    531,
    1,
    0,
    0,
    0,
    532,
    533,
    1,
    0,
    0,
    0,
    533,
    534,
    1,
    0,
    0,
    0,
    534,
    536,
    5,
    60,
    0,
    0,
    535,
    537,
    3,
    70,
    35,
    0,
    536,
    535,
    1,
    0,
    0,
    0,
    536,
    537,
    1,
    0,
    0,
    0,
    537,
    540,
    1,
    0,
    0,
    0,
    538,
    539,
    5,
    60,
    0,
    0,
    539,
    541,
    3,
    70,
    35,
    0,
    540,
    538,
    1,
    0,
    0,
    0,
    540,
    541,
    1,
    0,
    0,
    0,
    541,
    79,
    1,
    0,
    0,
    0,
    542,
    543,
    5,
    56,
    0,
    0,
    543,
    548,
    3,
    70,
    35,
    0,
    544,
    545,
    5,
    63,
    0,
    0,
    545,
    547,
    3,
    70,
    35,
    0,
    546,
    544,
    1,
    0,
    0,
    0,
    547,
    550,
    1,
    0,
    0,
    0,
    548,
    546,
    1,
    0,
    0,
    0,
    548,
    549,
    1,
    0,
    0,
    0,
    549,
    552,
    1,
    0,
    0,
    0,
    550,
    548,
    1,
    0,
    0,
    0,
    551,
    553,
    5,
    63,
    0,
    0,
    552,
    551,
    1,
    0,
    0,
    0,
    552,
    553,
    1,
    0,
    0,
    0,
    553,
    554,
    1,
    0,
    0,
    0,
    554,
    555,
    5,
    57,
    0,
    0,
    555,
    81,
    1,
    0,
    0,
    0,
    556,
    559,
    5,
    56,
    0,
    0,
    557,
    560,
    3,
    70,
    35,
    0,
    558,
    560,
    3,
    82,
    41,
    0,
    559,
    557,
    1,
    0,
    0,
    0,
    559,
    558,
    1,
    0,
    0,
    0,
    560,
    568,
    1,
    0,
    0,
    0,
    561,
    564,
    5,
    63,
    0,
    0,
    562,
    565,
    3,
    70,
    35,
    0,
    563,
    565,
    3,
    82,
    41,
    0,
    564,
    562,
    1,
    0,
    0,
    0,
    564,
    563,
    1,
    0,
    0,
    0,
    565,
    567,
    1,
    0,
    0,
    0,
    566,
    561,
    1,
    0,
    0,
    0,
    567,
    570,
    1,
    0,
    0,
    0,
    568,
    566,
    1,
    0,
    0,
    0,
    568,
    569,
    1,
    0,
    0,
    0,
    569,
    572,
    1,
    0,
    0,
    0,
    570,
    568,
    1,
    0,
    0,
    0,
    571,
    573,
    5,
    63,
    0,
    0,
    572,
    571,
    1,
    0,
    0,
    0,
    572,
    573,
    1,
    0,
    0,
    0,
    573,
    574,
    1,
    0,
    0,
    0,
    574,
    575,
    5,
    57,
    0,
    0,
    575,
    83,
    1,
    0,
    0,
    0,
    576,
    595,
    5,
    54,
    0,
    0,
    577,
    596,
    3,
    80,
    40,
    0,
    578,
    581,
    3,
    70,
    35,
    0,
    579,
    581,
    3,
    78,
    39,
    0,
    580,
    578,
    1,
    0,
    0,
    0,
    580,
    579,
    1,
    0,
    0,
    0,
    581,
    589,
    1,
    0,
    0,
    0,
    582,
    585,
    5,
    63,
    0,
    0,
    583,
    586,
    3,
    70,
    35,
    0,
    584,
    586,
    3,
    78,
    39,
    0,
    585,
    583,
    1,
    0,
    0,
    0,
    585,
    584,
    1,
    0,
    0,
    0,
    586,
    588,
    1,
    0,
    0,
    0,
    587,
    582,
    1,
    0,
    0,
    0,
    588,
    591,
    1,
    0,
    0,
    0,
    589,
    587,
    1,
    0,
    0,
    0,
    589,
    590,
    1,
    0,
    0,
    0,
    590,
    593,
    1,
    0,
    0,
    0,
    591,
    589,
    1,
    0,
    0,
    0,
    592,
    594,
    5,
    63,
    0,
    0,
    593,
    592,
    1,
    0,
    0,
    0,
    593,
    594,
    1,
    0,
    0,
    0,
    594,
    596,
    1,
    0,
    0,
    0,
    595,
    577,
    1,
    0,
    0,
    0,
    595,
    580,
    1,
    0,
    0,
    0,
    596,
    597,
    1,
    0,
    0,
    0,
    597,
    598,
    5,
    55,
    0,
    0,
    598,
    85,
    1,
    0,
    0,
    0,
    599,
    603,
    5,
    91,
    0,
    0,
    600,
    602,
    3,
    84,
    42,
    0,
    601,
    600,
    1,
    0,
    0,
    0,
    602,
    605,
    1,
    0,
    0,
    0,
    603,
    601,
    1,
    0,
    0,
    0,
    603,
    604,
    1,
    0,
    0,
    0,
    604,
    87,
    1,
    0,
    0,
    0,
    605,
    603,
    1,
    0,
    0,
    0,
    606,
    607,
    5,
    65,
    0,
    0,
    607,
    608,
    3,
    92,
    46,
    0,
    608,
    89,
    1,
    0,
    0,
    0,
    609,
    623,
    5,
    43,
    0,
    0,
    610,
    611,
    5,
    44,
    0,
    0,
    611,
    612,
    5,
    58,
    0,
    0,
    612,
    613,
    3,
    70,
    35,
    0,
    613,
    614,
    5,
    59,
    0,
    0,
    614,
    623,
    1,
    0,
    0,
    0,
    615,
    620,
    7,
    7,
    0,
    0,
    616,
    617,
    5,
    58,
    0,
    0,
    617,
    618,
    3,
    70,
    35,
    0,
    618,
    619,
    5,
    59,
    0,
    0,
    619,
    621,
    1,
    0,
    0,
    0,
    620,
    616,
    1,
    0,
    0,
    0,
    620,
    621,
    1,
    0,
    0,
    0,
    621,
    623,
    1,
    0,
    0,
    0,
    622,
    609,
    1,
    0,
    0,
    0,
    622,
    610,
    1,
    0,
    0,
    0,
    622,
    615,
    1,
    0,
    0,
    0,
    623,
    624,
    1,
    0,
    0,
    0,
    624,
    625,
    5,
    78,
    0,
    0,
    625,
    91,
    1,
    0,
    0,
    0,
    626,
    628,
    5,
    31,
    0,
    0,
    627,
    629,
    3,
    100,
    50,
    0,
    628,
    627,
    1,
    0,
    0,
    0,
    628,
    629,
    1,
    0,
    0,
    0,
    629,
    658,
    1,
    0,
    0,
    0,
    630,
    632,
    5,
    32,
    0,
    0,
    631,
    633,
    3,
    100,
    50,
    0,
    632,
    631,
    1,
    0,
    0,
    0,
    632,
    633,
    1,
    0,
    0,
    0,
    633,
    658,
    1,
    0,
    0,
    0,
    634,
    636,
    5,
    33,
    0,
    0,
    635,
    637,
    3,
    100,
    50,
    0,
    636,
    635,
    1,
    0,
    0,
    0,
    636,
    637,
    1,
    0,
    0,
    0,
    637,
    658,
    1,
    0,
    0,
    0,
    638,
    640,
    5,
    34,
    0,
    0,
    639,
    641,
    3,
    100,
    50,
    0,
    640,
    639,
    1,
    0,
    0,
    0,
    640,
    641,
    1,
    0,
    0,
    0,
    641,
    658,
    1,
    0,
    0,
    0,
    642,
    644,
    5,
    35,
    0,
    0,
    643,
    645,
    3,
    100,
    50,
    0,
    644,
    643,
    1,
    0,
    0,
    0,
    644,
    645,
    1,
    0,
    0,
    0,
    645,
    658,
    1,
    0,
    0,
    0,
    646,
    658,
    5,
    30,
    0,
    0,
    647,
    658,
    5,
    39,
    0,
    0,
    648,
    658,
    5,
    40,
    0,
    0,
    649,
    654,
    5,
    36,
    0,
    0,
    650,
    651,
    5,
    54,
    0,
    0,
    651,
    652,
    3,
    92,
    46,
    0,
    652,
    653,
    5,
    55,
    0,
    0,
    653,
    655,
    1,
    0,
    0,
    0,
    654,
    650,
    1,
    0,
    0,
    0,
    654,
    655,
    1,
    0,
    0,
    0,
    655,
    658,
    1,
    0,
    0,
    0,
    656,
    658,
    5,
    41,
    0,
    0,
    657,
    626,
    1,
    0,
    0,
    0,
    657,
    630,
    1,
    0,
    0,
    0,
    657,
    634,
    1,
    0,
    0,
    0,
    657,
    638,
    1,
    0,
    0,
    0,
    657,
    642,
    1,
    0,
    0,
    0,
    657,
    646,
    1,
    0,
    0,
    0,
    657,
    647,
    1,
    0,
    0,
    0,
    657,
    648,
    1,
    0,
    0,
    0,
    657,
    649,
    1,
    0,
    0,
    0,
    657,
    656,
    1,
    0,
    0,
    0,
    658,
    93,
    1,
    0,
    0,
    0,
    659,
    661,
    5,
    28,
    0,
    0,
    660,
    662,
    3,
    100,
    50,
    0,
    661,
    660,
    1,
    0,
    0,
    0,
    661,
    662,
    1,
    0,
    0,
    0,
    662,
    95,
    1,
    0,
    0,
    0,
    663,
    664,
    5,
    37,
    0,
    0,
    664,
    665,
    5,
    54,
    0,
    0,
    665,
    666,
    3,
    92,
    46,
    0,
    666,
    667,
    5,
    63,
    0,
    0,
    667,
    668,
    3,
    120,
    60,
    0,
    668,
    669,
    5,
    55,
    0,
    0,
    669,
    97,
    1,
    0,
    0,
    0,
    670,
    671,
    7,
    8,
    0,
    0,
    671,
    672,
    5,
    37,
    0,
    0,
    672,
    673,
    5,
    54,
    0,
    0,
    673,
    674,
    3,
    92,
    46,
    0,
    674,
    679,
    5,
    63,
    0,
    0,
    675,
    680,
    3,
    120,
    60,
    0,
    676,
    677,
    5,
    47,
    0,
    0,
    677,
    678,
    5,
    64,
    0,
    0,
    678,
    680,
    3,
    70,
    35,
    0,
    679,
    675,
    1,
    0,
    0,
    0,
    679,
    676,
    1,
    0,
    0,
    0,
    680,
    681,
    1,
    0,
    0,
    0,
    681,
    682,
    5,
    55,
    0,
    0,
    682,
    99,
    1,
    0,
    0,
    0,
    683,
    684,
    5,
    54,
    0,
    0,
    684,
    685,
    3,
    70,
    35,
    0,
    685,
    686,
    5,
    55,
    0,
    0,
    686,
    101,
    1,
    0,
    0,
    0,
    687,
    688,
    7,
    9,
    0,
    0,
    688,
    103,
    1,
    0,
    0,
    0,
    689,
    692,
    3,
    70,
    35,
    0,
    690,
    692,
    3,
    112,
    56,
    0,
    691,
    689,
    1,
    0,
    0,
    0,
    691,
    690,
    1,
    0,
    0,
    0,
    692,
    105,
    1,
    0,
    0,
    0,
    693,
    694,
    7,
    10,
    0,
    0,
    694,
    107,
    1,
    0,
    0,
    0,
    695,
    698,
    3,
    86,
    43,
    0,
    696,
    698,
    5,
    92,
    0,
    0,
    697,
    695,
    1,
    0,
    0,
    0,
    697,
    696,
    1,
    0,
    0,
    0,
    698,
    109,
    1,
    0,
    0,
    0,
    699,
    706,
    3,
    92,
    46,
    0,
    700,
    706,
    3,
    98,
    49,
    0,
    701,
    703,
    5,
    29,
    0,
    0,
    702,
    704,
    3,
    100,
    50,
    0,
    703,
    702,
    1,
    0,
    0,
    0,
    703,
    704,
    1,
    0,
    0,
    0,
    704,
    706,
    1,
    0,
    0,
    0,
    705,
    699,
    1,
    0,
    0,
    0,
    705,
    700,
    1,
    0,
    0,
    0,
    705,
    701,
    1,
    0,
    0,
    0,
    706,
    111,
    1,
    0,
    0,
    0,
    707,
    708,
    3,
    92,
    46,
    0,
    708,
    709,
    5,
    91,
    0,
    0,
    709,
    722,
    1,
    0,
    0,
    0,
    710,
    711,
    3,
    94,
    47,
    0,
    711,
    712,
    5,
    91,
    0,
    0,
    712,
    722,
    1,
    0,
    0,
    0,
    713,
    714,
    7,
    1,
    0,
    0,
    714,
    716,
    5,
    91,
    0,
    0,
    715,
    717,
    3,
    100,
    50,
    0,
    716,
    715,
    1,
    0,
    0,
    0,
    716,
    717,
    1,
    0,
    0,
    0,
    717,
    722,
    1,
    0,
    0,
    0,
    718,
    719,
    3,
    98,
    49,
    0,
    719,
    720,
    5,
    91,
    0,
    0,
    720,
    722,
    1,
    0,
    0,
    0,
    721,
    707,
    1,
    0,
    0,
    0,
    721,
    710,
    1,
    0,
    0,
    0,
    721,
    713,
    1,
    0,
    0,
    0,
    721,
    718,
    1,
    0,
    0,
    0,
    722,
    113,
    1,
    0,
    0,
    0,
    723,
    728,
    3,
    112,
    56,
    0,
    724,
    725,
    5,
    63,
    0,
    0,
    725,
    727,
    3,
    112,
    56,
    0,
    726,
    724,
    1,
    0,
    0,
    0,
    727,
    730,
    1,
    0,
    0,
    0,
    728,
    726,
    1,
    0,
    0,
    0,
    728,
    729,
    1,
    0,
    0,
    0,
    729,
    732,
    1,
    0,
    0,
    0,
    730,
    728,
    1,
    0,
    0,
    0,
    731,
    733,
    5,
    63,
    0,
    0,
    732,
    731,
    1,
    0,
    0,
    0,
    732,
    733,
    1,
    0,
    0,
    0,
    733,
    115,
    1,
    0,
    0,
    0,
    734,
    739,
    3,
    104,
    52,
    0,
    735,
    736,
    5,
    63,
    0,
    0,
    736,
    738,
    3,
    104,
    52,
    0,
    737,
    735,
    1,
    0,
    0,
    0,
    738,
    741,
    1,
    0,
    0,
    0,
    739,
    737,
    1,
    0,
    0,
    0,
    739,
    740,
    1,
    0,
    0,
    0,
    740,
    743,
    1,
    0,
    0,
    0,
    741,
    739,
    1,
    0,
    0,
    0,
    742,
    744,
    5,
    63,
    0,
    0,
    743,
    742,
    1,
    0,
    0,
    0,
    743,
    744,
    1,
    0,
    0,
    0,
    744,
    117,
    1,
    0,
    0,
    0,
    745,
    750,
    3,
    106,
    53,
    0,
    746,
    747,
    5,
    63,
    0,
    0,
    747,
    749,
    3,
    106,
    53,
    0,
    748,
    746,
    1,
    0,
    0,
    0,
    749,
    752,
    1,
    0,
    0,
    0,
    750,
    748,
    1,
    0,
    0,
    0,
    750,
    751,
    1,
    0,
    0,
    0,
    751,
    754,
    1,
    0,
    0,
    0,
    752,
    750,
    1,
    0,
    0,
    0,
    753,
    755,
    5,
    63,
    0,
    0,
    754,
    753,
    1,
    0,
    0,
    0,
    754,
    755,
    1,
    0,
    0,
    0,
    755,
    119,
    1,
    0,
    0,
    0,
    756,
    761,
    3,
    70,
    35,
    0,
    757,
    758,
    5,
    63,
    0,
    0,
    758,
    760,
    3,
    70,
    35,
    0,
    759,
    757,
    1,
    0,
    0,
    0,
    760,
    763,
    1,
    0,
    0,
    0,
    761,
    759,
    1,
    0,
    0,
    0,
    761,
    762,
    1,
    0,
    0,
    0,
    762,
    765,
    1,
    0,
    0,
    0,
    763,
    761,
    1,
    0,
    0,
    0,
    764,
    766,
    5,
    63,
    0,
    0,
    765,
    764,
    1,
    0,
    0,
    0,
    765,
    766,
    1,
    0,
    0,
    0,
    766,
    121,
    1,
    0,
    0,
    0,
    767,
    772,
    5,
    91,
    0,
    0,
    768,
    769,
    5,
    63,
    0,
    0,
    769,
    771,
    5,
    91,
    0,
    0,
    770,
    768,
    1,
    0,
    0,
    0,
    771,
    774,
    1,
    0,
    0,
    0,
    772,
    770,
    1,
    0,
    0,
    0,
    772,
    773,
    1,
    0,
    0,
    0,
    773,
    776,
    1,
    0,
    0,
    0,
    774,
    772,
    1,
    0,
    0,
    0,
    775,
    777,
    5,
    63,
    0,
    0,
    776,
    775,
    1,
    0,
    0,
    0,
    776,
    777,
    1,
    0,
    0,
    0,
    777,
    123,
    1,
    0,
    0,
    0,
    778,
    783,
    3,
    108,
    54,
    0,
    779,
    780,
    5,
    63,
    0,
    0,
    780,
    782,
    3,
    108,
    54,
    0,
    781,
    779,
    1,
    0,
    0,
    0,
    782,
    785,
    1,
    0,
    0,
    0,
    783,
    781,
    1,
    0,
    0,
    0,
    783,
    784,
    1,
    0,
    0,
    0,
    784,
    787,
    1,
    0,
    0,
    0,
    785,
    783,
    1,
    0,
    0,
    0,
    786,
    788,
    5,
    63,
    0,
    0,
    787,
    786,
    1,
    0,
    0,
    0,
    787,
    788,
    1,
    0,
    0,
    0,
    788,
    125,
    1,
    0,
    0,
    0,
    789,
    794,
    3,
    110,
    55,
    0,
    790,
    791,
    5,
    63,
    0,
    0,
    791,
    793,
    3,
    110,
    55,
    0,
    792,
    790,
    1,
    0,
    0,
    0,
    793,
    796,
    1,
    0,
    0,
    0,
    794,
    792,
    1,
    0,
    0,
    0,
    794,
    795,
    1,
    0,
    0,
    0,
    795,
    798,
    1,
    0,
    0,
    0,
    796,
    794,
    1,
    0,
    0,
    0,
    797,
    799,
    5,
    63,
    0,
    0,
    798,
    797,
    1,
    0,
    0,
    0,
    798,
    799,
    1,
    0,
    0,
    0,
    799,
    127,
    1,
    0,
    0,
    0,
    95,
    129,
    134,
    147,
    178,
    180,
    184,
    190,
    200,
    221,
    231,
    242,
    247,
    259,
    265,
    272,
    279,
    285,
    288,
    291,
    299,
    305,
    308,
    311,
    314,
    317,
    322,
    338,
    343,
    357,
    365,
    377,
    381,
    389,
    393,
    401,
    404,
    413,
    423,
    431,
    434,
    438,
    442,
    455,
    469,
    473,
    510,
    512,
    520,
    526,
    532,
    536,
    540,
    548,
    552,
    559,
    564,
    568,
    572,
    580,
    585,
    589,
    593,
    595,
    603,
    620,
    622,
    628,
    632,
    636,
    640,
    644,
    654,
    657,
    661,
    679,
    691,
    697,
    703,
    705,
    716,
    721,
    728,
    732,
    739,
    743,
    750,
    754,
    761,
    765,
    772,
    776,
    783,
    787,
    794,
    798,
  ];

  static final ATN _ATN = ATNDeserializer().deserialize(_serializedATN);
}

class ProgramContext extends ParserRuleContext {
  TerminalNode? EOF() => getToken(OpenQASM3Parser.TOKEN_EOF, 0);
  VersionContext? version() => getRuleContext<VersionContext>(0);
  List<StatementContext> statements() => getRuleContexts<StatementContext>();
  StatementContext? statement(int i) => getRuleContext<StatementContext>(i);
  ProgramContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_program;
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
  TerminalNode? VersionSpecifier() =>
      getToken(OpenQASM3Parser.TOKEN_VersionSpecifier, 0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  VersionContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_version;
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
  AliasDeclarationStatementContext? aliasDeclarationStatement() =>
      getRuleContext<AliasDeclarationStatementContext>(0);
  AssignmentStatementContext? assignmentStatement() =>
      getRuleContext<AssignmentStatementContext>(0);
  BarrierStatementContext? barrierStatement() =>
      getRuleContext<BarrierStatementContext>(0);
  BoxStatementContext? boxStatement() => getRuleContext<BoxStatementContext>(0);
  BreakStatementContext? breakStatement() =>
      getRuleContext<BreakStatementContext>(0);
  CalStatementContext? calStatement() => getRuleContext<CalStatementContext>(0);
  CalibrationGrammarStatementContext? calibrationGrammarStatement() =>
      getRuleContext<CalibrationGrammarStatementContext>(0);
  ClassicalDeclarationStatementContext? classicalDeclarationStatement() =>
      getRuleContext<ClassicalDeclarationStatementContext>(0);
  ConstDeclarationStatementContext? constDeclarationStatement() =>
      getRuleContext<ConstDeclarationStatementContext>(0);
  ContinueStatementContext? continueStatement() =>
      getRuleContext<ContinueStatementContext>(0);
  DefStatementContext? defStatement() => getRuleContext<DefStatementContext>(0);
  DefcalStatementContext? defcalStatement() =>
      getRuleContext<DefcalStatementContext>(0);
  DelayStatementContext? delayStatement() =>
      getRuleContext<DelayStatementContext>(0);
  EndStatementContext? endStatement() => getRuleContext<EndStatementContext>(0);
  ExpressionStatementContext? expressionStatement() =>
      getRuleContext<ExpressionStatementContext>(0);
  ExternStatementContext? externStatement() =>
      getRuleContext<ExternStatementContext>(0);
  ForStatementContext? forStatement() => getRuleContext<ForStatementContext>(0);
  GateCallStatementContext? gateCallStatement() =>
      getRuleContext<GateCallStatementContext>(0);
  GateStatementContext? gateStatement() =>
      getRuleContext<GateStatementContext>(0);
  IfStatementContext? ifStatement() => getRuleContext<IfStatementContext>(0);
  IncludeStatementContext? includeStatement() =>
      getRuleContext<IncludeStatementContext>(0);
  IoDeclarationStatementContext? ioDeclarationStatement() =>
      getRuleContext<IoDeclarationStatementContext>(0);
  MeasureArrowAssignmentStatementContext? measureArrowAssignmentStatement() =>
      getRuleContext<MeasureArrowAssignmentStatementContext>(0);
  OldStyleDeclarationStatementContext? oldStyleDeclarationStatement() =>
      getRuleContext<OldStyleDeclarationStatementContext>(0);
  QuantumDeclarationStatementContext? quantumDeclarationStatement() =>
      getRuleContext<QuantumDeclarationStatementContext>(0);
  ResetStatementContext? resetStatement() =>
      getRuleContext<ResetStatementContext>(0);
  ReturnStatementContext? returnStatement() =>
      getRuleContext<ReturnStatementContext>(0);
  WhileStatementContext? whileStatement() =>
      getRuleContext<WhileStatementContext>(0);
  List<AnnotationContext> annotations() => getRuleContexts<AnnotationContext>();
  AnnotationContext? annotation(int i) => getRuleContext<AnnotationContext>(i);
  StatementContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_statement;
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
  TerminalNode? AnnotationKeyword() =>
      getToken(OpenQASM3Parser.TOKEN_AnnotationKeyword, 0);
  TerminalNode? RemainingLineContent() =>
      getToken(OpenQASM3Parser.TOKEN_RemainingLineContent, 0);
  AnnotationContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_annotation;
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
  ScopeContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_scope;
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
  TerminalNode? RemainingLineContent() =>
      getToken(OpenQASM3Parser.TOKEN_RemainingLineContent, 0);
  PragmaContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_pragma;
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
  StatementOrScopeContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_statementOrScope;
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
  TerminalNode? DEFCALGRAMMAR() =>
      getToken(OpenQASM3Parser.TOKEN_DEFCALGRAMMAR, 0);
  TerminalNode? StringLiteral() =>
      getToken(OpenQASM3Parser.TOKEN_StringLiteral, 0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  CalibrationGrammarStatementContext([
    ParserRuleContext? parent,
    int? invokingState,
  ]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_calibrationGrammarStatement;
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
  TerminalNode? StringLiteral() =>
      getToken(OpenQASM3Parser.TOKEN_StringLiteral, 0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  IncludeStatementContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_includeStatement;
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
  BreakStatementContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_breakStatement;
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
  ContinueStatementContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_continueStatement;
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
  EndStatementContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_endStatement;
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
  StatementOrScopeContext? statementOrScope() =>
      getRuleContext<StatementOrScopeContext>(0);
  SetExpressionContext? setExpression() =>
      getRuleContext<SetExpressionContext>(0);
  TerminalNode? LBRACKET() => getToken(OpenQASM3Parser.TOKEN_LBRACKET, 0);
  RangeExpressionContext? rangeExpression() =>
      getRuleContext<RangeExpressionContext>(0);
  TerminalNode? RBRACKET() => getToken(OpenQASM3Parser.TOKEN_RBRACKET, 0);
  ExpressionContext? expression() => getRuleContext<ExpressionContext>(0);
  ScalarTypeContext? scalarType() => getRuleContext<ScalarTypeContext>(0);
  ForStatementContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_forStatement;
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
  List<StatementOrScopeContext> statementOrScopes() =>
      getRuleContexts<StatementOrScopeContext>();
  StatementOrScopeContext? statementOrScope(int i) =>
      getRuleContext<StatementOrScopeContext>(i);
  TerminalNode? ELSE() => getToken(OpenQASM3Parser.TOKEN_ELSE, 0);
  IfStatementContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_ifStatement;
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
  MeasureExpressionContext? measureExpression() =>
      getRuleContext<MeasureExpressionContext>(0);
  ReturnStatementContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_returnStatement;
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
  StatementOrScopeContext? statementOrScope() =>
      getRuleContext<StatementOrScopeContext>(0);
  WhileStatementContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_whileStatement;
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
  GateOperandListContext? gateOperandList() =>
      getRuleContext<GateOperandListContext>(0);
  BarrierStatementContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_barrierStatement;
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
  BoxStatementContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_boxStatement;
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
  GateOperandListContext? gateOperandList() =>
      getRuleContext<GateOperandListContext>(0);
  DelayStatementContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_delayStatement;
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
  GateOperandListContext? gateOperandList() =>
      getRuleContext<GateOperandListContext>(0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  List<GateModifierContext> gateModifiers() =>
      getRuleContexts<GateModifierContext>();
  GateModifierContext? gateModifier(int i) =>
      getRuleContext<GateModifierContext>(i);
  TerminalNode? LPAREN() => getToken(OpenQASM3Parser.TOKEN_LPAREN, 0);
  TerminalNode? RPAREN() => getToken(OpenQASM3Parser.TOKEN_RPAREN, 0);
  DesignatorContext? designator() => getRuleContext<DesignatorContext>(0);
  ExpressionListContext? expressionList() =>
      getRuleContext<ExpressionListContext>(0);
  TerminalNode? GPHASE() => getToken(OpenQASM3Parser.TOKEN_GPHASE, 0);
  GateCallStatementContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_gateCallStatement;
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
  MeasureExpressionContext? measureExpression() =>
      getRuleContext<MeasureExpressionContext>(0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  TerminalNode? ARROW() => getToken(OpenQASM3Parser.TOKEN_ARROW, 0);
  IndexedIdentifierContext? indexedIdentifier() =>
      getRuleContext<IndexedIdentifierContext>(0);
  MeasureArrowAssignmentStatementContext([
    ParserRuleContext? parent,
    int? invokingState,
  ]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_measureArrowAssignmentStatement;
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
  ResetStatementContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_resetStatement;
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
  AliasExpressionContext? aliasExpression() =>
      getRuleContext<AliasExpressionContext>(0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  AliasDeclarationStatementContext([
    ParserRuleContext? parent,
    int? invokingState,
  ]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_aliasDeclarationStatement;
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
  DeclarationExpressionContext? declarationExpression() =>
      getRuleContext<DeclarationExpressionContext>(0);
  ClassicalDeclarationStatementContext([
    ParserRuleContext? parent,
    int? invokingState,
  ]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_classicalDeclarationStatement;
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
  DeclarationExpressionContext? declarationExpression() =>
      getRuleContext<DeclarationExpressionContext>(0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  ConstDeclarationStatementContext([
    ParserRuleContext? parent,
    int? invokingState,
  ]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_constDeclarationStatement;
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
  IoDeclarationStatementContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_ioDeclarationStatement;
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
  OldStyleDeclarationStatementContext([
    ParserRuleContext? parent,
    int? invokingState,
  ]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_oldStyleDeclarationStatement;
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
  QuantumDeclarationStatementContext([
    ParserRuleContext? parent,
    int? invokingState,
  ]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_quantumDeclarationStatement;
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
  ArgumentDefinitionListContext? argumentDefinitionList() =>
      getRuleContext<ArgumentDefinitionListContext>(0);
  ReturnSignatureContext? returnSignature() =>
      getRuleContext<ReturnSignatureContext>(0);
  DefStatementContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_defStatement;
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
  ExternArgumentListContext? externArgumentList() =>
      getRuleContext<ExternArgumentListContext>(0);
  ReturnSignatureContext? returnSignature() =>
      getRuleContext<ReturnSignatureContext>(0);
  ExternStatementContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_externStatement;
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
  List<IdentifierListContext> identifierLists() =>
      getRuleContexts<IdentifierListContext>();
  IdentifierListContext? identifierList(int i) =>
      getRuleContext<IdentifierListContext>(i);
  TerminalNode? LPAREN() => getToken(OpenQASM3Parser.TOKEN_LPAREN, 0);
  TerminalNode? RPAREN() => getToken(OpenQASM3Parser.TOKEN_RPAREN, 0);
  GateStatementContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_gateStatement;
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
  IndexedIdentifierContext? indexedIdentifier() =>
      getRuleContext<IndexedIdentifierContext>(0);
  TerminalNode? SEMICOLON() => getToken(OpenQASM3Parser.TOKEN_SEMICOLON, 0);
  TerminalNode? EQUALS() => getToken(OpenQASM3Parser.TOKEN_EQUALS, 0);
  TerminalNode? CompoundAssignmentOperator() =>
      getToken(OpenQASM3Parser.TOKEN_CompoundAssignmentOperator, 0);
  ExpressionContext? expression() => getRuleContext<ExpressionContext>(0);
  MeasureExpressionContext? measureExpression() =>
      getRuleContext<MeasureExpressionContext>(0);
  AssignmentStatementContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_assignmentStatement;
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
  ExpressionStatementContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_expressionStatement;
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
  TerminalNode? CalibrationBlock() =>
      getToken(OpenQASM3Parser.TOKEN_CalibrationBlock, 0);
  CalStatementContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_calStatement;
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
  DefcalOperandListContext? defcalOperandList() =>
      getRuleContext<DefcalOperandListContext>(0);
  TerminalNode? LBRACE() => getToken(OpenQASM3Parser.TOKEN_LBRACE, 0);
  TerminalNode? RBRACE() => getToken(OpenQASM3Parser.TOKEN_RBRACE, 0);
  TerminalNode? LPAREN() => getToken(OpenQASM3Parser.TOKEN_LPAREN, 0);
  TerminalNode? RPAREN() => getToken(OpenQASM3Parser.TOKEN_RPAREN, 0);
  ReturnSignatureContext? returnSignature() =>
      getRuleContext<ReturnSignatureContext>(0);
  TerminalNode? CalibrationBlock() =>
      getToken(OpenQASM3Parser.TOKEN_CalibrationBlock, 0);
  DefcalArgumentDefinitionListContext? defcalArgumentDefinitionList() =>
      getRuleContext<DefcalArgumentDefinitionListContext>(0);
  DefcalStatementContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_defcalStatement;
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
  ExpressionContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
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
  List<TerminalNode> DOUBLE_PLUSs() =>
      getTokens(OpenQASM3Parser.TOKEN_DOUBLE_PLUS);
  TerminalNode? DOUBLE_PLUS(int i) =>
      getToken(OpenQASM3Parser.TOKEN_DOUBLE_PLUS, i);
  AliasExpressionContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_aliasExpression;
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
  MeasureExpressionContext? measureExpression() =>
      getRuleContext<MeasureExpressionContext>(0);
  DeclarationExpressionContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_declarationExpression;
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
  MeasureExpressionContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_measureExpression;
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
  RangeExpressionContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_rangeExpression;
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
  SetExpressionContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_setExpression;
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
  List<ArrayLiteralContext> arrayLiterals() =>
      getRuleContexts<ArrayLiteralContext>();
  ArrayLiteralContext? arrayLiteral(int i) =>
      getRuleContext<ArrayLiteralContext>(i);
  List<TerminalNode> COMMAs() => getTokens(OpenQASM3Parser.TOKEN_COMMA);
  TerminalNode? COMMA(int i) => getToken(OpenQASM3Parser.TOKEN_COMMA, i);
  ArrayLiteralContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_arrayLiteral;
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
  SetExpressionContext? setExpression() =>
      getRuleContext<SetExpressionContext>(0);
  List<ExpressionContext> expressions() => getRuleContexts<ExpressionContext>();
  ExpressionContext? expression(int i) => getRuleContext<ExpressionContext>(i);
  List<RangeExpressionContext> rangeExpressions() =>
      getRuleContexts<RangeExpressionContext>();
  RangeExpressionContext? rangeExpression(int i) =>
      getRuleContext<RangeExpressionContext>(i);
  List<TerminalNode> COMMAs() => getTokens(OpenQASM3Parser.TOKEN_COMMA);
  TerminalNode? COMMA(int i) => getToken(OpenQASM3Parser.TOKEN_COMMA, i);
  IndexOperatorContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_indexOperator;
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
  List<IndexOperatorContext> indexOperators() =>
      getRuleContexts<IndexOperatorContext>();
  IndexOperatorContext? indexOperator(int i) =>
      getRuleContext<IndexOperatorContext>(i);
  IndexedIdentifierContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_indexedIdentifier;
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
  ReturnSignatureContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_returnSignature;
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
  GateModifierContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_gateModifier;
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
  ScalarTypeContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_scalarType;
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
  QubitTypeContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_qubitType;
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
  ExpressionListContext? expressionList() =>
      getRuleContext<ExpressionListContext>(0);
  TerminalNode? RBRACKET() => getToken(OpenQASM3Parser.TOKEN_RBRACKET, 0);
  ArrayTypeContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_arrayType;
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
  ExpressionListContext? expressionList() =>
      getRuleContext<ExpressionListContext>(0);
  TerminalNode? DIM() => getToken(OpenQASM3Parser.TOKEN_DIM, 0);
  TerminalNode? EQUALS() => getToken(OpenQASM3Parser.TOKEN_EQUALS, 0);
  ExpressionContext? expression() => getRuleContext<ExpressionContext>(0);
  ArrayReferenceTypeContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_arrayReferenceType;
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
  DesignatorContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_designator;
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
  DefcalTargetContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_defcalTarget;
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
  ArgumentDefinitionContext? argumentDefinition() =>
      getRuleContext<ArgumentDefinitionContext>(0);
  DefcalArgumentDefinitionContext([
    ParserRuleContext? parent,
    int? invokingState,
  ]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_defcalArgumentDefinition;
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
  TerminalNode? HardwareQubit() =>
      getToken(OpenQASM3Parser.TOKEN_HardwareQubit, 0);
  TerminalNode? Identifier() => getToken(OpenQASM3Parser.TOKEN_Identifier, 0);
  DefcalOperandContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_defcalOperand;
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
  IndexedIdentifierContext? indexedIdentifier() =>
      getRuleContext<IndexedIdentifierContext>(0);
  TerminalNode? HardwareQubit() =>
      getToken(OpenQASM3Parser.TOKEN_HardwareQubit, 0);
  GateOperandContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_gateOperand;
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
  ArrayReferenceTypeContext? arrayReferenceType() =>
      getRuleContext<ArrayReferenceTypeContext>(0);
  TerminalNode? CREG() => getToken(OpenQASM3Parser.TOKEN_CREG, 0);
  DesignatorContext? designator() => getRuleContext<DesignatorContext>(0);
  ExternArgumentContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_externArgument;
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
  ArrayReferenceTypeContext? arrayReferenceType() =>
      getRuleContext<ArrayReferenceTypeContext>(0);
  ArgumentDefinitionContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_argumentDefinition;
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
  List<ArgumentDefinitionContext> argumentDefinitions() =>
      getRuleContexts<ArgumentDefinitionContext>();
  ArgumentDefinitionContext? argumentDefinition(int i) =>
      getRuleContext<ArgumentDefinitionContext>(i);
  List<TerminalNode> COMMAs() => getTokens(OpenQASM3Parser.TOKEN_COMMA);
  TerminalNode? COMMA(int i) => getToken(OpenQASM3Parser.TOKEN_COMMA, i);
  ArgumentDefinitionListContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_argumentDefinitionList;
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
  List<DefcalArgumentDefinitionContext> defcalArgumentDefinitions() =>
      getRuleContexts<DefcalArgumentDefinitionContext>();
  DefcalArgumentDefinitionContext? defcalArgumentDefinition(int i) =>
      getRuleContext<DefcalArgumentDefinitionContext>(i);
  List<TerminalNode> COMMAs() => getTokens(OpenQASM3Parser.TOKEN_COMMA);
  TerminalNode? COMMA(int i) => getToken(OpenQASM3Parser.TOKEN_COMMA, i);
  DefcalArgumentDefinitionListContext([
    ParserRuleContext? parent,
    int? invokingState,
  ]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_defcalArgumentDefinitionList;
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
  List<DefcalOperandContext> defcalOperands() =>
      getRuleContexts<DefcalOperandContext>();
  DefcalOperandContext? defcalOperand(int i) =>
      getRuleContext<DefcalOperandContext>(i);
  List<TerminalNode> COMMAs() => getTokens(OpenQASM3Parser.TOKEN_COMMA);
  TerminalNode? COMMA(int i) => getToken(OpenQASM3Parser.TOKEN_COMMA, i);
  DefcalOperandListContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_defcalOperandList;
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
  ExpressionListContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_expressionList;
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
  List<TerminalNode> Identifiers() =>
      getTokens(OpenQASM3Parser.TOKEN_Identifier);
  TerminalNode? Identifier(int i) =>
      getToken(OpenQASM3Parser.TOKEN_Identifier, i);
  List<TerminalNode> COMMAs() => getTokens(OpenQASM3Parser.TOKEN_COMMA);
  TerminalNode? COMMA(int i) => getToken(OpenQASM3Parser.TOKEN_COMMA, i);
  IdentifierListContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_identifierList;
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
  List<GateOperandContext> gateOperands() =>
      getRuleContexts<GateOperandContext>();
  GateOperandContext? gateOperand(int i) =>
      getRuleContext<GateOperandContext>(i);
  List<TerminalNode> COMMAs() => getTokens(OpenQASM3Parser.TOKEN_COMMA);
  TerminalNode? COMMA(int i) => getToken(OpenQASM3Parser.TOKEN_COMMA, i);
  GateOperandListContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_gateOperandList;
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
  List<ExternArgumentContext> externArguments() =>
      getRuleContexts<ExternArgumentContext>();
  ExternArgumentContext? externArgument(int i) =>
      getRuleContext<ExternArgumentContext>(i);
  List<TerminalNode> COMMAs() => getTokens(OpenQASM3Parser.TOKEN_COMMA);
  TerminalNode? COMMA(int i) => getToken(OpenQASM3Parser.TOKEN_COMMA, i);
  ExternArgumentListContext([ParserRuleContext? parent, int? invokingState])
    : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_externArgumentList;
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
  BitwiseXorExpressionContext(ExpressionContext ctx) {
    copyFrom(ctx);
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
  AdditiveExpressionContext(ExpressionContext ctx) {
    copyFrom(ctx);
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
  DurationofExpressionContext(ExpressionContext ctx) {
    copyFrom(ctx);
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
  ParenthesisExpressionContext(ExpressionContext ctx) {
    copyFrom(ctx);
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
  TerminalNode? ComparisonOperator() =>
      getToken(OpenQASM3Parser.TOKEN_ComparisonOperator, 0);
  ComparisonExpressionContext(ExpressionContext ctx) {
    copyFrom(ctx);
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
  MultiplicativeExpressionContext(ExpressionContext ctx) {
    copyFrom(ctx);
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
  LogicalOrExpressionContext(ExpressionContext ctx) {
    copyFrom(ctx);
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
  CastExpressionContext(ExpressionContext ctx) {
    copyFrom(ctx);
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
  TerminalNode? DOUBLE_ASTERISK() =>
      getToken(OpenQASM3Parser.TOKEN_DOUBLE_ASTERISK, 0);
  PowerExpressionContext(ExpressionContext ctx) {
    copyFrom(ctx);
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
  BitwiseOrExpressionContext(ExpressionContext ctx) {
    copyFrom(ctx);
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
  ExpressionListContext? expressionList() =>
      getRuleContext<ExpressionListContext>(0);
  CallExpressionContext(ExpressionContext ctx) {
    copyFrom(ctx);
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
  TerminalNode? BitshiftOperator() =>
      getToken(OpenQASM3Parser.TOKEN_BitshiftOperator, 0);
  BitshiftExpressionContext(ExpressionContext ctx) {
    copyFrom(ctx);
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
  BitwiseAndExpressionContext(ExpressionContext ctx) {
    copyFrom(ctx);
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
  TerminalNode? EqualityOperator() =>
      getToken(OpenQASM3Parser.TOKEN_EqualityOperator, 0);
  EqualityExpressionContext(ExpressionContext ctx) {
    copyFrom(ctx);
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
  TerminalNode? DOUBLE_AMPERSAND() =>
      getToken(OpenQASM3Parser.TOKEN_DOUBLE_AMPERSAND, 0);
  LogicalAndExpressionContext(ExpressionContext ctx) {
    copyFrom(ctx);
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
  IndexOperatorContext? indexOperator() =>
      getRuleContext<IndexOperatorContext>(0);
  IndexExpressionContext(ExpressionContext ctx) {
    copyFrom(ctx);
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
  TerminalNode? EXCLAMATION_POINT() =>
      getToken(OpenQASM3Parser.TOKEN_EXCLAMATION_POINT, 0);
  TerminalNode? MINUS() => getToken(OpenQASM3Parser.TOKEN_MINUS, 0);
  UnaryExpressionContext(ExpressionContext ctx) {
    copyFrom(ctx);
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
  TerminalNode? BinaryIntegerLiteral() =>
      getToken(OpenQASM3Parser.TOKEN_BinaryIntegerLiteral, 0);
  TerminalNode? OctalIntegerLiteral() =>
      getToken(OpenQASM3Parser.TOKEN_OctalIntegerLiteral, 0);
  TerminalNode? DecimalIntegerLiteral() =>
      getToken(OpenQASM3Parser.TOKEN_DecimalIntegerLiteral, 0);
  TerminalNode? HexIntegerLiteral() =>
      getToken(OpenQASM3Parser.TOKEN_HexIntegerLiteral, 0);
  TerminalNode? FloatLiteral() =>
      getToken(OpenQASM3Parser.TOKEN_FloatLiteral, 0);
  TerminalNode? ImaginaryLiteral() =>
      getToken(OpenQASM3Parser.TOKEN_ImaginaryLiteral, 0);
  TerminalNode? BooleanLiteral() =>
      getToken(OpenQASM3Parser.TOKEN_BooleanLiteral, 0);
  TerminalNode? BitstringLiteral() =>
      getToken(OpenQASM3Parser.TOKEN_BitstringLiteral, 0);
  TerminalNode? StringLiteral() =>
      getToken(OpenQASM3Parser.TOKEN_StringLiteral, 0);
  TerminalNode? TimingLiteral() =>
      getToken(OpenQASM3Parser.TOKEN_TimingLiteral, 0);
  TerminalNode? HardwareQubit() =>
      getToken(OpenQASM3Parser.TOKEN_HardwareQubit, 0);
  LiteralExpressionContext(ExpressionContext ctx) {
    copyFrom(ctx);
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
