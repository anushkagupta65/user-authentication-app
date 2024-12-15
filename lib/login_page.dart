import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_authentication/home_page.dart';
import 'package:user_authentication/login_cubit/login_cubit.dart';
import 'package:user_authentication/login_input_field.dart';
import 'package:user_authentication/login_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginService loginService = LoginService();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(loginService),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomePage()),
                (Route<dynamic> route) => false);
          }
        },
        builder: (context, state) {
          final loginCubit = context.read<LoginCubit>();
          return LayoutBuilder(
            builder: (context, constraints) {
              double cardWidth;
              if (constraints.maxWidth < 600) {
                // Mobile view: fixed width
                cardWidth = 320;
              } else if (constraints.maxWidth < 1200) {
                // Tablet view: flexible width
                cardWidth = 400;
              } else {
                // Web view: flexible width
                cardWidth = 500;
              }
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Login',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                  backgroundColor:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  shadowColor: Theme.of(context).colorScheme.shadow,
                ),
                backgroundColor:
                    Theme.of(context).colorScheme.primary.withOpacity(0.5),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Card(
                      child: SizedBox(
                        height: 400,
                        width: cardWidth,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LoginInputField(
                                  inputType: 'Email address',
                                  controller: _emailController,
                                  onChanged: (val) {
                                    context
                                        .read<LoginCubit>()
                                        .emailChanged(val);
                                  }),
                              if (state.emailError.isNotEmpty)
                                SizedBox(
                                  // width: 392,
                                  child: Text(
                                    state.emailError,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 14,
                                          color: Colors.redAccent,
                                        ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              const SizedBox(
                                height: 20,
                              ),
                              LoginInputField(
                                  isPassword: true,
                                  inputType: 'Password',
                                  controller: _passwordController,
                                  onChanged: (val) {
                                    context
                                        .read<LoginCubit>()
                                        .passwordChanged(val);
                                  }),
                              const SizedBox(
                                height: 4,
                              ),
                              if (state.passwordError.isNotEmpty)
                                SizedBox(
                                  width: 392,
                                  child: Text(
                                    state.passwordError,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 14,
                                          color: Colors.redAccent,
                                        ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              const SizedBox(height: 20),
                              state.isFailure
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 28),
                                      child: SizedBox(
                                        width: 392,
                                        child: Text(
                                          state.errorMessage,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontSize: 14,
                                                color: Colors.redAccent,
                                              ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              Center(
                                child: SizedBox(
                                  width: 400,
                                  height: 56,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      loginCubit.onDoneButtonClick();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 32, vertical: 8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40.0),
                                      child: state.isLoading
                                          ? const CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : Text(
                                              "Login",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                  ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
