import 'package:numerical_calc/math/algebric/other/get_matrix_coeff.dart';

class LuDecomp {
  final String eq1;
  final String eq2;
  final String eq3;

  late List<List<double>> matrix;
  late List<List<double>> lower;
  late List<List<double>> upper;
  late List<List<double>> solution;
  late int size;

  LuDecomp({required this.eq1, required this.eq2, required this.eq3});

  void decompose() {
    matrix = getMatrixCoeffs(eq1, eq2, eq3);
    size = matrix.length;
    lower = List.generate(size, (index) => List.filled(size, 0.0));
    upper = List.generate(size, (index) => List.filled(size, 0.0));
    for (int i = 0; i < size; i++) {
      // Upper Triangular
      for (int k = i; k < size; k++) {
        double sum = 0;
        for (int j = 0; j < i; j++) {
          sum += (lower[i][j] * upper[j][k]);
        }
        upper[i][k] = matrix[i][k] - sum;
      }

      // Lower Triangular
      for (int k = i; k < size; k++) {
        if (i == k)
          lower[i][i] = 1; // Diagonal as 1
        else {
          double sum = 0;
          for (int j = 0; j < i; j++) {
            sum += (lower[k][j] * upper[j][i]);
          }
          lower[k][i] = (matrix[k][i] - sum) / upper[i][i];
        }
      }
    }
  }

  solve() {
    decompose();
    List<double> b = matrix.map((e) => e.last).toList();
    List<double> y = List.filled(size, 0.0);
    List<double> x = List.filled(size, 0.0);

    // Solving Ly = b
    for (int i = 0; i < size; i++) {
      double sum = 0;
      for (int j = 0; j < i; j++) {
        sum += lower[i][j] * y[j];
      }
      y[i] = (b[i] - sum) / lower[i][i];
    }

    // Solving Ux = y
    for (int i = size - 1; i >= 0; i--) {
      double sum = 0;
      for (int j = i + 1; j < size; j++) {
        sum += upper[i][j] * x[j];
      }
      x[i] = (y[i] - sum) / upper[i][i];
    }

    solution = [x, y];
  }
}

void main(List<String> args) {
  LuDecomp luDecomp =
      LuDecomp(eq1: "4x + y -z = -2", eq2: "5x+y+2z=4", eq3: "6x + y + z = 6");

  luDecomp.solve();

  print("Lower Matrix:");
  for (int i = 0; i < luDecomp.size; i++) {
    print(luDecomp.lower[i]);
  }

  print("\nUpper Matrix:");
  for (int i = 0; i < luDecomp.size; i++) {
    print(luDecomp.upper[i]);
  }

  print("\nSolution:");
  for (int i = 0; i < luDecomp.solution[0].length; i++) {
    print("x$i = ${luDecomp.solution[0][i]}");
  }
  print("\C:");
  for (int i = 0; i < luDecomp.solution[1].length; i++) {
    print("c$i = ${luDecomp.solution[1][i]}");
  }

}
