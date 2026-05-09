import 'package:dart_frog/dart_frog.dart';
import 'package:server/repository.dart';

Handler middleware(Handler handler) {
  return handler.use(provider<AttendeeRepository>((context) => repository));
}
