install intel graphics driver packages:
  pkg.installed:
    - pkgs:
      - xf86-video-intel

/usr/local/etc/X11/xorg.conf.d/driver-intel.conf:
  file.managed:
    - source: salt://intel/driver-intel.conf
    - user: root
    - group: wheel
    - mode: 644

i915kms:
  kmod.present:
    - persist: True
