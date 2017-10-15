{% set xorg_confd_files = ['keyboard.conf.jinja','screen-resolution.conf.jinja'] -%}
{% if grains['id'] == 'smash.woods.am' -%}
  {% do xorg_confd_files.append('driver-nvidia.conf.jinja') -%}
{% endif -%}

install xorg packages:
  pkg.installed:
    - pkgs:
      - xorg
      - numlockx

/usr/local/etc/X11/xorg.conf.d:
  file.directory:
    - user: root
    - group: wheel
    - dir_mode: 755

{% for file in xorg_confd_files %}
/usr/local/etc/X11/xorg.conf.d/{{ file|replace('.jinja', '') }}:
  file.managed:
    - source: salt://x11/{{ file }}
    - user: root
    - group: wheel
    - mode: 644
  {% if file.endswith('.jinja') %}
    - template: jinja
  {% endif %}
{% endfor %}

/home/woodsb02/.xinitrc:
  file.managed:
    - source: salt://x11/dot.xinitrc.jinja
    - template: jinja
    - user: woodsb02
    - group: woodsb02
    - mode: 644
