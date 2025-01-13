import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:theme/theme.dart';

import '../bloc/login_cubit.dart';
import '../widgets/credentials_login_form_group.dart';
import '../widgets/social_login_button_group.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeResolver.of(context);
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }
      },
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppText.h1('Login'),
                const SizedBox(
                  height: 50,
                ),
                const SocialLoginButtonGroup(),
                SizedBox(height: theme.sizes.m),
                const CredentialsLoginFormGroup(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
