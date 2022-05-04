#kohta a

Kohdassa a oli tehtävänantona tehdä järjestelmään uusi komento ja asentaa 
se saltin avustuksella kaikille koneille. Vihjeenä oli tehdä sheel script,
joka tulostaa "hei maailma" ja apuna tunnilta, opettajan esimerkkisuorituksesta
otetut muutamat kuvakaappaukset. Koska shell scipt on  itselle melko vieras,
tukeuduin alkuun myös nettiin osoitteessa shellscript.sh, jonka ohjeella sain
jonkinlaisen scriptin toimimaan jostain kansiosta.

Tämän jälkeen perehdyin kuvakaappauksiin ja erinäisten yritysten ja erehdysten jälkeen
sain jotain aikaiseksikin.

Kansiorakenteen rakenteellisuuden vuoksi tein omaan kotihakemistoon erillisen "Scripting"-kansion
johon scrititiedosto tallennettiin:

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvascriptikansio.png)

Tämän jälkeen tehtiin itse scripti, ja testattiin sen toimivuus:

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvascripti.png)

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvascriptitesti.png)

Kun scripti saatiin toimimaan, voitiin sen asentaminen automatisoida salt-tilan avulla. 
Tätä varten luotiin uusi kansio /srv/salt/uusikomento, johon luotiin salt-tilatiedosto init.sls
ja kopioitiin tehty scripti:

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvauusikomentoinit.png)

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvauusikomentoscripti.png)

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvasaltstateuusikomento.png)

Aikaansaannoksesta haluttiin myös ls -l /usr/local/bin tuloste:

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuva_ls_usr_local_bin-tuloste.png)

Edit 4.5.2022:

Lopputulosta testattiin jälkikäteen tyjentämällä /usr/local/bin:

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvaemptybin.png)

ja ajamalla salt-tila uudelleen:

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvaaikascriptisalt.png)

# kohta b

Kohdassa b oli tehtävänä tehdä toinen uusi komento, joka kertoo ajankohtaista tietoa.
Päätin yksinkertaisuuden vuoksi tehdä scriptin, joka kertoo kellonajan:

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvadatescript.png)

joka testattiin samalla tavalla, kun kohdan a scripti:

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvadatescripttest.png)

Tästä vastaavasti tehtiin samankaltainen salt-tila, kuin kohdasta a:

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvadatescriptsalt.png)

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvadatescriptsaltfile.png)

![](https://github.com/BGO792/Palvelintenhallinta/blob/main/kuvat/kuvadatescriptsalttest.png)


# kohta c

Kohdassa C olisi pitänyt tehdä vastaavaa Pythonilla, mutta en oiken päässyt kärryille mitä
kohtia olisi pitänyt tehdä toisin, kuin aikaisemmissa.

# kohta d

# kohta e
