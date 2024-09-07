+++
title = 'Reverse Tether'
date = 2024-08-23T00:30:21+02:00
draft = true
+++

Und es begab sich zu der Zeit, dass ich in einer Ferienwohnung ohne Wlan saß. Allerdings hat mein Laptop eine Antenne die 
ausreichend lang war um sich mit dem nächstgelegene offenen (Hotel-)Wlan zu verbinden. Das war also ausreichend um einfache Dateien
herunterzuladen (Podcasts, Musik, ...). Aber ich wollte auch Filme von Prime Video für die anstehende Fahrt herunterladen und das 
geht nur aus der App. Also musste ich das Internet von meinem Laptop auf mein Handy bringen. In die andere Richtung ist das
recht einfach (zumindest mit meinem Handymodell (S10)), man teilt das mobile Datenvolumen oder eine Wlanverbindung über einen 
Hotspot; mein Laptop kann das nicht. Also muss das Internet durch das Kabel. Nach einiger Recherche bin ich dann auf 
[Gnirehtet](https://github.com/Genymobile/gnirehtet) gestoßen. 

## Nutzung

*Hier kann es je nach Hardware Unterschiede geben, das ist meine Erfahrung mit einem Laptop (NixOS) und einem Android Galaxy S10.*

Um den reverse tether nutzen zu können muss USB-Debugging auf dem Handy eingeschaltet sein, denn der Teil der auf dem Handy 
ausgeführt wird, wird über adb installiert.

Vorher muss man den "Entwicklermodus" aktivieren. Dafür muss man in den Einstellungen des Handys zu 
`Telefoninfo > Softwareinformationen` navigieren und dann so oft auf `Buildnummer` tippen, bis der "Entwicklermodus" aktiviert
wurde. Anschließend sollte die Option `USB-Debugging` einzuschalten verfügbar sein.

Dann recht einfach mit dem Ladekabel Laptop und Handy verbinden und es sollte ein Popup auf dem Handy erscheinen ob man dem Gerät
(Laptop) vertrauen möchte (hier kann man auch den RSA Schlüssel überprüfen wenn man sicher gehen will lol).

