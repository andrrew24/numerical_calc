import 'dart:ffi';
import 'dart:math';

import 'package:numerical_calc/math/algebric/other/get_matrix_coeff.dart';

class CramerRule {
  final String eq1;
  final String eq2;
  final String eq3;

  late List<List<double>> matrix;
  late List<List<double>> coefficients = [];
  double dA = 0; // determent A
  late List<double> constants = [];
  late List<double> solutions = [];
  List<double> determinants = [];

  CramerRule({required this.eq1, required this.eq2, required this.eq3});

  getcoefficients() {
    matrix = getMatrixCoeffs(eq1, eq2, eq3);
    for (var row in matrix) {
      coefficients.add(row.sublist(0, row.length - 1));
      constants.add(row.last);
    }
  }

  solve() {
    getcoefficients();
    int n = coefficients.length;
    double detA = _determinant(coefficients);

    dA = detA;

    // print("Determinant of coefficient matrix: $detA");

    for (int i = 0; i < n; i++) {
      List<List<double>> matrix =
          List.from(coefficients.map((row) => List<double>.from(row)));
      for (int j = 0; j < n; j++) {
        matrix[j][i] = constants[j];
      }
      double detAi = _determinant(matrix);
      determinants.add(detAi);
      // print("Determinant A${i + 1}: $detAi");
      solutions.add(detAi / detA);
    }
  }

  double _determinant(List<List<double>> matrix) {
    int n = matrix.length;
    if (n == 1) {
      return matrix[0][0];
    } else {
      double det = 0;
      for (int i = 0; i < n; i++) {
        List<List<double>> minor =
            List.generate(n - 1, (index) => List<double>.filled(n - 1, 0));
        for (int j = 1; j < n; j++) {
          for (int k = 0; k < n; k++) {
            if (k < i) {
              minor[j - 1][k] = matrix[j][k];
            } else if (k > i) {
              minor[j - 1][k - 1] = matrix[j][k];
            }
          }
        }
        det += pow(-1, i) * matrix[0][i] * _determinant(minor);
      }
      return det;
    }
  }
}

void main() {
  CramerRule cramerRule =
      CramerRule(eq1: "2x+y-z=1", eq2: "5x+2y+2z=-4", eq3: "3x+y+z=5");
  cramerRule.solve();

  print("Solutions: ${cramerRule.solutions}");
  print("Determenants: ${cramerRule.determinants}");
  print("\nMatrix:");

  for (var row in cramerRule.coefficients) {
    print(row);
  }
}
