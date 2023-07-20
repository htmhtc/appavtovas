import 'package:avtovas_web/src/common/di/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class CubitScope<T extends Cubit<dynamic>> extends StatelessWidget {
  static T of<T extends Cubit>(BuildContext context) => context.read<T>();

  final Widget child;

  const CubitScope({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => i.get<T>(),
      child: child,
    );
  }
}
