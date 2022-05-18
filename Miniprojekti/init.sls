servers:
  pkg.installed:
    - pkgs:
      - nginx
      - apache2
      - git
      
/var/www/html/nginx:
  file.directory

/var/www/html/nginx/index.html:
  file.managed:
    - source: salt://serversetup/nginx-index.html

/var/www/html/index.html:
  file.managed:
    - source: salt://serversetup/apache2-index.html

/etc/nginx/sites-enabled/default:
  file.managed:
    - source: salt://serversetup/nginx-ports

/etc/apache2/sites-enabled/000-default:
  file.managed:
    - source: salt://serversetup/apache2-sites

/etc/apache2/ports.conf:
  file.managed:
    - source: salt://serversetup/apache2-ports

nginx.service:
  service.running:
    - watch:
      - file: /etc/nginx/sites-enabled/*

apache2.service:
  service.running:
    - watch:
      - file: /etc/apache2/* 
