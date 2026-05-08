# buchungsys

A new Flutter project.

## Getting Started

 So startest du das System:

   1. Server starten:
   1     cd server
   2     dart_frog dev
      Der Server läuft standardmäßig auf Port 8080.

   2. Web-App hosten (für andere Geräte):

   1     flutter build web
   2     cd build/web
   3     python3 -m http.server 8000
      Andere Personen im WLAN können die App nun über http://10.0.2.15:8000 aufrufen.

   3. Daten zentral sammeln:
      Jeder Scan, egal von welchem Gerät, wird nun an deinen Server gesendet und in der zentralen Liste gespeichert.

