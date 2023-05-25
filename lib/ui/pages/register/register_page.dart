import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:seva_auth/domain/entities/user_entity.dart';
import 'package:seva_auth/ui/components/main_alert.dart';
import 'package:seva_auth/ui/components/main_button.dart';
import 'package:seva_auth/ui/components/main_input.dart';
import 'package:seva_auth/ui/pages/register/register_bloc.dart';

import '../../../utils/base_state.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final bloc = GetIt.I<RegisterBloc>();

    return Scaffold(
      body: Stack(
        children: [
          const FlutterLogo(),
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
                            'Create Account',
                            style: theme.primaryTextTheme.bodyMedium,
                          ),
                          MainInput(
                            controller: nameController,
                            label: 'User Name',
                            hint: 'Enter your name',
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            isRequired: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
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
                          BlocConsumer<RegisterBloc, BaseState>(
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
                                label: 'Register',
                                loading: state is LoadingState,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    var user = UserEntity(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                    bloc(user);
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
                      text: 'Already have an account? ',
                      style: theme.primaryTextTheme.bodySmall,
                      children: [
                        TextSpan(
                          text: 'Login',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
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
