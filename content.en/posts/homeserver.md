+++
title = 'Homeserver'
date = 2025-02-04T18:56:33+01:00
+++

Since a few weeks I have a running homeserver in my room. Here I want to give a rough overview over how I set thing up. Especially because it is a somewhat complicated since in the student
dorm that I live in makes everything a bit harder for me.

## Why

This is probably a good place to start; why do I want a homeserver? I just think it is cool to selfhost stuff. Also this allows me to deploy stuff I write myself without much trouble.
Besides that there are many good reasons to selfhost serveces you use. Just to name a few it allows you to actually control your own data and decentralize the internet and thus working
towards destroying the power that the wealthy few (that are now also are the US oligarchs) have over the internet.

## Hardware

With the hardware I was really lucky. Nothing crazy but by knowing some people that knew some people I got it for quite cheap (thanks Caspar, if you are reading this). The CPU is an `Intel(R) Core(TM) i5-4570 (4) @ 3.60 GHz`
and I upgraded it to 8GiB of RAM. Currently I have 500GB disk storage but I plan on upgrading when needed and to have redundancy.

And for the networking gear I have a FritzBox that does the routing for me (I will write more about networking later on because there is a bit more to talk about as I mentioned above) and attached to that
is an unmanaged switch to which the server is attached. I used a monitor for installing and setting everything up but now the server is running completly headless.

## Software

I use NixOS (btw!) to deploy and configure the server ([config repo](https://git.lovirent.eu/pacman/nixos)).
But I guess I should now talk about the thing I've been teasing you about so far. I is less a cool feature and more a workaround because of annoying circumstances. Since I am behind
a CG-NAT and as a concequence cannot open a port or use DDNS to serve content to the internet. So what I did is got a VPS (from ionos but I am sure most providers would work the same) for 1€ a month. Then (after installing nixos with
[nixos-infect](https://github.com/elitak/nixos-infect)) I connected my server and my VPS via a wireguard tunnel that I wanted to route the traffic through. The tunnel had to be initialized from the server (that is in this relationship the "client") because
only the VPS is reachable from the general internet. But once the connection is established it does not matter because wireguard creates a virtual network (who would have guessed that a VPN does that) where you can send data in both directions.
I'd like to share my config here because I think it could be helpful as a reference material even if you want to do something else.

This is the config for the VPS, I did some unusual stuff but that is probably only because I don't know what I am doing.

```nix
let
    externalInterface = "enp6";
    internalInterface = "wg-tunnel";
    internalIp = "10.10.10.1/24";
    port = 11111;
    peers = [
        {
            name = "server";
            publicKey = "xxxx";
            allowedIPs = [ "10.10.10.10/32" ];
        }
    ];
in {
    boot.kernel.sysctl = {
      "net.ipv4.ip_forward" = true;
      "net.ipv4.conf.all.forwarding" = true;
      "net.ipv4.conf.default.forwarding" = true;
    };
    networking = {
      nat = {
        enable = true;
        externalInterface = externalInterface;
        internalInterfaces = [ internalInterface ];
      };
      firewall = {
        allowedUDPPorts = [
          port
          53
        ];
        allowedTCPPorts = [
          port
          53
        ];
      };
    };
    networking.wg-quick.interfaces."${internalInterface}" = {
      autostart = true;
      mtu = 1380;
      address = [ internalIP ];
      listenPort = port;
      privateKeyFile = privateKeyFile;
      # I just found this on the internet somewhere and it works so I guess I will use it
      postUp = ''
        ${pkgs.iptables}/bin/iptables -A FORWARD -i ${internalInterface} -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -o ${internalInterface} -j MASQUERADE
      '';
      # Undo the above (maybe?)
      preDown = ''
        ${pkgs.iptables}/bin/iptables -D FORWARD -i ${internalInterface} -j ACCEPT
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s ${internalIP} -o ${externalInterface} -j MASQUERADE
      '';
      # here I am removing the name field from the attrset I defined above
      # this is only because I thought it would be nice to have a name associated with the public key
      peers = map (set: filterAttrs (n: v: n != "name") set) (
        map (set: set // { persistentKeepalive = 25; }) peers
      );
    };
  };
```

The client config is a bit simpler:

```nix
  networking.wg-quick.interfaces.tunnel-vpn = {
    autostart = true;
    privateKeyFile = "/path/to/privateKeyFile"
    address = [ "10.10.10.10/32" ];
    listenPort = 51820;
    peers = [
      {
        publicKey = "xxx";
        endpoint = "ip of the remote vps";
        allowedIPs = [
          "10.10.10.1/32"
        ];
        persistentKeepalive = 25;
      }
    ];
  };
```

In this configuration the server in my room has the ip `10.10.10.1` and the VPS `10.10.10.10`.

```text
3: tunnel-vpn: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1420 qdisc noqueue state UNKNOWN group default qlen 1000
    link/none
    inet 10.10.10.10/32 scope global tunnel-vpn
       valid_lft forever preferred_lft forever
```

And this is the relevant field in the output of `ip a` on the server.
But this is not only a workaround to make my server reachable from the outside internet but also a strategy to hide my IP. Also (I think and hope) this gives me another layer of security because I am not directly
routing stuff into my home network but rather have them flow into a external compnent (the VPS) and then come into my network in a controlled and resticted manner.

The final missing component is actually routing the incomming requests through the VPN to my server. For that I am using SSH tunneling. Surely there is a better and more efficient way to do that with ip tables or whatever
but I just went for this because I kinda knew what I had to do.

```nix
  systemd.services =
    let
      mkTnl =
        {
          port,
          targetPort ? port,
        }:
        {
          enable = true;
          script = ''
            ${lib.getExe pkgs.openssh} -NL 0.0.0.0:${builtins.toString port}:10.10.10.10:${builtins.toString targetPort} root@10.10.10.10 -i /root/vps-tunnel-ssh
          '';
        };
    in
    {
      "ssh-routing-tunnel-443" = mkTnl { port = 443; };
      "ssh-routing-tunnel-2222" = mkTnl {
        port = 2222;
        targetPort = 22;
      };
      "ssh-routing-tunnel-80" = mkTnl { port = 80; };
    };

```

This starts 3 systemd services that each starts a ssh session that maps a port from the remote host to the local host. In this case `80` (http), `443` (https), `2222` to `22` what I choose for ssh.
I had to choose a different port that I want to ssh to when I want to connect to my server, even tho the sshd on the server is listening on the defualt port (`22`) because on the VPS that port is
used by the respective sshd service of the VPS. So here I am, like I said, mapping the `2222` port to the `22` port on my server so I can connect to it from the outside via ssh. Notice that in this config
I am using the IPs assigned to the devices in the wireguard network.

This setup makes some tasks harder but I will stick with it for now. For example federation is something I haven't figured out yet (to be fair I also currently have exams so not thaaat much time to tinker around with this). I would need to route everything
through the tunnel (also the outbound traffic) I assume but to be honest I didn't really try so far (I also kinda need to fix the currently deployed services). And it is not cloudflare which is relevant because in my opinion cloudflare is one of the
most evil and or dangerous companies that control the internet.

In addition to that I had to fight with the infrastructure the dorm provides. I won't go into too much detail because it may be sensitive information and also it is too specific to be useful to anyone (if you are in a dorm in Leipzig and have issues feel free tomessage me but I can't promise anything). But that includes odd network settings on top of DNS and IP address masks. Also I wrote this systemd service that starts (another) ssh session

```nix
systemd.services = {
    ssh-studiwohnheim = {
      enable = true;
      wantedBy = [ "default.target" ];
      script =
        let
          ssh-script = pkgs.writeShellScript "ssh" ''
            ${lib.getExe pkgs.nushell} -c "${pkgs.openssh}/bin/ssh -v -o PubkeyAuthentication=no -o PreferredAuthentications=password $\"(${pkgs.uutils-coreutils-noprefix}/bin/cat ${
              config.sops.secrets."wohnheim/mieternummer".path
            })@139.18.143.253\""
          '';
        in
        ''
          ${lib.getExe pkgs.passh} -p file:${config.sops.secrets."wohnheim/ssh".path} ${ssh-script}
        '';
    };
};
```

That reads my tenant number from my secrets management system ([sops-nix](https://github.com/Mic92/sops-nix)) and then adds the IP they gave me that I should connect to and authenicate with a password (.\_.) that I am also reading from my secrets management.
I really don't understand what purpose the ssh session serves because my ethernet port isn't publically accessable so why should I authenicate? And why a ssh session that is just always running in the backround (and why no ssh key‽).

If you have any questions just it me up via [mail](mailto:mail@lovisrentsch.de) or [matrix](https://matrix.to/#/@pacman:olaf.one) and I will be happy to elaborate.
