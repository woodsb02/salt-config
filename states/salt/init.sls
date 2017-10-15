salt_minion:
  service.running:
    - enable: True
    - watch:
      - file: /usr/local/etc/salt/minion

/usr/local/etc/salt/minion:
  file.managed:
    - source: salt://salt/minion.jinja
    - template: jinja
    - user: root
    - group: wheel
    - mode: 644

cron shell:
  cron.env_present:
    - user: root
    - name: SHELL
    - value: '/bin/sh'

cron path:
  cron.env_present:
    - user: root
    - name: PATH
    - value: '/etc:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin'

cron highstate:
  cron.present:
    - user: root
    - minute: random
    - hour: 4
    - name: 'salt-call state.apply'
    - identifier: HIGHSTATE
