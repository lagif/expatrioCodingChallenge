import 'package:coding_challenge/auth/cubits/auth_cubit.dart';
import 'package:coding_challenge/auth/cubits/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  late final TextEditingController _emailTextController;
  late final TextEditingController _passwordTextController;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        //ToDO: show the bottom sheet with pretty button
                      }
                    },
                    listenWhen: (state1, state2) =>
                        state1 != state2 && state2 is AuthSuccess,
                    bloc: context.read<AuthCubit>(),
                    builder: (context, state) => switch (state) {
                          AuthLoading() => _loadingIndicator(),
                          AuthLogOut() => _loginForm(context, state),
                          AuthError() => _loginForm(context, state),
                          AuthPending() => _loginForm(context, state),
                          AuthSuccess() => const Text("Success!!!"),
                        }),
                Lottie.asset(
                  fit: BoxFit.fitWidth,
                  "assets/login-background.json",
                  repeat: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginForm(BuildContext context, AuthState state) {
    return Center(
      child: FormBuilder(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FormBuilderTextField(
              name: 'email',
              controller: _emailTextController,
              decoration: const InputDecoration(hintText: "email"),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.email(),
              ]),
            ),
            const SizedBox(height: 16.0),
            FormBuilderTextField(
              name: 'password',
              controller: _passwordTextController,
              obscureText: true,
              decoration: const InputDecoration(hintText: "password"),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                    errorText: "The password is required"),
                FormBuilderValidators.minLength(6,
                    errorText: "Password is too short"),
              ]),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _formKey.currentState?.save();
                if (_formKey.currentState?.validate() ?? false) {
                  context.read<AuthCubit>().logIn(
                      _emailTextController.text, _passwordTextController.text);
                }
              },
              child: const Text('LOGIN'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
