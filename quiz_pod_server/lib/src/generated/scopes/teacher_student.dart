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

abstract class TeacherStudent
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = TeacherStudentTable();

  static const db = TeacherStudentRepository._();

  @override
  int? id;

  _i1.UuidValue teacherUserId;

  _i1.UuidValue studentUserId;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TeacherStudent',
      if (id != null) 'id': id,
      'teacherUserId': teacherUserId.toJson(),
      'studentUserId': studentUserId.toJson(),
    };
  }

  static TeacherStudentInclude include() {
    return TeacherStudentInclude._();
  }

  static TeacherStudentIncludeList includeList({
    _i1.WhereExpressionBuilder<TeacherStudentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TeacherStudentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TeacherStudentTable>? orderByList,
    TeacherStudentInclude? include,
  }) {
    return TeacherStudentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TeacherStudent.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TeacherStudent.t),
      include: include,
    );
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

class TeacherStudentUpdateTable extends _i1.UpdateTable<TeacherStudentTable> {
  TeacherStudentUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> teacherUserId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.teacherUserId,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> studentUserId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.studentUserId,
    value,
  );
}

class TeacherStudentTable extends _i1.Table<int?> {
  TeacherStudentTable({super.tableRelation})
    : super(tableName: 'teacher_student') {
    updateTable = TeacherStudentUpdateTable(this);
    teacherUserId = _i1.ColumnUuid(
      'teacherUserId',
      this,
    );
    studentUserId = _i1.ColumnUuid(
      'studentUserId',
      this,
    );
  }

  late final TeacherStudentUpdateTable updateTable;

  late final _i1.ColumnUuid teacherUserId;

  late final _i1.ColumnUuid studentUserId;

  @override
  List<_i1.Column> get columns => [
    id,
    teacherUserId,
    studentUserId,
  ];
}

class TeacherStudentInclude extends _i1.IncludeObject {
  TeacherStudentInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => TeacherStudent.t;
}

class TeacherStudentIncludeList extends _i1.IncludeList {
  TeacherStudentIncludeList._({
    _i1.WhereExpressionBuilder<TeacherStudentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TeacherStudent.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => TeacherStudent.t;
}

class TeacherStudentRepository {
  const TeacherStudentRepository._();

  /// Returns a list of [TeacherStudent]s matching the given query parameters.
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
  Future<List<TeacherStudent>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TeacherStudentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TeacherStudentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TeacherStudentTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TeacherStudent>(
      where: where?.call(TeacherStudent.t),
      orderBy: orderBy?.call(TeacherStudent.t),
      orderByList: orderByList?.call(TeacherStudent.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TeacherStudent] matching the given query parameters.
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
  Future<TeacherStudent?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TeacherStudentTable>? where,
    int? offset,
    _i1.OrderByBuilder<TeacherStudentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TeacherStudentTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TeacherStudent>(
      where: where?.call(TeacherStudent.t),
      orderBy: orderBy?.call(TeacherStudent.t),
      orderByList: orderByList?.call(TeacherStudent.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TeacherStudent] by its [id] or null if no such row exists.
  Future<TeacherStudent?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TeacherStudent>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TeacherStudent]s in the list and returns the inserted rows.
  ///
  /// The returned [TeacherStudent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<TeacherStudent>> insert(
    _i1.DatabaseSession session,
    List<TeacherStudent> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<TeacherStudent>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [TeacherStudent] and returns the inserted row.
  ///
  /// The returned [TeacherStudent] will have its `id` field set.
  Future<TeacherStudent> insertRow(
    _i1.DatabaseSession session,
    TeacherStudent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TeacherStudent>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TeacherStudent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TeacherStudent>> update(
    _i1.DatabaseSession session,
    List<TeacherStudent> rows, {
    _i1.ColumnSelections<TeacherStudentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TeacherStudent>(
      rows,
      columns: columns?.call(TeacherStudent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TeacherStudent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TeacherStudent> updateRow(
    _i1.DatabaseSession session,
    TeacherStudent row, {
    _i1.ColumnSelections<TeacherStudentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TeacherStudent>(
      row,
      columns: columns?.call(TeacherStudent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TeacherStudent] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TeacherStudent?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<TeacherStudentUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TeacherStudent>(
      id,
      columnValues: columnValues(TeacherStudent.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TeacherStudent]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TeacherStudent>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<TeacherStudentUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<TeacherStudentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TeacherStudentTable>? orderBy,
    _i1.OrderByListBuilder<TeacherStudentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TeacherStudent>(
      columnValues: columnValues(TeacherStudent.t.updateTable),
      where: where(TeacherStudent.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TeacherStudent.t),
      orderByList: orderByList?.call(TeacherStudent.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TeacherStudent]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TeacherStudent>> delete(
    _i1.DatabaseSession session,
    List<TeacherStudent> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TeacherStudent>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TeacherStudent].
  Future<TeacherStudent> deleteRow(
    _i1.DatabaseSession session,
    TeacherStudent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TeacherStudent>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TeacherStudent>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TeacherStudentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TeacherStudent>(
      where: where(TeacherStudent.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TeacherStudentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TeacherStudent>(
      where: where?.call(TeacherStudent.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TeacherStudent] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TeacherStudentTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TeacherStudent>(
      where: where(TeacherStudent.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
