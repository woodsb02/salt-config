sudo:
  pkg:
    - installed

/usr/local/etc/sudoers:
  file.uncomment:
    - regex: '\%wheel\ ALL\=\(ALL\)\ ALL$'
    - char: '# '
    - backup: False
