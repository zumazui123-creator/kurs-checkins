import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import '../../routes/qr.dart' as route;

class MockRequestContext extends Mock implements RequestContext {}

void main() {
  group('GET /qr', () {
    test('responds with 200 and svg', () async {
      final context = MockRequestContext();
      final request = Request('GET', Uri.parse('http://localhost:8080/qr?data=test'));
      when(() => context.request).thenReturn(request);

      final response = route.onRequest(context);
      expect(response.statusCode, equals(200));
      expect(response.headers['Content-Type'], equals('image/svg+xml'));
      
      final body = await response.body();
      expect(body, contains('<svg'));
    });
  });
}
