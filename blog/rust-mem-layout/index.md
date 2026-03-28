---
title: rust memory layouts
date: 2024-02-11 12:29:01
description: Ausflug in den Arbeitsspeicher
slug: rust-mem-layout
title-image: /blog/rust-mem-layout/title.svg
tags: rust, linux
archive: true
---


> Dieser Eintrag ist als Gedankenmodell gedacht um anderen den Einstieg in die low-level Struktuen
> des Programmierens zu geben. Es besteht aus den Quellen, die ich gefunden und verstanden habe, sowie
> das was ich über die Zeit gelernt habe. Ich hoffe es stimmt alles, aber wenn nicht (wenn etwas auch nur
> nicht ganz stimmig scheint), bitte lasst es mich wissen. Danke :)

---

# Ausflug in den Arbeitsspeicher - wie Datenstrukturen (in Rust) dargestellt werden

Ich möchte hier darüber reden, wie Datenstrukturen in Rust im Arbeitsspeicher aussehen, und auch wie der Kernel
Arbeitsspeicher abstrahiert.

## Speichermedien

Erst einmal möchte ich alle Leser auf einen Nenner bringen, was den Aufbau von Speichermedien im Computer an geht.
Es gibt 4 hauptsächlich relevante Medien:
1. die Festplatte
2. den Arbeitsspeicher (RAM)
3. die Register
4. den VRAM auf der GPU (werde ich hier nicht behandeln)

Alle diese Speicher treffen die Abwägung zwischen Geschwindigkeit und Speicherkapazität. Und alle füllen eine Lücke
auf einem anderen Feld.

### Festplatte

Die Festplatte ist pro Speichereinheit sehr günstig (verglichen mit den anderen) und verbraucht um Daten zu halten/
zu speichern keinen Strom, daher auch der Begriff des "cold storage". Es ist allerdings verhältnimäßig langsam. Zu 
langsam, als das es mit einer moderen CPU mithalten könnte. Der Knackpunkt ist nämlich ebendieser, wo ist das 
langsamste Glied in der Kette, und wie schafft man es diese Lücke möglichts reibungslos zu füllen.

### RAM

Dafür gibt es RAM (random access memory, auch "DRAM" genannt -> "dynamic RAM"). Es ist der Arbeitsspeicher. Hier werden die Daten von der Festplatte 
zwischengespeichert, sodass die CPU sie schnell lesen kann. Das ist auch das was Ladezeiten bei zum Beispiel bei
Spielen führt. Die Daten, die zum Ausführen des Spiels, sowie die Spielprogrammdateien werden im RAM zwischengespeichert
um das Spiel bei gewünschter Geschwindigkeit laufen zu lassen. VRAM übernimmt eine vergleichbare Rolle für die Grafikkarte.
RAM brauch Strom um Daten zu speichern, da es Daten als Spannungsunterschiede dartellt, die mit der Zeit "erblassen" und dann
neu geschrieben werden müssen. Das kann für die CPU bedeuten, dass das RAM gerade in einem Refreshcycle ist, wenn Daten angefragt
werden. Diese Zyklen dauern nicht lange, aber länger als die CPU es verarbeiten könnte.

### Register

Noch eine Stufe darunter sind die Register. Sie spielen für den normalen Benutzer keine Rolle, denn dies sind sehr kleine
Speicher, die nur laufende Programme verwenden um mit der CPU zu reden, ihr mitzuteilen, was sie machen möchten. Sie 
existieren auch wegen der Art und Weise, auf die CPU/Computer gebaut werden (dazu werde ich hier leider nicht so viel
schreiben, vielleicht ein andern mal).

Ein Register ist meist eine wordsize groß. Also die Größe, die die CPU Architektur vorgibt. Bei den meisten moderenen
Systemen ist das 64bit (oder 8 byte).

### Cache

Der CPU-Cache (auch als SRAM -> "static RAM" bezeichnet) ist langsamer als die Register, aber schneller als das RAM. 
Es dient nicht nur für die minimalen Befehle der
Programme an die CPU, sondern um die aktuell benötigten Daten aus dem RAM anzufragen. Es ist also eine Form des noch 
schnelleren RAMs. Allerdings ist es nicht groß genug um alle Daten, die ein Programm braucht zu speichern, wie es das RAM
macht, sondern nur die aktuell betrachteten. Welche Daten im Cache liegen, versucht der Prozessor hervorzusagen. Wenn er es
richtig errät, hat das zur Folge, dass die CPU schneller die Daten bekommt und schneller rechnen kann (ein sogenannter
"cache hit"). Wenn er es falsch vorhersagt, dann spricht man von einem "cache miss". Er ist nicht fatal, allerdings muss
die CPU nun das RAM anfragen, was länger dauert, als wenn es schon im cache läge.

## der Kernel

### Kontrolle

An dieser Stelle werde ich etwas ausschweifen und die Grundlagen des Kernels betrachten. Alles unterliegt dem Kernel und
es verwaltet, wer wie viel CPU Zeit bekommt. Zuerst werden alle Resourcen vom Kernel in anspruch genommen und dann wird
alles weitere asynchron verwaltet. Sogenannte "interrupts" sind hier das Mittel der Wahl. Das bedeutet, dass ein Programm
unterbrochen wird und der Kernel Befehle ausführt, unter umständen den laufenden Prozess pausiert und einen anderen laufen
lässt. Das ermöglicht es Prozesse scheinbar gleichzeitig[^1] laufen zu lassen.

### Sicherheit

Ein weiterer Grund, den Kernel einzufühen, neben der Verwaltung der Prozesse, denn es "tötet" auch Prozesse, die unnötig
Threads occupieren, ist Sicherheit. Dafür unterteilt man das System in zwei Modi, den "user mode" und den "kernel mode".
Der Kernel hat die Hoheit nicht nur über die Resourcen, sondern auch die IO Geräte. Potentiell unsichere Operationen sind
so vom user mode aus unmöglich. Um also solche Operationen auszuführen ruft man den Kernel auf. Diesen Aufruf um zum Beispiel
mit Geräten/Hardware zu reden, nennt man `syscall` oder auch `system call`. Hier kommen auch wieder die Register ins Spiel,
den einige von ihnen haben spezielle Bedeutungen im Kontext der syscalls. Sie geben beispielsweise die Aktion, die man den
Kernel ausführen lassen möchte an und auch weitere Daten, die dafür norwendig sind. Hier ein Beispiel um etwas in der Konsole
ausgeben zu lassen und dann mit exit code `0`[^2] das Programm zu beenden[^3].

```asm
.global _start
.intel_syntax noprefix

_start:
   // printing out
   // setting the mode (for the syscall) to out
   mov rax, 1
   mov rdi, 1
   // getting the string (ascii)
   lea rsi, [hello_world]
   // length of the string to print out
   mov rdx, 9
   // calling the kernel to perform the set up actions
   syscall

   // exit call
   // set the instruction register to exit
   mov rax, 60
   // set the exit code
   mov rdi, 0
   // exit
   syscall

hello_world:
   // define the string
   .asciz "Heya <3\n"q
```

### Arbeitsspeicherabstraktionen

#### der Stack

Der Stack ist eine Addressspanne, auf die das Programm Daten mit bekannter Größe legen kann (in Rust ist das
der `Sized` Trait). Manche Sprachen zeigen die Stacknähe stärker als andere. Mann nennt diese Stack 
orientierte Sprachen (zum Beispiel [uiua](https://doc.lovirent.eu/p/uiua/)). Aber alle Sprachen haben den 
Stack als grundlegendes Datensystem. Auf dem Stack kann immer der oberste Wert genutzt werden.

Auch diese Strukturen kann man in ASM wieder finden. Es gibt zum Beispiel den `push` Befehl.

Was das mit dem Kernel zu tun hat? Diese Arbeitsspeicheraddressen sind Kernel Abstraktionen über die Hardware.
Der Kernel gaukelt dem Programm vor, es habe so und so viel Speicherplatz schon zugewiesen. Das ist aber nicht
der Fall. Der tatsächliche Arbeitsspeicher wird erst freigegeben ("allocated"), wenn das Programm in den, aus
seiner Sicht schon verfügbaren Speicher, Daten schreibt. So kann Speicherplatz effizienter verwaltet werden.

#### Der Heap

Der Heap ist eine mehr oder weniger lose Ansammlung an Daten. Dieses Datensystem ist gedacht um Daten von Typen
zu speichern, dessen Größe beim Bauen des Programms noch nicht bekannt ist (zum Beispiel ein `String`).

Das Problem mit dem Heap ist, dass hier die meisten Probleme bei der Verwaltung von Arbeitsspeicher entstehen.
Hier ist also auch die Mehrheit der "memory-leaks" zu verorten.

## Datenstrukturen

### padding und alignment

Häufig braucht ein Typ mehr Speicherplatz, als man vermuten würde. Das liegt am Padding, welches eingebaut wird
um es der Systemarchitektur (und damit der "wordsize") anzupassen. Das mag ineffizient erscheinen, aber tatsächlich
ermöglicht es dieser Trick der CPU die Daten schneller einzulesen und zu verarbeiten, da sie eben immer in den 
gleichzeitig betrachteten Datensatz passen.

### Beispieltypen

#### Zahlen

Die Größe von Zahlen ist beim Bau bekannt, also liegen die Werte dieses Typs auf dem Stack.

#### Buchstaben

Ein `char` ist ein (spezielles) `u8`, also auch auf dem Stack.

#### pointer / reference

Pointer sind immer eine wordsize groß. Sie liegen also auf dem Stack.

#### Listen und Tuples

Diese Größen sind abhängig vom Typ, den sie enthalten. Aber die Werte liegen einfach nebeneinander
in memory, was den lookup Prozess sehr schnell und einfach macht.

#### Vektor

Die Größe eines Vektors ist nicht nur abhänig vom enthaltenen Typ, sondern auch per Definition beim Bau nicht bekannt.
Also liegen die Werte im heap und können so beliebig gesetzt und entfernt werden. Der Vektor Struct enhält aber noch
weitere "Metadaten", wie zum Beispiel die Länge des Vektors und die Kapazität. Außederdem ein Pointer, der angibt wo
auf dem Stack die Werte (die Liste) des Vektors zu finden sind. All diese Werte liegen auf dem Stack. Der Teil der auf
dem Stack liegt kann zustätzliche "Kosten" verursachen, denn es kann sein, dass durch ein Syscall neuer Speicher
"beantragt" werden muss (und das dauert immer länger als direkte RAM Interaktionen), oder dass die Daten kopiert werden
müssen um neue Elemente hinzuzufügen.

#### String

Strings verhalten sich im Grunde genau wie Vektoren. Wenn aber ein String im Quellcode gegeben wird, so liegen die Buchstaben
einfach in der gebauten Datei und verursachen daher keine zustäzlichen Kosten (sie haben die `'static` lifetime und ist für die
gesamte Dauer des Programms lesbar).

#### Struct

Die Felder eines Structs verhalten sich wie die eines Tuples.

#### Enum

Die Felder eines Enums sind im Arbeitsspeicher Zahlen (unsigened int). Dabei wird immer der kleinste mögliche Typ verwendet.
Da die Felder eines Enums Structs sind, hat das gesamte Enum die Größe des größten Feldes und der Zahl um die Felder zu benennen.
Dabei wird durch den Kompiler aber noch einiges weg optimiert. Zum Beispiel ist ein `Option<T>` immer *nur* so groß wie `T`, denn
die einzige andere Option, und das weiß der Kompiler, ist kein Wert. Also wird die Zahl weg gelassen und etwas Speicher wird
gespart. Das ist sicher, denn der Kompiler prüft vorher auf `deref` und unterbindet sie.

#### Box

Box ist ein Pointer zu einem Element, welches auf dem heap liegt.
```rust
std::mem::size_of::<i128>()      // 16
std::mem::size_of::<Box<i128>>() // 8
```
Hier kann man sehen, dass eine Zahl des Typs `i128` 16 Bytes groß ist, der Box typ nimmt aber auf dem Stack nur 8 Bytes ein.
Die 8 Bytes kommen von meiner Systemarchitektur. Ich habe ein 64 Bit System, also ist ein Wort (im Sinne der Speichereinheiten) 
immer 8 Bytes groß.

### fat pointer

Ein "fat pointer" ist ein pointer, der aus zwei pointern besteht. Diese kommen zum Einsatz, wenn nur nur angegeben muss, wo
die Daten liegen, sondern auch was sie sind (also welcher Typ).

Zum Beispiel bei pointern mit dem `dyn` Operator, also bei Traitobjekten. Sie haben erst in der "runtime" einen zugewiesenen
Typ, der angegeben werden muss, wenn mit den Daten interagiert werden soll. Ein anderes Beispiel ist ein pointer zu einer 
slice eines Vekors. Hier muss der Datentyp und der Ausschnitt aus dem Vektor angegeben werden. Durch fat pointer ist
**polymorphism** in rust möglich, auch in runtime.

## Quellen

Bei Interesse, empfehle ich sehr, da mal rein zu schauen:

- [cs.yale.edu, memory design](https://www.cs.yale.edu/flint/cs422/lectureNotes/Fall19/L02.pdf), [cs.cornell.edu, kernel abstractions](https://www.cs.cornell.edu/courses/cs4410/2017sp/schedule/slides/02.kernel.pdf) (fast das gleiche)
- [Rust Atomics and RWLocks](https://marabos.nl/atomics/)
- [Type layout - Rust Lang Reference](https://doc.rust-lang.org/reference/type-layout.html)
- [Visualizing memory layout](https://yewtu.be/watch?v=7_o-YRxf_cc)


[^1]: Sie laufen asynchron, nicht parallel. Prozesse können nur auf verschiedenen Kernen/threads wirklich gleichzeitig
ablaufen.
[^2]: Bedeutet, dass es keinen Fehler gab. Also ein planmäßiges ende des Programms
[^3]: ich habe `as` verwendet um diesen ASM code zu "bauen"
