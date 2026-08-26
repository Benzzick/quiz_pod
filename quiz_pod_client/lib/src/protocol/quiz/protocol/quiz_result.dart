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

abstract class QuizResult implements _i1.SerializableModel {
  QuizResult._({
    required this.quizId,
    required this.totalQuestions,
    required this.score,
  });

  factory QuizResult({
    required int quizId,
    required int totalQuestions,
    required int score,
  }) = _QuizResultImpl;

  factory QuizResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuizResult(
      quizId: jsonSerialization['quizId'] as int,
      totalQuestions: jsonSerialization['totalQuestions'] as int,
      score: jsonSerialization['score'] as int,
    );
  }

  int quizId;

  int totalQuestions;

  int score;

  /// Returns a shallow copy of this [QuizResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QuizResult copyWith({
    int? quizId,
    int? totalQuestions,
    int? score,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuizResult',
      'quizId': quizId,
      'totalQuestions': totalQuestions,
      'score': score,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _QuizResultImpl extends QuizResult {
  _QuizResultImpl({
    required int quizId,
    required int totalQuestions,
    required int score,
  }) : super._(
         quizId: quizId,
         totalQuestions: totalQuestions,
         score: score,
       );

  /// Returns a shallow copy of this [QuizResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QuizResult copyWith({
    int? quizId,
    int? totalQuestions,
    int? score,
  }) {
    return QuizResult(
      quizId: quizId ?? this.quizId,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      score: score ?? this.score,
    );
  }
}
