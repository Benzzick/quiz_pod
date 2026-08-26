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
import '../../quiz/protocol/quiz_question.dart' as _i2;
import 'package:quiz_pod_client/src/protocol/protocol.dart' as _i3;

abstract class Quiz implements _i1.SerializableModel {
  Quiz._({
    this.id,
    required this.authorUserId,
    required this.title,
    required this.instructions,
    required this.questions,
  });

  factory Quiz({
    int? id,
    required _i1.UuidValue authorUserId,
    required String title,
    required String instructions,
    required List<_i2.QuizQuestion> questions,
  }) = _QuizImpl;

  factory Quiz.fromJson(Map<String, dynamic> jsonSerialization) {
    return Quiz(
      id: jsonSerialization['id'] as int?,
      authorUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['authorUserId'],
      ),
      title: jsonSerialization['title'] as String,
      instructions: jsonSerialization['instructions'] as String,
      questions: _i3.Protocol().deserialize<List<_i2.QuizQuestion>>(
        jsonSerialization['questions'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i1.UuidValue authorUserId;

  String title;

  String instructions;

  List<_i2.QuizQuestion> questions;

  /// Returns a shallow copy of this [Quiz]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Quiz copyWith({
    int? id,
    _i1.UuidValue? authorUserId,
    String? title,
    String? instructions,
    List<_i2.QuizQuestion>? questions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Quiz',
      if (id != null) 'id': id,
      'authorUserId': authorUserId.toJson(),
      'title': title,
      'instructions': instructions,
      'questions': questions.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuizImpl extends Quiz {
  _QuizImpl({
    int? id,
    required _i1.UuidValue authorUserId,
    required String title,
    required String instructions,
    required List<_i2.QuizQuestion> questions,
  }) : super._(
         id: id,
         authorUserId: authorUserId,
         title: title,
         instructions: instructions,
         questions: questions,
       );

  /// Returns a shallow copy of this [Quiz]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Quiz copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? authorUserId,
    String? title,
    String? instructions,
    List<_i2.QuizQuestion>? questions,
  }) {
    return Quiz(
      id: id is int? ? id : this.id,
      authorUserId: authorUserId ?? this.authorUserId,
      title: title ?? this.title,
      instructions: instructions ?? this.instructions,
      questions:
          questions ?? this.questions.map((e0) => e0.copyWith()).toList(),
    );
  }
}
