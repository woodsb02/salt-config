install xfce packages:
  pkg.installed:
    - pkgs:
      - xfce
      - xfce4-goodies
      - xscreensaver
      - numix-theme
      - xfce-icons-elementary
      - icons-tango-extras
      - lightdm
      - lightdm-gtk-greeter
      - slim
      - slim-themes
      - remmina
      - remmina-plugins
      - evince-lite

/home/woodsb02/.config:
  file.directory:
    - user: woodsb02
    - group: woodsb02
    - dir_mode: 755

dbus:
  service.running:
    - enable: True

hald:
  service.running:
    - enable: True

lightdm:
  service.running:
    - enable: True

/usr/local/etc/slim.conf:
  file.managed:
    - source: salt://xfce/slim.conf.jinja
    - template: jinja
    - user: root
    - group: wheel
    - mode: 644
