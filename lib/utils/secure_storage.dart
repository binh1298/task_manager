import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Create storage
final flutterSecureStorage = new FlutterSecureStorage();
final jwtTokenName = 'jwtToken';

void setJwtToken(token) {
  flutterSecureStorage.write(key: jwtTokenName, value: token);
}

Future<String> getJwtToken() {
  return flutterSecureStorage.read(key: jwtTokenName);
}