import 'package:encrypt/encrypt.dart';

class EncryptionUtil {
  final _key = Key.fromUtf8('my 32 length key................');
  final _iv = IV.fromLength(16);

  String encrypt(String text) {
    final encrypter = Encrypter(AES(_key));
    final encrypted = encrypter.encrypt(text, iv: _iv);
    return encrypted.base64;
  }

  String decrypt(String text) {
    final encrypter = Encrypter(AES(_key));
    final decrypted = encrypter.decrypt64(text, iv: _iv);
    return decrypted;
  }
}
