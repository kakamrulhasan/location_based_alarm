import 'package:flutter/material.dart';
import 'package:flutter_application_17/features/home_screen.dart';
import 'package:flutter_application_17/networks/notification_service.dart';
import 'package:provider/provider.dart';
import 'features/onboarding_viewmodel.dart';
import 'features/onboarding_screen.dart';
import 'features/location_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppFlowViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer<AppFlowViewModel>(
        builder: (context, vm, _) {
          switch (vm.state) {
            case AppFlowState.onboarding:
              return const OnboardingScreen();
            case AppFlowState.location:
              return const LocationScreen();
            case AppFlowState.home:
              return const HomeScreen(location: '',);
          }
        },
      ),
    );
  }
}
