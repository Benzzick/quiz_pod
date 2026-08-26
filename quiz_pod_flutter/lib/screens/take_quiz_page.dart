import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_pod_client/quiz_pod_client.dart';
import 'package:quiz_pod_flutter/main.dart';

class TakeQuizPage extends StatefulWidget {
  final Quiz quiz;

  const TakeQuizPage({super.key, required this.quiz});

  @override
  State<TakeQuizPage> createState() => _TakeQuizPageState();
}

class _TakeQuizPageState extends State<TakeQuizPage> {
  int _currentIndex = 0;
  late final List<int?> _selectedAnswers;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _selectedAnswers = List<int?>.filled(widget.quiz.questions.length, null);
  }

  Future<void> _submitQuiz() async {
    setState(() => _isSubmitting = true);

    try {
      final answers = _selectedAnswers.map((a) => a ?? -1).toList();
      final result = await client.quiz.submitQuiz(widget.quiz.id!, answers);

      if (!mounted) return;

      Get.defaultDialog(
        title: 'Quiz Completed!',
        middleText: 'You scored ${result.score} / ${result.totalQuestions}',
        textConfirm: 'OK',
        onConfirm: () {
          Get.back(); // close dialog
          Get.back(); // return to home
        },
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit quiz: $e');
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.quiz.questions[_currentIndex];
    final totalQuestions = widget.quiz.questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: (_currentIndex + 1) / totalQuestions,
          ),
        ),
      ),
      body: _isSubmitting
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${_currentIndex + 1} of $totalQuestions',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    question.question,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...List.generate(question.options.length, (index) {
                    final isSelected = _selectedAnswers[_currentIndex] == index;
                    return Card(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primaryContainer
                          : null,
                      child: RadioListTile<int>(
                        title: Text(question.options[index]),
                        value: index,
                        groupValue: _selectedAnswers[_currentIndex],
                        onChanged: (val) {
                          setState(() {
                            _selectedAnswers[_currentIndex] = val;
                          });
                        },
                      ),
                    );
                  }),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (_currentIndex > 0)
                        OutlinedButton(
                          onPressed: () => setState(() => _currentIndex--),
                          child: const Text('Previous'),
                        )
                      else
                        const SizedBox.shrink(),
                      if (_currentIndex < totalQuestions - 1)
                        ElevatedButton(
                          onPressed: () => setState(() => _currentIndex++),
                          child: const Text('Next'),
                        )
                      else
                        ElevatedButton(
                          onPressed: _selectedAnswers.contains(null)
                              ? () => Get.snackbar(
                                  'Notice',
                                  'Please answer all questions before submitting.',
                                )
                              : _submitQuiz,
                          child: const Text('Submit Quiz'),
                        ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
