# 📱 Kurs-Checkins — Project Blueprint

Herzlich willkommen zum **Kurs-Checkins** Projekt! Diese App ist eine moderne Flutter-Lösung für die effiziente Verwaltung von Teilnehmer-Anwesenheiten via QR-Code.

---

## 🎯 Projekt-Überblick

Die App ermöglicht eine nahtlose Erfassung von Kursteilnehmern mit Fokus auf Geschwindigkeit und Benutzerfreundlichkeit.

### Hauptfunktionen
*   **👥 Teilnehmer-Dashboard:** Übersichtliche Liste mit Vorname, Nachname, Uhrzeit und Kurs.
*   **🔍 QR-Scanning:** Schnelle Erfassung durch Scannen von Teilnehmer-QR-Codes.
*   **🎲 QR-Generierung:** Erstellen von individuellen QR-Codes für Teilnehmer.
*   **📝 Manueller Check-in:** Flexibles Eintragen über intuitive Popups.
*   **🌐 Cross-Platform:** Optimiert für Android, iOS und das Web.

---

## 🛠 Technischer Stack

| Komponente | Technologie |
| :--- | :--- |
| **Framework** | Flutter (Latest Stable) |
| **Sprache** | Dart (Sound Null Safety) |
| **UI System** | Material 3 + FlexColorScheme |
| **State Management** | Riverpod (Generator Pattern) |
| **Navigation** | GoRouter |
| **Datenbank** | In-Memory (Optional: Drift für Lokal) |
| **Modellierung** | Freezed & JSON Serializable |

---

## 🚀 Setup & Ausführung

### 1. Abhängigkeiten laden
```bash
flutter pub get
```

### 2. Code Generierung
Da wir Riverpod Generator und Freezed nutzen, muss der Builder laufen:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. App Starten
```bash
flutter run -d chrome  # Für Web
# oder
flutter run            # Für mobile Geräte
```

---

## 📐 Entwicklungskonventionen

### 🎨 UI & Design
*   **Material 3:** Konsequent `useMaterial3: true` verwenden.
*   **Declarative UI:** Widgets reagieren ausschließlich auf Provider-States.
*   **Responsive:** Layouts müssen auf Mobile und Web gleichermaßen funktionieren.

### 🏗 Architektur-Schichten
1.  **Presentation (UI):** Dumme Widgets & Screens.
2.  **Application (Providers):** Notifier für Business-Logik & State.
3.  **Data (Repos):** Schnittstellen zu Drift oder SharedPreferences (lokal).

### 💉 State Management (The Riverpod Way)
*   Nutze immer den **Riverpod Generator** (`@riverpod`).
*   State-Klassen sind **immer** immutable (via `@freezed`).
*   Handle `AsyncValue` (data, loading, error) explizit in der UI.

---

## 📝 Wichtige Dateien
*   `lib/router.dart`: Zentrale Routen-Konfiguration.
*   `lib/main.dart`: App-Entrypoint & Theme-Setup.
*   `GEMINI.md`: Diese Dokumentation (Source of Truth).
*   `TODO.md`: Aktueller Projektstatus & Roadmap.
