// import 'package:quiz_pod_client/quiz_pod_client.dart';
// import 'package:flutter/material.dart';
// import 'package:serverpod_flutter/serverpod_flutter.dart';
// import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

// import 'screens/greetings_screen.dart';

// /// Sets up a global client object that can be used to talk to the server from
// /// anywhere in our app. The client is generated from your server code
// /// and is set up to connect to a Serverpod running on a local server on
// /// the default port. You will need to modify this to connect to staging or
// /// production servers.
// /// In a larger app, you may want to use the dependency injection of your choice
// /// instead of using a global client object. This is just a simple example.
// late final Client client;

// late String serverUrl;

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // When you are running the app on a physical device, you need to set the
//   // server URL to the IP address of your computer. You can find the IP
//   // address by running `ipconfig` on Windows or `ifconfig` on Mac/Linux.
//   //
//   // You can set the variable when running or building your app like this:
//   // E.g. `flutter run --dart-define=SERVER_URL=https://api.example.com/`.
//   //
//   // Otherwise, the server URL is fetched from the assets/config.json file or
//   // defaults to http://$localhost:8080/ if not found.
//   final serverUrl = await getServerUrl();

//   client = Client(serverUrl)
//     ..connectivityMonitor = FlutterConnectivityMonitor()
//     ..authSessionManager = FlutterAuthSessionManager();

//   client.auth.initialize();

//   runApp(const MyApp());
// }

// /// Builds a theme for the given [brightness].
// ThemeData _buildTheme(Brightness brightness) {
//   return ThemeData(
//     colorScheme: ColorScheme.fromSeed(
//       seedColor: Colors.blue,
//       brightness: brightness,
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Serverpod Demo',
//       theme: _buildTheme(Brightness.light),
//       darkTheme: _buildTheme(Brightness.dark),
//       themeMode: ThemeMode.system,
//       home: const MyHomePage(title: 'Serverpod Example'),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(title)),
//       body: const GreetingsScreen(),
//       // To test authentication in this example app, uncomment the line below
//       // and comment out the line above. This wraps the GreetingsScreen with a
//       // SignInScreen, which automatically shows a sign-in UI when the user is
//       // not authenticated and displays the GreetingsScreen once they sign in.
//       //
//       // body: SignInScreen(
//       //   child: GreetingsScreen(
//       //     onSignOut: () async {
//       //       await client.auth.signOutDevice();
//       //     },
//       //   ),
//       // ),
//     );
//   }
// }
import 'package:quiz_pod_client/quiz_pod_client.dart';
import 'package:flutter/material.dart';
import 'package:quiz_pod_flutter/controllers/auth_controller.dart';
import 'package:quiz_pod_flutter/screens/add_quiz_page.dart';
import 'package:quiz_pod_flutter/screens/login_page.dart';
import 'package:quiz_pod_flutter/screens/manage_students_pane.dart';
import 'package:quiz_pod_flutter/screens/take_quiz_page.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:get/get.dart';

import 'controllers/quiz_controller.dart';

/// Sets up a global client object that can be used to talk to the server from
/// anywhere in our app. The client is generated from your server code
/// and is set up to connect to a Serverpod running on a local server on
/// the default port. You will need to modify this to connect to staging or
/// production servers.
/// In a larger app, you may want to use the dependency injection of your choice
/// instead of using a global client object. This is just a simple example.
late final Client client;

late String serverUrl;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // When you are running the app on a physical device, you need to set the
  // server URL to the IP address of your computer. You can find the IP
  // address by running `ipconfig` on Windows or `ifconfig` on Mac/Linux.
  //
  // You can set the variable when running or building your app like this:
  // E.g. `flutter run --dart-define=SERVER_URL=https://api.example.com/`.
  //
  // Otherwise, the server URL is fetched from the assets/config.json file or
  // defaults to http://$localhost:8080/ if not found.
  final serverUrl = await getServerUrl();

  client = Client(serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();

  client.auth.initialize();
  Get.put(QuizController());
  Get.put(AuthController());

  runApp(const MyApp());
}

/// Builds a theme for the given [brightness].
ThemeData _buildTheme(Brightness brightness) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: brightness,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Serverpod Demo',
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: ThemeMode.system,
      home: client.auth.isAuthenticated
          ? const MyHomePage(title: 'QuizPod Home')
          : const LoginPage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  void _confirmDelete(
    BuildContext context,
    QuizController controller,
    Quiz quiz,
  ) {
    Get.defaultDialog(
      title: 'Delete Quiz',
      middleText: 'Are you sure you want to delete "${quiz.title}"?',
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        Get.back();
        controller.deleteQuiz(quiz);
      },
    );
  }

  void _openManageStudentsPane(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const ManageStudentsPane(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuizController>();
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: const Icon(Icons.group_add),
            tooltip: 'Manage Students',
            onPressed: () => _openManageStudentsPane(context),
          ),
          IconButton(
            onPressed: authController.signOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Stack overlay when deleting
        return Stack(
          children: [
            if (controller.quizzes.isEmpty)
              const Center(
                child: Text(
                  'No quizzes yet.\nCreate your first quiz.',
                  textAlign: TextAlign.center,
                ),
              )
            else
              RefreshIndicator(
                onRefresh: controller.getQuizzes,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.quizzes.length,
                  itemBuilder: (context, index) {
                    final quiz = controller.quizzes[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        title: Text(
                          quiz.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${quiz.questions.length} questions\n${quiz.instructions}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        isThreeLine: true,
                        onTap: () => Get.to(
                          () => TakeQuizPage(quiz: quiz),
                        ), // Tapping opens quiz
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () =>
                                  Get.to(() => AddQuizPage(quiz: quiz)),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () =>
                                  _confirmDelete(context, controller, quiz),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

            // Loading overlay during deletion
            if (controller.isDeleting.value)
              Container(
                color: Colors.black,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(() => const AddQuizPage()),
        icon: const Icon(Icons.add),
        label: const Text('Add Quiz'),
      ),
    );
  }
}
