import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:seva_auth/utils/routes.dart';

import '../../../utils/base_state.dart';
import '../../components/main_alert.dart';
import '../../components/main_button.dart';
import '../../components/main_input.dart';
import 'login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final bloc = GetIt.I<LoginBloc>();

    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Hero(
              tag: 'topImage',
              child: Transform(
                transform: Matrix4.identity()..rotateZ(-0.2),
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(.7),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(75),
                      bottomRight: Radius.circular(75),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Hero(
              tag: 'bottomImage',
              child: Transform(
                transform: Matrix4.identity()..rotateZ(0.2),
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: theme.hintColor.withOpacity(.7),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(75),
                      topLeft: Radius.circular(75),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FlutterLogo(
                    size: 150,
                  ),
                  const SizedBox(height: 50),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sign In',
                            style: theme.primaryTextTheme.bodyMedium,
                          ),
                          MainInput(
                            controller: emailController,
                            label: 'Email',
                            hint: 'Enter your email',
                            keyboardType: TextInputType.emailAddress,
                            isRequired: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          MainInput(
                            controller: passwordController,
                            label: 'Password',
                            hint: 'Enter your password',
                            keyboardType: TextInputType.visiblePassword,
                            isRequired: true,
                            isPassword: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 50),
                          BlocConsumer<LoginBloc, BaseState>(
                            bloc: bloc,
                            listener: (context, state) {
                              if (state is ErrorState) {
                                MainAlertNotification.show(
                                  context,
                                  title: 'Error',
                                  message: state.message,
                                  duration: const Duration(seconds: 3),
                                );
                              }
                            },
                            builder: (context, state) {
                              return MainButton(
                                label: 'Login',
                                loading: state is LoadingState,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    FocusScope.of(context).unfocus();
                                    bloc.login(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: theme.primaryTextTheme.bodySmall,
                      children: [
                        TextSpan(
                          text: 'Register',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                context,
                                Routes.register,
                              );
                            },
                          style: theme.primaryTextTheme.bodySmall?.copyWith(
                            color: theme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
