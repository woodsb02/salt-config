{% set repo_files = [] -%}
{% set cert_files = [] -%}
{% if grains['id'].endswith('.woods.am') -%}
{%   do cert_files.append('pkg.cert.jinja') -%}
{%   do repo_files.append('FreeBSD.conf.jinja') -%}
{%   do repo_files.append('FreeBSD-ports.conf.jinja') -%}
{%   if grains['osfinger'] == 'FreeBSD-12' -%}
{%     do repo_files.append('FreeBSD-base.conf.jinja') -%}
{%   endif -%}
{% endif -%}

ca_root_nss:
  pkg:
    - installed

{% for file in repo_files %}
/usr/local/etc/pkg/repos/{{ file|replace('.jinja', '') }}:
  file.managed:
    - source: salt://pkgng/repos/{{ file }}
    - user: root
    - group: wheel
    - mode: 640
  {% if file.endswith('.jinja') %}
    - template: jinja
  {% endif %}
{% endfor %}

{% for file in cert_files %}
/usr/local/etc/ssl/certs/{{ file|replace('.jinja', '') }}:
  file.managed:
    - source: salt://pkgng/{{ file }}
    - user: root
    - group: wheel
    - mode: 640
  {% if file.endswith('.jinja') %}
    - template: jinja
  {% endif %}
{% endfor %}

pkg update:
  cmd:
    - run
  require:
    - pkg: ca_root_nss
{% for file in repo_files %}
    - file: /usr/local/etc/pkg/repos/{{ file|replace('.jinja', '') }}
{% endfor %}
{% for file in cert_files %}
    - file: /usr/local/etc/pkg/repos/{{ file|replace('.jinja', '') }}
{% endfor %}

pkg:
  pkg:
    - installed
  require:
    - cmd: pkg update
