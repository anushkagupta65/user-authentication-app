import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_authentication/login_cubit/login_cubit.dart';

class LoginInputField extends StatefulWidget {
  final String inputType;
  final TextEditingController controller;
  final bool isPassword;
  final void Function(String)? onChanged;

  const LoginInputField({
    super.key,
    required this.inputType,
    required this.controller,
    this.isPassword = false,
    this.onChanged,
  });

  @override
  State<LoginInputField> createState() => _LoginInputFieldState();
}

class _LoginInputFieldState extends State<LoginInputField> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final loginCubit = context.read<LoginCubit>();
        final isPasswordVisible = state.isPasswordVisible;
        return TextFormField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          obscureText: widget.isPassword ? state.isPasswordVisible : false,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary, // Text color
          ),
          cursorColor: Theme.of(context).colorScheme.primary, // Cursor color
          decoration: InputDecoration(
            hintText: widget.inputType,
            hintStyle: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withOpacity(0.3), // Hint color
            ),
            labelText: widget.inputType,
            labelStyle: TextStyle(
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withOpacity(0.8), // Label color
            ),
            prefixIcon: Icon(
              widget.isPassword ? Icons.lock_outline : Icons.person_outline,
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withOpacity(0.8), // Icon color
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.6), // Eye icon color
                    ),
                    onPressed: () {
                      loginCubit.togglePasswordVisibility();
                    },
                  )
                : null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withOpacity(0.8), // Border color when enabled
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withOpacity(0.8), // Border color when focused
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        );
      },
    );
  }
}
