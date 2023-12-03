import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

class LoginService {
  static Client client = Client();

  LoginService.init() {
    client
        .setEndpoint('https://cloud.appwrite.io/v1') // Your API Endpoint
        .setProject('rupiah') // Your project ID
        .setSelfSigned(); // Remove in production
  }

  static Future<Token> createAccount(String phoneNo, String userId) async {
    Account account = Account(client);
    return await account.createPhoneSession(
      userId: userId,
      phone: phoneNo,
    );
  }

  static Future<User> updateSession(String userId, String otp) async {
    Account account = Account(client);
    final session = await account.updatePhoneSession(
      userId: userId,
      secret: otp,
    );

    return await account.get();
  }

  static Future<User> getUser() async {
    Account account = Account(client);
    return await account.get();
  }
}
