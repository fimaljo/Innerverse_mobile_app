import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:innerverse/app.dart';
import 'package:innerverse/core/di/injection_container.dart' as di;
import 'package:innerverse/core/navigation/app_router.dart';
import 'package:innerverse/core/navigation/route_tracker.dart';
import 'package:innerverse/core/utils/app_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  final routeTracker = RouteTracker();
  final router = AppRouter.createRouter(routeTracker);
  await di.setupServiceLocator(router, routeTracker);

  Bloc.observer = AppBlocObserver();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    InnerverseApp(router: router),
  );
}

//  runApp(
//     DevicePreview(
//       builder: (context) => const InnerverseApp(), // Wrap your app
//     ),
//   );
