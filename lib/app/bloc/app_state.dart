part of 'app_bloc.dart';

class AppState extends Equatable {
  const AppState._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
  });

  const AppState.unknown() : this._();

  const AppState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AppState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}
