import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_pod_client/quiz_pod_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../main.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  /// Handles routing based on whether the user already has a role set in the DB
  Future<void> _handlePostAuthRedirect() async {
    try {
      // 1. Fetch user profile from database
      final profile = await client.user.getUserProfile();

      // 2. If profile exists and role is assigned, bypass selection dialog
      if (profile != null) {
        Get.offAll(() => const MyHomePage(title: 'QuizPod Home'));
      } else {
        // 3. Otherwise, prompt user to select role
        await _showRoleSelectionDialog();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to retrieve profile: $e');
    }
  }

  Future<void> _showRoleSelectionDialog() async {
    UserScopes selectedRole = UserScopes.student;

    await Get.defaultDialog(
      title: 'Select Your Role',
      barrierDismissible: false,
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            children: [
              const Text('Please select how you will be using QuizPod:'),
              const SizedBox(height: 16),
              RadioListTile<UserScopes>(
                title: const Text('Student'),
                value: UserScopes.student,
                groupValue: selectedRole,
                onChanged: (val) {
                  if (val != null) setState(() => selectedRole = val);
                },
              ),
              RadioListTile<UserScopes>(
                title: const Text('Teacher'),
                value: UserScopes.teacher,
                groupValue: selectedRole,
                onChanged: (val) {
                  if (val != null) setState(() => selectedRole = val);
                },
              ),
            ],
          );
        },
      ),
      textConfirm: 'Continue',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        try {
          // Persist selected role into database
          await client.user.updateUserRole(selectedRole);

          Get.back();
          Get.offAll(() => const MyHomePage(title: 'QuizPod Home'));
        } catch (e) {
          Get.snackbar('Error', 'Failed to update role: $e');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.quiz,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 16),
              const Text(
                'Welcome to QuizPod',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              SignInWidget(
                client: client,
                emailSignInWidget: EmailSignInWidget(
                  client: client,
                  startScreen: EmailFlowScreen.startRegistration,
                  onAuthenticated: () {
                    _handlePostAuthRedirect();
                  },
                  onError: (error) {
                    Get.showSnackbar(
                      GetSnackBar(
                        messageText: Text('Error: $error'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
