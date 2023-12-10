// ignore_for_file: prefer_const_constructors, unused_element

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
          children: [
            Spacer(
              flex: 3,
            ),
            _Username(),
            SizedBox(height: 10),
            _Email(),
            SizedBox(height: 10),
            _Password(),
            SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                minimumSize: MaterialStateProperty.all<Size>(Size(100, 50)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
              ),
              onPressed: () {},
              child: Text(
                'Sing up',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.black),
              ),
            ),
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

class _SingInRedirect extends StatelessWidget {
  const _SingInRedirect();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
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
    return const CustomTextField(
      labelText: 'Password',
      obscureText: true,
    );
  }
}

class _Username extends StatelessWidget {
  const _Username();

  @override
  Widget build(BuildContext context) {
    return const CustomTextField(
      labelText: 'Username',
      textInputType: TextInputType.name,
    );
  }
}
class _Email extends StatelessWidget {
  const _Email();

  @override
  Widget build(BuildContext context) {
    return const CustomTextField(
      labelText: 'Email',
      textInputType: TextInputType.emailAddress,
    );
  }
}

