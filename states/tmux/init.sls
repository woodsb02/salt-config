tmux:
  pkg:
    - installed

/usr/local/etc/tmux.conf:
  file.managed:
    - source: salt://tmux/tmux.conf
    - user: root
    - group: wheel
    - mode: 644
