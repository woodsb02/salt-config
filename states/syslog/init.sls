{% set newsyslog_files = [] -%}
{% set newsyslog_absent_files = ['amd.conf','ftp.conf','lpr.conf','pf.conf','ppp.conf','sendmail.conf'] -%}
{% set syslog_absent_files = ['ftp.conf','lpr.conf','ppp.conf'] -%}
{% set syslog_files = [] -%}
{% if grains['id'].endswith('.woods.am') and grains['id'] != 'freenas.woods.am' -%}
  {% do syslog_files.append('remote.conf.jinja') -%}
{% endif -%}

service newsyslog restart:
  cmd.run:
    - onchanges:
      - file: /etc/newsyslog.conf
      - file: /etc/newsyslog.conf.d
{% for file in newsyslog_files %}
      - file: /etc/newsyslog.conf.d/{{ file|replace('.jinja', '') }}
{% endfor %}
{% for file in newsyslog_absent_files %}
      - file: /etc/newsyslog.conf.d/{{ file }}
{% endfor %}

/etc/newsyslog.conf:
  file.managed:
    - source: salt://syslog/newsyslog.conf.jinja
    - template: jinja
    - user: root
    - group: wheel
    - mode: 644

/etc/newsyslog.conf.d:
  file.directory:
    - user: root
    - group: wheel
    - dir_mode: 755

{% for file in newsyslog_files %}
/etc/newsyslog.conf.d/{{ file|replace('.jinja', '') }}:
  file.managed:
    - source: salt://syslog/newsyslog-{{ file }}
    - user: root
    - group: wheel
    - mode: 644
  {% if file.endswith('.jinja') %}
    - template: jinja
  {% endif %}
{% endfor %}

{% for file in newsyslog_absent_files %}
/etc/newsyslog.conf.d/{{ file }}:
  file.absent
{% endfor %}

syslogd:
  service.running:
    - watch:
      - file: /etc/syslog.conf
      - file: /etc/syslog.d
{% for file in syslog_files %}
      - file: /etc/syslog.d/{{ file|replace('.jinja', '') }}
{% endfor %}
{% for file in syslog_absent_files %}
      - file: /etc/syslog.d/{{ file }}
{% endfor %}

/etc/syslog.conf:
  file.managed:
    - source: salt://syslog/syslog.conf.jinja
    - template: jinja
    - user: root
    - group: wheel
    - mode: 644

/etc/syslog.d:
  file.directory:
    - user: root
    - group: wheel
    - dir_mode: 755

{% for file in syslog_files %}
/etc/syslog.d/{{ file|replace('.jinja', '') }}:
  file.managed:
    - source: salt://syslog/syslog-{{ file }}
    - user: root
    - group: wheel
    - mode: 644
  {% if file.endswith('.jinja') %}
    - template: jinja
  {% endif %}
{% endfor %}

{% for file in syslog_absent_files %}
/etc/syslog.d/{{ file }}:
  file.absent
{% endfor %}
