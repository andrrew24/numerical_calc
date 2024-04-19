import 'package:math_expressions/math_expressions.dart';

double eval(Expression exp, double a) {
  ContextModel cm = ContextModel();
  Variable x = Variable('x');
  cm.bindVariable(x, Number(a));
  double res = exp.evaluate(EvaluationType.REAL, cm);
  return res;
}
