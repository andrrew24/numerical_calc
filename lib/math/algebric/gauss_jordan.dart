import 'package:numerical_calc/math/algebric/other/get_matrix_coeff.dart';

class GaussJordanElim {
  final String eq1;
  final String eq2;
  final String eq3;

  GaussJordanElim({required this.eq1, required this.eq2, required this.eq3});

  List<List<double>> matrix = [];
  List<List<double>> abMatrix = [];
  List<double> solution = [];

  void gaussJordanElimination() {
    matrix = getMatrixCoeffs(eq1, eq2, eq3);
    int n = matrix.length;
    List<List<double>> abMatrix =
        List.generate(n, (index) => List<double>.from(matrix[index]));

    for (int k = 0; k < n; k++) {
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

      // Make pivot element 1
      double pivot = abMatrix[k][k];
      if (pivot != 0) {
        for (int j = k; j < n + 1; j++) {
          abMatrix[k][j] /= pivot;
        }
      }

      // Make other elements in the column zero
      for (int i = 0; i < n; i++) {
        if (i != k) {
          double multiplier = abMatrix[i][k];
          for (int j = k; j < n + 1; j++) {
            abMatrix[i][j] -= multiplier * abMatrix[k][j];
          }
        }
      }
    }
    this.abMatrix = abMatrix;
  }

  getSolution() {
    int n = abMatrix.length;
    List<double> solution = List.filled(n, 0.0);

    for (int i = 0; i < n; i++) {
      solution[i] = abMatrix[i][n];
    }
    this.solution = solution;
  }
}

void main() {
  GaussJordanElim gaussJordanElim = GaussJordanElim(
      eq1: "4x + y -z = -2", eq2: "5x+y+2z=4", eq3: "6x + y + z = 6");
  gaussJordanElim.gaussJordanElimination();
  List<List<double>> abMatrix = gaussJordanElim.abMatrix;
  gaussJordanElim.getSolution();

  print("\nReduced Row Echelon Form (RREF) Matrix:");
  for (int i = 0; i < abMatrix.length; i++) {
    print(abMatrix[i]);
  }

  print("\nSolution:");
  print(gaussJordanElim.solution);
}
