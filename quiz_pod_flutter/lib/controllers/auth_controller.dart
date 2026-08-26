// lib/controllers/auth_controller.dart
import 'package:get/get.dart';
import 'package:quiz_pod_flutter/main.dart';
import 'package:quiz_pod_flutter/screens/login_page.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart'; // REQUIRED for client.auth extension

class AuthController extends GetxController {
  Future<void> signOut() async {
    await client.auth.signOutDevice();
    Get.to(LoginPage());
  }
}
