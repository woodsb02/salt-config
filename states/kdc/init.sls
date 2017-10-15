krb5:
  pkg:
    - installed

/root/.cshrc:
  file.line:
    - match: 'set path = (/sbin /bin /usr/sbin /usr/bin /usr/local/sbin /usr/local/bin $HOME/bin)'
    - content: 'set path = (/usr/local/sbin /usr/local/bin $HOME/bin /sbin /bin /usr/sbin /usr/bin)'
    - mode: replace

/etc/rc.conf:
  file.append:
    - source: salt://kdc/rc.conf
    - source_hash: sha256:8855d004b5182a9a9748cd6f40762b96b539a11d2ee8fdaba4f37e1761153975

kdc:
  service.running:
    - watch:
      - pkg: krb5
      - file: /etc/krb5.conf
      - file: /usr/local/var/krb5kdc/kdc.conf

kadmind:
  service.running:
    - watch:
      - pkg: krb5
      - file: /etc/krb5.conf
      - file: /usr/local/var/krb5kdc/kdc.conf

/etc/krb5.conf:
  file.managed:
    - source: salt://kdc/krb5.conf
    - user: root
    - group: wheel
    - mode: 0644

/usr/local/var/krb5kdc/kdc.conf:
  file.managed:
    - source: salt://kdc/kdc.conf
    - user: root
    - group: wheel
    - mode: 0640
