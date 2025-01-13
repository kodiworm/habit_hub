import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:theme/theme.dart';

import '../../login/widgets/social_login_button_group.dart';
import '../bloc/signup_cubit.dart';
import '../bloc/signup_state.dart';
import '../widgets/signup_form_group.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeResolver.of(context);
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Sign Up Failure'),
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
                AppText.h1('Sign Up'),
                const SizedBox(
                  height: 50,
                ),
                const SocialLoginButtonGroup(),
                SizedBox(height: theme.sizes.m),
                const SignupFormGroup(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
