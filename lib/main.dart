
import 'package:e_learning_dathboard/admin_screens/admin_home/admin_home.dart';
import 'package:e_learning_dathboard/admin_screens/splash_screen/splash_screen.dart';
import 'package:e_learning_dathboard/business_logic/app_cubit/app_cubit.dart';
import 'package:e_learning_dathboard/constants/cache_helper.dart';
import 'package:e_learning_dathboard/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/app_cubit/app_states.dart';
import 'styles/color_manager.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Nunito',
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: ColorManager.white,
              appBarTheme: AppBarTheme(
                titleSpacing: 0.0,
                backgroundColor: ColorManager.white,
                elevation: 0.0,
                iconTheme: IconThemeData(
                  color: ColorManager.black,
                ),
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarColor: Colors.white,
                ),
              ),
            ),
            home: const SplashScreen(),

          );
        },
      ),
    );
  }
}

