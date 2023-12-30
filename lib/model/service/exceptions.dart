import 'package:logger/logger.dart';

class ServiceError implements Exception {
  final int? code;
  final String? message;
  final StackTrace? trace;

  const ServiceError({
    required this.code,
    required this.message,
    this.trace,
  });

  @override
  String toString() {
    return 'Service Error: $code $message';
  }

  void log() {
    var logger = Logger();
    logger.e(toString());
  }
}
