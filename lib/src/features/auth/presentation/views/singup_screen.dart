// ignore_for_file: prefer_const_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:insta/src/features/auth/presentation/controller/cubits/singup/singup_cubit.dart';
import 'package:insta/src/shared/presentation/widgets/custom_text_field.dart';

class SingupScreen extends StatelessWidget {
  const SingupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Singup'),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: const [
            Spacer(
              flex: 3,
            ),
            _Username(),
            SizedBox(height: 10),
            _Email(),
            SizedBox(height: 10),
            _Password(),
            SizedBox(height: 10),
            _SingupButton(),
            Spacer(
              flex: 2,
            ),
            _SingInRedirect()
          ],
        ),
      )),
    );
  }
}

class _SingupButton extends StatelessWidget {
  const _SingupButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingupCubit, SingupState>(
      buildWhen: (previous, current) {
        return previous.status != current.status;
      },
      builder: (context, state) {
        return state.status == FormzStatus.submissionInProgress
            ? CircularProgressIndicator(
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
                  if (state.status == FormzStatus.valid) {
                    context.read<SingupCubit>().singUpWithCredentials();
                    context.pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Check your username and password : ${state.status}'),
                      ),
                    );
                  }
                },
                child: Text(
                  'Sing up',
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

class _SingInRedirect extends StatelessWidget {
  const _SingInRedirect();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed('login');
      },
      child: RichText(
          text: TextSpan(children: [
        TextSpan(text: 'Already have an account ?'),
        TextSpan(
            text: 'Sign In',
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
    return BlocBuilder<SingupCubit, SingupState>(
      buildWhen: (previous, current) {
        return previous.password != current.password;
      },
      builder: (context, state) {
        return CustomTextField(
          labelText: 'Password',
          errorText: state.password.invalid ? "The Password is invalid" : null,
          onChanged: (password) {
            context.read<SingupCubit>().passwordChanged(password);
          },
          obscureText: true,
        );
      },
    );
  }
}

class _Username extends StatelessWidget {
  const _Username();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingupCubit, SingupState>(
      buildWhen: (previous, current) {
        return previous.username != current.username;
      },
      builder: (context, state) {
        return CustomTextField(
            labelText: 'Username',
            textInputType: TextInputType.name,
            errorText:
                state.username.invalid ? "The Username is invalid" : null,
            onChanged: (username) {
              context.read<SingupCubit>().usernameChanged(username);
            });
      },
    );
  }
}

class _Email extends StatelessWidget {
  const _Email();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingupCubit, SingupState>(
      buildWhen: (previous, current) {
        return previous.email != current.email;
      },
      builder: (context, state) {
        return CustomTextField(
          labelText: 'Email',
          errorText: state.email.invalid ? "The Email is invalid" : null,
          onChanged: (email) {
            context.read<SingupCubit>().emailChanged(email);
          },
          textInputType: TextInputType.emailAddress,
        );
      },
    );
  }
}
