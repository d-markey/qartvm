SET __SRC_DIR__="%~dp0\..\..\lib\src\openqasm\antlr4\parser"

java -jar "%~dp0\antlr-4.12.0-complete.jar" -Dlanguage=Dart "%~dp0\OpenQASM3Lexer.g4" -o %__SRC_DIR__%

java -jar "%~dp0\antlr-4.12.0-complete.jar" -Dlanguage=Dart "%~dp0\OpenQASM3Parser.g4" -visitor -o %__SRC_DIR__%
