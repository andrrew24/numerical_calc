import 'package:math_expressions/math_expressions.dart';

import '../../models/newton_model.dart';
import '../../models/simple_fixed_iter.dart';
import '../../other_methods/eval.dart';
import '../../other_methods/get_f.dart';

class Newton {
  final double eps;
  final double x;

  final String expressionString;

  List<NewtonIter> iterations = [];

  Newton({required this.eps, required this.x, required this.expressionString});

  double f(double x) {
    Expression exp = getF(expressionString);
    exp.simplify();
    return eval(exp, x);
  }

  double fdash(double x) {
    Expression exp = getF(expressionString);
    Expression expDerived = exp.derive('x');
    return eval(expDerived, x);
  }

  newton() {
    double xi = x;
    double xiplus1;
    double error = 0;
    double iter = 0;
    
    do {
        xiplus1 = xi - (f(xi) / fdash(xi));
        iterations.add(NewtonIter(
            iter: iter,
            xi: xi,
            fxi: f(xi),
            fdashxi: fdash(xi),
            error: iter == 0 ? 0 : error));
        error = ((xiplus1 - xi) / xiplus1).abs() * 100;
        xi = xiplus1;
        iter++;
    } while (error > eps);
    
    iterations.add(NewtonIter(
        iter: iter,
        xi: xi,
        fxi: f(xi),
        fdashxi: fdash(xi),
        error: error));
}

}

// void main() {
//   Newton newton =
//       Newton(eps: 0.7, x: 5, expressionString:"-0.9 * x^2 +  1.7 * x + 2.5");
//   newton.newton();

//   for (var e in newton.iterations) {
//     print(
//         "iter: ${e.iter.toStringAsFixed(0)} |xi: ${e.xi.toStringAsFixed(3)}| f(xi): ${e.fxi.toStringAsFixed(3)}| fdash(xi): ${e.fdashxi.toStringAsFixed(3)}|error: ${e.error.toStringAsFixed(3)}");
//   }
// }

