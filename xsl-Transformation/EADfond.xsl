<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="urn:isbn:1-931666-22-9" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- Ablieferung - Provenienz - Ordnungssystem -->
	<xsl:template match="arelda:ablieferung">
		<xsl:variable name="signature">
			<xsl:value-of select="$archsig"/>
			<xsl:text>.</xsl:text>
			<xsl:number/>
		</xsl:variable>
		<!-- 3.1.4 Verzeichnungsstufe -->
		<xsl:attribute name="id"><xsl:value-of select="$signature"/></xsl:attribute>
		<xsl:attribute name="level">otherlevel</xsl:attribute>
		<xsl:attribute name="otherlevel">Bestand</xsl:attribute>
		<xsl:element name="did">
			<!-- 3.1.1 Signatur -->
			<xsl:call-template name="EADreference">
				<xsl:with-param name="signature" select="$signature"/>
			</xsl:call-template>
			<!-- 3.1.2 Titel -->
			<xsl:element name="unittitle">
				<xsl:attribute name="label">main</xsl:attribute>
				<xsl:choose>
					<xsl:when test="$fondtitle">
						<xsl:value-of select="$fondtitle"/>
					</xsl:when>
					<xsl:when test="arelda:provenienz/arelda:registratur/text()">
						<xsl:value-of select="arelda:provenienz/arelda:registratur"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="arelda:ordnungssystem/arelda:name"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
			<!-- 3.1.3 Entstehungszeitraum / Laufzeit -->
			<xsl:choose>
				<xsl:when test="arelda:entstehungszeitraum">
					<xsl:call-template name="EADdate">
						<xsl:with-param name="range" select="arelda:entstehungszeitraum"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="arelda:ordnungssystem/arelda:anwendungszeitraum">
					<xsl:call-template name="EADdate">
						<xsl:with-param name="range" select="arelda:ordnungssystem/arelda:anwendungszeitraum"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
			<!-- 3.1.4 Verzeichnungsstufe -->
			<!-- 3.1.5 Umfang (Menge und Abmessung) -->
			<!-- 3.2.1 Name der Provenienzstelle -->
			<xsl:if test="arelda:provenienz/arelda:aktenbildnerName/text()">
				<xsl:element name="origination">
					<xsl:value-of select="arelda:provenienz/arelda:aktenbildnerName"/>
				</xsl:element>
			</xsl:if>
		</xsl:element>
		<!-- 3.6.1 Allgemeine Anmerkungen -->
		<xsl:if test="arelda:bemerkung/text() or arelda:provenienz/arelda:bemerkung/text() or arelda:ordnungssystem/arelda:bemerkung/text()">
			<xsl:element name="note">
				<xsl:if test="arelda:bemerkung/text()">
					<xsl:element name="p">
						<xsl:value-of select="arelda:bemerkung"/>
					</xsl:element>
				</xsl:if>
				<xsl:if test="arelda:provenienz/arelda:bemerkung/text()">
					<xsl:element name="p">
						<xsl:value-of select="arelda:provenienz/arelda:bemerkung"/>
					</xsl:element>
				</xsl:if>
				<xsl:if test="arelda:ordnungssystem/arelda:bemerkung/text()">
					<xsl:element name="p">
						<xsl:value-of select="arelda:ordnungssystem/arelda:bemerkung"/>
					</xsl:element>
				</xsl:if>
			</xsl:element>
		</xsl:if>
		<!-- 3.1.5 Umfang (Menge und Abmessung) -->
		<!-- 3.2.2 Verwaltungsgeschichte / Biographische Angaben -->
		<xsl:if test="arelda:provenienz/arelda:geschichteAktenbildner/text()">
			<xsl:element name="bioghist">
				<xsl:element name="p">
					<xsl:value-of select="arelda:provenienz/arelda:geschichteAktenbildner"/>
				</xsl:element>
			</xsl:element>
		</xsl:if>
		<!-- 3.2.3 Bestandesgeschichte -->
		<xsl:if test="arelda:provenienz/arelda:systemBeschreibung/text()">
			<xsl:element name="custodhist">
				<xsl:element name="p">
					<xsl:value-of select="arelda:provenienz/arelda:systemBeschreibung/text()"/>
				</xsl:element>
			</xsl:element>
		</xsl:if>
		<!-- 3.2.4 Abgebende Stelle -->
		<xsl:if test="arelda:ablieferndeStelle/text()">
			<xsl:element name="acqinfo">
				<xsl:element name="p">
					<xsl:value-of select="arelda:ablieferndeStelle"/>
				</xsl:element>
			</xsl:element>
		</xsl:if>
		<!-- 3.3.1 Form und Inhalt -->
		<!--   -->
		<!-- 3.3.2 Bewertung und Kassation -->
		<xsl:if test="arelda:referenzBewertungsentscheid/text()">
			<xsl:element name="appraisal">
				<xsl:element name="p">
					<xsl:value-of select="arelda:referenzBewertungsentscheid"/>
				</xsl:element>
			</xsl:element>
		</xsl:if>
		<!-- 3.4.1 Zugangsbestimmungen -->
		<xsl:call-template name="EADaccess">
			<xsl:with-param name="position" select="."/>
		</xsl:call-template>
<!-- 
		<xsl:element name="accessrestrict">
			<xsl:attribute name="type">restrict</xsl:attribute>
			<xsl:element name="p">
				<xsl:text>ToDo</xsl:text>
			</xsl:element>
		</xsl:element> -->
		<!-- 3.4.4 Physische Beschaffenheit und technische Anforderungen -->
		<!--   -->
	</xsl:template>
</xsl:stylesheet>
