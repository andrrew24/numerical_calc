import 'package:math_expressions/math_expressions.dart';

import '../../models/secant_model.dart';
import 'other/eval.dart';
import 'other/get_f.dart';

class Secant {
  final double eps;
  final double xI;
  final double xIminus1;
  final String expressionString;

  Secant(
      {required this.eps,
      required this.xI,
      required this.xIminus1,
      required this.expressionString});

  List<SecantIter> iterations = [];

  double f(double x) {
    Expression exp = getF(expressionString);
    exp.simplify();
    return eval(exp, x);
  }

  secant() {
    double xi = xI;
    double xiplus1 = 0;
    double ximinus1 = xIminus1;
    double error = 0;
    double iter = 0;

    do {
      xiplus1 = xi - ((f(xi) * (ximinus1 - xi)) / (f(ximinus1) - f(xi)));
      iterations.add(SecantIter(
          iter: iter,
          ximinus1: ximinus1,
          fximinus1: f(ximinus1),
          xi: xi,
          fxi: f(xi),
          error: iter == 0 ? 0 : error));
      error = ((xiplus1 - xi) / xiplus1).abs() * 100;
      ximinus1 = xi;
      xi = xiplus1;
      iter++;
    } while (error > eps);
    iterations.add(SecantIter(
        iter: iter,
        ximinus1: ximinus1,
        fximinus1: f(ximinus1),
        xi: xi,
        fxi: f(xi),
        error: error));
  }
}

// void main() {
//   Secant secant = Secant(
//       eps: 0.5,
//       xI: 3.5,
//       xIminus1: 2.5,
//       expressionString: "0.95 * x^3 - 5.9 * x^2 + 10.9 * x - 6");
//   secant.secant();
//   for (var e in secant.iterations) {
//     print(
//         "iter: ${e.iter.toStringAsFixed(0)} |ximinus1: ${e.ximinus1.toStringAsFixed(3)}| f(ximinus1): ${e.fximinus1.toStringAsFixed(3)}|xi: ${e.xi.toStringAsFixed(3)}|f(xi): ${e.fxi.toStringAsFixed(3)}|error: ${e.error.toStringAsFixed(3)}");
//   }
// }
