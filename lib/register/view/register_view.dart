import 'package:ala_mod/register/bloc/register_bloc.dart';
import 'package:ala_mod/shared/custom_hero.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              heightFactor: 0,
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
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: const [
                _Header(),
                _RegisterForm(),
              ],
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
    return Container(
      height: size.height * 0.3,
      padding: const EdgeInsets.symmetric(vertical: 6),
      alignment: Alignment.topCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(96),
        child: CircleAvatar(
          radius: 70,
          backgroundColor: Colors.transparent,
          child: IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: () {},
            iconSize: 25,
          ),
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
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
        if (state.status == FormzStatus.submissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Account creation successful'),
              ),
            );
        }
      },
      child: Column(
        children: const [
          _EmailInput(),
          _UsernameInput(),
          _BioInput(),
          _PasswordInput(),
          _RegisterButton(),
        ],
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  const _UsernameInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return CustomHeroWrapper(
          tag: 'Form_usernameInput_textField',
          child: SizedBox(
            width: MediaQuery.of(context).size.width > 600
                ? MediaQuery.of(context).size.width * 0.3
                : MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              key: const Key('registerForm_usernameInput_textField'),
              onChanged: (username) => context
                  .read<RegisterBloc>()
                  .add(RegisterUsernameChanged(username)),
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
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return CustomHeroWrapper(
          tag: 'Form_passwordInput_textField',
          child: SizedBox(
            width: MediaQuery.of(context).size.width > 600
                ? MediaQuery.of(context).size.width * 0.3
                : MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              key: const Key('registernForm_passwordInput_textField'),
              onChanged: (password) => context
                  .read<RegisterBloc>()
                  .add(RegisterPasswordChanged(password)),
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

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Material(
          color: Colors.transparent,
          child: SizedBox(
            width: MediaQuery.of(context).size.width > 600
                ? MediaQuery.of(context).size.width * 0.3
                : MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              key: const Key('registerForm_emailInput_textField'),
              onChanged: (email) =>
                  context.read<RegisterBloc>().add(RegisterEmailChanged(email)),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: 'Email',
                helperText: '',
                errorText: state.email.invalid ? 'invalid email' : null,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BioInput extends StatelessWidget {
  const _BioInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.bio != current.bio,
      builder: (context, state) {
        return Material(
          color: Colors.transparent,
          child: SizedBox(
            width: MediaQuery.of(context).size.width > 600
                ? MediaQuery.of(context).size.width * 0.3
                : MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              key: const Key('registerForm_bioInput_textField'),
              onChanged: (bio) =>
                  context.read<RegisterBloc>().add(RegisterBioChanged(bio)),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                labelText: 'Bio',
                helperText: '',
                errorText: state.bio.invalid ? 'invalid bio' : null,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
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
              key: const Key('registerForm_continue_raisedButton'),
              onPressed: state.status.isValidated
                  ? () => context.read<RegisterBloc>().add(
                        RegisterSubmitted(),
                      )
                  : null,
              child: const Text(
                'Register',
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
        }
      },
    );
  }
}
