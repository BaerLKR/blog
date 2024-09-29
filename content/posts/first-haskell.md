+++
title = 'erste Woche Haskell'
date = 2024-09-24T10:05:34+02:00
+++

Ach ja, Haskell. Es stand schon länger auf meiner Todo-Liste Haskell zu lernen. Es
übt eine besondere Faszination aus als Programmiersprache die so anders funktioniert.
Auch als possionierter OOP Hater, ohne jemals wirklich OOP Code geschrieben zu haben
musste ich irgendwann auch mal bei Haskell landen.

Hier will ich also meine Erfahrungen nach so rund einer Woche festhalten. Also,
das kann auch alles falsch sein was ich hier schreibe.

## funktionelle Programmierung

Was mich, wie ich schon ansprach, besonders reitzt ist der funktionelle Aspekt der Sprache.
Aber ich hatte deutlich weniger Probleme mit Rekursion als ich erwartet habe. Ich habe
noch nicht durchschaut wie `fold` effektiv zu verwenden ist. Die anderen Seiten der
Sprache, bis auf die Syntax, waren mir schon recht bekannt. Vorallem das Typeclass
system ähnelt dem rust Trait System sehr. Das liegt wohl daran, dass Rust es sich von
Haskell abgeschaut. Das Funktionen "first-class-citizens" sind kenne ich auch schon aus
rust und julia. Und in rust `const` Funktionen haben ähnliche Beschränkungen wie Haskell
Funktionen. Ganz nützlich wurden auch meine kleinen Exkursionen in Uiua, weil diese Programme
immer tacit sind. Dort "fließen" die Daten auch durch die Programmzeilen ohne an Variablen
gebunden zu werden. Aber um so erstaunlicher ist es finde ich, dass mir die Rekursion keine
Probleme gemacht hat.

Ich finde es eine sehr interessantes Designentscheidung rekursion als so einen zentralen
Bauteil der Sprache zu haben. Manchmal durchaus mental fordernd, aber auch nah an der
Mathematik, aber dazu später mehr. Ein weiterer hübscher Nebeneffekt der Rekursion ist, dass
Funktionen sehr kompakt werden können. Das wird noch weiter bestärkt durch "point-free" notation,
die zwar nicht pflicht ist aber mir intuitiv vorkommt und auch einfacher, denn die Variablen wären
ohnehin nicht veränderbar.

## mathematische Notation

Zufällig bin ich auch aktuell in der ersten Woche meiner mathe Vorlesungen an der Uni und wir
klären Grundlagen von Mengenlehre, Aussagenlogik und mathematische Schreibweisen. Mir sind immer
wieder Ähnlichkeiten in der Notation aufgefallen. Zum Beispiel bei der Definition von Mengen
und einer list comprehension und der Definition einer Menge.

```Haskell
[ x^2 | x <- [1..] ]
```

Oder auch die Schreibweise einer Fallunterscheidung und dem Patternmatching:

```Haskell
betrag x
    | x >= 0    = x
    | x < 0     = -x
```

Und auch in der Notation und Herangehensweise zu Induktionsbeweisen:

```Haskell
factorial 0 = 1
factorial x = x * factorial (x - 1)
```

Es wird ein Grundfall und ein Fall definiert, der darauf aufbaut. Außerdem wird immer rekursiv argumentiert.
Nur das der Beweis (zumindest die die ich zu sehen bekommen habe) meist in die Unendlichkeit verläuft und damit
wahr ist und Funktionen in Haskell sich "nach unten" selbst aufrufen und so (im Idealfall) terminieren.

## Fazit

Haskell ist ohne Frage eine sehr interessante Sprache die ich weiter lernen und verwenden werde.
Es mag zwar nicht so performant sein wie rust,

> Haskell ist nur Rust mit `.clone()` überall

aber es erlaubt einem sich mehr auf die Logik zu konzentrieren und kompakteren code zu schreiben.
Mann muss sich nicht um lifetimes Gedanken machen und type generics sind deutlich einfacher und
mit weniger Boilerplate verbunden als in rust, was code reusal wiederum einfacher macht.
