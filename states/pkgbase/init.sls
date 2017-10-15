/home/woodsb02/bin:
  file.directory:
    - user: woodsb02
    - group: woodsb02
    - dir_mode: 750
    - file_mode: 750
    - recurse:
      - user
      - group
      - mode

/home/woodsb02/bin/beadm-upgrade-master.sh:
  file.managed:
    - source: salt://pkgbase/beadm-upgrade-master.sh
    - user: woodsb02
    - group: woodsb02
    - mode: 750

/home/woodsb02/bin/beadm-upgrade-slave.sh:
  file.managed:
    - source: salt://pkgbase/beadm-upgrade-slave.sh
    - user: woodsb02
    - group: woodsb02
    - mode: 750
