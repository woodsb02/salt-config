zsh:
  pkg:
    - installed

zsh-navigation-tools:
  pkg:
    - installed

zsh-syntax-highlighting:
  pkg:
    - installed

/usr/local/etc/zshrc:
  file.managed:
    - source: salt://zsh/zshrc.jinja
    - template: jinja
    - user: root
    - group: wheel
    - mode: 644
