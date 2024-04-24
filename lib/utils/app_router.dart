import 'package:go_router/go_router.dart';
import 'package:numerical_calc/views/forms/algebric/cramers.dart';
import 'package:numerical_calc/views/forms/algebric/gauss_eli_form.dart';
import 'package:numerical_calc/views/forms/algebric/lu_dec.dart';
import 'package:numerical_calc/views/forms/polynomials/biesection_form.dart';
import 'package:numerical_calc/views/forms/polynomials/false_position_form.dart';
import 'package:numerical_calc/views/forms/polynomials/newton.dart';
import 'package:numerical_calc/views/forms/polynomials/secant.dart';
import 'package:numerical_calc/views/forms/polynomials/simple_fixed.dart';
import 'package:numerical_calc/views/home_screen.dart';

final GoRouter router = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: '/',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/biesect',
    builder: (context, state) => const BiesectionForm(),
  ),
  GoRoute(
    path: '/falsepos',
    builder: (context, state) => const FalsePositionForm(),
  ),
  GoRoute(
    path: '/simplefixed',
    builder: (context, state) => const SimpleFixedForm(),
  ),
  GoRoute(
    path: '/secant',
    builder: (context, state) => const SecantForm(),
  ),
  GoRoute(
    path: '/newton',
    builder: (context, state) => const NewtonForm(),
  ),
  GoRoute(
    path: '/gauss',
    builder: (context, state) => const GaussForm(),
  ),
  GoRoute(
    path: '/ludecom',
    builder: (context, state) => const LuDecomForm(),
  ),
  GoRoute(
    path: '/cramers',
    builder: (context, state) => const CramersForm(),
  ),
]);
