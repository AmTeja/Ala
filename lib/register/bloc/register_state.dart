part of 'register_bloc.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.bio = const Bio.pure(),
    this.password = const Password.pure(),
    this.avatar =
        'https://images.hdqwalls.com/download/death-sworn-katarina-league-of-legends-kb-3840x2160.jpg',
    this.errorMessage,
  });

  final FormzStatus status;
  final Username username;
  final Email email;
  final Bio bio;
  final Password password;
  final String avatar;
  final String? errorMessage;

  RegisterState copyWith({
    FormzStatus? status,
    Username? username,
    Email? email,
    Password? password,
    String? avatar,
    Bio? bio,
    String? errorMessage,
  }) {
    return RegisterState(
      status: status ?? this.status,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [username, email, password, avatar, errorMessage, bio];
}
