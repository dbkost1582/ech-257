Extraktion deskriptiver Metadaten aus der archivischen Ablieferungsschnittstelle eCH-0160
-----------------------------------------------------------------------------------------

Damit auch eine M�glichkeit besteht, die Transformationen eCH-0160 -> xIsadg und CH-0160 ->  EAD konkret zu �berpr�fen, sind beide Transformationen auch als XSL-Transformationen ausgef�hrt. Damit k�nnen mit einem entsprechenden Programm (saxon, xalan u.a.) XML-Metadatendateien nach eCH-0160 in die jeweils anderen Metadaten-Formate �berf�hrt werden. 

Der �bersichtlichkeit halber sind die Transformationen nach den vier Ebenen in eCH-0160 gegliedert ..fond.xsl ..serie.xsl ..file.xsl  und ..item.xsl. Zugangsbestimmungen, Entstehungszeitraum und Signatur sind gesondert in ..access.xsl ..date.xsl und ..reference.xsl abgehandelt.

F�r den Online-Test steht eine Webapplikation zur Verf�gung: http://kost-ceco.ch/isadg/app/input.php .

Ein Windows-Commandline-Beispiel mit Saxon9 und xmllint ist in diesem ZIP file integriert (transform.bat). 
