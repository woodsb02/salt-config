{% set ssh_global_files = ['ssh_config.jinja','sshd_config.jinja'] -%}
{% set ssh_user_files = ['config.jinja'] -%}
{% set ssh_key_files = ['freebsd-id_ed25519','github-id_ed25519','womlins-id_ed25519'] -%}

sshd:
  service.running:
    - enable: True
    - watch:
      - file: /etc/ssh/sshd_config

{% for file in ssh_global_files %}
/etc/ssh/{{ file|replace('.jinja', '') }}:
  file.managed:
    - source: salt://ssh/{{ file }}
  {% if file.endswith('.jinja') %}
    - template: jinja
  {% endif %}
    - user: root
    - group: wheel
    - mode: 644
{% endfor %}

/home/woodsb02/.ssh:
  file.directory:
    - user: woodsb02
    - group: woodsb02
    - dir_mode: 700
    - file_mode: 600
    - recurse:
      - user
      - group
      - mode

{% for file in ssh_user_files %}
/home/woodsb02/.ssh/{{ file|replace('.jinja', '') }}:
  file.managed:
    - source: salt://ssh/config
  {% if file.endswith('.jinja') %}
    - template: jinja
  {% endif %}
    - user: woodsb02
    - group: woodsb02
    - mode: 600
{% endfor %}

{#
{% if 'developer' in grains['roles'] %}
{% for file in ssh_key_files %}
/home/woodsb02/.ssh/{{ file }}:
  file.managed:
    - source: salt://ssh/freebsd-id_ed25519
    - user: woodsb02
    - group: woodsb02
    - mode: 600

/home/woodsb02/.ssh/{{ file }}.pub:
  file.managed:
    - source: salt://ssh/freebsd-id_ed25519.pub
    - user: woodsb02
    - group: woodsb02
    - mode: 600
{% endfor %}
{% endif  %}

{% if 'interactive' in grains['roles'] %}
/home/woodsb02/.ssh/woodsb02-id_ed25519:
  file.managed:
    - source: salt://ssh/woodsb02-id_ed25519
    - user: woodsb02
    - group: woodsb02
    - mode: 600

/home/woodsb02/.ssh/woodsb02-id_ed25519.pub:
  file.managed:
    - source: salt://ssh/woodsb02-id_ed25519.pub
    - user: woodsb02
    - group: woodsb02
    - mode: 600

/home/woodsb02/.ssh/woodsb02-id_ed25519.ppk:
  file.managed:
    - source: salt://ssh/woodsb02-id_ed25519.ppk
    - user: woodsb02
    - group: woodsb02
    - mode: 600
{% endif  %}
#}
