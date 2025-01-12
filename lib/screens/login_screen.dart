import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:sign_button/sign_button.dart';
import 'package:habit_hub/config/constraint.dart';

final GetIt getIt = GetIt.instance;
const List<Widget> screenContent = [
  WelcomeToText(),
  SizedBox(
    height: 100,
  ),
  BrandQuoteText(),
  SignInButtons(),
  AuthDeclaration(),
];

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      body: SafeArea(
        child: Center(
          child: MediaQuery.of(context).size.height > 500
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: screenContent,
                )
              : ListView(
                  children: screenContent,
                ),
        ),
      ),
    );
  }
}

class WelcomeToText extends StatelessWidget {
  const WelcomeToText({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: defaultTopPadding,
          child: Text(
            'Welcome to',
            style: themeData.textTheme.bodyMedium?.copyWith(
              color: themeData.colorScheme.outline,
              fontSize: 30,
            ),
          ),
        ),
        Text(
          'Habits Hub',
          style: themeData.textTheme.bodyLarge?.copyWith(
            fontFamily: 'Montserrat',
            color: themeData.colorScheme.primary,
            height: 1,
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class BrandQuoteText extends StatelessWidget {
  const BrandQuoteText({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Padding(
      padding: defaultHorizontalViewPadding,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Track, manage and improve your habits ',
          style: themeData.textTheme.bodyMedium?.copyWith(
            color: themeData.colorScheme.outline,
            fontSize: 25,
          ),
          children: [
            TextSpan(
              text: 'for a better life',
              style: themeData.textTheme.bodyMedium?.copyWith(
                color: themeData.colorScheme.primary,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationThickness: 0.5,
                decorationColor: themeData.colorScheme.primary,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SignInCustomButton extends StatelessWidget {
  final ButtonType type;
  final Function() onPressed;
  const SignInCustomButton(
      {super.key, required this.type, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SignInButton(
      buttonType: type,
      buttonSize: ButtonSize.medium,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

class SignInButtons extends StatelessWidget {
  const SignInButtons({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: defaultTopPadding,
          child: Center(
            child: SignInCustomButton(
              type: ButtonType.googleDark,
              onPressed: () => {context.go('/home')},
            ),
          ),
        ),
        Padding(
          padding: defaultTopPadding / 2,
          child: Center(
            child: SignInCustomButton(
              type: ButtonType.appleDark,
              onPressed: () => {context.go('/home')},
            ),
          ),
        ),
        Padding(
          padding: defaultTopPadding,
          child: InkWell(
            onTap: () {
              context.go('/home');
            },
            child: Text(
              'OR SIGN IN LATER',
              style: themeData.textTheme.bodyMedium?.copyWith(
                color: themeData.colorScheme.outline,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AuthDeclaration extends StatelessWidget {
  const AuthDeclaration({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Padding(
      padding: defaultHorizontalViewPadding.add(
        defaultTopPadding,
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'By continuing, you agree to our ',
          style: themeData.textTheme.bodyMedium?.copyWith(
            color: themeData.colorScheme.outline,
            fontSize: 15,
          ),
          children: [
            TextSpan(
              text: 'Terms of Service',
              style: themeData.textTheme.bodyMedium?.copyWith(
                color: themeData.colorScheme.primary,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationThickness: 0.5,
                decorationColor: themeData.colorScheme.primary,
                fontSize: 15,
              ),
            ),
            TextSpan(
              text: 'and',
              style: themeData.textTheme.bodyMedium?.copyWith(
                color: themeData.colorScheme.outline,
                fontSize: 15,
              ),
            ),
            TextSpan(
              text: 'Privacy Policy',
              style: themeData.textTheme.bodyMedium?.copyWith(
                color: themeData.colorScheme.primary,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationThickness: 0.5,
                decorationColor: themeData.colorScheme.primary,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
