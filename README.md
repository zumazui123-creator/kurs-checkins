# 📱 Kurs-Checkins System

Moderne Flutter-App zur effizienten Anwesenheitsverwaltung via QR-Code.

## 🚀 Inbetriebnahme

### 1. Server starten
Der Server fungiert als zentrale Datenbank und API für die App.
```bash
cd server
dart pub get
dart_frog dev --address 0.0.0.0 --port 8080
```
Der Server sollte nun auf `http://<Dein-PC-IP>:8080` erreichbar sein.

### 2. Flutter Client starten
Starte die App auf deinem Gerät oder Emulator:
```bash
flutter run
```

## 🛠 Konfiguration (Setup-Tab)

Nach dem Start kannst du die App im **Setup**-Tab konfigurieren (Zugang: `admin` / `admin`):

1.  **Server-Verbindung:** Gib die IP-Adresse und den Port deines PCs ein, auf dem der Dart-Frog-Server läuft. Klicke auf **Speichern** (die Verbindung wird automatisch geprüft).
2.  **Kurse verwalten:** Hier kannst du Kurse hinzufügen, löschen und per **Drag-and-Drop** sortieren.
    *   **CSV-Import:** Über das Upload-Icon kannst du eine Kursliste im Format `Name,Startzeit,Endzeit` importieren.
3.  **QR-Generator:** Erstelle QR-Codes für Teilnehmer. Du kannst sie generieren und direkt in deine Galerie herunterladen.
4.  **Sicherheit:** Ändere im Setup-Bereich dein Anmelde-Passwort (wird sicher gehasht gespeichert) oder setze die App über **Alle Daten löschen** auf den Werkszustand zurück.

## 👥 Teilnehmer-Check-in

*   **Scan:** Nutze den Scan-Tab, um QR-Codes von Teilnehmern zu erfassen. Die Daten werden automatisch an den Server gesendet.
*   **Manuell:** Im Teilnehmer-Tab kannst du Teilnehmer über den **+** Button manuell hinzufügen.
*   **Export:** Die Teilnehmerliste des Tages kann als CSV exportiert werden.
---

