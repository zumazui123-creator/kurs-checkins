import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:server/repository.dart';

Future<Response> onRequest(RequestContext context) async {
  final repository = context.read<AttendeeRepository>();

  return switch (context.request.method) {
    HttpMethod.get => _getAttendees(repository),
    HttpMethod.post => _addAttendee(context, repository),
    HttpMethod.delete => _clearAttendees(repository),
    _ => Response(statusCode: HttpStatus.methodNotAllowed),
  };
}

Future<Response> _getAttendees(AttendeeRepository repository) async {
  return Response.json(body: repository.attendees);
}

Future<Response> _addAttendee(RequestContext context, AttendeeRepository repository) async {
  final body = await context.request.json();
  if (body is Map<String, dynamic>) {
    body['checkin_time'] ??= DateTime.now().toIso8601String();
    repository.add(body);
    return Response.json(body: body, statusCode: HttpStatus.created);
  }
  return Response(statusCode: HttpStatus.badRequest);
}

Future<Response> _clearAttendees(AttendeeRepository repository) async {
  repository.clear();
  return Response(statusCode: HttpStatus.noContent);
}
