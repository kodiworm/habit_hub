import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:theme/theme.dart';

import 'bloc/signup_cubit.dart';
import 'widgets/signup_form.dart';

final GetIt getIt = GetIt.instance;

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _TranslatedBackground(),
          const _FadedLayer(),
          BlocProvider<SignUpCubit>(
            create: (_) => getIt<SignUpCubit>(),
            child: const SignUpForm(),
          ),
        ],
      ),
    );
  }
}


class _FadedLayer extends StatelessWidget {
  const _FadedLayer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeResolver.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            theme.colors.skin,
            Colors.white.withOpacity(0),
          ],
          stops: const [
            0.65,
            0.8,
          ],
        ),
      ),
    );
  }
}

class _TranslatedBackground extends StatelessWidget {
  const _TranslatedBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -220),
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/splash_screen.png'),
          ),
        ),
      ),
    );
  }
}
