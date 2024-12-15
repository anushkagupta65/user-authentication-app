import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:user_authentication/login_service.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginService loginService;

  LoginCubit(this.loginService) : super(LoginState.initial());

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void emailChanged(String email) {
    emit(state.copyWith(
      email: email,
      isSuccess: false,
      isFailure: false,
    ));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(
      password: password,
      isSuccess: false,
      isFailure: false,
    ));
  }

  bool validateCredentials() {
    String? emailErrorMessage;
    String? passwordErrorMessage;

    if (state.email.isEmpty) {
      emailErrorMessage = "Email is required.";
    } else if (!state.email.contains("@")) {
      emailErrorMessage = "Please enter a valid email.";
    }

    if (state.password.isEmpty) {
      passwordErrorMessage = "Password is required.";
    } else if (state.password.length < 8 ||
        !state.password.contains(RegExp(r'[A-Z]')) ||
        !state.password.contains(RegExp(r'[0-9]')) ||
        !state.password.contains(RegExp(r'[!@#\$&*~]'))) {
      passwordErrorMessage = "Please enter a valid password.";
    }

    emit(state.copyWith(
      emailError: emailErrorMessage ?? "",
      passwordError: passwordErrorMessage ?? "",
    ));

    return emailErrorMessage == null && passwordErrorMessage == null;
  }

  Future<void> onDoneButtonClick() async {
    emit(state.copyWith(
        isLoading: true,
        isSuccess: false,
        isFailure: false,
        errorMessage: "",
        emailError: "",
        passwordError: ""));

    if (!validateCredentials()) {
      emit(state.copyWith(
        isLoading: false,
      ));
      return;
    }

    final response = await loginService.loginWithCredentials(
      state.email,
      state.password,
    );

    if (response != null) {
      emit(state.copyWith(
        isSuccess: true,
        isFailure: false,
        isLoading: false,
        errorMessage: "",
      ));
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        emit(state.copyWith(
          isSuccess: false,
          isFailure: true,
          isLoading: false,
          errorMessage: "Invalid Credentials. Please try again.",
        ));
      });
    }
  }
}
