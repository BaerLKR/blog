+++
title = 'Monitor'
date = 2024-09-07T16:27:35+02:00
+++

Ok so hear me out, this is very scuffed but I think it is funny and also maybe sometimes somewhat useful.
I don't own a second monitor but I have an old thinkpad. So I thought it would be a good idea to try to make it my second monitor. The first thing I had to do is to get
a second output, a virtual display that gets rendered by my computer. I was not able to do that in software so I bought a HDMI dummi dongle (~7€). Then I tired to stream
that to my laptop over the network. The first option I tried was [weylus](https://github.com/H-M-H/Weylus). It worked but the display selction (choosing what HDMI) output
gets streamed to the laptop) was unreliable and the performance on the client wasn't too great either. Probably because of all the features that came with it but that I 
did not use. To be fair, this is not really it's intendet usecase. 
Then finally I used the tool, the elephant in the room, the programm literally made to do this (lol). I tried setting up VNC before in this context but it did not work
out. But it really wasn't hard.

```nix
# this is the script I use to start the service on my host machine

#! /usr/bin/env nix-shell
#! nix-shell -p wayvnc novnc -i bash
wayvnc&
novnc
```

Maybe I should just quickly go over that script (if you can even call it that). I pull the dependencies (`wayyvnc` and `novnc`) from `nixpkgs` using the 
[nix-shell shebang](https://nixos.wiki/wiki/Nix-shell_shebang). Then I start `wayvnc` (a wayland vnc server) in the background and also start `novnc`. The latter is a 
tool to simplify connecting to a VNC stream. That way I don't need any dependencies on the client side exept for a web browser.

That setup worked right out of the box, choosing the second virtual screen and streaming it with out any issues.
It has to be said though that both devices need to be in the same LAN and the server device has to disable the firewall 
(or open some ports, but I am lazy and just disable it when I want to use this cursed setup); the stream is not protected, meaning that anyone on the local netowrk
can look at the screen that is being transferred.
Also the performance isn't great. It is better than with waylus and it is totally acceptale for the usecases I have. For example opening the docs while still being able
to have the code open/ontinue programming, having reference material for what you are doing on the main monitor. Sadly it is not enought to stream video in a watchable
bitrate (but it is enougth to render nvim with a decent refresh rate so I could write this post on my "second monitor") but maybe having better connection to the router
could fix that.

To conclude this article I just want to say that I am aware how hidious this is. But sometimes it comes in handy, also I had the time and my laptop was laying around.
So this was a fun little project. Have a picture of my not-scatchy-at-all setup:

![from the front](/20240907_172419.jpg)
![from the side](/20240907_172440.jpg)

*(yes everything is held up by a surprisingly well fitting box and a formulary)*
