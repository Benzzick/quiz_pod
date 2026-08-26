import 'package:get/get.dart';
import 'package:quiz_pod_client/quiz_pod_client.dart';
import 'package:quiz_pod_flutter/main.dart';

class QuizController extends GetxController {
  final quizzes = <Quiz>[].obs;

  final isLoading = false.obs;
  final isAdding = false.obs;
  final isDeleting = false.obs;

  @override
  void onInit() {
    super.onInit();
    getQuizzes();
  }

  Future<void> getQuizzes() async {
    try {
      isLoading.value = true;

      final result = await client.quiz.getQuizes();

      quizzes.assignAll(result);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not load quizzes: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addQuiz({
    required String title,
    required String instructions,
    required List<QuizQuestion> questions,
  }) async {
    try {
      isAdding.value = true;

      final quiz = await client.quiz.addQuiz(
        title,
        instructions,
        questions,
      );

      // Add the newly-created quiz to the top immediately.
      quizzes.insert(0, quiz);

      Get.back();

      Get.snackbar(
        'Success',
        'Quiz created successfully',
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not create quiz: $e',
      );
    } finally {
      isAdding.value = false;
    }
  }

  Future<void> deleteQuiz(Quiz quiz) async {
    try {
      isDeleting.value = true;

      // Call the serverpod soft-delete endpoint
      await client.quiz.deleteQuiz(quiz);

      // Remove the deleted quiz from local list immediately
      quizzes.removeWhere((item) => item.id == quiz.id);

      Get.snackbar(
        'Success',
        'Quiz deleted successfully',
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not delete quiz: $e',
      );
    } finally {
      isDeleting.value = false;
    }
  }
}
