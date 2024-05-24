import 'package:bologna/common/values/colors.dart';
import 'package:bologna/firebase_options.dart';
import 'package:bologna/sign_in/bloc/singin_bloc.dart';
import 'package:bologna/sign_in/sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SignInBloc()),
        ],
        child: ScreenUtilInit(
          builder: (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                appBarTheme: const AppBarTheme(
                    elevation: 0, backgroundColor: Colors.white,
                    iconTheme: IconThemeData(
                        color: AppColors.primaryText
                    )
                ),
                useMaterial3: true),
            home: const SingIn()

          ),
        ));
  }
}
