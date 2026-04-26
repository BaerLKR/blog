---
title: I liked GPG
date: 2026-04-26 20:40:00
description: GPG is not good, and that makes me sad
slug: i-liked-gpg
title-image: /blog/i-liked-gpg/title.svg
tags: gpg
---

*This is more of an opinion and experience blog entry than it is one that tries to explain the topic. Though I try to link to relevant sites 
wherever I can.*

In the last few days I once again sat down to look at [GPG](https://gnupg.org/). Mainly because I once again read that I should not use GPG anymore, 
as it supposedly is bad in all sorts of ways. Since I was aware of 
many issues in the implementation of GPG I switched to [sequoia](https://sequoia-pgp.org/) a while ago. I thought that pretty much resolved 
the issues, but sadly not. I say sadly because I like using it; don't get me wrong, it is still very complicated but it felt like a well thought out
tool that did many things correct. 

GPG is not good software, I think we can all agree on that. It has a habit of lagging behind on encryption standards,
which is not a smart thing to do; the user interface is terrible and the words used to describe operations within GPG are poorly chosen. I've also
noticed people complaining about GPG being a "swiss army knive" and that it does too many things, but I actually liked that, though from a security
standpoint I understand the criticism. Sequoia improves on that. The documentation is good and they thought a lot about how they word it. On a small
side note: it is underrated how important wording in documentation is. Not only for security relevant tooling like encryption tools but in general.
Without carefully naming user facing options and outputs it becomes very hard to talk/reason about programs or teach new people how to use them. I
jokingly say that one needs a "PhD in GPG" to use it and I think a big part of that is how many things are named very similar (for example 
[things named "key *"](https://media.ccc.de/v/fsck-2025-108-hrt-auf-openpgp-zu-benutzen-#t=390)).

Using sequoia ironically gave me a better understanding of GPG. Because it is written in rust it doesn't have the 
[many string handling errors](https://gpg.fail/) GPG has. Also I feel like it put more emphasis on a "local first" 
[web of trust](https://book.sequoia-pgp.org/bckgrnd_wot.html). Rather than 
relying on the keyservers as much as GPG does, sequoia gives you "your view" of the keys that are known to you. Fundamentally GPG does the same, 
but again, it doesn't properly explain it that way.

## OpenPGP

Many of the issues that I found this time while doing research on the topic were not really related to the implementation (GPG) but rather to the 
underlying specifications (OpenPGP). It aims to provide a platform that can be overlaid on any insecure channel to make it secure. In the real world
however it is not that simple ([relevant blog artilce](https://words.filippo.io/giving-up-on-long-term-pgp/)).

A system like OpenPGP has one weak link, and that is time. Because to prove your identity using PGP you have a long lived identity key, which
[you probably don't want](https://argemma.com/blog/long-lived-keys/) because in theory you have to keep it safe forever (a long time). Some 
practices are more promising than others (hardware tokens, printing them out, ...) but the key issue remains. Even beyond that, by design PGP 
sources everything from that key, so once it (or that of your communication partner) is compromised, all authentication and, even worse, all 
secrecy through encryption goes out the window. For me that is the main reason away form the one system that verifies your identity and towards
more specialised applications that provide what they need do so with a solution that exactly fits their needs (and also links back to the 
criticism of GPG trying to do everything at once). One example of this is Signal and Matrix having 
[forward secrecy](https://signal.org/docs/specifications/doubleratchet/) which is not possible with PGP. And the tools that are covering
similar use cases ([minisign](https://jedisct1.github.io/minisign/), [age](https://age-encryption.org/),
[ssh-keygen](https://man.openbsd.org/ssh-keygen.1)) move away from long lived keys wherever possible or at least try to not bind them to a fixed
identity. Which neatly brings us to my next realization (probably the most obvious and relevant in here), all those aren't (entirely) technical
issues.

## It's not a technical issue

What I realised is that the web of trust is not a technical issue, it is a social one. As the name suggests it is all about trust. What the PGP web
of trust does (and what I really like about it) is, that it formalizes "trust". It provides a standardized way to express/announce trust and verify
it. But the matter of the fact is that you already have a web of trust. 

Some people you trust and some you don't. This is also applies onto the online world with the added step of "linking" an account to a person with 
enough certainty (for your needs). But it
isn't so strictly defined, it almost exclusively relies on you and your human-to-human communication. This is always true, but I would really like
a tool to give a standardized interface to this web of trust that exists either way.

I think that matrix for example would greatly
benefit from a web of trust system. It already has a long lived identity key that is used to prove the users identity. My idea would be that upon
verifying a user you could "share" that verification with all other users that went through this process with you. Then, when I get a message from
an account I don't know and they tell me who they are, I can see that a person 
[I verified approved of this users identity](https://media.ccc.de/v/matrix-conf-2025-72671-why-do-i-have-2-passwords-how-to-talk-about-encryption-in-matrix#t=631). 
I would really like this because it not only makes the WoT more accessible but also integrates it into an overall better cryptographic system. On 
the other hand this would be platform specific. That is again where the "overlay GPG over everything" idea shines; then again, maybe it's just me
being very fond of the web of trust.

### In an ideal world

I admit that using it is very rare but there are some specific use cases where it fits. I want some notion of "verifying it's me" with a key
that I tie to my identity and that I distribute as such. Within that constraint I would argue that OpenPGP does a decent job. For what I want the 
web is such a platform. Today we're all in on the idea of roots of trust that are universally accepted. Maybe one could draw some inspiration
on how [the dark web](https://boehs.org/node/dark-web-security) approaches this matter. On there there is no such authority that does the work 
of verifying authenticity and ownership.

Maybe a PGP-like system could work for the web. It provides subkeys that can be rotated to reduce the lifespan of a certificate that is actually
in use and keys can act as a local [certificate authority](https://book.sequoia-pgp.org/bckgrnd_shadow_cas.html). With a system that is interconnected
enough it would be possible to track sources of truth when looking up critical information. Like [human.json](https://codeberg.org/robida/human.json)
but cryptographically signed and built into web technologies (and not specific to AI).

---

```gpg
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

PGP is cool, don't use PGP
-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSEz7iSbAlmndtBLDuzIcWhv/ZTpgUCaevrKAAKCRCzIcWhv/ZT
pr5xAP9x5CJlw4Z46iac6JEL8Y7pzRQeHC+TL9GsunRWVMnw3wD7BSHQdoCawgQ0
n6JlBzalmNS2RLnxaJ0XrweM1/2/3A4=
=+6uJ
-----END PGP SIGNATURE-----
```
