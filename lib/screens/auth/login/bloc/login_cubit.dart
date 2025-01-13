import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../domain/value-objects/email.dart';
import '../../domain/value-objects/password.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  // final AuthenticationGateway _authenticationGateway;

  LoginCubit() : super(const LoginState());
  // LoginCubit(this._authenticationGateway) : super(const LoginState());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;

    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    // final result = await _authenticationGateway.logInWithEmailAndPassword(
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

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    // final result = await _authenticationGateway.logInWithGoogle();
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
