vim:
  pkg.installed:
    - name: {{ pillar['pkgs']['vim'] }}

/usr/local/etc/vim/vimrc:
  file.managed:
    - source: salt://vim/vimrc.jinja
    - template: jinja
    - user: root
    - group: wheel
    - mode: 644

/usr/local/etc/vimrc:
  file.absent
