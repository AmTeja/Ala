import 'package:ala_mod/login/bloc/login_bloc.dart';
import 'package:ala_mod/register/view/register_page.dart';
import 'package:ala_mod/shared/custom_hero.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.topRight,
              child: Hero(
                tag: 'test',
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: const Color(0xFF212121),
                    borderRadius: BorderRadius.circular(96),
                  ),
                ),
              ),
            ),
          ),
          // ignore: use_decorated_box
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListView(
              children: const [_Header(), _LoginForm()],
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(size.width);
    final themeData = Theme.of(context);
    return Container(
      height: size.height * 0.3,
      alignment: size.width > 600 ? Alignment.center : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: size.width > 600
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Ala',
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Welcome',
            style: TextStyle(fontSize: 32),
          ),
          Row(
            mainAxisAlignment: size.width > 600
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(_page());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign up',
                          style: TextStyle(
                            color: themeData.colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == FormzStatus.submissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }
      },
      child: Column(
        children: const [
          _UsernameInput(),
          _PasswordInput(),
          _LoginButton(),
        ],
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  const _UsernameInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return CustomHeroWrapper(
          tag: 'Form_usernameInput_textField',
          child: SizedBox(
            width: MediaQuery.of(context).size.width > 600
                ? MediaQuery.of(context).size.width * 0.3
                : MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              key: const Key('loginForm_usernameInput_textField'),
              onChanged: (username) =>
                  context.read<LoginBloc>().add(LoginUsernameChanged(username)),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: 'Username',
                helperText: '',
                errorText: state.username.invalid ? 'invalid username' : null,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return CustomHeroWrapper(
          tag: 'Form_passwordInput_textField',
          child: SizedBox(
            width: MediaQuery.of(context).size.width > 600
                ? MediaQuery.of(context).size.width * 0.3
                : MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              key: const Key('loginForm_passwordInput_textField'),
              onChanged: (password) =>
                  context.read<LoginBloc>().add(LoginPasswordChanged(password)),
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: 'Password',
                helperText: '',
                errorText: state.password.invalid ? 'invalid password' : null,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status.isSubmissionInProgress) {
          return const CircularProgressIndicator();
        } else {
          return Hero(
            tag: 'Form_continue_raisedButton',
            child: ElevatedButton(
              style: ElevatedButton.styleFrom().copyWith(
                fixedSize: MaterialStateProperty.all(
                  Size(
                    MediaQuery.of(context).size.width > 600
                        ? MediaQuery.of(context).size.width * 0.3
                        : MediaQuery.of(context).size.width * 0.8,
                    50,
                  ),
                ),
              ),
              key: const Key('loginForm_continue_raisedButton'),
              onPressed: state.status.isValidated
                  ? () => context.read<LoginBloc>().add(LoginSubmitted())
                  : null,
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
        }
      },
    );
  }
}

Route _page() {
  return PageRouteBuilder<Page>(
    pageBuilder: (context, animation, secondaryAnimation) {
      return const RegisterPage();
    },
    transitionDuration: const Duration(milliseconds: 500),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}
