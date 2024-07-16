import 'package:flutter/material.dart';
import 'package:app_api/app/page/auth/login.dart';
import 'package:app_api/app/page/cart/cart_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      // initialRoute: "/",
      // onGenerateRoute: AppRoute.onGenerateRoute,  -> su dung auto route (pushName)
    );
  }
}
