// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:insta/src/features/auth/presentation/controller/cubits/login/login_cubit.dart';
import 'package:insta/src/shared/presentation/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
         if(state.status.isSubmissionFailure){
           ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorText ??'Authentication Failure')),
           );
         }
        },
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: const [
              Spacer(
                flex: 3,
              ),
              _Username(),
              SizedBox(height: 10),
              _Password(),
              SizedBox(height: 10),
              _LoginButton(),
              Spacer(
                flex: 2,
              ),
              _SingupRedirect()
            ],
          ),
        )),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (pervious, current) {
        return pervious.status != current.status;
      },
      builder: (context, state) {
        return state.status == FormzStatus.submissionInProgress
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  minimumSize: MaterialStateProperty.all<Size>(Size(100, 50)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
                ),
                onPressed: () {
                  state.status == FormzStatus.valid ? context.read<LoginCubit>().logInWithCredentials() :
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Check your username and password : ${state.status}')));
                },
                child: Text(
                  'Login',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black),
                ),
              );
      },
    );
  }
}

class _SingupRedirect extends StatelessWidget {
  const _SingupRedirect();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed('singup');
      },
      child: RichText(
          text: TextSpan(children: [
        TextSpan(text: 'Don\'t you have an account ?'),
        TextSpan(
            text: 'Sign up',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold))
      ])),
    );
  }
}

class _Password extends StatelessWidget {
  const _Password();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) {
        return previous.password != current.password;
      },
      builder: (context, state) {
        return CustomTextField(
          labelText: 'Password',
          errorText: state.password.invalid ? 'The Password is invalid' : null,
          obscureText: true,
          onChanged: (String password) {
            context.read<LoginCubit>().passwordChanged(password);
          },
        );
      },
    );
  }
}

class _Username extends StatelessWidget {
  const _Username();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) {
        return previous.username != current.username;
      },
      builder: (context, state) {
        return CustomTextField(
          labelText: 'Username',
          errorText: state.username.invalid ? "The Username is invalid" : null,
          textInputType: TextInputType.name,
          onChanged: (username) {
            context.read<LoginCubit>().usernameChanged(username);
          },
        );
      },
    );
  }
}
