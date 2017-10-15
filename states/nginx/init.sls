{% set nginx_conf_files = ['nginx.conf.jinja','ssl.conf.jinja'] -%}
{% set nginx_site_files = ['acme.jinja'] -%}
{% if grains['id'] == 'www.woods.am' -%}
  {% do nginx_site_files.append('pkg.woods.am.jinja') -%}
  {% do nginx_site_files.append('www.woods.am.jinja') -%}
  {% do nginx_site_files.append('womlins.wedding.jinja') -%}
{% endif -%}
{% if grains['id'] == 'womlins.wedding' -%}
  {% do nginx_site_files.append('womlins.wedding.jinja') -%}
{% endif -%}

nginx:
  pkg:
    - installed
  service.running:
    - watch:
      - pkg: nginx
      - file: /usr/local/etc/nginx/nginx.conf
      - file: /usr/local/etc/nginx/ssl.conf
{% for file in nginx_site_files %}
      - file: /usr/local/etc/nginx/sites-available/{{ file|replace('.jinja','') }}
{% endfor %}

{% for file in nginx_conf_files %}
/usr/local/etc/nginx/{{ file|replace('.jinja','') }}:
  file.managed:
    - source: salt://nginx/{{ file }}
  {% if file.endswith('.jinja') %}
    - template: jinja
  {% endif %}
    - user: root
    - group: wheel
    - mode: 640
{% endfor %}

{% for file in nginx_site_files %}
/usr/local/etc/nginx/sites-available/{{ file|replace('.jinja','') }}:
  file.managed:
    - source: salt://nginx/sites/{{ file }}
  {% if file.endswith('.jinja') %}
    - template: jinja
  {% endif %}
    - makedirs: true
    - user: root
    - group: wheel
    - mode: 640

/usr/local/etc/nginx/sites-enabled/{{ file|replace('.jinja','') }}:
  file.symlink:
    - target: /usr/local/etc/nginx/sites-available/{{ file|replace('.jinja','') }}
    - makedirs: true
    - require:
      - file: /usr/local/etc/nginx/sites-available/{{ file|replace('.jinja','') }}
{% endfor %}

