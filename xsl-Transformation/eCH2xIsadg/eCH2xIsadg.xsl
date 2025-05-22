<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="ISADG" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" media-type="application/xml"/>
	<!-- parameter -->
	<xsl:param name="fondtitle"/>
	<xsl:param name="archsig"/>
	<xsl:param name="reffilename"/>
	<xsl:variable name="reffile" select="document($reffilename)"/>
	<!-- helper functions and named templates -->
	<xsl:include href="xIdate.xsl"/>
	<xsl:include href="xIaccess.xsl"/>
	<xsl:include href="xIreference.xsl"/>
	<!-- schema location -->
	<xsl:variable name="location">ISADG xIsadg_v1.6.1.xsd</xsl:variable>
	<!-- Ablieferung - Provenienz -->
	<xsl:include href="xIfond.xsl"/>
	<!-- root node transformation sets namespace and schema location -->
	<xsl:template match="/arelda:paket">
		<xsl:element name="archivalDescription">
			<xsl:attribute name="xsi:schemaLocation"><xsl:value-of select="$location"/></xsl:attribute>
			<xsl:apply-templates select="arelda:ablieferung"/>
			<xsl:apply-templates select="arelda:ablieferung/arelda:ordnungssystem"/>
		</xsl:element>
	</xsl:template>
	<!-- Ordnungssystem -->
	<xsl:template match="arelda:ablieferung/arelda:ordnungssystem">
		<xsl:apply-templates select="arelda:ordnungssystemposition">
			<xsl:with-param name="sig">
				<xsl:value-of select="$archsig"/>
				<xsl:text>.</xsl:text>
				<xsl:number/>
			</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
	<!-- Ordnungsystemposition -->
	<xsl:include href="xIserie.xsl"/>
	<!-- Dossier -->
	<xsl:include href="xIfile.xsl"/>
	<!-- Dokument -->
	<xsl:include href="xIitem.xsl"/>
</xsl:stylesheet>
