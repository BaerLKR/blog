---
title: i2p
date: 2023-01-18 08:29:01
description: i2p ist ein abgeschlossenes, verschlüsseltes ""darknet""
slug: i2p
title-image: /blog/i2p/title.svg
tags: 52posts
archive: true
---

---

*Das Nutzen eines solchen Netzwerks ist nicht illegal (in Deutschland), allerdings können auch illegale Inhalte zu sehen sein. Es ist daher mit großer Vorsicht vorzugehen, wenn man ein solches Netzwerk nutzt.*

---

# Anon

Das normale Internet (das "clearnet") ist alles andere als anonym. Viele sagen, sie würden sich in der Anonymität des Internets verstecken, aber das ist nur scheinbar und auf der Benutzerebene so. In Wirklichkeit hat jede Seite, die man besucht viele Daten über einen. Diese Daten wie zum Beispiel IP-Adresse, cookies, Browser und OS oder möglicherweise verknüpfte Accounts ermöglichen sogenanntes "Fingerprinting". Der Betreiber kann also einzelne Nutzer wiedererkennen, obwohl sie keinen Account haben und so auch Werbung gezielter schalten. 

Ob man auf der Seite auch wirklich verfolgt wird ist natürlich vom Betreiber abhängig.

Allerdings wird man so oder so vom ISP (internet service provider) getrackt. Denn diese Firmen können (und tun es auch) jeden Datentransver sehen und mitschreiben. Dann werden die gesammelten Daten an andere Unternehmen, vor allem Werbetreibende, weiterverkauft.

## VPN

Die wohl bekannteste Lösung für dieses Privatsphärenproblem ist das VPN. Vor allem in letzter Zeit wurde viel Werbung für diesen Service gemacht.

Dagegen hilft tatsächlich ein VPN (virtual private network). Es sendet deinen Internetverkehr verschlüsselt an die eigenen Server, die es dann wiederum an das Internet freigeben. Dadurch wird die IP-Adresse verborgen, die viele sensible Daten wie den Wohnort preis gibt, denn die angesteuerten Seiten sehen nur die IP-Adresse des VPN-Anbieters, durch den der Verkehr geleitet wird. 

Wenn viele Menschen diesen Dienst nutzen wird dadurch auch eine Anonymität geschaffen, denn es lässt sich von außen nicht mehr sagen, welche Anfragen von wem kommen. 

Aber ich rate dennoch stark von einem VPN ab. VPNs haben durchaus ihre Daseinsberechtigung, aber nicht zu dem Zweck, zu dem sie momentan genutzt werden und nicht wie sie momentan genutzt werden.

Die Unternehmen, die VPNs anbieten sind immer noch das, Unternehmen mit Gewinnorientierung. Der Quellcode, mit dem sie ihre Server betreiben ist nicht öffentlich einsehbar und sie schreiben fast immer mit. Es gibt natürlich Ausnahmen, aber im allgemeinen sind sie sogar dazu verpflichtet den Datenverkehr mitzuschreiben und den Behörden auszuhändigen (Europol und die amerikanischen Geheimdienste verpflichten Anbieter Daten mitzuschreiben und bei Verdachtsfällen auszuhändigen (so wurden schon IP-Adressen von Aktivisten und Journalisten herausgegeben)).

Ein VPN (oder eine Proxy) sind sinvoll(er), wenn man sie selbst betreibt und daher auch weiß was wo und von wem gespeichert wird (am besten nichts).

Ein anderer Anwendungszweck für VPNs ist, dass sich so in ein internes Netzwerk von außen verbunden werden kann. So kann ein VPN dazu dienen ein Servernetzwerk zusätzlich zu sichern, denn die Angreifer müssten erst den (besonders geschützten) VPN-Server einnehmen, bevor sie weiteren Zugriff auf die komplexeren Server haben (die wegen ihrer Komplexität oftmals mehr Schwachstellen haben). 

---

## Tor

Ein anonymes Netzwerk ist zum Beispiel [Tor](https://torproject.org/).

Das Tor-Netzwerk verschlüsselt alle gesendeten Daten mehrfach (3 mal). Diese Daten werden durch 3 "Relays" weiter anonymisiert. Dabei weiß auch keiner der mittleren Relays welche Daten er gerade weiter leitet. Nur in der exit-node liegen die Daten unverschlüsselt vor, denn sie werden dann in des clearnet (oder auf eine onionseite) weiter gelitten. Aber auch der Betreiber der exit-node weiß nicht für wen die Daten gedacht sind, denn es werden andere, zufällig ausgewählte, Nodes/Relays für den Handshake und die "Antwort" des Servers genutzt.

Weitere, für den normalen Nutzer aber unnötige, Methoden zur Anonymisierung sind zum Beispiel Brücken. Sie sind vor allem für Menschen in Krisengebieten gedacht, bei denen der Zugang zum Internet Zensiert ist oder auch der Tor-Verkehr verhindert wird. Brücken nutzen Server, die ähnlichen Verkehr aussenden, wie bekannte und nicht zensierte Seiten, um so den Zugang zu ihnen sicherzustellen (meek-azure). Oder aber werden die Daten an andere Nutzer "geproxyt" um so eventuelle Sperren zu umgehen. 

Ein großer Vorteil von Tor, den die anderen Netzwerke hier nicht haben, ist, dass es so einfach zu installieren ist. Einfach das Browse-Bundle installieren und los gehts! Das ist einfacher, als ein VPN zu installieren, denn dafür muss man meistens bezahlen (und wenn nicht würde ich ganz und gar von der Nutzung abraten, denn dann finanziert es sich **nur** über den Verkauf deiner Daten (da sind deine Daten bei deinem ISP sicherer lol)). 

Das Tor-Netzwerk hat allerdings auch einige Nachteile. Zum Beispiel ist die Belastung des Internetverkehrs sehr ungleich verteilt. Denn nur einige wenige (6.000) betreiben die Relays, die das Tor-Netzwerk möglich machen. Wo hingegen rund 2.500.000 Menschen das Netzwerk nutzen (und nur 2.200 Bridges). Des verringert die Anonymität der Nutzer und die Geschwindigkeit des Netzwerks. Außerdem macht es das Netzwerk verletzbar für Angriffe die versuchen mehr als 50% der Relays zu betreiben und es ihnen so zu ermöglichen die Daten der Nutzer zu deanonymisieren *([kax17](https://cybersecurityworldconference.com/2021/12/03/kax17-threat-actor-is-attempting-to-deanonymize-tor-users-running-thousands-of-rogue-relays/))*.

### onion site

Jeder kann seine eigene Tor-Seite hosten. Das ist wichtig, nicht nur wenn man als Host seine Daten nicht alle Preisgeben will, sondern auch weil die Domain im Tor-Netzwerk einem gehört und man nicht von Unternehmen, DNS-Servern und Regierungen abhängig ist.

#### Linux

Um eine (auf Linux) zu betreiben muss man nur die entsprechenden Zeilen in der ``/etc/tor/torrc``
bearbeiten.

![](/week/torrc.png)

Entferne die ``#`` in den Zeilen, die du brauchst und starte den Tor-Hintergrundprozess neu.

Deinen Webserver musst du dann auf dem angegeben Port (in diesem Fall 8080) laufen lassen. Deine ``.onion`` Adresse ist in ``/var/lib/tor/hidden_service/hostname``.

*[mehr Infos](https://community.torproject.org/onion-services/)*

#### Windows

Ich würde es nicht empfehlen, denn man weiß nicht was davon wirklich geheim ist. Und das verfehlt den Sinn und Zweck, anonym zu bleiben.

### onionshare

[onionshare](https://onionshare.org/) ist eine GUI-Applikation, die es allen ermöglicht einfach (und ohne Konfigurationsdateien zu Bearbeiten) .onion Webseiten und Dateitransferseiten zu hosten(auch mehrere auf ein mal).

![](/week/onionshare.png)

### Relay

Das Betreiben eines Relays gestaltet sich allerdings als etwas komplexer. Grundsätzlich ist es sehr einfach ein Relay zu betreiben, wieder nur die Zeilen die relevant sind einfügen und fertig. Allerdings können manche privaten Router (WLAN/LAN Router) die vielen offenen Verbindungen nicht handhaben. Außerdem ist es empfohlen einen Port am Router auf zu machen, um den Datenverkehr an der Firewall vorbei zu leiten. Das ist eine weitere Hürde. 

Allerdings gibt es auf der Tor Seite tolle Anleitungen zum Betreiben eines Relays. 

- [community.torproject.org](https://community.torproject.org/relay/)
- [nyx](https://nyx.torproject.org/)

---

## i2p

Ein anderes Netzwerk ist [i2p](https://geti2p.net). Genauso wie Tor ist auch i2p ein Netzwerk, dass darauf beruht dass der Verkehr durch andere Nutzer des Netzwerks anonymisiert wird. Allerdings ist bei i2p jeder Nutzer auch eine art Relay, es ist somit ein "echtes" P2P-Netzwerk. Dadurch ähnelt i2p [torrents](#torrents). Das hilft einerseits den Datenverkehr weiter zu verteilen und Zensur zu erschweren und zweitens nimmt es die Last von den Relay Betreibern, wie sie es im Tor Netzwerk gibt.

Im Gegensatz zu Tor bietet i2p aber keine exit nodes in das clearnet. Man kann also nur eepsites (die Seiten des Netzwerks). Obwohl es mittlerweile Plugins gibt die es ermöglichen, aber von sich aus ist i2p nicht dazu gemacht das clearnet zu nutzen. 

Der Zugang zum Netzwerk ist über mehrere Wege möglich. Es gibt eine http proxie für den Webbrowser aber auch andere Zugänge wie SOCKS, BOB, SAM, I2CP, I2PControl. Dadurch ist es möglich auch andere Applikationen mit i2p interagieren zu lassen.

Dadurch, dass jeder mithilft das Netzwerk am laufen zu halten und dadurch ein Relay ist, welches die verschlüsselten "Tunnel" aufbauen muss, dauert es einige Zeit, bis man in das Netzwerk eingebunden ist und auch Webseiten erreichbar sind. Es wird empfohlen es entweder auf einem VPS oder im Heimnetz auf einem Server laufen zu lassen. So ist der Router immer an und man hat eine gute Einbindung und hilft den anderen Nutzern durch eine gute Upload-Ratio.

i2p ist auch von einer technischen Sicht aus sicherer, denn in Tor gibt es immer wieder Vorfälle, wo Dienste von Angreifern auf dem applikation-layer (des ISO/OSI Schichten Modells) von Tor attackiert wurden (zum Beispiel ein DOS).

### browser

Für i2p gibt es kein Browse-Bundle wie für tor, aber das macht nichts, denn so kann man mehr selbst entscheiden (ohne großen Aufwand einzugehen). Mann muss nur die Proxy-Einstellungen des Browsers, den man für i2p nutzen will, so einstellen, dass sie als Proxy ``127.0.0.1:4444`` angeben (wenn du die Standardeinstellungen beibehalten hast (wenn du sie geändert hast kennst du dich genug aus um es selbst zu ändern)).

Hier die Einstellungen in Firefox (ich nutze hier die http-proxy).
![](/week/proxy.png)

### diese Seite

Diese Seite ist auch als eepseite verfügbar.

[baer.i2p](http://baer.i2p), [b32](http://bz5rhwsbmm6r55m5inlngxbhz5gz55xdvtl26pgt65awivx36v5a.b32.i2p), [addresshelper](http://baer.i2p/?i2paddresshelper=sdhVeOJleozceGKTaQCKSeG9a~xWxz2rvM06z-rrd6Gx2FV44mV6jNx4YpNpAIpJ4b1r~FbHPau8zTrP6ut3obHYVXjiZXqM3Hhik2kAiknhvWv8Vsc9q7zNOs~q63ehsdhVeOJleozceGKTaQCKSeG9a~xWxz2rvM06z-rrd6Gx2FV44mV6jNx4YpNpAIpJ4b1r~FbHPau8zTrP6ut3obHYVXjiZXqM3Hhik2kAiknhvWv8Vsc9q7zNOs~q63ehsdhVeOJleozceGKTaQCKSeG9a~xWxz2rvM06z-rrd6Gx2FV44mV6jNx4YpNpAIpJ4b1r~FbHPau8zTrP6ut3obHYVXjiZXqM3Hhik2kAiknhvWv8Vsc9q7zNOs~q63ehsdhVeOJleozceGKTaQCKSeG9a~xWxz2rvM06z-rrd6Gx2FV44mV6jNx4YpNpAIpJ4b1r~FbHPau8zTrP6ut3obeR4wA7Q188BZnz1dCrDPvHZg4~DrPhx6hfO0oMgGmvBQAEAAcAAA==)

### i2pd

[i2pd](https://i2pd.website/) ist eine C++ Implementation des in Java geschriebenen offiziellen Routers. Es nutzt von sich aus weniger Ressourcen und kann daher auf leistungsschwächeren Maschinen problemlos ausgeführt werden. 

Es hat alle Funktionen, die auch der Java Router hat. Allerdings muss man bei i2pd die Konfigurationsdateien händisch bearbeiten (im Gegensatz dazu hat der Java Router mehr Funktionen im GUI verfügbar).

Der offizielle Router von i2p hat eine eingebaute torrent Funktion (i2psnark). Das ist bei i2pd nicht so, allerdings kann man andere Programme nutzen um anonym über i2p torrents herunterzuladen. Eine Option ist die standalone version von i2psnark (herausgegeben von i2p+). Oder andere Torrent clients die kompatibel sind (es gibt nicht viele und die meisten sind archiviert). 

### eepsite

Auch auf i2p kann jeder seine eigene Seite betreiben. Man nennt sie hier eepsites.

In i2p sind Seiten nicht für jeden verfügbar. Der host muss erst im Adressbuch auftauchen, bevor er angesteuert werden kann. Dafür gibt es öffentliche Registrations Seiten, auf denen man seine Domain verkünden kann. Die Listen der Hosts kann man dann in sein Adressbuch einfügen und hat so Zugang zu den meisten Seiten. 

*[reg.i2p](http://reg.i2p), [inr.i2p](http://inr.i2p), [identiguy.i2p](http://identiguy.i2p)* 

---

## torrents

Torrenting ist nicht anonym! Aber es ist auch im Sinne des dezentralen P2P (peer to peer) Konzepts.

Es ist stark davon abzuraten Torrents ohne VPN oder andere Verschlüsselung (IP-Adressen versteckende Maßnahmen) herunterzuladen, da alle Peers deine IP-Adresse sehen können.

Beim Torrenting lädt man die Dateien von allen herunter, die schon etwas davon haben (Peers) und von denen die schon die ganze Datei haben (Seeds). Auch man selbst wird zum Uploader und trägt so zum "weiterleben" des torrents bei. Man sollte immer eine upload-download-ratio von 1 haben. bevor man das seeden beendet (dass man also genau so viel Beigetragen (hochgeladen) hat wie man heruntergeladen hat).

Torrenting ist nicht illegal, aber häufig werden illegale/gestohlen Inhalte über torrents verbreitet, da man als Staat/Unternehmen Torrents schlecht offline nehmen kann (weil sie ja dezentral sind).

---

## andere

Es gibt noch viele andere solcher Netzwerke, aber das sind die bekanntesten mit den meisten Nutzern. Alle diese Protokolle haben andere Zwecke und Zielgruppen.

1. [lokinet](https://lokinet.org/)
2. [freenet](https://freenetproject.org/)
3. [gnunet](https://www.gnunet.org/en/)

---

## 52posts

Dieser Beitrag ist Teil meines Plans, in 2023 jede Woche einen Post zu erstellen, mit Dingen, die ich gelernt habe. (Das sind dann 52 Posts).

[#52posts](/tag/52posts/)
