class SecantIter {
  final double iter;
  final double ximinus1;
  final double fximinus1;
  final double xi;
  final double fxi;
  final double error;

  SecantIter(
      {required this.iter,
      required this.ximinus1,
      required this.fximinus1,
      required this.xi,
      required this.fxi,
      required this.error});
}
