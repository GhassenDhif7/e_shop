import 'package:e_shop/controller/carteProvider.dart';
import 'package:e_shop/controller/productProvider.dart';
import 'package:e_shop/view/user_auth/cartPage.dart';
import 'package:e_shop/view/user_auth/firebase_auth_imp/view_auth/login_page.dart';
import 'package:e_shop/view/user_auth/firebase_auth_imp/view_auth/register_page.dart';
import 'package:e_shop/view/user_auth/productListPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductProvider()..loadProducts(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'Product List',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginPage(),
        routes: {
          '/register': (context) => const RegisterPage(),
          '/login': (context) => const LoginPage(),
          '/product' : (context) => const ProductListPage(),
          '/cart': (context) => CartPage(),

        },
      ),
    );
  }
}
