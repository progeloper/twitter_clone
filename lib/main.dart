import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:twitter_clone/core/common/error_text.dart';
import 'package:twitter_clone/core/common/loader.dart';
import 'package:twitter_clone/models/user.dart' as model;
import 'package:twitter_clone/features/auth/screens/details_screen.dart';
import 'package:twitter_clone/features/auth/screens/login_screen.dart';
import 'package:twitter_clone/features/auth/screens/signup_screen.dart';
import 'package:twitter_clone/router.dart';
import 'package:twitter_clone/theme/palette.dart';
import 'features/auth/controller/auth_controller.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  model.User? userModel;
  int ctr = 0;

  void getData(WidgetRef ref, User user) async {
    userModel = await ref
        .read(authControllerProvider.notifier)
        .getUserData(user.uid)
        .first;
    ref.watch(userProvider.notifier).update((state) => userModel);
    if (ctr == 0) {
      ctr++;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
          data: (data) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: Palette.lightsOutModeAppTheme,
            routerDelegate: RoutemasterDelegate(
              routesBuilder: (context) {
                if (data != null) {
                  getData(ref, data);
                  if(userModel == null){
                    return loggedOutRoute;
                  }
                }
                return loggedOutRoute;
              },
            ),
            routeInformationParser: const RoutemasterParser(),
          ),
          error: (err, stack) => ErrorText(error: err.toString()),
          loading: () => const Loader(),
        );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Twitter Clone',
//       theme: Palette.lightsOutModeAppTheme,
//       home: const DetailsScreen(name: 'mayo', email: 'maayo@email.com', dob: '14 aug 1998'),
//     );
//   }
// }
