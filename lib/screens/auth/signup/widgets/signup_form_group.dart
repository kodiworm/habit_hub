import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:theme/theme.dart';

import '../bloc/signup_cubit.dart';
import '../bloc/signup_state.dart';

class SignupFormGroup extends StatelessWidget {
  const SignupFormGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeResolver.of(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(theme.sizes.l),
          topRight: Radius.circular(theme.sizes.l),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: theme.sizes.m),
            child: AppText.p1('Profile details'),
          ),
          Container(
            width: double.infinity,
            color: theme.colors.skin,
            height: 1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: theme.sizes.l),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: theme.sizes.m),
                const _NameInput(),
                SizedBox(height: theme.sizes.s),
                const _EmailInput(),
                SizedBox(height: theme.sizes.s),
                const _PasswordInput(),
                const _SignupButton(),
                SizedBox(height: theme.sizes.s),
                const _LoginText(),
                SizedBox(height: theme.sizes.xl + theme.sizes.m),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  const _NameInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return AppInput.primary(
          key: const Key('signupForm_nameInput_textField'),
          icon: Icons.account_circle_rounded,
          hintText: 'Name',
          errorText: state.email.invalid ? 'invalid email' : null,
          onChanged: (name) => context.read<SignUpCubit>().nameChanged(name),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return AppInput.primary(
          key: const Key('signupForm_emailInput_textField'),
          icon: Icons.email_outlined,
          hintText: 'Email',
          errorText: state.email.invalid ? 'invalid email' : null,
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        );
      },
    );
  }
}

class _PasswordInput extends StatefulWidget {
  const _PasswordInput({
    Key? key,
  }) : super(key: key);

  @override
  State<_PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return AppInput.primary(
          key: const Key('loginForm_passwordInput_textField'),
          icon: Icons.lock_outline,
          hintText: 'Password',
          obscureText: _obscureText,
          showHiddenInput: _toggle,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
          errorText: state.password.invalid ? 'invalid password' : null,
        );
      },
    );
  }
}

class _SignupButton extends StatelessWidget {
  const _SignupButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeResolver.of(context);
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: theme.sizes.l),
          child: AppButton.primary(
            key: const Key('signupForm_continue_raisedButton'),
            text: 'Sign Up',
            elevation: 5,
            isLoading: state.status.isSubmissionInProgress,
            backgroundColor: theme.colors.sunrise,
            onPressed: state.status.isValidated
                ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                : () => context.go('/home'),
          ),
        );
      },
    );
  }
}

class _LoginText extends StatelessWidget {
  const _LoginText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const Key('loginForm_createAccount_flatButton'),
      onTap: () => context.go('/'),
      child: RichText(
        text: TextSpan(
          text: "Already have an account?",
          style: AppText.styleOf(context, StyleEnum.p3),
          children: [
            const TextSpan(text: '  '),
            TextSpan(
              text: 'Login',
              style: AppText.styleOf(context, StyleEnum.p2),
            )
          ],
        ),
      ),
    );
  }
}
