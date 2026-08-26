import 'package:quiz_pod_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

class TeacherEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Adds a student to the teacher's roster if not already present.
  Future<void> addStudent(Session session, UuidValue studentUserId) async {
    final authenticated = session.authenticated;
    if (authenticated == null) throw FormatException('Not authenticated');

    final profile = await AppUserProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authenticated.authUserId),
    );

    if (profile?.role != UserScopes.teacher) {
      throw FormatException('Only teachers can manage student rosters.');
    }

    final existingRelation = await TeacherStudent.db.findFirstRow(
      session,
      where: (t) =>
          t.teacherUserId.equals(authenticated.authUserId) &
          t.studentUserId.equals(studentUserId),
    );

    if (existingRelation != null) return;

    await TeacherStudent.db.insertRow(
      session,
      TeacherStudent(
        teacherUserId: authenticated.authUserId,
        studentUserId: studentUserId,
      ),
    );
  }

  /// Returns all registered student profiles in the platform.
  Future<List<AppUserProfile>> getAllStudents(Session session) async {
    final authenticated = session.authenticated;
    if (authenticated == null) throw FormatException('Not authenticated');

    final profile = await AppUserProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authenticated.authUserId),
    );

    if (profile?.role != UserScopes.teacher) {
      throw FormatException('Only teachers can view registered students.');
    }

    // Fetch all user profiles with the student scope
    return await AppUserProfile.db.find(
      session,
      where: (t) => t.role.equals(UserScopes.student),
    );
  }

  /// Returns only the UUIDs of students currently assigned to this teacher.
  Future<List<UuidValue>> getAssignedStudentIds(Session session) async {
    final authenticated = session.authenticated;
    if (authenticated == null) throw FormatException('Not authenticated');

    final relations = await TeacherStudent.db.find(
      session,
      where: (t) => t.teacherUserId.equals(authenticated.authUserId),
    );

    return relations.map((e) => e.studentUserId).toList();
  }
}
