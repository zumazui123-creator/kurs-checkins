import 'dart:convert';
import 'dart:io';
import 'package:dart_frog/dart_frog.dart';

// In-memory storage for simplicity. 
// In a real app, this would be a database or a file.
final List<Map<String, dynamic>> _attendees = [];

Future<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _getAttendees(context);
    case HttpMethod.post:
      return _addAttendee(context);
    case HttpMethod.delete:
      return _clearAttendees(context);
    default:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

Future<Response> _getAttendees(RequestContext context) async {
  return Response.json(body: _attendees);
}

Future<Response> _addAttendee(RequestContext context) async {
  final body = await context.request.json();
  if (body is Map<String, dynamic>) {
    // Add timestamp if not present
    body['checkin_time'] ??= DateTime.now().toIso8601String();
    _attendees.add(body);
    return Response.json(body: body, statusCode: HttpStatus.created);
  }
  return Response(statusCode: HttpStatus.badRequest);
}

Future<Response> _clearAttendees(RequestContext context) async {
  _attendees.clear();
  return Response(statusCode: HttpStatus.noContent);
}
