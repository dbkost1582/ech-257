<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" media-type="application/xml"/>
	<!-- helper functions and named templates -->
	<xsl:param name="archsig"/>
	<!-- root node transformation sets namespace and schema location -->
	<xsl:template match="/arelda:paket">
		<xsl:element name="reference">
			<xsl:apply-templates select="arelda:ablieferung"/>
			<xsl:apply-templates select="arelda:ablieferung/arelda:ordnungssystem"/>
		</xsl:element>
	</xsl:template>
	<!-- Ablieferung - Provenienz -->
	<xsl:template match="arelda:ablieferung">
		<xsl:element name="identity">
			<!-- 3.1.1 Signatur -->
			<xsl:element name="referenceCode">
				<xsl:value-of select="$archsig"/>
				<xsl:text>.</xsl:text>
				<xsl:number/>
			</xsl:element>
			<xsl:element name="depth">
				<xsl:value-of select="0"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!-- Ordnungsystem -->
	<xsl:template match="arelda:ablieferung/arelda:ordnungssystem">
		<xsl:apply-templates select="arelda:ordnungssystemposition">
			<xsl:with-param name="depth" select="1"/>
			<xsl:with-param name="sig">
				<xsl:value-of select="$archsig"/>
				<xsl:text>.</xsl:text>
				<xsl:number/>
			</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
	<!-- Ordnungsystemposition -->
	<xsl:template match="arelda:ordnungssystemposition">
		<xsl:param name="depth"/>
		<xsl:param name="sig"/>
		<xsl:variable name="signature">
			<xsl:value-of select="$sig"/>
			<xsl:text>.</xsl:text>
			<xsl:number/>
		</xsl:variable>
		<xsl:element name="identity">
			<!-- 3.1.2 Titel -->
			<xsl:element name="title">
				<xsl:value-of select="arelda:titel"/>
			</xsl:element>
			<!-- 3.1.1 Signatur -->
			<xsl:element name="referenceCode">
				<xsl:value-of select="$signature"/>
			</xsl:element>
			<xsl:element name="depth">
				<xsl:value-of select="$depth"/>
			</xsl:element>
		</xsl:element>
		<xsl:apply-templates select="arelda:ordnungssystemposition">
			<xsl:with-param name="depth" select="$depth+1"/>
			<xsl:with-param name="sig" select="$signature"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="arelda:dossier">
			<xsl:with-param name="depth" select="$depth+1"/>
			<xsl:with-param name="sig" select="$signature"/>
		</xsl:apply-templates>
	</xsl:template>
	<!-- Dossier -->
	<xsl:template match="arelda:dossier">
		<xsl:param name="depth"/>
		<xsl:param name="sig"/>
		<xsl:variable name="signature">
			<xsl:value-of select="$sig"/>
			<xsl:text>.</xsl:text>
			<xsl:number/>
		</xsl:variable>
		<xsl:element name="identity">
			<!-- 3.1.2 Titel -->
			<xsl:element name="title">
				<xsl:value-of select="arelda:titel"/>
			</xsl:element>
			<!-- 3.1.1 Signatur -->
			<xsl:element name="referenceCode">
				<xsl:value-of select="$signature"/>
			</xsl:element>
			<xsl:element name="depth">
				<xsl:value-of select="$depth"/>
			</xsl:element>
		</xsl:element>
		<xsl:apply-templates select="arelda:dokument">
			<xsl:with-param name="depth" select="$depth+1"/>
			<xsl:with-param name="sig" select="$signature"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="arelda:dateiRef">
			<xsl:with-param name="depth" select="$depth+1"/>
			<xsl:with-param name="sig" select="$signature"/>
		</xsl:apply-templates>
		<xsl:apply-templates select="arelda:dossier">
			<xsl:with-param name="depth" select="$depth+1"/>
			<xsl:with-param name="sig" select="$signature"/>
		</xsl:apply-templates>
	</xsl:template>
	<!-- Dokument GEVER -->
	<xsl:template match="arelda:dokument">
		<xsl:param name="depth"/>
		<xsl:param name="sig"/>
		<xsl:variable name="signature">
			<xsl:value-of select="$sig"/>
			<xsl:text>_</xsl:text>
			<xsl:number/>
		</xsl:variable>
		<xsl:element name="identity">
			<!-- 3.1.2 Titel -->
			<xsl:element name="title">
				<xsl:value-of select="arelda:titel"/>
			</xsl:element>
			<!-- 3.1.1 Signatur -->
			<xsl:element name="referenceCode">
				<xsl:value-of select="$signature"/>
			</xsl:element>
			<xsl:element name="depth">
				<xsl:value-of select="$depth"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!-- Dokument FILE -->
	<xsl:template match="arelda:dateiRef">
		<xsl:param name="depth"/>
		<xsl:param name="sig"/>
		<xsl:variable name="signature">
			<xsl:value-of select="$sig"/>
			<xsl:text>_</xsl:text>
			<xsl:number/>
		</xsl:variable>
		<xsl:element name="identity">
			<!-- 3.1.2 Titel -->
			<xsl:element name="title">
				<xsl:value-of select="."/>
			</xsl:element>
			<!-- 3.1.1 Signatur -->
			<xsl:element name="referenceCode">
				<xsl:value-of select="$signature"/>
			</xsl:element>
			<xsl:element name="depth">
				<xsl:value-of select="$depth"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
