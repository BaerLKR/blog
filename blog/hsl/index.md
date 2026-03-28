---
title: hsl
date: 2023-02-16 16:29:01
description: Farbe ist nicht gleich Farbe
slug: hsl-colorspace
title-image: /blog/hsl-colorspace/title.svg
tags: 52posts
archive: true
---

``hsl`` ist ein Format der Farbdarstellung. In diesem Fall werde ich vor allem von hsl im Zusammenhang mit CSS sprechen. CSS hat viele verschiedene Art und Weisen Farben auszudrücken (zum Beispiel hex).

## Lesbarkeit

``hsl`` ist viel lesbarer als hex.

Die Farbe besteht aus drei Werten.

1. Farbton (hue)
2. Sättigung (saturation)
3. Helligkeit (lightness)

### Farbton

Der Farbton wird in Grad angegeben. Das bedeutet, dass man sich leicht vorstellen kann, welche Zahl welche Farbe ist, denn sie folgen einfach dem normalen Farbrad, das man auch aus dem Kunstunterricht kennt. 

![](https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.LdSQjM5BRDGJWcmpIOuMLwHaHa%26pid%3DApi&f=1&ipt=045b306b3cfe59dbfe1ccfd3ddcfe22266802651bbdbca60e1a0249e4c7f7443&ipo=images)
Wobei oben 0° ist. Das hat zur Folge, dass sowohl 0° als auch 360° der gleiche Rot-Ton ist. 

### Sättigung

Die Sättigung ist eine Prozentzahl. Wenn der Wert 0 ist, ist die Farbe irrelevant und nur die Helligkeit spielt eine Rolle. 

### Helligkeit

Die Helligkeit ist auch ein Prozentwert. Hier ist es einfach die Helligkeit der Farbe. Daher ist 0% immer schwarz und 100% immer weiß.

### Alpha

Zusätzlich gibt es noch den Alpha-Wert. Er gibt die Transparenz des Farbe an. In CSS variieren die Schreibweisen je nach Version, wobei ältere Schreibweisen auch in Zukunft noch unterstützt werden (sollten sie zumindest). 

``hsl(hue saturation lighness / alpha)``
Dieser Syntax ist der neuere, der die Werte nur mit Leerzeichen (nicht mit Kommata) trennt. Der optonale Alph-Wert wird mit einem ``/`` abgetrennt. 

### Test

Kannst du erkennen, welche Farbe das ist?

``hsl(250, 100%, 0%)``

oder das

``hsl(0, 50%, 49%)``
(das ist die gleiche Farbe: ``#bb3e3e``)

---

## Technische Gründe

RGB wir am besten als mehrere sich überlappende Kreise beschrieben. Hex hingegen ist eine Tabelle der Farben, die dann durch Koordinaten beschrieben wird. hsl ist hingegen als dreidimensionale Struktur zu beschreiben. Denn man hat die Drei werte, die aber nicht ineinander übergehen (so wie rgb). Daher kann man sich hsl als Zylinder vorstellen, denn die Grundfläche ist das Farbrad. Die Höhe des Zylinders ist dann die Helligkeit und je näher man dem Zentrum des Zylinders kommt, desto gesättigter sind die Farben. Die Funktion der letzten beiden Werte, ob sie also Höhe oder Nähe zur Mitte sind ist nicht relevant, denn es ist nur ein Modell zur Veranschaulichung der Vielfältigkeit. Daher hat man, wenn man hsl benutzt tatsächlich mehr Farben zur Verfügung, als wenn man andere Farbmodelle nutzt (auch wenn die Entscheidung, welches dieser Farbbeschreibungssysteme man benutzt für den Designprozess von Webseiten eher zweitrangig ist). Denn diese können die Farben in ihrem Definitionsbereich einfach nicht beschreiben. 
![](https://lea.verou.me/wp-content/uploads/2020/04/srgb-vs-p3.png)
Das hat zur Folge, dass man mehr Farbauswahl hat und die Farben unter Umständen besser passen oder leuchtender sind. 

---

## Beispiel

```CSS
:root {
        --high-1: 28;
        --high-2: 80%;
        --high-3-a: 10%;
        --high-3-b: 50%;
        --high-3-c-l: calc(var(--high-3-b) + var(--high-3-a));
        --high-3-c-d: calc(var(--high-3-b) - var(--high-3-a));
    --high: hsl(var(--high-1), var(--high-2), var(--high-3-b));
        --high-l:hsl(var(--high-1), var(--high-2), var(--high-3-c-l));
        --high-d: hsl(var(--high-1), var(--high-2), var(--high-3-c-d));
            --base-1: 209;
            --base-2: 29%;
            --base-3-a: 5%;
            --base-3-b: 17%;
            --base-3-c-l: calc(var(--base-3-b) + var(--base-3-a));
            --base-3-c-d: calc(var(--base-3-b) - var(--base-3-a));
    --base: hsl(var(--base-1), var(--base-2), var(--base-3-b));
        --base-l:hsl(var(--base-1), var(--base-2), var(--base-3-c-l));
        --base-d:hsl(var(--base-1), var(--base-2), var(--base-3-c-d));
            --cont-1: 100;
            --cont-2: 60%;
            --cont-3-a: 20%;
            --cont-3-b: 60%;
            --cont-3-c-l: calc(var(--cont-3-b) + var(--cont-3-a));
            --cont-3-c-d: calc(var(--cont-3-b) - var(--cont-3-a));
    --cont: hsl(var(--cont-1), var(--cont-2), var(--cont-3-b));
        --cont-l: hsl(var(--cont-1), var(--cont-2), var(--cont-3-c-l));
        --cont-d: hsl(var(--cont-1), var(--cont-2), var(--cont-3-c-d));
}
```

*das CSS-Variablenschema von [lovirent.eu](https://lovirent.eu) ([var.css](https://lovirent.eu/css/var.css))*

Das mag auf den ersten Blick überwältigend wirken, aber ich werde versuchen es zu erläutern.

Ich mache hierbei Gebrauch von der Möglichkeit andere CSS-Variablen in den hsl Werten meiner Variablen zu nutzen. Das geht nur, weil die Werte auch eine tatsächliche Bedeutung für das Aussehen der Seite haben. 

```CSS
:root {
      --cont-hue: 100;
      --cont-saturation: 60%;
      --cont-brightness: 20%;
  --content: hsl(var(--cont-hue), var(--cont-saturation), var(--cont-brightness));  
}
```

Hier zum Beispiel für die ``--content`` Variable. Das hat den Hintergrund, dass ich so die Farben manipulieren kann. Entweder indem ich Javascript nutze um die Variablen zu setzten, oder noch im CSS. Im CSS kann ich zum Beispiel weitere Farben in Abhängigkeit von einer Farbe erschaffen (vor allem indem ich die ``calc()`` Funktion nutze).

```js
document.documentElement.style.setProperty("--cont-hue", val)
```

*Zusammenhang besser verstehen [index.js](https://lovirent.eu/js/index.js) (ist mit Kommentaren versehen)*

Hier zum Beispiel habe ich den Wert des Farbtons auf den Wert eines Inputs (in meinem Fall den Wert eines Schiebereglers mit 360 Möglichkeiten).

```CSS
:root {

            --base-1: 209;
            --base-2: 29%;
            --base-3-a: 5%;
            --base-3-b: 17%;
            --base-3-c-l: calc(var(--base-3-b) + var(--base-3-a));
            --base-3-c-d: calc(var(--base-3-b) - var(--base-3-a));
    --base: hsl(var(--base-1), var(--base-2), var(--base-3-b));
        --base-l:hsl(var(--base-1), var(--base-2), var(--base-3-c-l));
        --base-d:hsl(var(--base-1), var(--base-2), var(--base-3-c-d));
}
```

Hier definiere ich erstmal die einzelnen Werte für die Farbe ``--base`` (hue, saturation, brightness). Dann verarbeite ich diese Werte weiter, um sie in einer von der Umgebungsfarbe abhängigen Farbe zu nutzen. Das hat den Vorteil, dass ich wenn ich die Variablen im Javascript manipuliere alle von dieser Farbe abhängigen Farben sich anpassen und im Verhältnis zur Umgebungsfarbe gleich aussehen (in meinem Fall sind es dunklere und hellere Versionen (Akzente) der Farben). 

---

## 52posts

Dieser Beitrag ist Teil meines Plans, in 2023 jede Woche einen Post zu erstellen, mit Dingen, die ich gelernt habe. (Das sind dann 52 Posts).

[#52posts](/tag/52posts)
