# 📱 Kurs-Checkins — Project Blueprint

Herzlich willkommen zum **Kurs-Checkins** Projekt! Diese App ist eine moderne Flutter-Lösung für die effiziente Verwaltung von Teilnehmer-Anwesenheiten via QR-Code.

---

## 🎯 Projekt-Überblick

Die App ermöglicht eine nahtlose Erfassung von Kursteilnehmern mit Fokus auf Datenschutz, Geschwindigkeit und Benutzerfreundlichkeit.

### Hauptfunktionen
*   **👥 Teilnehmer-Dashboard:** Übersichtliche Liste mit Teilnehmern des heutigen Tages (Vorname & Uhrzeit).
*   **🔍 QR-Scanning:** Schnelle Erfassung durch Scannen von Teilnehmer-QR-Codes (Nur Mobile).
*   **🎲 Lokale QR-Generierung:** Lokale Erstellung von QR-Codes mit Export-Funktion in die Galerie.
*   **📝 Manueller Check-in:** Flexibles Eintragen von Teilnehmern.
*   **⚙️ Setup-Bereich:** Konfiguration der Server-Verbindung, Kursverwaltung (mit Drag-and-Drop & CSV-Import) und Passwortschutz.

---

## 🛠 Technischer Stack

| Komponente | Technologie |
| :--- | :--- |
| **Framework** | Flutter (Latest Stable) |
| **Sprache** | Dart (Sound Null Safety) |
| **UI System** | Material 3 + FlexColorScheme |
| **State Management** | Riverpod |
| **Navigation** | GoRouter |
| **Backend** | Dart Frog (mit `barcode`-Lib für serverseitige QR-Erstellung) |
| **Daten** | Shared Preferences & REST API (Dio) |

---

## 🚀 Setup & Ausführung

### 1. Server Starten
```bash
cd server
dart pub get
dart_frog dev --address 0.0.0.0 --port 8080
```

### 2. App Starten
```bash
flutter run
```

---

## 📐 Entwicklungskonventionen

### 🏗 Architektur-Schichten
1.  **Presentation (UI):** Dumme Widgets & Screens, die auf Riverpod-Provider hören.
2.  **Domain (Models):** `Attendee`, `Course`, `ServerConfig`.
3.  **Data/Services:** `ApiClient` (Dio), `CourseProvider` (SharedPreferences).

### 🔒 Sicherheit & Konfiguration
*   **Auth:** Der Setup-Bereich ist durch einen PIN-Dialog geschützt (Default: `admin`/`admin`).
*   **Dynamik:** Die Server-Verbindung (IP/Port) ist im Setup-Bereich konfigurierbar und wird mittels SHA-256 (Passwort) und SharedPreferences persistiert.
*   **Datenschutz:** Teilnehmerliste filtert automatisch auf das heutige Datum und zeigt aus Anonymitätsgründen nur Vornamen und Ankunftszeiten an.

---

## 📝 Wichtige Dateien
*   `lib/router.dart`: Zentrale Navigation (GoRouter).
*   `lib/main.dart`: Provider-Initialisierung & App-Entrypoint.
*   `lib/features/settings/providers/course_provider.dart`: Kursverwaltung.
*   `server/routes/qr.dart`: Serverseitige QR-Code Generierung.
*   `TODO.md`: Roadmap.
---
