@ECHO OFF 
SETLOCAL

SET JAVA_HOME=C:\Tools\jdk1.8.0_40
SET SAXON=C:\Tools\saxon9
SET LINT=C:\Tools\PCUnixUtils

IF [%1]==[] (
    ECHO usage: %0  path\SIP...  OUTPUT
    EXIT /B
)

IF [%2]==[] (
    ECHO usage: %0  path\SIP...  OUTPUT
    EXIT /B
)

IF NOT EXIST %1 (
    ECHO SIP path %1 not found
    ECHO usage: %0 path\SIP...
    EXIT /B
)

SET ECH-0160=%1\header\metadata.xml

IF NOT EXIST %ECH-0160% (
    SET ECH-0160=%1
)

IF NOT EXIST %ECH-0160% (
    ECHO %ECH-0160% not found
    ECHO usage: %0 path\SIP...
    EXIT /B
)

SET OUTPUT=%2
IF EXIST %OUTPUT% (
    DEL /Q %OUTPUT%
)

REM User input -----------------------------------------------------------------

ECHO.
ECHO Benutzereingabe
ECHO ===============
IF [%FONDTITLE%]==[] (
    SET /P "FONDTITLE=Bestand Titel: "
)
REM left trim xslt parameter
for /f "tokens=* delims= " %%a in ("%FONDTITLE%") do set FONDTITLE=%%a

IF [%SIGNATUR%]==[] (
    SET /P "SIGNATUR=Archivkuerzel und Bestandessignatur: "
)
REM left trim xslt parameter
for /f "tokens=* delims= " %%a in ("%SIGNATUR%") do set SIGNATUR=%%a

IF [%STIL%]==[] (
    SET STIL=1
    SET /P "STIL=Signaturstil (fortlaufend SIG.1 SIG.2 / hierarchisch SIG.1 SIG.1.1): [1] oder [2] "
)

IF [%FMT%]==[] (
    SET FMT=1
    SET /P "FMT=Ausgabeformat (xIsadg / xIsadg 2.1 / EAD / RIC-O): [1] [2] [3] oder [4] "
)
ECHO.

REM create unique reference for each archival object
SET REF=numberRef.xml
%JAVA_HOME%\bin\java -jar %SAXON%\saxon9.jar -versionmsg:off -s:%ECH-0160% -xsl:createRef.xsl -o:"createRef.xml" fondtitle=%FONDTITLE% archsig=%SIGNATUR%

REM create running number for each archival object
%JAVA_HOME%\bin\java -jar %SAXON%\saxon9.jar -versionmsg:off -s:createRef.xml -xsl:elementRef.xsl -o:%REF% fondtitle=%FONDTITLE% archsig=%SIGNATUR%
IF %STIL% == 2 (
    SET REF=null.xml
)

REM convert to xIsadg and validate with xmllint
IF %FMT% == 1 (
%JAVA_HOME%\bin\java -jar %SAXON%\saxon9.jar -versionmsg:off -s:%ECH-0160% -xsl:eCH2xIsadg.xsl -o:"%OUTPUT%" fondtitle=%FONDTITLE% archsig=%SIGNATUR% reffilename=%REF%
REM schema validate with xmllint
%LINT%\xmllint.exe -sax -noout -schema xIsadg_v1.6.1.xsd "%OUTPUT%"
)

REM convert to xIsadg 2.1 and validate with xmllint
IF %FMT% == 2 (
%JAVA_HOME%\bin\java -jar %SAXON%\saxon9.jar -versionmsg:off -s:%ECH-0160% -xsl:eCH2xI2sadg.xsl -o:"%OUTPUT%" fondtitle=%FONDTITLE% archsig=%SIGNATUR% reffilename=%REF%
REM schema validate with xmllint
%LINT%\xmllint.exe -sax -noout -schema xIsadg_v2.1.xsd "%OUTPUT%"
)

REM convert to EAD and validate with xmllint
IF %FMT% == 3 (
%JAVA_HOME%\bin\java -jar %SAXON%\saxon9.jar -versionmsg:off -s:%ECH-0160% -xsl:eCH2EAD.xsl -o:"%OUTPUT%" fondtitle=%FONDTITLE% archsig=%SIGNATUR% reffilename=%REF%
REM schema validate with xmllint
%LINT%\xmllint.exe -sax -noout -schema ead.xsd "%OUTPUT%"
)

REM convert to RIC-O and validate with xmllint
IF %FMT% == 4 (
%JAVA_HOME%\bin\java -jar %SAXON%\saxon9.jar -versionmsg:off -s:%ECH-0160% -xsl:eCH2RIC.xsl -o:"%OUTPUT%" fondtitle=%FONDTITLE% archsig=%SIGNATUR% reffilename=%REF%
REM schema validate with xmllint
REM %LINT%\xmllint.exe -sax -noout -schema ead.xsd "%OUTPUT%"
)

ECHO.
IF %ERRORLEVEL%==0 (
    ECHO SIP %ECH-0160% converted
    ECHO output is %OUTPUT%
    ECHO.
)
