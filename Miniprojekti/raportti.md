# Projektin tavoite

Projektin tavoitteena oli luoda salt-tila, joka asentaa kaksi eri serveriohjelmaa samalle koneelle siten, 
että ohjelmat käyttävät eri porttikonfiguraatioita ja seuraavat eri index-sivuja.
Serverivaihtoehdoiksi päätyivät kurssin aikana käytetyt Apache2 ja Nginx-serverit.

## Pakettien asentaminen

Käsin asennettuina nämä asentuvat komennoilla:
 
	sudo apt-get install -y apache2
	sudo apt-get install -y nginx

Apachen ensiasennuksen jälkeen nettiselaimen localhost-osoitteeseen ilmestyy alla olevan kuvan mukainen oletussivu:
![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvaapachedefaultindex.png)

Nginx:llä vastaava on tällainen:
![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvanginxdefaultindex.png)

Salt-tilan init.sls-tiedostolla molempien asennus onnistuu tämänlaisella koodinpätkällä:



	servers:
	  pkg.installed:
	    - pkgs:
	      - nginx
	      - apache2

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvasaltserversetup1.png)

## Porttien konfigurointi:

Vaikka molemmat serveriohjelmat saadaan asennettua yhtäaikaa, niin oletusasetuksilla ne eivät suostu olemaan käynnissä samaan aikaan, koska molemmat konfiguroivat
kuuntelemaan samaa porttia. Tästä johtuen vähintäänkin toisen porttikonfiguraatiota on muutettava. Nginx:issä se onnituu muokkaamalla /etc/nginx/sites-enabled/default-tiedostoa:

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvanginxports.png)

Apache2:ssa vastaava vaatii kahden eri tiedoston, eli /etc/apache2/ports.conf ja /etc/apache2/sites-enabled/000-default muokkaamista:

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvaapache2sites.png)

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvaapache2ports.png)

Harjoituksessa Nginx konfiguroitiin porttiin 8081 ja Apache2 porttiin 8082. Salt-tilaa muokattiin tekemään tämä automaattisesti kopioimalla kyseiset tiedostot salt-moduulin kansioon
ja lisäämällä init.sls-tiedostoon vastaavat komennot, joilla kyseisiin tiedostoihin tehtäviä muutoksia voi sekä masterin kautta muokata tai käyttäjän vahingossa tekemiä muutoksia korjata.
Salt.moduulissa olevien tiedostojen nimiä muokattiin vähän, jotta ne olisivat kuvaavampia. Porttimuutoksien voimaantulo edellyttää myös serverin uudelleenkäynnistämisen. Salt:illa
tämä on helppo automatisoida laittamalla service.running seuraamaan muutoksia porttikonfiguraatio-tiedostoissa erillisellä "watch"-alikomennolla. Tässä kohtaa init.sls muodostui siis tällaiseksi.

	servers:
	  pkg.installed:
	    - pkgs:
	      - nginx
	      - apache2
	     
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

Tämän salt-tilan ajaminen tuotti alla olevan tuloksen:

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvasaltserversetup2.png

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvasaltserversetup3.png

Kun nettiselaimella käy muutosten jälkeen katsomassa annettuja porrtteja localhost:8081 ja localhost:8082 tulee yllättäen sama apache2:n oletusetusivu:

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvaapache2default8081.png

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvaapache2default8082.png

Syy tälle on molemmilla servereillä oleva konfiguraatio katsoa oletusetusivu samasta /var/www/html- kansiosta, jossa sattuu olemaan apache2:n sivu ensimmäisenä.
Itse päätin korjata tämän lisäämällä nginx:n konfiguraatioon kyseiseen html-kansioon alikansion /nginx ja lisäämällä init.sls-tiedostoon kansion lisäävän komennon: 

	/var/www/html/nginx:
	  file.directory
	
	/var/www/html/nginx/index.html:
	  file.managed:
	    - source: salt://serversetup/nginx-index.html
	
	/var/www/html/index.html:
	  file.managed:
	    - source: salt://serversetup/apache2-index.html

Nginx:n porttikonfiguraatiotiedostoa piti korjat seuraamaan tätä uutta kansiota:

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvanginxports1.png

Samassa yhteydessä muokkasin noita salt-moduulissa olevia index-sivuja osoittamaan, että salt-tila hyödyntää nimenomaan salt-moduulissa olevia index-sivuja.

Lopullinen init.sls on siis:

	servers:
	  pkg.installed:
	    - pkgs:
	      - nginx
	      - apache2
	
	/etc/nginx/sites-enabled/default:
	  file.managed:
	    - source: salt://serversetup/nginx-ports
	
	/etc/apache2/sites-enabled/000-default:
	  file.managed:
	    - source: salt://serversetup/apache2-sites
	
	/etc/apache2/ports.conf:
	  file.managed:
	    - source: salt://serversetup/apache2-ports
	
	/var/www/html/nginx:
	 file.directory
		
	/var/www/html/nginx/index.html:
	  file.managed:
	   - source: salt://serversetup/nginx-index.html
		
	/var/www/html/index.html:
	  file.managed:
	    - source: salt://serversetup/apache2-index.html
	
	nginx.service:
	  service.running:
	    - watch:
	      - file: /etc/nginx/sites-enabled/*
	
	apache2.service:
	  service.running:
	    - watch:
	      - file: /etc/apache2/*

ja salt-moduulin sisältö:

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvaserversetupinit.png

Salt-tilan ajaminen tuotti tällaisen lopputuloksen:

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvasaltserversetup4.png

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvasaltserversetup5.png

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvasaltserversetup6.png

Muutosket näkyvät myös nettiselaimella:

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvanginxdefault8081.png

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvaapache2default8082new.png


      
