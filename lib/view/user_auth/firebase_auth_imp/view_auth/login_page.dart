import 'package:e_shop/utils/cyptage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../service/firebase_auth_service.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final EncryptionUtil _encryptionUtil = EncryptionUtil();

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    // Implement your login logic here
    // Encrypt the email and password
    String encryptedEmail = _encryptionUtil.encrypt(email);
    String encryptedPassword = _encryptionUtil.encrypt(password);

    // Print the encrypted email and password
    print('Encrypted Email: $encryptedEmail');
    print('Encrypted Password: $encryptedPassword');
    User? user = await _auth.signInWithEmailAndPassword(email, password);
    if (user != null) {
      // Encrypt and save the email and password
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', _encryptionUtil.encrypt(email));
      await prefs.setString('password', _encryptionUtil.encrypt(password));

      print('User is successfully created');
      Navigator.pushNamed(context, "/product");
    }
    print('Email: $email, Password: $password');
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: _navigateToRegister,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
