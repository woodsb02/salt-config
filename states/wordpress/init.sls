nginx:
  pkg.installed: []
  service.running:
    - enable: True

/usr/local/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://wordpress/nginx.conf
    - watch_in:
      - service: nginx
