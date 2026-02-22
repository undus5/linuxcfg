# linuxcfg

Usage:

```
(user)$ git clone https://github.com/undus5/linuxcfg.git ~/a

(user)$ cd
(user)$ ln -s ~/a/icons

(user)$ cd ~/.config
(user)$ ln -s ~/a/config/*

(user)$ cd ~/.local/share
(user)$ ln -s ~/a/local.share/fonts
(user)$ cp -r ~/a/local.share/applications.e applications/e

(user)$ echo 'source ~/a/sbin/bashrc.sh' >> ~/.bashrc
```

Custom apps: `~/a/local.share/apps/`\
Custom fonts: `~/a/local.share/fonts/`\
Custom icons: `~/a/local.share/icons/hicolor/128x128/apps/`

