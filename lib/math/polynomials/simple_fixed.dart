import 'package:math_expressions/math_expressions.dart';

import '../../models/simple_fixed_iter.dart';
import 'other/eval.dart';
import 'other/get_f.dart';

class SimpleFixed {
  final double eps;
  final double x;

  final String expressionString;

  List<SimpleFixedIter> iterations = [];

  SimpleFixed(
      {required this.eps, required this.x, required this.expressionString});

  double f(double x) {
    Expression exp = getF(expressionString);
    exp.simplify();
    return eval(exp, x);
  }

  simplefixed() {
    double xi = x;
    double xiplus1;
    double error;
    double iter = 0;

    do {
      xiplus1 = f(xi);
      error = ((xiplus1 - xi) / xiplus1).abs() * 100;
      iterations.add(
        SimpleFixedIter(iter: iter, xi: xi, fxi: f(xi), error: error)
      );
      xi = xiplus1;
      iter++;
    } while (error >= eps);
  }
}

// void main() {
//   SimpleFixed simpleFixed =
//       SimpleFixed(eps: 0.2, x: 5, expressionString: "-x^2 + 1.8 * x + 2.5");
//   simpleFixed.simplefixed();
//   for (var e in simpleFixed.iterations) {
//     print(
//         "iter: ${e.iter.toStringAsFixed(0)} |xi: ${e.xi.toStringAsFixed(3)}| f(xi): ${e.fxi.toStringAsFixed(3)}|error: ${e.error.toStringAsFixed(3)}");
//   }
// }
