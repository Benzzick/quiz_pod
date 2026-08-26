import 'package:get/get.dart';
import 'package:quiz_pod_client/quiz_pod_client.dart';
import 'package:quiz_pod_flutter/main.dart';

class StudentController extends GetxController {
  var isLoading = false.obs;
  var allStudents = <AppUserProfile>[].obs;
  var assignedStudentIds = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadRosterData();
  }

  Future<void> loadRosterData() async {
    isLoading.value = true;
    try {
      final students = await client.teacher.getAllStudents();
      final assignedIds = await client.teacher.getAssignedStudentIds();

      allStudents.assignAll(students);
      assignedStudentIds.assignAll(assignedIds.map((e) => e.uuid));
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch student directory: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addStudent(UuidValue studentUserId) async {
    try {
      await client.teacher.addStudent(studentUserId);
      assignedStudentIds.add(studentUserId.uuid);
      Get.snackbar('Success', 'Student added to your roster!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add student: $e');
    }
  }
}
