import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:routemaster/routemaster.dart';
import 'package:twitter_clone/core/common/widgets/input_text_field.dart';
import 'package:twitter_clone/core/common/widgets/rounded_filled_button.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';

import '../../../theme/palette.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void navigateToSignupScreen(BuildContext context) {
    Routemaster.of(context).push('/signup-screen');
  }

  void login(BuildContext context, WidgetRef ref){
    if(_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty){
      ref.read(authControllerProvider.notifier).login(context: context, email: _emailController.text.trim(), password: _passwordController.text.trim());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.read(themeProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background,
        title: SvgPicture.asset(
          'assets/twitter-logo.svg',
          colorFilter: const ColorFilter.mode(
            Palette.blueColor,
            BlendMode.srcIn,
          ),
          fit: BoxFit.scaleDown,
          width: 35,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Log in to Twitter',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InputTextField(
                    controller: _emailController,
                    label: 'Email',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputTextField(
                    controller: _passwordController,
                    label: 'Password',
                    obscured: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RoundedFilledButton(
                    function: () {
                      ref.read(authControllerProvider.notifier).login(context: context, email: _emailController.text.trim(), password: _passwordController.text.trim());
                    },
                    label: 'Log in',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(color: Palette.blueColor),
                        ),
                      ),
                      const Text(' • '),
                      InkWell(
                        onTap: () => navigateToSignupScreen(context),
                        child: const Text(
                          'Sign up for Twitter',
                          style: TextStyle(color: Palette.blueColor),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
