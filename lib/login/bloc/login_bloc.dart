import 'package:ala_mod/shared/models/models.dart';
import 'package:ala_mod/utils/secure_storage.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  final AuthRepository _authRepository;

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate([username, state.password]),
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([state.username, password]),
      ),
    );
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final tokens = await _authRepository.login(
        username: state.username.value,
        password: state.password.value,
      );
      if (tokens != null) {
        await SecureStorage.saveTokens(
          accessToken: tokens['access_token']!,
          refreshToken: tokens['refresh_token']!,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } else {
        emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
            errorMessage: 'Authentication Failure',
          ),
        );
      }
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: 'Authentication Failure: ${e.toString()}',
        ),
      );
    }
  }
}
