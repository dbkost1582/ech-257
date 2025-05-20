Extraktion deskriptiver Metadaten aus der archivischen Ablieferungsschnittstelle eCH-0160
-----------------------------------------------------------------------------------------

Damit auch eine Möglichkeit besteht, die Transformationen eCH-0160 -> xIsadg und CH-0160 ->  EAD konkret zu überprüfen, sind beide Transformationen auch als XSL-Transformationen ausgeführt. Damit können mit einem entsprechenden Programm (saxon, xalan u.a.) XML-Metadatendateien nach eCH-0160 in die jeweils anderen Metadaten-Formate überführt werden. 

Der Übersichtlichkeit halber sind die Transformationen nach den vier Ebenen in eCH-0160 gegliedert ..fond.xsl ..serie.xsl ..file.xsl  und ..item.xsl. Zugangsbestimmungen, Entstehungszeitraum und Signatur sind gesondert in ..access.xsl ..date.xsl und ..reference.xsl abgehandelt.

Für den Online-Test steht eine Webapplikation zur Verfügung: http://kost-ceco.ch/isadg/app/input.php .

Ein Windows-Commandline-Beispiel mit Saxon9 und xmllint ist in diesem ZIP file integriert (transform.bat). 
