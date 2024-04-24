// import 'package:numerical_calc/math/algebric/other/get_matrix_coeff.dart';

// class GaussElim {
//   final String eq1;
//   final String eq2;
//   final String eq3;

//   GaussElim({required this.eq1, required this.eq2, required this.eq3});

//   List<List<double>> matrix = [];
//   List<List<double>> abmatrix = [];
//   List<double> multipersList = [];

//   gaussianEliminationWithPartialPivoting() {
//     matrix = getMatrixCoeffs(eq1, eq2, eq3);
//     int n = matrix.length;
//     List<List<double>> abMatrix =
//         List.generate(n, (index) => List<double>.from(matrix[index]));
//     List<double> multipliers = List.filled(n, 0.0);

//     for (int k = 0; k < n - 1; k++) {
//       // Partial Pivoting
//       int pivotRow = k;
//       double maxAbsValue = abMatrix[k][k].abs();
//       for (int i = k + 1; i < n; i++) {
//         if (abMatrix[i][k].abs() > maxAbsValue) {
//           maxAbsValue = abMatrix[i][k].abs();
//           pivotRow = i;
//         }
//       }
//       if (pivotRow != k) {
//         // Swap rows k and pivotRow
//         List<double> temp = List<double>.from(abMatrix[k]);
//         abMatrix[k] = List<double>.from(abMatrix[pivotRow]);
//         abMatrix[pivotRow] = List<double>.from(temp);
//       }

//       // Gaussian Elimination
//       for (int i = k + 1; i < n; i++) {
//         double pivot = abMatrix[k][k];
//         if (pivot != 0) {
//           double multiplier = abMatrix[i][k] / pivot;
//           multipliers[i] = multiplier;
//           for (int j = k; j < n + 1; j++) {
//             abMatrix[i][j] -= multiplier * abMatrix[k][j];
//           }
//         }
//       }
//     }
//     abmatrix = abMatrix;
//   }

//   calculateMultipliers() {
//     int n = matrix.length;
//     List<double> multipliers = List.filled(n, 0.0);

//     for (int k = 0; k < n - 1; k++) {
//       int pivotRow = k;
//       double maxAbsValue = matrix[k][k].abs();
//       for (int i = k + 1; i < n; i++) {
//         if (matrix[i][k].abs() > maxAbsValue) {
//           maxAbsValue = matrix[i][k].abs();
//           pivotRow = i;
//         }
//       }
//       if (pivotRow != k) {
//         List<double> temp = List<double>.from(matrix[k]);
//         matrix[k] = List<double>.from(matrix[pivotRow]);
//         matrix[pivotRow] = List<double>.from(temp);
//       }
//       for (int i = k + 1; i < n; i++) {
//         double pivot = matrix[k][k];
//         if (pivot != 0) {
//           double multiplier = matrix[i][k] / pivot;
//           multipliers[i] = multiplier;
//           for (int j = k; j < n; j++) {
//             matrix[i][j] -= multiplier * matrix[k][j];
//           }
//         }
//       }
//     }
//     multipersList = multipliers;
//   }
// }

// void main(List<String> args) {
//   GaussElim gaussElim =
//       GaussElim(eq1: "4x + y -z = -2", eq2: "5x+y+2z=4", eq3: "6x + y + z = 6");
//   gaussElim.gaussianEliminationWithPartialPivoting();
//   gaussElim.calculateMultipliers();
//   List<List<double>> abMatrix = gaussElim.abmatrix;
//   List<double> ms = gaussElim.multipersList;

//   print("Upper Triangular Matrix (a/b matrix):");
//   for (int i = 0; i < abMatrix.length; i++) {
//     print(abMatrix[i]);
//   }

//   print("\nMultipliers:");
//   print(ms);
// }


import 'package:numerical_calc/math/algebric/other/get_matrix_coeff.dart';

class GaussElim {
  final String eq1;
  final String eq2;
  final String eq3;

  GaussElim({required this.eq1, required this.eq2, required this.eq3});

  List<List<double>> matrix = [];
  List<List<double>> abMatrix = [];
  List<double> multipliers = [];
  List<double> variables = [];

  void gaussianEliminationWithPartialPivoting() {
    matrix = getMatrixCoeffs(eq1, eq2, eq3);
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
    this.abMatrix = abMatrix;
    this.multipliers = multipliers;
  }

  void calculateVariables() {
    int n = abMatrix.length;
    List<double> variables = List.filled(n, 0.0);

    // Back Substitution
    for (int i = n - 1; i >= 0; i--) {
      double sum = abMatrix[i][n];
      for (int j = i + 1; j < n; j++) {
        sum -= abMatrix[i][j] * variables[j];
      }
      variables[i] = sum / abMatrix[i][i];
    }
    this.variables = variables;
  }
}

void main() {
  GaussElim gaussElim = GaussElim(
      eq1: "4x + y -z = -2", eq2: "5x+y+2z=4", eq3: "6x + y + z = 6");
  gaussElim.gaussianEliminationWithPartialPivoting();
  gaussElim.calculateVariables();
  List<List<double>> abMatrix = gaussElim.abMatrix;
  List<double> ms = gaussElim.multipliers;
  List<double> variables = gaussElim.variables;

  for (int i = 0; i < abMatrix.length; i++) {
  }

  print("\nMultipliers:");
  print(ms);

  print("\nVariables:");
  print(variables);
}
