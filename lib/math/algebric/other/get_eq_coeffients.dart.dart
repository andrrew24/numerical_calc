
List<double> getCoefficients(String equation) {
  List<double> coefficients = [
    0.0,
    0.0,
    0.0,
    0.0
  ]; // Initialize with default values

  equation = equation.replaceAll(' ', ''); // Remove whitespaces

  List<String> sides = equation.split('=');
  if (sides.length != 2) {
    throw Exception(
        "Invalid equation. Please provide an equation in the form of 'ax + by + cz = d'.");
  }

  String lhs = sides[0];
  String rhs = sides[1];

  RegExp regex = RegExp(r'([-+])?(\d*\.?\d*)?[a-z]');
  Iterable<Match> matches = regex.allMatches(lhs);

  for (Match match in matches) {
    String sign = match.group(1) ?? '+';
    String coefStr = match.group(2) ?? '1';
    double coef = double.tryParse(coefStr)!;

    String variable = match.group(0)!;
    String variableName =
        variable.substring(variable.length - 1); // Extract the variable name

    int index = -1;

    if (variableName == 'x') {
      index = 0;
    } else if (variableName == 'y') {
      index = 1;
    } else if (variableName == 'z') {
      index = 2;
    }

    if (index != -1) {
      double signedCoef = sign == '-' ? -coef : coef;
      coefficients[index] +=
          signedCoef; // Add the coefficient to the corresponding index
    } else {
      throw Exception("Invalid variable found: $variableName");
    }
  }

  double constantTerm = double.tryParse(rhs)!;
  coefficients[3] = constantTerm;

  return coefficients;
}


