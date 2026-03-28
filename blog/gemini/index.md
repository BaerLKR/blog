---
title: gemini
date: 2023-11-23 22:29:01
description: Gemini ist in alternatives Internetprotokoll, das sich gegen die Überkomerzialisierung des Internets stellt.
slug: gemini
title-image: /blog/gemini/title.svg
archive: true
---

[gemini](https://geminiprotocol.net) ist ein Protokoll um Daten über das Internet zu 
transportieren. Es soll eine freiere und schnellere Alternative zu http darstellen. Dabei ist es
nicht gedacht, dass gemini alle Features von http hat, sondern, dass absichtlich weniger Features
da sind. Vorallem kein Javascript und nur sehr eingeschränktes tracking, und das schon im 
Protokoll garantiert.

## Das Problem mit http

Eigentlich gibt es kein Problem mit http. Aber das moderne Internet ist nicht mehr das, wofür es
geschaffen wurde. Es ist kein Ort mehr des **freien** Infromationsaustausches. Es ist meistens
nicht mal mehr ein Ort des Austausches. Alles ist zentralisiert und vor allem komerzialisiert.
Auf jeder Seite erwarten einen die Tracker einer anderen Webseite. Und es kann Javascript
ausgeführt werden. Nicht nur das, man kann das Netz nicht mehr nutzen, ohne Javascript. Und 
dieses kann eben besagte http Anfragen abschicken und das ist das Problem. So können im 
Hintergrund Dinge gemacht, aufgerufen und geladen werden, von denen der Nutzer nichts mit 
bekommt. Das ist eine unfassbar tolle Technologie, aber nicht in der Hand der kapitalistischen 
und datenhungrigen Internet Monopolisten[^1]. 

## Der Lösungsansatz

gemini hat bewusst weniger Funktionen und ist damit einerseits ungefährlicher und andererseits
deutlich einfacher zu navigieren. Keine Banner, Pop-Ups, PayWalls, LogIns, Werbung, CAPCHAS, und
so vieles mehr, was wir einfach als neue Normalitär akzeptiert haben, was aber ja total absurd 
ist. gemini bietet nur eine markdown ähnliche Syntax (*Punkt*). Das wars, kein JS, kein Styling,
nur das warum ich die Webseite aufrufe, die Informationen. Ich will damit nicht sagen, dass 
Browser oder CSS schlecht sind, sind sie nicht, aber sie machen einem gerne mal das Leben schwer.
Auf eine bestimmt Art und Weise ist gmini die Weiterentwicklung und Ausweitung von RSS auf das
gesammte bewegen im Internet. Ich sage gesamtes Internet, aber natürlich ist das Ökosystem in 
gmini noch sehr klein, denn es ist ein niche FOSS Projekt und kein Mainstram Produkt[^2]. Möglich
sind interaktive Elemente trotzdem, denn es können auf dem Server interaktive Elemente berechnet
werden, aber eben nicht auf dem Client und damit meinem Gerät.

## Was ist gemini nun genau?

gemini ist ein Protokoll auf der Appliations-Ebene des ISO/OSI Schichtenmodells. Es eignet sich 
für den Transfer arbiträrer Daten. Es hat allerdings besondere Funktionalitäten, was den 
Transport der gemini (`gmi`) Dateien und deren Verlinkung untereinander an geht. Es hat bewusst
wenige, aber dafür gut bewärte Funktionen. Gemeint ist damit, dass auch gemini auf den 
allgemeinen Konzepten von `URI`, `MIME` und `TLS` aufbaut. Hier würde ich gerne einschieben, dass
`TLS` immer aktiv ist. Es funktioniert aber etwas anders als im "normalen" Internet. Das 
Zerztifikat ist (meist) selbst signiert und dient fast nur der Verschlüsselung des 
Datentransfers. Aber das Zertifikat wird nicht gegen einen Anbieter geprüft, wie zum Beispiel 
"Let's Encrypt" oder anderen. Um allerdings Man in the middle Attacks vorzubeugen wird beim 
ersten Besuch einer Seite, man nennt sie bei gemini, auch wegen des Namens, Kapseln, das 
Zertifikat notiert (ein hash). Wenn das Zertifikat sich also verändert, fällt das auf. So ist man
gegen MIM Angriffe geschützt, außer beim ersten Aufrufen[^3].

Viele Artikel und Vidos von Leuten, die gemini kennen und vorgestellt haben, sprechen an, dass
es dem ganz frühen Internet ähnelt. Das kann ich persönlich nicht bezeugen, ich bin mit dem 
aktuellen Bloat-Web aufgewachsen, aber ich denke nicht, dass das etwas schlechtes ist. Vorallem
im Anbetracht, dass das Web so schnell nicht weg gehen wird und die Verwendung von gemini es auch
nicht ausschließt das "normale" Internet zu nutzen. Aber für manche Dinge ist einfach Text die
beste Wahl, wie auch Wikipedia erkannt hat.

## Wo kann ich anfangen?

### client

Man kann nicht einfach einen Webbrowser verwenden, denn der nutzt ja http(s). Also muss man einen
eigenen client verwenden. Wegen des einfachen Layouts der Kapseln, gibt es sogar Terminal Browser
für gemini. Externe Medien werden dann in den zugehörigen Programmen geöffnet.

Ich verwende den `amfora` Browser und öffne Bilder einfach in `imv`. Ich habe mit einigen
Einstellungen den Browser meinen persönlichen Präferenzen angepasst und kann nun gemini erkunden.
Wichtig zu bemerken ist, dass die URLs mit `gemini://` beginnen. Die Dokumentation liegt unter
`gemini://geminiprotocol.net/docs/`.

### server

Es ist auch sehr einfach einen gemini Server zu betreiben. Die einzige Schwierigkeit ist das
SSL Zertifikat, aber wie oben angesprochen, kann man es einfach selbst erstellen.

Man braucht einen Server für das gemini Protokoll, ich verwende `agate` (in rust geschrieben).
Das ist mein Ordneraufbau:
```
.
├── cert.pem
├── content
│  └── index.gmi
└── key.rsa
```
Den Schlüssel habe ich mit 
```
 openssl req -x509 -newkey rsa:4096 -keyout key.rsa -out cert.pem -days 3650 -nodes -subj "/CN=localhost"
```
generiert. Dann starte ich den Server mit dem Befehl:
```
agate --content content/ --addr 0.0.0.0:1965 --hostname localhost --lang en-US 
```
Besuchen kann ich die Webseite dann unter `gemini://localhost`.

[^1]: Ich bin mir darüber im Klaren, dass der Plural von Monopolist keinen Sinn ergibt. Deal with it. Rethorische Mittel und so.
[^2]: Es ist eben gar kein Produkt
[^3]: Meines Wissens nach, heißt dieses System `TOFU`
