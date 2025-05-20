<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="ISADG" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- Ordnungsystemposition -->
	<xsl:template match="arelda:ordnungssystemposition">
		<xsl:param name="sig"/>
		<xsl:variable name="signature">
			<xsl:value-of select="$sig"/>
			<xsl:text>.</xsl:text>
			<xsl:number/>
		</xsl:variable>
		<xsl:element name="archivalDescription">
			<xsl:element name="identity">
				<!-- 3.1.1 Signatur -->
				<xsl:call-template name="xIreference">
					<xsl:with-param name="signature" select="$signature"/>
				</xsl:call-template>
				<!-- 3.1.2 Titel -->
				<xsl:element name="title">
					<xsl:value-of select="arelda:titel"/>
				</xsl:element>
				<!-- 3.1.3 Entstehungszeitraum / Laufzeit -->
				<!--   -->
				<!-- 3.1.4 Verzeichnungsstufe -->
				<xsl:element name="descriptionLevel">
					<xsl:text>Serie</xsl:text>
				</xsl:element>
				<!-- 3.1.5 Umfang (Menge und Abmessung) -->
				<!--   -->
			</xsl:element>
			<!-- 3.2.1 Name der Provenienzstelle -->
			<!--   -->
			<!-- 3.2.2 Verwaltungsgeschichte / Biographische Angaben -->
			<!--   -->
			<!-- 3.2.3 Bestandesgeschichte -->
			<!--   -->
			<!-- 3.2.4 Abgebende Stelle -->
			<!--   -->
			<!-- 3.3.1 Form und Inhalt -->
			<!--   -->
			<!-- 3.3.2 Bewertung und Kassation -->
			<!--   -->
			<xsl:element name="conditionsAccessUse">
				<!-- 3.4.1 Zugangsbestimmungen -->
				<xsl:call-template name="xIaccess">
					<xsl:with-param name="position" select="."/>
				</xsl:call-template>
				<!-- 3.4.4 Physische Beschaffenheit und technische Anforderungen -->
				<!--   -->
			</xsl:element>
			<!-- 3.6.1 Allgemeine Anmerkungen -->
			<!--   -->
			<xsl:apply-templates select="arelda:ordnungssystemposition">
				<xsl:with-param name="sig" select="$signature"/>
			</xsl:apply-templates>
			<xsl:apply-templates select="arelda:dossier">
				<xsl:with-param name="sig" select="$signature"/>
			</xsl:apply-templates>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
