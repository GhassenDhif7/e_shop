import 'package:e_shop/utils/cyptage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RetrieveDataExample extends StatelessWidget {
  final EncryptionUtil _encryptionUtil = EncryptionUtil();

  RetrieveDataExample({super.key});

  Future<Map<String, String>> _getUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    String encryptedEmail = prefs.getString('email') ?? '';
    String encryptedPassword = prefs.getString('password') ?? '';

    String email = _encryptionUtil.decrypt(encryptedEmail);
    String password = _encryptionUtil.decrypt(encryptedPassword);

    return {'email': email, 'password': password};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retrieve Credentials'),
      ),
      body: FutureBuilder<Map<String, String>>(
        future: _getUserCredentials(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Email: ${snapshot.data!['email']}'),
                Text('Password: ${snapshot.data!['password']}'),
              ],
            );
          } else {
            return const Text('No credentials found');
          }
        },
      ),
    );
  }
}
