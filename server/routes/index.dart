import 'package:dart_frog/dart_frog.dart';
import 'package:server/repository.dart';

Response onRequest(RequestContext context) {
  final repository = context.read<AttendeeRepository>();
  final attendees = repository.attendees;

  final html = '''
<!DOCTYPE html>
<html>
<head>
    <title>Kurs-Checkins Dashboard</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body { font-family: sans-serif; padding: 20px; background: #f4f4f9; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        h1 { color: #3f51b5; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #f8f9fa; }
        .btn { display: inline-block; padding: 10px 20px; background: #3f51b5; color: white; text-decoration: none; border-radius: 4px; margin-right: 10px; }
        .btn-secondary { background: #4caf50; }
        .actions { margin-bottom: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Kurs-Checkins Dashboard</h1>
        <div class="actions">
            <a href="/" class="btn">Aktualisieren</a>
            <a href="/download" class="btn btn-secondary">Als CSV exportieren</a>
        </div>
        <table>
            <thead>
                <tr>
                    <th>Vorname</th>
                    <th>Nachname</th>
                    <th>Kurs</th>
                    <th>Uhrzeit</th>
                </tr>
            </thead>
            <tbody>
                ${attendees.map((a) => '''
                <tr>
                    <td>${a['first_name'] ?? ''}</td>
                    <td>${a['last_name'] ?? ''}</td>
                    <td>${a['course'] ?? ''}</td>
                    <td>${a['checkin_time'] != null ? DateTime.parse(a['checkin_time'] as String).toLocal().toString().substring(11, 16) : ''}</td>
                </tr>
                ''').join('')}
            </tbody>
        </table>
        ${attendees.isEmpty ? '<p style="text-align: center; color: #666;">Noch keine Teilnehmer eingecheckt.</p>' : ''}
    </div>
</body>
</html>
''';

  return Response(
    body: html,
    headers: {'Content-Type': 'text/html; charset=utf-8'},
  );
}
