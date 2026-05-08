# 🗺 Projekt-Roadmap & TODO

Hier findest du den aktuellen Fortschritt und die geplanten Schritte für die **Kurs-Checkins** App.

---

## 🏗 Phase 1: Fundament & Architektur
- [x] **Anforderungen fixieren**
    - [x] Projektname finalisieren
    - [x] App-Logo definieren
    - [x] Zielplattformen (Android, iOS, Web) sicherstellen
- [x] **Technologie-Stack**
    - [x] Flutter Setup (Material 3, Dynamic Colors)
    - [x] Riverpod Integration (Generator & Annotations)
- [x] **Projektstruktur aufsetzen**
    - [x] Clean Architecture Folder-Struktur (`core`, `features`, `shared`)
    - [x] Feature-Struktur für `attendance`, `qr`, `courses`, `settings`

---

## 💎 Phase 2: Core Features (MVP)
- [x] **Navigation & UI-Grundgerüst**
    - [x] `go_router` Konfiguration
    - [x] Bottom Navigation Bar
    - [x] Theme mit `flex_color_scheme`
- [x] **Teilnehmer-Management**
    - [x] Hauptliste (DataTable) mit Echtzeit-Updates
    - [x] Manueller Eintrag via Dialog-Popup
    - [x] Validierung der Eingabefelder
    - [x] CSV-Export der Liste

---

## 🔍 Phase 3: QR-System & Scan-Logik
- [x] **QR-Generator**
    - [x] Erstellung von Teilnehmer-QR-Codes
    - [ ] Teilen- & Download-Funktion
- [x] **QR-Scanner**
    - [x] Integration von `mobile_scanner`
    - [x] Scan-UX (Vibration, Rahmen-Animation)
    - [x] Audio-Feedback (Erfolg/Fehler Sounds)
    - [ ] Dubletten-Check beim Einchecken

---

## 🌐 Phase 4: Lokales Hosting & Backend
- [x] **Backend Setup**
    - [x] Dart Frog Server initialisiert
    - [x] REST-Endpoints für Anwesenheit (`GET`, `POST`)
    - [x] In-Memory Datenspeicherung auf dem Server
    - [x] Web-Dashboard zur Anzeige der Liste (HTML)
    - [x] Server-seitiger CSV-Export (/export)
- [x] **Client-Anbindung**
    - [x] HTTP-Client (Dio) im Flutter-Projekt
    - [x] Provider auf Async-Datenfluss umgestellt
    - [x] Automatische Synchronisation (Refresh) integriert

---

## 🎨 Phase 5: Polishing & Deployment
- [ ] **Modernes UI/UX**
    - [ ] Dark Mode Support
    - [ ] Responsive Layouts für Web/Tablet
    - [ ] Animationen (z.B. Success-Checkmark beim Scan)
- [ ] **Testing & Qualität**
    - [ ] Unit-Tests für Repositories & Provider
    - [ ] Widget-Tests für kritische UI-Komponenten
- [ ] **Release**
    - [ ] Web-Deployment (Vercel/Firebase)
    - [ ] Mobile Builds (Android App Bundle, iOS TestFlight)

---

<details>
<summary>🌈 <b>UI-Ideen & "Cool Stuff"</b> (Klicken zum Aufklappen)</summary>

*   [ ] **Live Check-in Animation:** Grüner Glow & Sound bei Erfolg.
*   [ ] **Avatar-Farben:** Automatische Farben basierend auf Namen.
*   [ ] **QR-Wallet:** Teilnehmer können ihren Code in der App "aufbewahren".
*   [ ] **Live Dashboard:** Peak-Zeiten & Teilnehmer-Statistiken.
*   [ ] **NFC-Support:** Check-in via NFC-Tags/Karten.
*   [ ] **Badge-System:** Gamification für regelmäßige Teilnahme.
</details>

<details>
<summary>🚀 <b>Erweiterungen für die Zukunft</b></summary>

*   Kalender-Integration (iCal/Google).
*   Push-Benachrichtigungen für Kursänderungen.
*   PDF/CSV Export für Administratoren.
*   Mehrsprachigkeit (i18n).
</details>

---

## 🛠 Empfohlene Packages
| Bereich | Empfehlung |
| :--- | :--- |
| **State** | `flutter_riverpod`, `riverpod_annotation` |
| **Scanner** | `mobile_scanner` |
| **Design** | `flex_color_scheme`, `google_fonts` |
| **Models** | `freezed`, `json_serializable` |
