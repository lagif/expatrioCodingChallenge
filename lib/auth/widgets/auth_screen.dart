import 'package:coding_challenge/api/client/exceptions.dart';
import 'package:coding_challenge/auth/cubits/auth_cubit.dart';
import 'package:coding_challenge/auth/cubits/auth_state.dart';
import 'package:coding_challenge/shared/widgets/bottom_sheet.dart';
import 'package:coding_challenge/shared/widgets/icon_title.dart';
import 'package:coding_challenge/shared/widgets/result_notification.dart';
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
  bool _shwowPassword = false;

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
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(16.0, topPadding, 16.0, bottomPadding),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: bottomPadding,
              child: Lottie.asset(
                fit: BoxFit.fitWidth,
                "assets/login-background.json",
                repeat: true,
              ),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/2019_XP_logo_white.png',
                      height: 40,
                      fit: BoxFit.fitHeight,
                    ),
                    const SizedBox(height: 16.0),
                    BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is AuthSuccess) {
                            _showSuccessView(context);
                          }
                          if (state is AuthError) {
                            _showErrorView(state.error);
                          }
                        },
                        bloc: context.read<AuthCubit>(),
                        builder: (context, state) => switch (state) {
                              AuthLoading() => _loadingIndicator(),
                              AuthLogOut() => _loginForm(context, state),
                              AuthError() => _loginForm(context, state),
                              AuthPending() => _loginForm(context, state),
                              AuthSuccess() => _loginForm(
                                  context,
                                  state,
                                  enabled: true,
                                ),
                            }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginForm(BuildContext context, AuthState state,
      {bool enabled = true}) {
    String login = '';
    if (state is AuthPending && (state.previousLogin ?? '').isNotEmpty) {
      login = state.previousLogin!;
      _emailTextController.text = login;
    }
    return Center(
      child: FormBuilder(
        key: _formKey,
        enabled: enabled,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const IconTitle(icon: Icons.email_outlined, title: "email"),
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
            const IconTitle(
                icon: Icons.lock_outline_rounded, title: "password"),
            FormBuilderTextField(
              name: 'password',
              controller: _passwordTextController,
              obscureText: !_shwowPassword,
              decoration: InputDecoration(
                hintText: "password",
                suffixIcon: IconButton(
                  icon: Icon(_shwowPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined),
                  onPressed: () {
                    setState(() {
                      _shwowPassword = !_shwowPassword;
                    });
                  },
                ),
              ),
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
      child: CircularProgressIndicator(
        color: Color.fromRGBO(65, 171, 158, 1),
      ),
    );
  }

  _showSuccessView(BuildContext context) {
    AppBottomSheet.show(
        context: context,
        child: ResultNotification(
          isSuccess: true,
          title: "Successful Login",
          message: "You will be redirected to your dasboard",
          action: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('GOT IT'),
          ),
        ),
        onComplete: () {
          Navigator.of(context).pushNamed("TaxInfoScreen");
        });
  }

  _showErrorView(dynamic error) {
    String errorMessage = '';
    if (error is HttpErrorException) {
      errorMessage = error.toString();
    }
    if (error is ServerNotRespondingException) {
      errorMessage = "No response from server. "
          "Please check your connection and try again!";
    }
    AppBottomSheet.show(
      context: context,
      child: ResultNotification(
        isSuccess: false,
        title: "The error occurred",
        message: errorMessage,
        action: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('GOT IT'),
        ),
      ),
    );
  }
}
