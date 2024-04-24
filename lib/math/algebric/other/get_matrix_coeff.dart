import 'get_eq_coeffients.dart.dart';

List<List<double>> getMatrixCoeffs(String eq1, String eq2, String eq3) {
  List<String> equations = [eq1, eq2, eq3];
  List<List<double>> matrixCoeffs = [];

  for (var eq in equations) {
    matrixCoeffs.add(getCoefficients(eq));
  }

  return matrixCoeffs;
}

// void main() {
//   print(getMatrixCoeffs("2x + y -z = 1", "5x+2y+2z=-4", "3x + y + z = 5"));
// }
