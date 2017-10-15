/root/.cshrc:
  file.managed:
    - source: salt://csh/cshrc-root.jinja
    - template: jinja
    - user: root
    - group: wheel
    - mode: 644

/usr/share/skel/dot.cshrc:
  file.managed:
    - source: salt://csh/cshrc.jinja
    - template: jinja
    - user: root
    - group: wheel
    - mode: 644
