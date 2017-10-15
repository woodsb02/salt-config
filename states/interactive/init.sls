install sysadmin console packages:
  pkg.installed:
    - pkgs:
      - htop
      - beadm

/etc/login.conf:
  file.managed:
    - source: salt://interactive/login.conf.jinja
    - template: jinja
    - user: root
    - group: wheel
    - mode: 644

Rebuild login class capabilities database:
  cmd.run:
    - name: cap_mkdb /etc/login.conf
    - onchanges:
      - file: /etc/login.conf
