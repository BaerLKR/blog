---
title: Terminal
date: 2023-05-17 17:31:00
description: Das Terminal ist dein Freind, du musst nur noch seiner werden
slug: temrinal
title-image: /blog/terminal/title.svg
tags: 52posts, linux
archive: true
---

Hab keine Angst vorm Terminal. Es ist super nützlich und effizient, man muss nur wissen wie man es nutzt. 

## Begriffsklärungen

### Terminal

Das Terminal ist das Fenster, in das man die Befehle eingibt. Es gibt hier viele Optionen, aber die meisten vorinstallierten Terminals sind in Ordnung. Allerdings gibt es auch Gründe ein anderes Terminal zu nutzen, zum Beispiel wegen der Features in Sachen Personalisierung (*siehe [kitty](./../kitty))

### Shell

Die Shell ist das, mit dem man die Befehle dann tatsächlich ausführt. Es ist das Programm, welches das Kernel wie eine Schale (daher der Name) umgibt. Über sie kann man mit dem Rechner Interaagieren. Auch hier gibt es viele Optionen, die verschiedene Zielgruppen und Anwendungen haben.

1. Bash => Die Standart shell, mit der man scriptet
2. fish => Eine Shell, die versucht moderner und benutzerfreundlicher zu sein (nixht für scripting geeignet)
3. zsh => so was dazwischen
4. Nu => eine neue (aber coole) Shell, die noch in alpha ist

Hier werde ich vor allem über Bash schreiben, denn hier soll es ja um die ersten Schritte gehen. 

## grundsätzlicher Aufbau der Commandline

### Prompt 

Wenn man das Terminal auf mach und die shell gestartet wird, wird man als erstes von einem Promt und einem Cursor begrüßt. So sieht das in Bash bei mir aus.

`[lovis@compooter:~/website/git]$ `

Das ist 
1. der Benutzername (`lovis`)
2. der Hostname (`compooter`), mit dem dein Rechner im Netzwerk erkannt werden kann
3. der Weg zum aktuellen "Ordner" (`~/website/git`, in Linux spricht man eher von directories)
4. und zu guter letzt der Privilegienstatus (`$`). Das Dollarzeichen symbolisiert normale Privilegien und `#` die erhöhten Rechtes des `root` Nutzers

Und natürlich gibt es auch hier viele Optionen. Man kann es einstellen und personalisieren, so viel man will.

### Befehle

Wie oben angesprochen gibt es `$` und `#`. Diese Struktur wird auch gerne in Wikis oder anderen Foren gentutzt. Wenn also eine Anweisung so aussieht:
`$ ncdu -x -q /`,
dann sollte er als normaler Nutzer ausgeführt werden. Und so
`# ncdu -x -q /  ` als root nutzer.

**Nicht einfach so Befehle aus dem Internet kopieren und ausführen, sie können sehr viel Sachaden anrichten.**

#### sudo

Um nicht jedes mal zum `root` Nutzer zu wechseln, wenn man höhere Privilegien braucht gibt es auf den meisten Distros das `sudo` Werkzeug. Um es zu nutzen schreibt man es wie einen Präfix vor den Befehl. `sudo sudo arp-scan` zum Beispiel.

#### Befehlsstruktur

Wenn man etwas ausführen möchte, dann muss man im Terminal den Befehl dafür kennen. Ein Befehl kommt aber selten alleine, denn oft haben diese CLIs (commandline interfaces), also Apps für das Terminal, mehrere Funktionen. Um zu sagen, was man möchte werden meistens sogenannte flags genutzt. Um sie zu finden kann man meist `$ <Befehl> --help` oder `$ man <Befehl>` ausführen. 

## Warum das Terminal?

Wenn man sein System über das Terminal bedient, dann bewegt man sich in reinen Daten. Da lernt man erst zu schätzen, wie praktisch eine `txt` Datei ist. Und muss sich nicht mit den vorgefertigten Workflows oder den von andferen leuten bevorzugte Art und Weise Dinge zu machen herumschlagen. Die Wrkzeuge, die man benutzt sind auf so einem niedrigen System-Level, dass man sie so nutzen kann wie man es eben gerne hätte. 

### scripting

Außerdem kann man in der shell viel einfacher Dinge automatisieren, denn die shell ist eine scripting Sprache, nicht nur eine Eingabe für den Nutzer. Ich finde, das ist auch ein guter Einstieg ins Programmieren. Weil man muss keine komplexen Programme schreiben. Nein kleine scripts, die häufig ausgeführte Aktionen vereinfachen. 

Schreibe dazu deinen Script in eine `.sh` Datei und führe die dann aus mit `sh <filename>.sh`.

## Allgemeines

Ein paar allgemeine Tricks und Tips, die nicht besonders sind baerr für den Anfang ganz gut zu wissen.

Es gibt relative und absolute Wege zu einer Datei. Wenn ich in `~` (meiner home-dir) bin und in den "Music" Ordner möchte kann ich entweder `cd ./Music` oder `cd /home/lovis/Music` nutzen.

In einem Ordner gibt es immer schon 2 Unterordner, `.` und `..`. Dabei ist `.` der aktuelle Ordner, daher kann man im oben genannten Beispiel den Punkt auch weg lassen (also `cd Music`). Und wenn ich zum nächsthöheren Ordner wechseln möchte kann ich `cd ..` nutzen.

Sogenannte `dotfiles` sind Dateien, die mit einem Punkt beginnen. Sie werden standartmäßig versteckt. In ihnen werden häufig Konfigurationen oder ähnliches gespeichert. Man kann sie auflisten mit `ls -a` (oder `ls -A`, wenn man `.` und `..` verstecken möchte, denn sie haben keinen praktischen Zweck).

1. `*` bedeutet alle -> `rm *` löscht alle Dateien im momentanen Ordner (oder auch `rm *.html`, löscht alle html Dateien)
2. `|` die Pipe ermöglicht es das Ergebnis des vorherigen Befehls in den nächsten weiter zu geben
3. `>` schreibt den gegebenen input in eine Datei (`cat file1 > file2`, schreibt die Inhalte von 1 in 2)
4. `>>` fügt den Inhalt an die Datei hinzu, wobei `>` alle schon gegebenen Inhalte überschreibt

### Dateimanagement

Eines der wichtigsten Dinge ist es die Dateien auf dem System zu managen. Hier ein paar nützliche Befehle.

1. `rm` Entferne Dateien (mit der `-r` Flag kann man auch Ordner löschen (recursive))
2. `ls` liste alle Ordner und Dateien in dem momentanen Directory
3. `pwd` gibt den "working path", also der Ordner, in dem man sich momentan befindet
4. `cd` "change dir" -> `cd Music` wechselt den momentanen Ordner zu "Music"
5. `cat` listet die Inhalte einer text Datei in das Terminal
6. `touch` erstellt eine neue Datei

## Einstellungen

Man kann die shell (und das Terminal) auch configurieren und seinen Bedürfnissen anpassen. 

Das geht in der configurationsdatei. Sie ist auch ein guter Einstieg in die Welt der Linux-Einstellungen, die anders als bisher wahrscheinlich bekannt keine GUIs haben, sondern einfach Textdateien sind.
Für bash liegt die Datei bei `~/.bashrc`.

### Environmentvariables

Linux nutzt sogenannte environmntvariables. Sie können Programmen wichtige Daten mitteilen, sind aber auch für die shell selbst essenziell. Zum Beispiel die `PATH` variable. Wenn man sie sehen möchte kann man `echo "$PATH"` ausführen. Sie sagt dem System, wo die Binaries, also die ausführbaren Dateien liegen. Wenn ich zum Beispiel `~/.local/bin/` hinzufügen, dann können die Binaries auch dort liegen und ich muss sie nicht mit `./.local/bin/examplebin` ausführen, sondern kann einfach `examplebin` ausführen.

---

## 52posts

Dieser Beitrag ist Teil meines Plans, in 2023 jede Woche einen Post zu erstellen, mit Dingen, die ich gelernt habe. (Das sind dann 52 Posts).

[#52posts](/tag/52posts)
