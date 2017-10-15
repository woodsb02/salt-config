install nvidia graphics driver packages:
  pkg.installed:
    - pkgs:
      - nvidia-driver
      - nvidia-settings
      - nvidia-xconfig

/usr/local/etc/X11/xorg.conf.d/driver-nvidia.conf:
  file.managed:
    - source: salt://nvidia/driver-nvidia.conf
    - user: root
    - group: wheel
    - mode: 644
