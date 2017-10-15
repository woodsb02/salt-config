openntpd:
  pkg:
    - installed
  service.running:
    - enable: True
    - watch:
      - pkg: openntpd
      - file: /usr/local/etc/ntpd.conf

/usr/local/etc/ntpd.conf:
  file.managed:
    - source: salt://ntpd/ntpd.conf.jinja
    - template: jinja
    - user: root
    - group: wheel
    - mode: 0640

ntpd:
  service.dead:
    - enable: False

ntpdate:
  service.dead:
    - enable: False
