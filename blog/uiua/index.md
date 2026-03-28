---
title: uiua
date: 2023-10-24 22:29:01
description: uiua ftw
slug: uiua
title-image: /blog/uiua/title.svg
tags: programming
archive: true
---

[uiua](https://uiua.org) ist eine Sprache, die ich in den letzten Tagen entdeckt habe und sehr
faszinierend finde (außerdem ist der Interpreter in Rust geschrieben und kann zu WASM kompiliert
werden).
Einige Besonderheiten, die uiua von anderen Sprachen abhebt, ist die Verwendung von Symbolen
(glyphs) um Funktionen und Operationen darzustellen. Das macht es natürlich schwerer die Sprache
zu lernen, da man nicht nur die Funktionalität, sondern auch die Schreibweise komplett neu 
erlernen muss. Allerdings glaube ich, dass wenn man es einigermaßen flüssig lesen kann, dass es
dann sogar von Vorteil ist, denn man weiß bei einem Bestimmten Symbol sofort, was passiert und
muss nicht so viel lesen. Ich halte es nicht für sinnvoll, hier alle Symbole aufzuschlüsseln,
denn die Dokumentation auf der Webseite ist hervorragend.

Außerdem hat uiua noch 2 weitere Paradigmen; es ist auf dem Stack system gebaut und es ist eine 
Array basierte Sprache.

## Arraysprache

Arrays, also Listen, sind Objekte erster Klasse in uiua. Das bedeutet, dass die als ganz normale
primitive Typen verwendet werden können. Das hat zur Folge, dass uiua extrem viel auf Arrays
aufbaut und fast alle eingebauten Funktionen mit der Manipulation von Arrays zu tun haben. Das
hat zusätzlich den Hintergrund, dass es keine vorgebauten Abstraktiknen gibt und man sich mit 
Hilfe von Arrays ebendiese zusammenschustern kann.

Da Arrays grundlegende Datentypen sind, kann man selbstverständlich auch Array Arrays bauen, also
n-dimensionale Matrizen. Auch für diese gibt es schon viele Manipulationsfunktionen zur Auswahl.
Es gibt in uiua sogar nur 3 Typen in uiua.

1. Nummern
2. Boxen
3. Buchstaben

und den sogenannten Stack, zu dem ich später kommen werde.

Boxen sind ein bisschen wie pointer, sie ermöglichen es Dinge verschiedener Größen (zum Beispiel
zwei Arrays mit verschiedener Länge) in einen Array zu tun. Sie nehmen die Größe also weg, 
ermöglichen aber weiterhin den Zugriff auf die gespeicherten Daten. Zu beachten ist allerdings,
dass dann, wie bei pointern auch, alle Elemente des Arrays eine Box (oder in einer Box) sein 
müssen.

## Der Stack

Der Stack ist im grunde Genommen eine Liste aus Listen, denn:

> Every value in Uiua is an array

Alles, auch die primitiven Datentypen sind also als Arrays abgelegt (eben mit der Länge 1). Die
Grundidee des Stacks ist es, dass es immer eine Liste an Werten gibt, von der man immer von oben
herab arbeitet, denn an die unteren Werte eines Stapels kommt man erst, wenn man die Oberen
bearbeitet hat. SO ist es möglich Werte zu verwenden, die keinen Namen haben, man muss nur dafür
sorge tragen, dass auch die richtigen Werte gerade auf dem Stack liegen. Natürlich kann man auch
den Stack bearbeiten, denn es ist auch nur ein Array, auf dem die Sprache eben aufbaut.

## Beispiel

Das war alles sehr abstrakt, und auch echt schwer zu verstehen. Ich musste auch sehr viel
Denkleistung aufbringen, um die Doku zu verstehen; nicht, weil es sonderlich komplex oder 
schlecht beschrieben ist (eher im Gegenteil), sondern weil es einfach so neue und 
grundverschiedene Konzepte sind, zu dem was ich sonst gewohnt bin. Vielleicht helfen zwei 
Beispiele, die ich programmiert habe und die ich jetzt erklären werde.

### Pythagoras

Ich will eine Funtion `c`, in die ich die Parameter `a` und `b` geben kann, um die 
Hypothenusenlänge eines rechtwinkligen Dreicks zu bekommen.

Hier erstelle ich eine Funktion `c`, indem ich den rechten Therm an den Linken "binde" (`←`).
weiterhin ist es wichtig zu verstehen, dass eine Zeile von rechts nach links evaluiert wird. Das
mag anfangs komisch erscheinen, aber ich finde, dass es voll Sinn ergibt (der Pfeil läuft auch
in die passende Richtung), denn so ist auch die mathematische Evaluationsrichtung ([Begründung 
des Entwicklers](https://www.uiua.org/docs/rtl)).
```uiua
c ← √/+ⁿ2⊂
c 3 4
```
Man kann die symbole auch so ausschreiben. Das ist einer der großen Vorteile gegnüber anderen
ähnlichen Sprachen wie BQN. Der Interpreter wird es dann automatisch formatieren. Das gilt sowohl
für den lokalen Interpreter, der mit dem Dateisystem interagiert, als auch für den, den man auf
der Webseite nutzen kann ([hier](https://uiua.org/pad)). Man kann es vielleicht besser erklären,
wenn man die Ascii representation nutzt. Zuerst wird der `join` Operator auf die beiden Werte,
die auf dem Stack liegen angewandt. Das bedeutet, dass sie in einen Array geschrieben werden. Als
nächstes die `pow` Operation, die braucht 2 Paramteter, die Basis und den Exponenten. Wie alle
grundlegenden mathematischen Operationen, wird auch die Potenz auf alle Elemente einer List 
angewandt. Hier also `[3² 4²]`. Dann `reduce`n wir den Array mit der `+` Funktion. Das bedeutet,
dass wir nicht mehr Plus einen Wert für jedes Element im Array rechnen, sondern den Array zu
einem einzelnen Element reduzieren; hier eben durch Addition der Einzelwerte. Dann nehmen wir
noch die Quadratwurzel des neuen Wertes, der als oberstes auf dem Stack liegt. Das ist die Länge
der Hypothenuse nach Pythagoras.
```uiua
c = sqrtreduce+pow2join
c 3 4
```
```
2
```

### Advent of Code

Advent of code sind kleine Challgenes, die es immer im Advent gibt. Ich hatte mir hier den ersten
Tag von 2021 angeschaut. Das ist auch nur der erste Teil der Aufgabe 1, auch wenn Teil 2 von 
dieser Grundlage nicht allzuschwer ist.

Hier verwende ich zum ersten Mal auch system APIs, wie zum Beispiel das Auslesen einer Datei in
einen String (`&fras`, **f**ile **r**ead **a**s **S**tring). Dann verändere ich die Eingabewerte
noch so, dass ich einen Array aus Zahlen habe, was der eigentlich Input ist. Ich möchte mich hier
erstmal auf die Logik konzentrieren. *Das ist das, was ich schnell zusammengeschrieben habe und
sicher weder elegant noch optimal. Es sollte trotzdem einen Enblick geben können. Ich kenne die
Sprache jetzt seit ~48 Stunden.* Es geht darum zu finden, wie viele Werte größer sind, als der
vorgherige Wert.

[hier mit Beispielwerten](https://www.uiua.org/pad?src=aSDihpAgJCAyMDAKICAgICQgMjAxCiAgICAkIDMwMAogICAgJCAyOTkKICAgICQgMQpwIOKGkCDiipzilqHCrOKIiiwiXG4iaSAjIHJlbW92ZSB0aGUgYnJlYWtsaW5lIGNoYXJzCnAg4oaQIOKItXBhcnNl4oqUcCAgICMgcGFyc2UgaXQgaW50byBhbiBhcnIgb2YgaW50CuKNiVvih4x-4oaYMeKHjOKGuzFwIHBdCi8r4omhLzwK)

```uiua
i ← &fras "one.txt"
p ← ⊜□¬∊,"\n"i # remove the breakline chars
p ← ∵parse⊔p     # parse it into an arr of int

⍉[⇌~↘1⇌↻1p p]
/+≡/<
```

Unten habe ich es wieder in der ASCII Schreibweise ausgeschrieben.

```uiua
trans[reversesurfacedrop1reverserotate1p p]
reduce+rows<
```

Erst erstelle ich eine Liste, bestehend aus der Eingabeliste `p` und p, nur dass des um eins 
rotiert wurde und der letzte Wert durch `-1` ersetzt wurde (`surface` -> "join with -1"). 
Dann nehmen wir diesen Wert, ohne etwas dafür zu notieren oder ihn zu benennen, denn er liegt
einfach auf dem Stack ganz oben. Wenn man ihn  nach der Zeile ausgeben würde, dann sähe dass im
verlinkten Beispiel so aus:
```
╭─         
╷ 201 200  
  300 201  
  299 300  
    1 299  
   ¯1   1  
          ╯
```
Dann überprüfen wir in jeder Reihe, ob der Weert rechts größer ist oder nicht und addieren dann
die `true`s und das ist dann die Anzahl an Werten, die größer sind als der vorherige Wert (`2`).

Wie man sehen kann, ist die Sprache sehr kompakt, da man weder Funktionsnamen noch Variablennamen
ausschreiben muss. Außerdem ist es einfach faszinieren. Ich hoffe ich konnte dir einen kleinen
Einblick geben und dich vielleicht sogar neugierig machen. Danke fürs Lesen <3.
