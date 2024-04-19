import 'package:math_expressions/math_expressions.dart';



Expression getF(String expString) {
  Parser parser = Parser();
  Expression expression = parser.parse(expString);
  return expression;
}


