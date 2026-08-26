import 'package:quiz_pod_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

class QuizEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Creates a new quiz authored by the authenticated teacher.
  Future<Quiz> addQuiz(
    Session session,
    String title,
    String instructions,
    List<QuizQuestion> questions,
  ) async {
    final authenticated = session.authenticated;
    if (authenticated == null) throw FormatException('Not authenticated');

    final profile = await AppUserProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authenticated.authUserId),
    );

    if (profile?.role != UserScopes.teacher) {
      throw FormatException('Only teachers can create quizzes.');
    }

    final quiz = Quiz(
      authorUserId: authenticated.authUserId,
      title: title,
      instructions: instructions,
      questions: questions,
    );

    return await Quiz.db.insertRow(session, quiz);
  }

  /// Returns quizzes filtered by role:
  /// - Teachers see only the quizzes they created.
  /// - Students see only quizzes from teachers assigned to them.
  Future<List<Quiz>> getQuizes(Session session) async {
    final authenticated = session.authenticated;
    if (authenticated == null) throw FormatException('Not authenticated');

    final profile = await AppUserProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authenticated.authUserId),
    );

    // If Teacher: return quizzes created by this teacher
    if (profile?.role == UserScopes.teacher) {
      return await Quiz.db.find(
        session,
        where: (t) => t.authorUserId.equals(authenticated.authUserId),
        orderBy: (t) => t.id,
        orderDescending: true,
      );
    }

    // If Student: fetch assigned teachers and return their quizzes
    final teacherRelations = await TeacherStudent.db.find(
      session,
      where: (t) => t.studentUserId.equals(authenticated.authUserId),
    );

    final assignedTeacherIds = teacherRelations
        .map((e) => e.teacherUserId)
        .toSet();

    if (assignedTeacherIds.isEmpty) return [];

    return await Quiz.db.find(
      session,
      where: (t) => t.authorUserId.inSet(assignedTeacherIds),
      orderBy: (t) => t.id,
      orderDescending: true,
    );
  }

  /// Deletes a quiz after validating teacher role and authorship ownership.
  Future<Quiz> deleteQuiz(Session session, Quiz quiz) async {
    final authenticated = session.authenticated;
    if (authenticated == null) throw FormatException('Not authenticated');

    final profile = await AppUserProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authenticated.authUserId),
    );

    if (profile?.role != UserScopes.teacher) {
      throw FormatException('Only teachers can delete quizzes.');
    }

    final existingQuiz = await Quiz.db.findById(session, quiz.id!);
    if (existingQuiz == null) {
      throw FormatException('Quiz not found');
    }

    if (existingQuiz.authorUserId != authenticated.authUserId) {
      throw FormatException('You can only delete quizzes that you created.');
    }

    return await Quiz.db.deleteRow(session, existingQuiz);
  }

  /// Evaluates and submits a quiz after verifying student assignment.
  Future<QuizResult> submitQuiz(
    Session session,
    int quizId,
    List<int> selectedAnswers,
  ) async {
    final authenticated = session.authenticated;
    if (authenticated == null) throw FormatException('Not authenticated');

    final quiz = await Quiz.db.findById(session, quizId);
    if (quiz == null) throw FormatException('Quiz not found');

    // Verify student is assigned to the quiz author
    final isAssigned = await TeacherStudent.db.findFirstRow(
      session,
      where: (t) =>
          t.teacherUserId.equals(quiz.authorUserId) &
          t.studentUserId.equals(authenticated.authUserId),
    );

    if (isAssigned == null) {
      throw FormatException(
        'You are not assigned to the teacher who created this quiz.',
      );
    }

    int score = 0;
    for (int i = 0; i < quiz.questions.length; i++) {
      if (i < selectedAnswers.length &&
          selectedAnswers[i] == quiz.questions[i].answerIndex) {
        score++;
      }
    }

    return QuizResult(
      quizId: quizId,
      totalQuestions: quiz.questions.length,
      score: score,
    );
  }
}
