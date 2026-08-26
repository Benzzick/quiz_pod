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
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:quiz_pod_server/src/generated/protocol.dart' as _i2;

abstract class QuizQuestion
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  QuizQuestion._({
    required this.question,
    required this.options,
    required this.answerIndex,
  });

  factory QuizQuestion({
    required String question,
    required List<String> options,
    required int answerIndex,
  }) = _QuizQuestionImpl;

  factory QuizQuestion.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuizQuestion(
      question: jsonSerialization['question'] as String,
      options: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['options'],
      ),
      answerIndex: jsonSerialization['answerIndex'] as int,
    );
  }

  String question;

  List<String> options;

  int answerIndex;

  /// Returns a shallow copy of this [QuizQuestion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  QuizQuestion copyWith({
    String? question,
    List<String>? options,
    int? answerIndex,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuizQuestion',
      'question': question,
      'options': options.toJson(),
      'answerIndex': answerIndex,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuizQuestion',
      'question': question,
      'options': options.toJson(),
      'answerIndex': answerIndex,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _QuizQuestionImpl extends QuizQuestion {
  _QuizQuestionImpl({
    required String question,
    required List<String> options,
    required int answerIndex,
  }) : super._(
         question: question,
         options: options,
         answerIndex: answerIndex,
       );

  /// Returns a shallow copy of this [QuizQuestion]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  QuizQuestion copyWith({
    String? question,
    List<String>? options,
    int? answerIndex,
  }) {
    return QuizQuestion(
      question: question ?? this.question,
      options: options ?? this.options.map((e0) => e0).toList(),
      answerIndex: answerIndex ?? this.answerIndex,
    );
  }
}
