krb5:
  pkg:
    - installed

/etc/krb5.conf:
  file.managed:
    - source: salt://krb5/krb5.conf.jinja
    - template: jinja
    - user: root
    - group: wheel
    - mode: 0644

/etc/pam.d/system:
  file.managed:
    - source: salt://krb5/system.jinja
    - template: jinja
    - user: root
    - group: wheel
    - mode: 0644
