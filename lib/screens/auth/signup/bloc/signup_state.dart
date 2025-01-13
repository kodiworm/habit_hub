import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../domain/value-objects/confirmed_password.dart';
import '../../domain/value-objects/email.dart';
import '../../domain/value-objects/password.dart';
import '../widgets/name_input.dart';

enum ConfirmPasswordValidationError { invalid }

class SignUpState extends Equatable {
  const SignUpState({
    this.name = const NameInput.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.status = FormzStatus.pure,
    this.errorMessage,
  });

  final NameInput name;
  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [email, password, confirmedPassword, status];

  SignUpState copyWith({
    NameInput? name,
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    required FormzStatus status,
    String? errorMessage,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      status: status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
