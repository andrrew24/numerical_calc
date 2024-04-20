import 'package:math_expressions/math_expressions.dart';

import '../../models/biesect_model.dart';
import '../../other_methods/eval.dart';
import '../../other_methods/get_f.dart';

class Biesection {
  final double eps;
  final double xL;
  final double xU;
  final String expressionString;

  List<BiesectIter> iterations = [];

  Biesection(
      {required this.eps,
      required this.xL,
      required this.xU,
      required this.expressionString});

  double f(double x) {
    Expression exp = getF(expressionString);
    return eval(exp, x);
  }

  biesection() {
    double xl = xL;
    double xu = xU;
    double iter = 1;
    double xr = 0;
    double xrOld = 0;
    double error = 0;

    if (f(xl) * f(xu) < 0) {
      do {
        xrOld = xr;
        xr = (xl + xu) / 2;
        error = ((xrOld - xr) / xr).abs() * 100;
        iterations.add(
          BiesectIter(
              iter: iter,
              xl: xl,
              fxl: f(xl),
              xu: xu,
              fxu: f(xu),
              xr: xr,
              fxr: f(xr),
              error: iter == 1 ? 0 : error),
        );

        if (f(xl) * f(xr) > 0) {
          xl = xr;
        } else {
          xu = xr;
        }

        iter++;
      } while (error > eps);
    } else {
      return false;
    }
  }
}

// void main() {
//   Biesection biesection = Biesection(
//       eps: 1, xL: 0, xU: 1, expressionString: "4 * x^3 - 6 * x^2 + 7*x - 2.3");
//   biesection.biesection();
//   for (var e in biesection.iterations) {}
// }


// for (var e in biesection.iterations) {
//           print(
//               "iter: ${e.iter.toStringAsFixed(3)} |xl: ${e.xl.toStringAsFixed(3)}| f(xl): ${e.fxl.toStringAsFixed(3)}|xu: ${e.xu.toStringAsFixed(3)}|f(xu): ${e.fxu.toStringAsFixed(3)}|xr: ${e.xr.toStringAsFixed(3)}|f(xr): ${e.fxr.toStringAsFixed(3)}|error: ${e.error.toStringAsFixed(3)}");
//         }
