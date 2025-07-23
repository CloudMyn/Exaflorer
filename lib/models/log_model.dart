import 'dart:math';

class LogModel {
  late final int id;
  final String message;
  final String stackTrace;
  final int createdAt;

  LogModel({
    required this.message,
    required this.stackTrace,
    required this.createdAt,
  }) {
    this.id = Random.secure().nextInt(100000);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'message': this.message,
      'stackTrace': this.stackTrace,
      'createdAt': this.createdAt,
    };
  }

  static LogModel fromMap(Map<String, dynamic> data) {
    return LogModel(
      message: data['message'] ?? 'Undifined exception',
      stackTrace: data['stackTrace'] ?? StackTrace.current.toString(),
      createdAt: data['createdAt'] ?? 00,
    );
  }

  List<String> stackTraceList() {
    String pattern = '(#[0-9\\s]*)';
    List<String> s = stackTrace.split(RegExp(pattern, multiLine: true));
    s.removeAt(0);
    return s;
  }

  String formatDate() {
    return DateTime.fromMillisecondsSinceEpoch(this.createdAt).toString();
  }
}
