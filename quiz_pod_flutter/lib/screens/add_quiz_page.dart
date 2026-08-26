import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_pod_client/quiz_pod_client.dart';
import 'package:quiz_pod_flutter/controllers/quiz_controller.dart';

class AddQuizPage extends StatefulWidget {
  final Quiz? quiz;

  const AddQuizPage({super.key, this.quiz});

  @override
  State<AddQuizPage> createState() => _AddQuizPageState();
}

class _AddQuizPageState extends State<AddQuizPage> {
  final titleController = TextEditingController();
  final instructionsController = TextEditingController();

  // New question form controllers
  final questionController = TextEditingController();
  final option1Controller = TextEditingController();
  final option2Controller = TextEditingController();
  final option3Controller = TextEditingController();
  final option4Controller = TextEditingController();

  int answerIndex = 0;

  // Track index of question currently being edited in the list (-1 means none)
  int editingIndex = -1;

  // Controllers for the question currently under edit
  final editQuestionController = TextEditingController();
  final editOption1Controller = TextEditingController();
  final editOption2Controller = TextEditingController();
  final editOption3Controller = TextEditingController();
  final editOption4Controller = TextEditingController();
  int editAnswerIndex = 0;

  final questions = <QuizQuestion>[];

  @override
  void initState() {
    super.initState();
    // Populate form fields if editing an existing quiz
    if (widget.quiz != null) {
      titleController.text = widget.quiz!.title;
      instructionsController.text = widget.quiz!.instructions;
      questions.addAll(widget.quiz!.questions);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    instructionsController.dispose();

    questionController.dispose();
    option1Controller.dispose();
    option2Controller.dispose();
    option3Controller.dispose();
    option4Controller.dispose();

    editQuestionController.dispose();
    editOption1Controller.dispose();
    editOption2Controller.dispose();
    editOption3Controller.dispose();
    editOption4Controller.dispose();

    super.dispose();
  }

  void addQuestion() {
    if (questionController.text.trim().isEmpty) {
      return;
    }

    final question = QuizQuestion(
      question: questionController.text.trim(),
      options: [
        option1Controller.text.trim(),
        option2Controller.text.trim(),
        option3Controller.text.trim(),
        option4Controller.text.trim(),
      ],
      answerIndex: answerIndex,
    );

    setState(() {
      questions.add(question);

      questionController.clear();
      option1Controller.clear();
      option2Controller.clear();
      option3Controller.clear();
      option4Controller.clear();

      answerIndex = 0;
    });
  }

  void startEditing(int index) {
    final q = questions[index];
    setState(() {
      editingIndex = index;
      editQuestionController.text = q.question;
      editOption1Controller.text = q.options.length > 0 ? q.options[0] : '';
      editOption2Controller.text = q.options.length > 1 ? q.options[1] : '';
      editOption3Controller.text = q.options.length > 2 ? q.options[2] : '';
      editOption4Controller.text = q.options.length > 3 ? q.options[3] : '';
      editAnswerIndex = q.answerIndex;
    });
  }

  void saveEditing(int index) {
    if (editQuestionController.text.trim().isEmpty) return;

    final updatedQuestion = QuizQuestion(
      question: editQuestionController.text.trim(),
      options: [
        editOption1Controller.text.trim(),
        editOption2Controller.text.trim(),
        editOption3Controller.text.trim(),
        editOption4Controller.text.trim(),
      ],
      answerIndex: editAnswerIndex,
    );

    setState(() {
      questions[index] = updatedQuestion;
      editingIndex = -1;
    });
  }

  void cancelEditing() {
    setState(() {
      editingIndex = -1;
    });
  }

  Future<void> saveQuiz() async {
    if (titleController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Enter a quiz title');
      return;
    }

    if (questions.isEmpty) {
      Get.snackbar(
        'Error',
        'Add at least one question',
      );
      return;
    }

    final controller = Get.find<QuizController>();

    await controller.addQuiz(
      title: titleController.text.trim(),
      instructions: instructionsController.text.trim(),
      questions: questions,
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuizController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Quiz'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Quiz title',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: instructionsController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Instructions',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Questions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            if (questions.isNotEmpty)
              ...questions.asMap().entries.map(
                (entry) {
                  final index = entry.key;
                  final question = entry.value;

                  if (editingIndex == index) {
                    return _buildEditQuestionCard(index);
                  }

                  return Card(
                    child: ListTile(
                      title: Text(
                        '${index + 1}. ${question.question}',
                      ),
                      subtitle: Text(
                        'Correct: Option ${question.answerIndex + 1} • ${question.options.length} options',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => startEditing(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                questions.removeAt(index);
                                if (editingIndex == index) editingIndex = -1;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

            const SizedBox(height: 16),

            const Text(
              'Add Question',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: questionController,
              decoration: const InputDecoration(
                labelText: 'Question',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            _optionField(
              controller: option1Controller,
              label: 'Option 1',
            ),

            const SizedBox(height: 8),

            _optionField(
              controller: option2Controller,
              label: 'Option 2',
            ),

            const SizedBox(height: 8),

            _optionField(
              controller: option3Controller,
              label: 'Option 3',
            ),

            const SizedBox(height: 8),

            _optionField(
              controller: option4Controller,
              label: 'Option 4',
            ),

            const SizedBox(height: 12),

            DropdownButtonFormField<int>(
              value: answerIndex,
              decoration: const InputDecoration(
                labelText: 'Correct answer',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 0, child: Text('Option 1')),
                DropdownMenuItem(value: 1, child: Text('Option 2')),
                DropdownMenuItem(value: 2, child: Text('Option 3')),
                DropdownMenuItem(value: 3, child: Text('Option 4')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    answerIndex = value;
                  });
                }
              },
            ),

            const SizedBox(height: 16),

            OutlinedButton.icon(
              onPressed: addQuestion,
              icon: const Icon(Icons.add),
              label: const Text('Add Question'),
            ),

            const SizedBox(height: 32),

            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: controller.isAdding.value ? null : saveQuiz,
                  child: controller.isAdding.value
                      ? const CircularProgressIndicator()
                      : const Text('Create Quiz'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditQuestionCard(int index) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Editing Question #${index + 1}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: editQuestionController,
              decoration: const InputDecoration(
                labelText: 'Question text',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            _optionField(controller: editOption1Controller, label: 'Option 1'),
            const SizedBox(height: 4),
            _optionField(controller: editOption2Controller, label: 'Option 2'),
            const SizedBox(height: 4),
            _optionField(controller: editOption3Controller, label: 'Option 3'),
            const SizedBox(height: 4),
            _optionField(controller: editOption4Controller, label: 'Option 4'),
            const SizedBox(height: 8),
            DropdownButtonFormField<int>(
              value: editAnswerIndex,
              decoration: const InputDecoration(
                labelText: 'Correct answer',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 0, child: Text('Option 1')),
                DropdownMenuItem(value: 1, child: Text('Option 2')),
                DropdownMenuItem(value: 2, child: Text('Option 3')),
                DropdownMenuItem(value: 3, child: Text('Option 4')),
              ],
              onChanged: (val) {
                if (val != null) setState(() => editAnswerIndex = val);
              },
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: cancelEditing,
                  child: const Text('Cancel'),
                ),
                ElevatedButton.icon(
                  onPressed: () => saveEditing(index),
                  icon: const Icon(Icons.check, size: 18),
                  label: const Text('Save Changes'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _optionField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
