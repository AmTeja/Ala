import 'dart:async';

import 'package:ala_mod/utils/jwt.dart';
import 'package:ala_mod/utils/secure_storage.dart';
import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AppState.unknown()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    _authenticationStatusSubscription = _authRepository.status
        .listen((status) => add(_AuthenticationStatusChanged(status)));
  }

  final AuthRepository _authRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authRepository.dispose();
    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(
    _AuthenticationStatusChanged event,
    Emitter<AppState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unknown:
        return emit(const AppState.unknown());
      case AuthenticationStatus.authenticated:
        final accessToken = await SecureStorage.getAccessToken();
        if (accessToken == null) return emit(const AppState.unauthenticated());
        final claims = parseJwt(accessToken);
        return _authRepository.getUserFromToken(claims: claims).then((user) {
          return emit(AppState.authenticated(user));
        });
      case AuthenticationStatus.unauthenticated:
        return emit(const AppState.unauthenticated());
    }
  }

  Future<void> _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AppState> emit,
  ) async {
    print('logout called?');
    await _authRepository.logout();
    emit(const AppState.unauthenticated());
  }
}
