---
title: barless
date: 2025-01-29 08:45:47
description: I don't have a bar on my linux machine; here is why
slug: barless
title-image: /blog/barless/title.svg
archive: true
---

After recently switching window manager from [sway](https://swaywm.org/) to [niri](https://github.com/YaLTeR/niri) I
decided to try out not having a bar. That is because my bar is kind of useless. It only has two useful bits of information:
the clock and the battery level. Sure I can see my cpu and memory usage which is nice but not that relevant to have
displayed all the time, if I want to know it I can just open my system monitor. The worspace display also isn't that
relevant for my workflow because I assigned a task to each workspace, so I always know on what workspace I am. Fist of all
I just pressed the keybind to get there and also if there is uni work open for example I know I am on workspace 2 and when it
is programming it is on workspace 4. So I don't need a display to also tell me the same thing again, since I went to that
specific workspace to do something where I know it has to be on said workspace. Another element I had on my bar is a display
and selector for brightness and volume. I basically never used them because for both I also have keybinds and it kind of
irrelevant how high the volume is because when I want to change it that is because it is either too loud or not loud enough
and in those cases I don't care what the current volume is. I only want to change the state, I don't need to know it.
Also I am getting the feedback (the sound gets louder or the display brighter) so the bar is also redundant as a feedback
service.
Now let's get back to those information I actually want to be able to see. The simple solution I tought up is having a keybind
that triggers a notification that displays the date-time and battery level.

![a notification displaying on 2 lines: the day of the week,
the date (day, month, yeaar) and the time (hour:minute:second); charging status and battery level (in %)](./notif.png)

That way when I get the impulse to look at the clock or check the battery level i press the keybind and look at the
notification. That way there is no delay in my actions but at the same time it does not occupy a section of the secreen
at all times (I am using a tiling window manager to maximise screen space usage after all).

With this small entry I just wanted to get you to think about what you actually need in your setup. Of course you can,
if you choose to also try not having a bar, have more information in the notification, or another notification keybind
that shows you the cpu usage or current brightness. That is the beauty after all, it is easy to modify and you can do
whatever you want (as in freedom lol). To wrap it up I just want to say that I have been daily driving my setup without
a bar for 2 weeks now and I think it will stay (at least for a while).
