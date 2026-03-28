---
title: Linux Teil 2
date: 2023-01-28 12:29:00
description: linux 2, electric boogaloo
slug: linux-2
title-image: /blog/linux-2/title.svg
tags: 52posts, linux
archive: true
---

Hier werde ich 2 Distros näher anschauen, die durchaus besondere Eigenschaften im Vergleich zu "normalen" Distro, wie Debian oder Arch, haben. 

*Bedenke, dass ich wahrlich kein Profi bin und nicht die tiefsten Einblicke in die jeweiligen Distros habe. Ich schreibe hier was ich weiß und beim Benutzen und dem Lesen der Documentation gefunden habe.*

## NixOS

[NixOS](https://nixos.org) ist eine Distribution die primär für Entwickler und Systemadministratoren gedacht ist. Das ganze Betriebssystem beruht im grunde genommen auf einem Paketmanager. Was ich für einen recht guten Ansatz halte, denn das Paketmanagement ist, meiner Meinung nach, eins der Wichtigsten Dinge auf die man bei der Wahl seine Distribution achten sollte. Das ist auch der Grund, weßhalb ich Arch nutze, denn im AUR ist einfach jedes Paket, dass man brauchen könnte.

*[nixos Dokumentation](https://nixos.org/manual/)*

Neuerdings gibt es NixOS auch mit einem GUI-Installer!

### configuration.nix

Die globale Konfigurationsdatei liegt in ``/etc/nixos/configuration.nix``. Dort werden die Benutzer, die Pakete, das DE (oder WM), die Sudo-Gruppen, das Shell-Environement, hostname, Startupprogramme und vieles mehr deklariert. Die Idee hinter dieser Datei ist, dass NixOS dadurch sehr tragbar und reproduzierbar wird. Das sind nähmlich die grundsätzlichen Ziele von NixOS.

Wenn Änderungen an der Konfigurationsdatei vorgenommen werden wird ein sogenannter Snapshot werstellt. Im Grub-Menü erscheint die ältere Version dann. So kann man die älteren Einstellungen noch **vor** dem Boot auswählen und so bootunfähige Konfigurationen umgehen. Das macht das System natürlich äußerst robust.

Wenn man eine Änderung an der Datei vorgenommen hat und man auf die neue Version (den neuen Snapshot) des Systems wechseln möchte. ``nixos-rebuild switch`` baut das System neu und wechselt zur neuen Version (meistens ist allerdings ein Neustart nötig, um die Änderungen auch anzuwenden).

### nix store

Die installierten Programme werden in ``/nix/store/`` gespeichert. Auch hier gibt es wieder einige Besonderheiten. Die Programme werden für immer gespeichert, die alten Versionen werden bei einem Update also nicht gelöscht (nicht automatisch zumindest, durch einen Befehl kann man sie trotzdem löschen). Dadurch kann das System auch nicht durch neue, inkompatible Pakete kaputt gemacht werden. Die Binärdateien werden außerdem mit symlinks zu den ``$PATH`` Orten gelinkt.

### nix-env

Programme müssen aber nicht für das ganze System installiert werden (man kann sie auch in der Konfigurationsdatei Benutzerbezogen installieren, aber hier meine ich, dass man mit ``nix-env`` Pakete ähnlich zu traditionellen Paketmanagern installieren kann).

Nix kann man auf fast allen Distros installieren. Also kann man immer aus den Nix-Repos Pakete laden. Dafür muss man nur ``curl -L https://nixos.org/nix/install | sh`` ausführen. Der Installationsscript wird dann automatisch die nötigen Binärdateien herunterladen und die Ordner erstellen. Wenn man zum Beispiel das [``hello``](https://search.nixos.org/packages?query=hello) Paket (ein einfacher Testscript) installiern möchte führt man ``nix-env -iA nixpkgs.hello`` aus (wenn man das gleiche Programm mit nix-env auf nixos installiern möchte ist es ``nix-env -iA nixos.hello``). Die Nix-Repos haben über 80.000 Pakete, somit auch die wichtigsten AUR Pakete, und nixpkgs sind im Bau deutlich schneller. Außerdem kann man so das Paketmanagement über (fast) alle Distros einheitlich machen, und muss nicht immer neuen Synatx und Funktionsweisen der jeweiligen Distros lernen. (nix-env ist auch für mac erhältlich).

### nix-shell

Die ``nix-shell`` ist ein Feature, welches eher für Entwickler interessant ist. Es erlaubt einem ein Programm in einer isolierten Umgebung auszuführen. So kann wieder eine der Grundlagen von Nixos durchgesetzt werde, die Reproduktivität. Auch die ``nixpkg``, die Pakete aus den Nix Repos, funktionieren in einer ähnlich isolierten Umgebung.

Auch Programme aus den Repos kann man in der nix-shell Umgebung testen. Indem man die ``-p [package]`` Option wählt.

Wenn andere Software das Programm stören könnte kann man auch die ``--pure`` Option wählen, dann ist der Container ein (fast) ganz frisches System. 

---
## VanillaOS

[VanillaOS](https://vanillaos.org) ist eine auf Ubuntu basierende Distribution, betrieben von [Mirko Bombin](https://fabricators.ltd). Auch hier wird ein besonderer Ansatz für Paketmanagement genutzt. Alle Programme werden in Containern untergebracht. Das Host-System, auf dem alle Daten wie zum Beispiel der ``/home`` Ordner gespeichert sind. Da sowieso alle Programme in Containern untergebracht sind, werden auch andere Betriebssysteme (Distros) in diesen Containern genutzt. Von sich aus hat VanillaOS einen Ubuntu container (auf dem Programme mit ``apt`` installiert werden).

Die Benutzung ist einfach und intuitiv. Die in den Containern befindlichen Programme werden ohne Probleme in die GNOME Umgebung integriert.

### apx

Apx ist der Paketmanager von VanillaOS. Mit ihm ist es möglich auch Programme aus den Fedora Repos (``--dnf``) und dem AUR (``--aur``) installieren. Es ist auch geplant Nixpkgs zu unterstützen. 

Die dem zugrundeliegende Technologie ist ``abroot``. Ein eigens dafür geschriebenes Programm. Es erlaubt dem Betriebssystem die Root-Partition zu tauschen, ohne Daten zu bewegen. 

---
## 52posts

Dieser Beitrag ist Teil meines Plans, in 2023 jede Woche einen Post zu erstellen, mit Dingen, die ich gelernt habe. (Das sind dann 52 Posts).

 [#52posts](/tag/52posts/)

