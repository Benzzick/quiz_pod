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
import '../../quiz/protocol/quiz_question.dart' as _i2;
import 'package:quiz_pod_server/src/generated/protocol.dart' as _i3;

abstract class Quiz implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = QuizTable();

  static const db = QuizRepository._();

  @override
  int? id;

  _i1.UuidValue authorUserId;

  String title;

  String instructions;

  List<_i2.QuizQuestion> questions;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Quiz',
      if (id != null) 'id': id,
      'authorUserId': authorUserId.toJson(),
      'title': title,
      'instructions': instructions,
      'questions': questions.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static QuizInclude include() {
    return QuizInclude._();
  }

  static QuizIncludeList includeList({
    _i1.WhereExpressionBuilder<QuizTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuizTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuizTable>? orderByList,
    QuizInclude? include,
  }) {
    return QuizIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Quiz.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Quiz.t),
      include: include,
    );
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

class QuizUpdateTable extends _i1.UpdateTable<QuizTable> {
  QuizUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> authorUserId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.authorUserId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> instructions(String value) => _i1.ColumnValue(
    table.instructions,
    value,
  );

  _i1.ColumnValue<List<_i2.QuizQuestion>, List<_i2.QuizQuestion>> questions(
    List<_i2.QuizQuestion> value,
  ) => _i1.ColumnValue(
    table.questions,
    value,
  );
}

class QuizTable extends _i1.Table<int?> {
  QuizTable({super.tableRelation}) : super(tableName: 'quizes') {
    updateTable = QuizUpdateTable(this);
    authorUserId = _i1.ColumnUuid(
      'authorUserId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    instructions = _i1.ColumnString(
      'instructions',
      this,
    );
    questions = _i1.ColumnSerializable<List<_i2.QuizQuestion>>(
      'questions',
      this,
    );
  }

  late final QuizUpdateTable updateTable;

  late final _i1.ColumnUuid authorUserId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString instructions;

  late final _i1.ColumnSerializable<List<_i2.QuizQuestion>> questions;

  @override
  List<_i1.Column> get columns => [
    id,
    authorUserId,
    title,
    instructions,
    questions,
  ];
}

class QuizInclude extends _i1.IncludeObject {
  QuizInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Quiz.t;
}

class QuizIncludeList extends _i1.IncludeList {
  QuizIncludeList._({
    _i1.WhereExpressionBuilder<QuizTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Quiz.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Quiz.t;
}

class QuizRepository {
  const QuizRepository._();

  /// Returns a list of [Quiz]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Quiz>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<QuizTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuizTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuizTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Quiz>(
      where: where?.call(Quiz.t),
      orderBy: orderBy?.call(Quiz.t),
      orderByList: orderByList?.call(Quiz.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Quiz] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Quiz?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<QuizTable>? where,
    int? offset,
    _i1.OrderByBuilder<QuizTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QuizTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Quiz>(
      where: where?.call(Quiz.t),
      orderBy: orderBy?.call(Quiz.t),
      orderByList: orderByList?.call(Quiz.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Quiz] by its [id] or null if no such row exists.
  Future<Quiz?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Quiz>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Quiz]s in the list and returns the inserted rows.
  ///
  /// The returned [Quiz]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Quiz>> insert(
    _i1.DatabaseSession session,
    List<Quiz> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Quiz>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Quiz] and returns the inserted row.
  ///
  /// The returned [Quiz] will have its `id` field set.
  Future<Quiz> insertRow(
    _i1.DatabaseSession session,
    Quiz row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Quiz>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Quiz]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Quiz>> update(
    _i1.DatabaseSession session,
    List<Quiz> rows, {
    _i1.ColumnSelections<QuizTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Quiz>(
      rows,
      columns: columns?.call(Quiz.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Quiz]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Quiz> updateRow(
    _i1.DatabaseSession session,
    Quiz row, {
    _i1.ColumnSelections<QuizTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Quiz>(
      row,
      columns: columns?.call(Quiz.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Quiz] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Quiz?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<QuizUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Quiz>(
      id,
      columnValues: columnValues(Quiz.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Quiz]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Quiz>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<QuizUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<QuizTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QuizTable>? orderBy,
    _i1.OrderByListBuilder<QuizTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Quiz>(
      columnValues: columnValues(Quiz.t.updateTable),
      where: where(Quiz.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Quiz.t),
      orderByList: orderByList?.call(Quiz.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Quiz]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Quiz>> delete(
    _i1.DatabaseSession session,
    List<Quiz> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Quiz>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Quiz].
  Future<Quiz> deleteRow(
    _i1.DatabaseSession session,
    Quiz row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Quiz>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Quiz>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<QuizTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Quiz>(
      where: where(Quiz.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<QuizTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Quiz>(
      where: where?.call(Quiz.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Quiz] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<QuizTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Quiz>(
      where: where(Quiz.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
