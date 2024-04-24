import 'package:math_expressions/math_expressions.dart';
import 'package:numerical_calc/models/false_position_model.dart';

import 'other/eval.dart';
import 'other/get_f.dart';

class FalsePosition {
  final double eps;
  final double xL;
  final double xU;
  final String expressionString;

  List<FalsePositionIter> iterations = [];

  FalsePosition(
      {required this.eps,
      required this.xL,
      required this.xU,
      required this.expressionString});

  double f(double x) {
    Expression exp = getF(expressionString);
    return eval(exp, x);
  }

  falseposition() {
    double xl = xL;
    double xu = xU;
    double iter = 1;
    double xr = 0;
    double xrOld = 0;
    double error = 0;

    if (f(xl) * f(xu) < 0) {
      do {
        xrOld = xr;
        xr = xu - ((f(xu) * (xl - xu)) / (f(xl) - f(xu)));
        error = ((xrOld - xr) / xr).abs() * 100;
        iterations.add(
          FalsePositionIter(
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
//   FalsePosition falsePosition = FalsePosition(
//       eps: 1,
//       xL: -1,
//       xU: 0,
//       expressionString: "-13 - 20 * x + 19 * x^2 - 3 * x^3");
//   falsePosition.falseposition();
//   for (var e in falsePosition.iterations) {
//     print(
//         "iter: ${e.iter.toStringAsFixed(3)} |xl: ${e.xl.toStringAsFixed(3)}| f(xl): ${e.fxl.toStringAsFixed(3)}|xu: ${e.xu.toStringAsFixed(3)}|f(xu): ${e.fxu.toStringAsFixed(3)}|xr: ${e.xr.toStringAsFixed(3)}|f(xr): ${e.fxr.toStringAsFixed(3)}|error: ${e.error.toStringAsFixed(3)}");
//   }
// }


// for (var e in biesection.iterations) {
//           print(
//               "iter: ${e.iter.toStringAsFixed(3)} |xl: ${e.xl.toStringAsFixed(3)}| f(xl): ${e.fxl.toStringAsFixed(3)}|xu: ${e.xu.toStringAsFixed(3)}|f(xu): ${e.fxu.toStringAsFixed(3)}|xr: ${e.xr.toStringAsFixed(3)}|f(xr): ${e.fxr.toStringAsFixed(3)}|error: ${e.error.toStringAsFixed(3)}");
//         }
