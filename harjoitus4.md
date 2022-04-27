# kohta a

Kohdan a tehtävänanto edellytti sellaisen salt-tilan tekemistä, joka 
asentaisi 10 suosikkiohjelman paketinhallinnasta. Koska en ole vannoutunut Linux-käyttäjä
ei minulla ole niin montaa linux-yhteensopivaa suosikkiohjelmaa joita asentaa, niin 
niin asennan harjoituksen vuoksi vain Inkscape ja OpenOfficen.

Koska nämä pitää ensin asentaa käsin, jotta ne voi automatisoida, aloitin Inkscapesta 
komennolla:

	sudo apt-get install inkscape
	
joka asensi kyseisen ohjelman muuten automaattisesti, mutta yhdessä välissä piti 
vahvistaa asennus komennolla -y.

OpenOfficen asennus edellytti ensin Java-paketin asennusta komennolla:

	sudo apt-get install default-jdk
	
jonka jälkeen Debian-paketin mukana tullut LibreOffice piti poistaa komennolla 

	sudo apt-get remove --purge libreoffice*
	
Tämä siksi, että LibreOffice haittaa muuten OpenOfficen asentumista

Openofficen asentamiseen tarvittava asennustiedosto saatiin ladattua komennolla

	wget https://sourceforge.net/projets/openofficeorg.mirror/files/
	4.1.10/binaries/en-US/Apache_OpenOffice_4.1.10_Linux_x86-64_install-deb_en-US.tar.gz

Paketin latautumisen jälkeen se purettiin komennolla

	tar xvf Apache_OpenOffice_4.1.10_Linux_x86-64_install-deb_en_US.tar.gz

Tämä loi kansion en-US/DEBS, johon siiryttiin cd-komennolla ja kansion sisällä
aloitettin varsinainen asennus komenolla 

	sudo dpkg -i *.deb

Tämän jälkeen piti vielä purkaa ja asentaa työpöytä-integraatiot komennoilla

	cd desktop-integration/
	sudo dpkg -i *deb

Onnistunut asennus todennettiin löytämällä OpenOffice asentuneena graafisesta
käyttöliittymästä toimistotyökaluista:

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvaopenoffice.png)

Vasta tehtyäni tämän asennuksen luin tehtävänantoa vielä uudestaan tajutakseni
tarkoituksen olleen käyttää valmiita pakettivarastoija, jotta asennus toimisi
yksinkertaisesti, kuten inkscape kanssa. Tosiinsanoen OpenOfficen asennus ei vastaa
tehtävänantoa. Päädyin siis takaisin arpomaan paketinhallinnan kautta asennettavissa
olevia ohjelmia, yhdeksi niistä valikoitui Dia

	sudo apt-get install dia
	
kolmanneksi testiohjelmaksi päätin ottaa GIMP:in

	sudo apt-get install gimp

Näiden asennus salt-tilana tehtiin maurinohjelmat.init.sls-tiedostoon paloittain
Ensimmäisenä lisättiin inkscape-paketti ja testattiin tiedoston toimivuus

	inkscape:
	  pkg.installed

Kun halutaan asentaa useampi paketti kerralla, pitää init.sls-tiedosto muokata 

	mypkgs:
	  pkg.installed:
	    - pkgs:
	      -inkscape
	      -dia
	      -gimp

# kohta b

Tässä kohdassa olisi pitänyt tehdä tiedostoista aikajana, mutta tehtävänannossa 
annettu komento ei jostain syystä toimi, niin en pystynyt sitä tekemään.

Edit 27.4.2022

Muiden palautuksia arvioidessa huomasin, että tehtävänannossa oleva mallikomento oli kirjoitettu 
sen verran tiiviisti, että en huomannut komennossa olleita välilyöntejä, jonka takia en saanut
komentoa toimimaan. Tämän huomion mukaisesti korjatulla komennolla

	sudo find -printf '%T+ %p\n'|sort|tail
	
Sain aikaan tällaisen aikajanan:

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvaaikajana.png)

# kohta c

Tehtävä edellyttäisi toimivan aikajanan aikaansaamista, joten ei onnistu

Edit 27.4.2022

Kun aikajanakomento saatiin toimimaan, niin pääsin tämän kohdan kanssa eteenpäin.
Muokkasin kokeen vuoksi saltin master-dokumenttia lisäämällä sinne turhaa tekstiä alla olevan mukaisesti:

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvasaltmastermod.png)

Tämä muokkaus näkyy sitten aikajanalla näin:

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvaaikajana1.png)

# kohta d

