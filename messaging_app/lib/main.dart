import 'package: flutter/material.dart';
import 'package:firebase_core/firebase-core.dart';
import 'package: provider/provider.dart';
import 'app/app_router.dart';
import 'services/auth_service.dart';
import 'screens/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MessageBoardApp());
}

class MessageBoardApp extends StatelessWidget {
  const MessageBoardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthService>(
          create: (_) => AuthService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Message Board App',

        // Theme (you can modify later)
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true
        ),

        // Routes
        onGenerateRoute: AppRouter.generateRoute,

        // First screen
        home: const SplashScreen(),
      ),
    );
  }
}