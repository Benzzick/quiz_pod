import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_pod_flutter/controllers/student_controller.dart';

class ManageStudentsPane extends StatelessWidget {
  const ManageStudentsPane({super.key});

  @override
  Widget build(BuildContext context) {
    final studentController = Get.put(StudentController());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'All Registered Students',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Select students from the system directory to add them to your class roster.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          Obx(() {
            if (studentController.isLoading.value) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            if (studentController.allStudents.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: Center(child: Text('No registered students found.')),
              );
            }

            return SizedBox(
              height: 350,
              child: ListView.separated(
                itemCount: studentController.allStudents.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final student = studentController.allStudents[index];
                  final isAdded = studentController.assignedStudentIds.contains(
                    student.authUserId.uuid,
                  );

                  return ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(
                      'Student ID: ${student.authUserId.uuid.substring(0, 8)}...',
                    ),
                    subtitle: Text(student.authUserId.uuid),
                    trailing: isAdded
                        ? const Chip(
                            avatar: Icon(Icons.check, size: 16),
                            label: Text('Added'),
                          )
                        : ElevatedButton.icon(
                            icon: const Icon(Icons.add, size: 16),
                            label: const Text('Add'),
                            onPressed: () => studentController.addStudent(
                              student.authUserId,
                            ),
                          ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
