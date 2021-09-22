import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:u_commerce/app/screens/screens.dart';
import 'package:u_commerce/data/datasources/product_service.dart';

 
void main() => runApp(AppState());
 
class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=>ProductService()
        )
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'U-Commerce',
      initialRoute: 'login',
      routes: {
        'login': (_) => LoginScreen(),
        'home': (_) => HomeScreen(),
        'product': (_) => ProductScreen()
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[350],
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.indigoAccent
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.indigoAccent,
          elevation: 0
        )
      ),
    );
  }
}