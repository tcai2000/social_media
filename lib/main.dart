import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:social_media/config/firebase_options.dart';
import 'package:social_media/config/providers.dart';
import 'package:social_media/constants/themes.dart';
import 'package:social_media/config/app_routes.dart';
import 'package:social_media/config/routes.dart';
import 'package:social_media/models/user/user_hive.dart';
import 'package:social_media/views/index.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

late List<CameraDescription> cameraList;

Future<void> main() async {
  // run some necessary for application

  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that plugin services are initialized
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(UserHiveAdapter());
  //var box = await Hive.openBox("test");
  await Hive.openBox("myBox");
  //box.clear();
  // Load file env
  await dotenv.load(fileName: ".env");
  cameraList = await availableCameras();

  // Get a specific camera from the list of available cameras.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: providers,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Social Media App',
            theme: AppThemes.lightTheme,
            initialRoute: Routes.splashRoute,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            home: child,
            builder: EasyLoading.init(),
          ),
        );
      },
    );
  }
}
