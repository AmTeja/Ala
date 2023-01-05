import 'package:ala_mod/shared/models/bio.dart';
import 'package:ala_mod/shared/models/email.dart';
import 'package:ala_mod/shared/models/models.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const RegisterState()) {
    on<RegisterUsernameChanged>(_onUsernameChanged);
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterBioChanged>(_onBioChanged);
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  final AuthRepository _authRepository;

  void _onUsernameChanged(
    RegisterUsernameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate([username]),
      ),
    );
  }

  void _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email]),
      ),
    );
  }

  void _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([password]),
      ),
    );
  }

  void _onBioChanged(
    RegisterBioChanged event,
    Emitter<RegisterState> emit,
  ) {
    final bio = Bio.dirty(event.bio);
    emit(
      state.copyWith(
        bio: bio,
        status: Formz.validate([bio]),
      ),
    );
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authRepository.signUp(
        username: state.username.value,
        email: state.email.value,
        password: state.password.value,
        bio: state.bio.value,
        avatar: state.avatar,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on AuthException catch (e) {
      print(e);
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: e.message,
        ),
      );
    }
  }
}
