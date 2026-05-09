import 'package:barcode/barcode.dart';
import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final request = context.request;
  final queryParams = request.uri.queryParameters;
  final data = queryParams['data'] ?? 'https://flutter.dev';

  final bc = Barcode.qrCode();
  final svg = bc.toSvg(
    data,
    width: 200,
    height: 200,
  );

  return Response(
    body: svg,
    headers: {
      'Content-Type': 'image/svg+xml',
    },
  );
}
