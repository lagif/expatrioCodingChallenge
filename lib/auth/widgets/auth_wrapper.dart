import 'package:coding_challenge/auth/cubits/auth_cubit.dart';
import 'package:coding_challenge/auth/cubits/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthWrapperWidget extends StatelessWidget {
  final Widget child;

  const AuthWrapperWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
        } else {
          Navigator.of(context).popAndPushNamed("LoginScreen");
        }
      },
      bloc: context.read<AuthCubit>(),
      child: child,
    );
  }
}
