import 'dart:math';

import 'package:numerical_calc/math/algebric/other/get_matrix_coeff.dart';

List<List<double>> gaussianEliminationWithPartialPivoting(
    List<List<double>> matrix) {
  int n = matrix.length;
  List<List<double>> abMatrix =
      List.generate(n, (index) => List<double>.from(matrix[index]));
  List<double> multipliers = List.filled(n, 0.0);

  for (int k = 0; k < n - 1; k++) {
    // Partial Pivoting
    int pivotRow = k;
    double maxAbsValue = abMatrix[k][k].abs();
    for (int i = k + 1; i < n; i++) {
      if (abMatrix[i][k].abs() > maxAbsValue) {
        maxAbsValue = abMatrix[i][k].abs();
        pivotRow = i;
      }
    }
    if (pivotRow != k) {
      // Swap rows k and pivotRow
      List<double> temp = List<double>.from(abMatrix[k]);
      abMatrix[k] = List<double>.from(abMatrix[pivotRow]);
      abMatrix[pivotRow] = List<double>.from(temp);
    }

    // Gaussian Elimination
    for (int i = k + 1; i < n; i++) {
      double pivot = abMatrix[k][k];
      if (pivot != 0) {
        double multiplier = abMatrix[i][k] / pivot;
        multipliers[i] = multiplier;
        for (int j = k; j < n + 1; j++) {
          abMatrix[i][j] -= multiplier * abMatrix[k][j];
        }
      }
    }
  }

  return abMatrix;
}

List<double> calculateMultipliers(List<List<double>> matrix) {
  int n = matrix.length;
  List<double> multipliers = List.filled(n, 0.0);

  for (int k = 0; k < n - 1; k++) {
    int pivotRow = k;
    double maxAbsValue = matrix[k][k].abs();
    for (int i = k + 1; i < n; i++) {
      if (matrix[i][k].abs() > maxAbsValue) {
        maxAbsValue = matrix[i][k].abs();
        pivotRow = i;
      }
    }
    if (pivotRow != k) {
      List<double> temp = List<double>.from(matrix[k]);
      matrix[k] = List<double>.from(matrix[pivotRow]);
      matrix[pivotRow] = List<double>.from(temp);
    }
    for (int i = k + 1; i < n; i++) {
      double pivot = matrix[k][k];
      if (pivot != 0) {
        double multiplier = matrix[i][k] / pivot;
        multipliers[i] = multiplier;
        for (int j = k; j < n; j++) {
          matrix[i][j] -= multiplier * matrix[k][j];
        }
      }
    }
  }

  return multipliers;
}

void main() {
  List<List<double>> matrix =
      getMatrixCoeffs("4x + y -z = -2", "5x+y+2z=4", "6x + y + z = 6");

  List<List<double>> abMatrix = gaussianEliminationWithPartialPivoting(matrix);
  List<double> multipliers = calculateMultipliers(matrix);

  print("Upper Triangular Matrix (a/b matrix):");
  for (int i = 0; i < abMatrix.length; i++) {
    print(abMatrix[i]);
  }

  print("\nMultipliers:");
  print(multipliers);
}
