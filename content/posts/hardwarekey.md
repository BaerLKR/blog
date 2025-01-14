+++
title = 'Hardwarekey'
date = 2025-01-14T00:25:50+01:00
+++

Seit einigen Jahren erfreuen sich Hardwareschlüssel wie der Yubikey oder viele andere Modelle immer größerer Beliebtheit.
Ich kann das durchaus verstehen, denn es ist nicht nur cool sondern tatsächlich auch sicherer als die meisten anderen
Lösungen. Primär weil es ein echter zweiter Faktor ist der an vielen Stellen werdendet werden kann wo sonst 2FA nicht
verfügbar oder möglich ist. Was ich damit meine ist das andere Methoden, die üblicherweise als 2FA beworben werden nicht
wirklich einen zweiten Faktor darstellen. Besonders schlimm finde ich e-mail. Denn die ist aktuell so etwas wie die globale
anlaufstelle für Passwortzurücksetzungen. Das hat zur Folge, dass ich das Passwort gar nicht brauche sondern nur das für doe
email, und damit ist es nur ein Faktor. Aber auch eine App oder ein OTP sind nicht immer die beste Wahl (keine Frage, besser
als sie nicht zu verwenden, nur eben nicht unbeding ein echter zweiter Faktor), denn am handy habe ich immer beides. Dann ist
nur noch die Frage wer mein Handy kontrolliert und "haben" ist nur ein Sicherheitsfaktor.

An sich ist die Idee ganz gut Schlüssel auf einem Gerät zu haben das man kontrolliert ganz gut und gefällt mir auch persönlich
einfach. Cryptografisch ergibt das auch sinn Schlüssel auf einem getrennten Gerät aufzubewahren.
Das Problem was ich damit habe ist das Sicherheit der Passwörter zwei Seiten hat. Die eine ist das die Passwörter vor andern
sicher sind und keiner unbefugten Zugang zu den Daten hat. Aber eben auch die andere Seite, dass ich sicher, also zuverlässig,
an meine Daten selber komme. Und da sehe ich das Hauptproblem mit solchen Hardwareschlüsseln, sie sind ein Stück Elektronik
von dem abhängig ist ob ich meine Passwörter habe oder nicht. Daher bleibe ich weiter bei einem herkömmlichen Passwortmanager
denn den kann ich auch in backups dezentral hinterlegen. Ich habe dann immer noch 2 Faktoren, einmal das Haben der
verschlüsselten Datei und dann das Wissen des Masterpasswortes. Klar kann die Datei kopiert werden, aber das ist ja das was
ich will.

Wie immer ist Sicherheit ein Kompromiss. In diesem Fall habe ich für mich entschlossen dass ein Passwortmanager mit einer
verschlüsselten Datei für mich die bessere Wahl ist als einer der in Hardware ein seperates Gerät ist. Ich bin zu
abhängig von meinen Passwörter, nicht nur von Onlineprofilen, die ich zurücksetzten lassen könnte, sondern auch für
Passwörter für verschlüsselte Partitionen und Dateien. Ich kann nicht riskieren dass ich diese Zugänge verliere wenn ich ihn
aus versehen in Wasser fallen lasse oder er einfach kaputt geht[^1]. Für andere mögen die Vorteile eines Hardwareschlüssels
die Nachteile überwiegen, das muss jeder für sich entscheiden.

[^1]: Ja ich weiß, dass man auch bei zB Yubikeys ein zweites Backupgerät haben kann, aber dann ist das auch eine Kostenfrage.
