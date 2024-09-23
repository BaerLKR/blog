+++
title = 'android safe mode'
date = 2024-09-23T17:16:21+02:00
+++

Dieser Post wird nicht wirklich vielen weiterhelfen, aber ich schreibe ihn trotzdem mal. Außerdem kann man ein bisschen über freie
Software und ihre Rolle in modernen Systemen nachdenken.

Meine Ausgangslage war die, dass ich nicht die Vorinstallierte Samsung Tastatur benutzen wollte, weil ich ihr nicht vertraue. Ich
mag paranoid klingen aber die können da sonst was installiert haben und ich habe keinerlei Möglichkeit es zu überprüfen (unter
anderem mangels der Peripherie, was mich sowieso an der Nutzung des Handys stört). Und die Tastatur ist einer der sensibelsten
Informationsquellen auf meinem Gerät. Über die Tastatur geht das Masterpasswort meines Passwortmanagers, alle meine Textnachrichten,
meine Suchanfragen, meine Notizen, und ,und ,und. Wenn ich irgendwo ein bisschen paranoid sein sollte, dann da. Noch dazu wenn es
keine nennenswerten Einschränkungen imm Kompfort zur Folge hat. Um zum Punkt zu kommen, ich habe eine Quelloffene Tastatur
installiert und als Standart gesetzt. Es war [Fossify Keyboard](https://github.com/FossifyOrg/Keyboard), aber das spielt hier
nicht wirklich eine Rolle. Ich war sehr zufrieden damit, es war einfach eine Tastatur und die hatte auch noch mehr Optionen als
die normale.

Das Problem ergab sich dann als ich mein Gerät neu gestartet habe. Nichts böses ahnend habe ich es neu gestartet und wollte es
entsperren. Das ging aber nicht, weil die Tastatur einfach wieder verschwunden ist. Ich war für einen Moment echt aufgeschmissen
weil alle Wege die kannte, die nicht eine externe Tastatur gebraucht hätten nicht gehen wenn das Gerät noch verschlüsselt ist; nach
einem Neustart ist es verschlüsselt bis es einmal entsperrt wurde. Also kein adb, kein garnix. Nach einigen schnellen Suchanfragen
habe ich herausgefunden dass Android den "Safe Mode" hat in dem 3rd party Applikationen ausgeschaltet werden. Und das hat mir dann
den Tag gerattet, denn ich konnte die Einstellungen bezüglich der Tastatur auf die Standarts zurücksetzten und alles war wieder gut.

Also, wenn jemand unter den werten Lesenden jemals ein Problem dieser Natur haben sollte dann wisst ihr jetzt was zu tun ist. Wenn
man auf den "Aus Knopf" bis die Option zum Herunterfahren erscheint. Dann "Herunterfahren" gedrückt halten bis in den "Safe Mode"
gebootet wird.

Jetzt noch ein bisschen freies Philosophieren über freie Software zum Abschluss. Das Problem mit der Enschlüsselung wurde
auch [prompt behoben](https://github.com/FossifyOrg/Keyboard/issues/59). Wenn man nun mal einen Schritt zurück macht und betrachtet
war wir vor uns haben. Wir haben ein Programm welches besser oder zumindest genau so gut funktioniert wie die komerzielle
Variante, aber es wird von freiwilligen Entwicklern ohne Gegenlohn entwickelt und uns zur Verfügung gestellt. Ich bin also selber
Schuld. Aber das ist auch eine Image Frage, "freie Software ist einfach schlechter, sie ist unzuverlässig und schafft Probleme". Ich
hoffe ich mache es hiermit nicht noch schlimmer, denn ich liebe freie Software. Das Problem ist nicht der Entwickler des Projekts, es
sind wir und ebendieses Vorurteil. Meiner Meinung nach geht es um Wertschätzung und Vergütung von freier Software. Alles baut auf
diese Projekte auf. Sie sind die zuverlässigsten die wir haben, aber die komerziellen Produkte bauen darauf auf und haben bessere
testing Instanzen die dann so etwas zum Beispiel verhindern.

Das ist jetzt nicht wirklich ein rundes Ende aber mein Punkt steht, doof gelaufen aber das Problem ist nicht die freie Software.
