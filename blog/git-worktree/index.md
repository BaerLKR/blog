---
title: git worktree
date: 2024-12-11 19:14:47
description: Git worktrees are a useful feature that I use often. But it is rarely talked about.
slug: git-worktree
title-image: /blog/git-worktree/git.png
image: /blog/git-worktree/veloren.png
archive: true
---

Vor nicht allzulanger Zeit habe ich ein `git` feature entdeckt. Darüber will ich hier einen kleinen Entrag machen, weil ich es
ziemlich praktische finde und es daher dir, meiner werten Leserschaft, nicht vorenthalten möchte.

Ich verwende es um verschiedene branches gleichzeitig bearbeiten zu können ohne Dinge stashen zu müssen. Mit `git worktree` kann
man eine branch als einen Unterordner öffnen und bearbeiten und das eben so vielen commits wie man möchte. Bei mir ist das
aktuell besonders praktisch für meine Unimitschrifen die ich mit `git` verwalte. So kann ich eine Änderung an einer Übungsabgabe
vornehmen und gleich im anschluss, bevor die Abgabe so weit ist einen commit zu machen, meine Mitschriften anpassen oder etwas
konkretisieren.

Klar könnte man all das auch mit `git stash` erreichen, aber ich mag die stashing area nicht. Ich verliere immer den Überblick
was in welchem stash liegt. Meistens vergesse ich einfach dass ich dort überhaupt etwas abgelegt habe und es ist auf Dauer
auch aufwendiger als die worktree Variante. Den einzigen Nachteil den ich sehe ist dass man bei sehr großen repos mehrfach fast
identische branches auf der disk hat. Aber wenn git metadaten, die aus meiner Erfahrung häufiger das Problem ist, wird nicht
doppelt gespeichert.

Hier will ich noch eine kleine Zusammenfassung geben wie ich den `worktree` subcommand verwende. Zuerst muss das repo neu gecloned
werden und zwar mit der `--bare` Option. Wenn man dann nachschaut was manheruntergeladen hat, dann fällt auf, dass es nicht so
aussieht wie ein normales git repo. Es liegen nicht die Programmdateien da, sondern nur git Metadaten. Hier kann man jetzt mit dem
eben erwähnten Unterbefehl die Magie erleben. `git worktree add <branch>` und einem optionalen `path` erstellt einen Unterordner wo
dann die gewohnte Umgebung von git ist eben mit der ausgewählten branch ausgewählt. Wieder im root des git repos kann man mit
`git worktree list` sich anzeigen lassen welcher Ordner welche branch auf welchem commit enthält. Der einzige andere Befehl den
ich noch verwende ist `git worktree remove` um eine branch bzw. einen Unterordner wieder zu löschen.
