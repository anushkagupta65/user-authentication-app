part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  factory LoginState({
    @Default("") String email,
    @Default("") String password,
    @Default(false) bool isLoading,
    @Default("") String errorMessage,
    @Default(false) bool isSuccess,
    @Default(false) bool isFailure,
    @Default("") String emailError,
    @Default("") String passwordError,
    @Default(true) bool isPasswordVisible,
  }) = _LoginState;

  factory LoginState.initial() => LoginState(
        email: "",
        password: "",
        isLoading: false,
        isSuccess: false,
        isFailure: false,
        emailError: "",
        passwordError: "",
        isPasswordVisible: true,
        errorMessage: "",
      );
}
