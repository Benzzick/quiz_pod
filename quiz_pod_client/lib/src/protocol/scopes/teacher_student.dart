/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class TeacherStudent implements _i1.SerializableModel {
  TeacherStudent._({
    this.id,
    required this.teacherUserId,
    required this.studentUserId,
  });

  factory TeacherStudent({
    int? id,
    required _i1.UuidValue teacherUserId,
    required _i1.UuidValue studentUserId,
  }) = _TeacherStudentImpl;

  factory TeacherStudent.fromJson(Map<String, dynamic> jsonSerialization) {
    return TeacherStudent(
      id: jsonSerialization['id'] as int?,
      teacherUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['teacherUserId'],
      ),
      studentUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['studentUserId'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i1.UuidValue teacherUserId;

  _i1.UuidValue studentUserId;

  /// Returns a shallow copy of this [TeacherStudent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TeacherStudent copyWith({
    int? id,
    _i1.UuidValue? teacherUserId,
    _i1.UuidValue? studentUserId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TeacherStudent',
      if (id != null) 'id': id,
      'teacherUserId': teacherUserId.toJson(),
      'studentUserId': studentUserId.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TeacherStudentImpl extends TeacherStudent {
  _TeacherStudentImpl({
    int? id,
    required _i1.UuidValue teacherUserId,
    required _i1.UuidValue studentUserId,
  }) : super._(
         id: id,
         teacherUserId: teacherUserId,
         studentUserId: studentUserId,
       );

  /// Returns a shallow copy of this [TeacherStudent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TeacherStudent copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? teacherUserId,
    _i1.UuidValue? studentUserId,
  }) {
    return TeacherStudent(
      id: id is int? ? id : this.id,
      teacherUserId: teacherUserId ?? this.teacherUserId,
      studentUserId: studentUserId ?? this.studentUserId,
    );
  }
}
