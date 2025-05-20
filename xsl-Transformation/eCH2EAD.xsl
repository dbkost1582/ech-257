<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="urn:isbn:1-931666-22-9" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" media-type="application/xml"/>
	<!-- parameter -->
	<xsl:param name="fondtitle"/>
	<xsl:param name="archsig"/>
	<xsl:param name="reffilename"/>
	<xsl:variable name="reffile" select="document($reffilename)"/>
	<!-- helper functions and named templates -->
	<xsl:include href="EADdate.xsl"/>
	<xsl:include href="EADaccess.xsl"/>
	<xsl:include href="EADreference.xsl"/>
	<!-- schema location -->
	<xsl:variable name="location">urn:isbn:1-931666-22-9 http://www.loc.gov/ead/ead.xsd</xsl:variable>
	<!-- Ablieferung - Provenienz -->
	<xsl:include href="EADfond.xsl"/>
	<!-- root node transformation sets namespace and schema location -->
	<xsl:template match="/arelda:paket">
		<xsl:element name="ead">
			<xsl:attribute name="xsi:schemaLocation"><xsl:value-of select="$location"/></xsl:attribute>
			<!-- EAD header -->
			<xsl:element name="eadheader">
				<xsl:element name="eadid">
					<xsl:text>what_so_ever</xsl:text>
				</xsl:element>
				<xsl:element name="filedesc">
					<xsl:element name="titlestmt">
						<xsl:element name="titleproper"/>
					</xsl:element>
				</xsl:element>
			</xsl:element>
			<!-- EAD arcdesc -->
			<xsl:element name="archdesc">
				<xsl:attribute name="level">otherlevel</xsl:attribute>
				<xsl:attribute name="otherlevel"><xsl:value-of select="@xsi:type"/></xsl:attribute>
				<xsl:element name="did">
					<xsl:element name="unittitle">
						<xsl:attribute name="label">main</xsl:attribute>
						<xsl:value-of select="@xsi:type"/>
					</xsl:element>
					<xsl:element name="langmaterial"/>
				</xsl:element>
				<xsl:element name="dsc">
					<xsl:element name="c">
						<xsl:apply-templates select="arelda:ablieferung"/>
						<xsl:apply-templates select="arelda:ablieferung/arelda:ordnungssystem"/>
					</xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!-- Ordnungssystem -->
	<xsl:template match="arelda:ablieferung/arelda:ordnungssystem">
		<!-- Das entsprechende Template findet sich in EADserie.xsl -->
		<xsl:apply-templates select="arelda:ordnungssystemposition">
			<xsl:with-param name="sig">
				<xsl:value-of select="$archsig"/>
				<xsl:text>.</xsl:text>
				<xsl:number/>
			</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
	<!-- Ordnungsystemposition  -->
	<xsl:include href="EADserie.xsl"/>
	<!-- Dossier  -->
	<xsl:include href="EADfile.xsl"/>
	<!-- Dokument  -->
	<xsl:include href="EADitem.xsl"/>
</xsl:stylesheet>
