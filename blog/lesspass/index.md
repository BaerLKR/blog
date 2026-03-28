---
title: lesspass
date: 2022-12-29 18:16:00
description: Man kann die Passworddatenbank nicht verlieren wenn es keine gibt
slug: lesspass
title-image: /blog/lesspass/title.svg
tags: 52posts
archive: true
---

# Passwortmanager

## Datenbank basierte Passwortmanager

Die meisten Passwortmanager basieren auf einer verschlüsselten Datenbank. Dabei vergibt der Nutzer ein "Masterpasswort", mit dem die verschlüsselten Passwörter lesbar gemacht werden können. Dadurch muss man sich nur ein Passwort merken (es kann dann auch ein besseres Passwort sein) und alle anderen können zufällig generierte Zahlen, Buchstaben und Sonderzeichen sein. 
Dadurch wird die Sicherheit der Passwörter, und damit die Sicherheit der Nutzer erhöht, wobei gleichzeitig auch der Komfort gesteigert wird, denn es muss sich, wie gesagt, nur ein Passwort gemerkt werden. 

Beispiele dafür wären:

- [Bitwarden](https://bitwarden.com/) *synchronisiert*
- [KeePassXC](https://keepassxc.org/)
- [1Passwort](https://1password.com/) *synchronisiert, kostenpflichtig*

Einige davon haben einen Server, der von der Firma unterhalten wird, um die Passwörter für verschiedene Endgeräte zu Synchronisieren.

### Browser

Viele Browser (eigentlich fast alle) haben eine Passwortfunktion eingebaut. Es wird stark davon abgeraten diese zu nutzen, da die Passwörter nicht verschlüsselt vorliegen und so einfach von Malware abgegriffen werden können. (Da Passwörter so wichtig sind, sind sie ein beliebtes Ziel solcher Angriffe)

Allerdings bieten viele Passwortmanager eine Browserextention, mit der ähnliches erzielt werden kann und die Passwörter automatisch, nach dem "Öffnen" der Datenbank, eingetragen werden. 

### Das Problem

Aber auch wenn die Datenbank verschlüsselt ist, besteht immer noch die Gefahr eines schwachen Masterpasswortes oder anderer Methoden um die Datenbank zu entschlüsseln. Zum Beispiel ein schlechter Verschlüsselungsalgorithmus oder ein Brute-Force-Angriff.

Wenn die Datenbank lokal auf dem PC gespeichert ist, ist das meist kein Problem. Denn dann kann Malware sie nicht einfach finden und öffen. Wenn allerdings ein Server dazu benutzt wird die Datenbank zu speichern und an die verschiedenen Endgeräte zu senden, können die Daten vieler Menschen auf ein mal "geklaut" werden. Daher sind diese Unternehmen auch beliebt Ziele solcher Angriffe. 
Dann besteht immer noch die Gefahr, dass ein schwaches Masterpasswort gewählt wurde, oder dass das Unternehmen die Passwörter nicht ordnungsgemäß verschlüsselt hat. Es gibt noch weitere Faktoren, auf die man keinerlei Einfluss hat, da der Server (logischerweise) proprietär verwaltet wird. Man muss dem Anbieter also voll vertrauen.

#### LastPass

[LastPass](https://www.lastpass.com/) ist das neuste Beispiel eines solchen Falls. Dabei wurden im August technische Daten und Quellcode gestohlen. Durch diese Informationen waren die Hacker in der Lage die Zugangsdaten eines Mitarbeiters zu erlangen. Dieser Mitarbeiteraccount hatte Zugang zu einem Backup der von LastPass gespeicherten Nutzerdaten. In diesen Daten sind "nur" verschlüsselte Passwörter enthalten (256-bit AES). 

Um so etwas zu verhindern muss man entweder lokal seine Passwörter speichern, oder ein System ohne Datenbank nutzen. 

## Die Alternative

Eine Alternative zu solchen Passwortmanagern wäre [LessPass](https://www.lesspass.com/#/). 

Diese Programme funktionieren ohne Datenbank. Das Passwort wird aus dem Benutzernamen, der Seite, auf der sich eingeloggt wird und dem Masterpasswort (sowie den Passworteinstellungen) ein Hash gebildet. Diese Hashfunktion hat, so lange die Parameter die gleichen sind, auch immer den gleichen Output.

Jedes mal, wenn man sich auf der Seite einloggen möchte wird das Passwort also neu generiert.

### Vorteile

1. Dadurch, dass keine Daten gespeichert werden, kann es auch nicht dazu kommen, dass Daten geklaut werden.
2. Man muss keinem Unternehmen vertrauen, dass mit den äußerst sensiblen Daten richtig umgegangen wird
3. Man kann es auf mehreren verschiedenen Geräten nutzen, da keine Daten übertragen werden müssen (bis auf das Masterpasswort, das man sowieso wissen muss. Und den Benutzernamen)

### Nachteile

1. Man kann keine anderen Daten, wie Geheime Notizen, Dateien oder Metainformationen speichern
2. Man muss sich etwas mehr merken als bei anderen Passwortmanagern

---

## 52posts

Dieser Beitrag ist Teil meines Plans in 2023 jede Woche einen Post zu erstellen, mit Dingen die ich gelernt habe. (Das sind dann 52 Posts).

[#52posts](/tag/52posts)
