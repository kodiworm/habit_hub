import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';

import '../../domain/value-objects/confirmed_password.dart';
import '../../domain/value-objects/email.dart';
import '../../domain/value-objects/password.dart';
import '../widgets/name_input.dart';
import 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  // SignUpCubit(this._authenticationGateway) : super(const SignUpState());
  SignUpCubit() : super(const SignUpState());

  // final AuthenticationGateway _authenticationGateway;

  void nameChanged(String value) {
    final name = NameInput.dirty(value);
    emit(
      state.copyWith(
        name: name,
        status: Formz.validate([
          name,
          state.email,
          state.password,
          state.confirmedPassword,
        ]),
      ),
    );
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([
          state.name,
          email,
          state.password,
          state.confirmedPassword,
        ]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        confirmedPassword: confirmedPassword,
        status: Formz.validate([
          state.name,
          state.email,
          password,
          confirmedPassword,
        ]),
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        status: Formz.validate([
          state.name,
          state.email,
          state.password,
          confirmedPassword,
        ]),
      ),
    );
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;

    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    // final result = await _authenticationGateway.signUp(
    //   name: state.name.value,
    //   email: state.email.value,
    //   password: state.password.value,
    // );
    //
    // result.fold(
    //   (l) {
    //     emit(
    //       state.copyWith(
    //         errorMessage: l.message,
    //         status: FormzStatus.submissionFailure,
    //       ),
    //     );
    //   },
    //   (r) => emit(state.copyWith(status: FormzStatus.submissionSuccess)),
    // );
  }
}
