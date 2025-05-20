<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="ISADG"
	xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" media-type="application/xml" />
	<!-- parameter -->
	<xsl:param name="fondtitle" />
	<xsl:param name="archsig" />
	<xsl:param name="archstyle" />
	<xsl:param name="reffilename" />
	<xsl:variable name="reffile" select="document($reffilename)" />
	<xsl:variable name="idfilexml" select="document($idfilename)" />
	<!-- helper functions and named templates -->
	<xsl:include href="xI2date.xsl" />
	<xsl:include href="xI2access.xsl" />
	<xsl:include href="xI2reference.xsl" />
	<xsl:include href="xI2filename.xsl" />
	<!-- schema location -->
	<xsl:variable name="location">ISADG xIsadg_v3.0.xsd</xsl:variable>
	<!-- Ablieferung - Provenienz -->
	<xsl:include href="xI2fond.xsl" />
	<!-- root node transformation sets namespace and schema location -->
	<xsl:template match="/arelda:paket">

		<xsl:element name="archivalDescription">
			<xsl:attribute name="xsi:schemaLocation">
				<xsl:value-of select="$location" />
			</xsl:attribute>
			<!-- Selects only the child elements of ablieferung. All templates will be applied on them -->
			<!-- The 'Mappe' in Ablieferung is taken care of in xI2fond.xsl -->
			<xsl:apply-templates select="arelda:ablieferung">
			</xsl:apply-templates>
			<!-- Selects only the child elements of ordnungssystem in ablieferung -->
			<xsl:apply-templates select="arelda:ablieferung/arelda:ordnungssystem" />
		</xsl:element>
	</xsl:template>

	<!-- Ordnungssystem -->
	<!-- Template is automatically executed when it matches the node ordnungssystem -->
	<xsl:template match="arelda:ablieferung/arelda:ordnungssystem">
		<xsl:apply-templates select="arelda:ordnungssystemposition">
			<xsl:with-param name="sig">
				<xsl:value-of select="$archsig" />
				<xsl:if test="$archstyle='fortlaufend'">
				<xsl:text>.ordnungssystem</xsl:text>
				<xsl:number level="any"/>
				</xsl:if>
				<xsl:if test="$archstyle='dezimal'">
				<xsl:text>.ordnungssystem</xsl:text>
				<xsl:number level="single"/>
				</xsl:if>	
			</xsl:with-param>
			<xsl:with-param name="astyle">
				<xsl:value-of select="$archstyle" />
			</xsl:with-param>
		</xsl:apply-templates>
		<!-- Ordnungssystem does not have Mappen/binder in GEVER
		Ordnungssystem has Mappen/binder in FILES, as a consequence an ifcase is needed
		the subsequent apply-templates will basically only apply the templates which were includec BEFORE this command--> 
		<xsl:if test="arelda:mappe">
			<xsl:apply-templates select="arelda:mappe">
				<xsl:with-param name="sig">
					<xsl:value-of select="$archsig" />
					<xsl:if test="$archstyle='fortlaufend'">
					<xsl:text>.ordnungssystem</xsl:text>
					<xsl:number level="any"/>
					</xsl:if>
					<xsl:if test="$archstyle='dezimal'">
					<xsl:text>.ordnungssystem</xsl:text>
					<xsl:number level="single"/>
					</xsl:if>	
				</xsl:with-param>
				<xsl:with-param name="astyle">
					<xsl:value-of select="$archstyle" />
				</xsl:with-param>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>


	<!-- Ordnungssystemposition -->
	<xsl:include href="xI2serie.xsl" />

	<!-- Mappe -->
	<xsl:include href="xI2binder.xsl" />

	<!-- Dossier -->
	<xsl:include href="xI2file.xsl" />

	<!-- Dokument -->
	<xsl:include href="xI2item.xsl" />


</xsl:stylesheet>