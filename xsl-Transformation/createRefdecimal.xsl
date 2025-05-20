<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" media-type="application/xml" />
	<!-- helper functions and named templates -->
	<xsl:param name="archsig" />
	<!-- root node transformation sets namespace and schema location -->
	<xsl:template match="/arelda:paket">
		<xsl:element name="reference">
			<xsl:apply-templates select="arelda:ablieferung" />
			<xsl:apply-templates
				select="arelda:ablieferung/arelda:ordnungssystem" />
		</xsl:element>
	</xsl:template>
	<!-- Ablieferung - Provenienz -->
	<xsl:template match="arelda:ablieferung">
		<xsl:element name="identity">
			<!-- 3.1.1 Signatur -->
			<xsl:element name="referenceCode">
				<xsl:value-of select="$archsig" />
				<xsl:text>.ablieferung</xsl:text>
				<xsl:number level="single" />
			</xsl:element>
			<xsl:element
				name="depth">
				<xsl:value-of select="0" />
			</xsl:element>
		</xsl:element>
		<!-- In case of "FILE" a map can be part of the Ablieferung -->
		<xsl:apply-templates
			select="arelda:mappe">
			<xsl:with-param name="depth" select="1" />
			<xsl:with-param name="sig">
				<xsl:value-of select="$archsig" />
				<xsl:text>.ablieferung</xsl:text>
				<xsl:number level="single" />
			</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>

	<!-- Ordnungssystem -->
	<xsl:template match="arelda:ablieferung/arelda:ordnungssystem">
		<xsl:apply-templates select="arelda:ordnungssystemposition">
			<xsl:with-param name="depth" select="1" />
			<xsl:with-param name="sig">
				<xsl:value-of select="$archsig" />
				<xsl:text>.ordnungssystem</xsl:text>
				<xsl:number level="single" />
			</xsl:with-param>
		</xsl:apply-templates>
		<!-- In case of FILES, a mappe is allowed too.  -->
		<xsl:apply-templates
			select="arelda:mappe">
			<xsl:with-param name="depth" select="1" />
			<xsl:with-param name="sig">
				<xsl:value-of select="$archsig" />
				<xsl:text>.ordnungssystem</xsl:text>
				<xsl:number level="single" />
			</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>

	<!-- Ordnungsystemposition -->
	<xsl:template match="arelda:ordnungssystemposition">
		<xsl:param name="depth" />
		<xsl:param name="sig" />
		<xsl:variable name="signature">
			<xsl:value-of select="$sig" />
			<xsl:text>.ordnungssystemposition</xsl:text>
			<xsl:number level="single" />
		</xsl:variable>
		<xsl:element
			name="identity">
			<!-- 3.1.2 Titel -->
			<xsl:element name="title">
				<xsl:value-of select="arelda:titel" />
			</xsl:element>
			<!-- 3.1.1 Signatur -->
			<xsl:element
				name="referenceCode">
				<xsl:value-of select="$signature" />
			</xsl:element>
			<xsl:element
				name="depth">
				<xsl:value-of select="$depth" />
			</xsl:element>
			<xsl:element
				name="identitaet">
			<xsl:value-of select="./@id"/>
			</xsl:element>
		</xsl:element>
		<xsl:apply-templates
			select="arelda:ordnungssystemposition">
			<xsl:with-param name="depth" select="$depth+1" />
			<xsl:with-param name="sig" select="$signature" />
		</xsl:apply-templates>
		<xsl:apply-templates
			select="arelda:dossier">
			<xsl:with-param name="depth" select="$depth+1" />
			<xsl:with-param name="sig" select="$signature" />
		</xsl:apply-templates>
		<xsl:apply-templates
			select="arelda:mappe">
			<xsl:with-param name="depth" select="$depth+1" />
			<xsl:with-param name="sig" select="$signature" />
		</xsl:apply-templates>
	</xsl:template>


	<!-- Mappe -->
	<xsl:template match="arelda:mappe">
		<xsl:param name="depth" />
		<xsl:param name="sig" />
		<xsl:variable name="signature">
			<xsl:value-of select="$sig" />
			<xsl:text>.mappe</xsl:text>
			<xsl:number level="single" />
		</xsl:variable>
		<xsl:element
			name="identity">
			<!-- 3.1.2 Titel -->
			<xsl:element name="title">
				<xsl:value-of select="arelda:titel" />
			</xsl:element>
			<!-- 3.1.1 Signatur -->
			<xsl:element
				name="referenceCode">
				<xsl:value-of select="$signature" />
			</xsl:element>
			<xsl:element
				name="depth">
				<xsl:value-of select="$depth" />
			</xsl:element>
			<xsl:element
				name="identitaet">
				<xsl:value-of select="./@id"/>
			</xsl:element>
		</xsl:element>
		<xsl:apply-templates
			select="arelda:ordnungssystemposition">
			<xsl:with-param name="depth" select="$depth+1" />
			<xsl:with-param name="sig" select="$signature" />
		</xsl:apply-templates>
		<xsl:apply-templates
			select="arelda:dossier">
			<xsl:with-param name="depth" select="$depth+1" />
			<xsl:with-param name="sig" select="$signature" />
		</xsl:apply-templates>
		<xsl:apply-templates
			select="arelda:mappe">
			<xsl:with-param name="depth" select="$depth+1" />
			<xsl:with-param name="sig" select="$signature" />
		</xsl:apply-templates>
		<xsl:apply-templates
			select="arelda:dokument">
			<xsl:with-param name="depth" select="$depth+1" />
			<xsl:with-param name="sig" select="$signature" />
		</xsl:apply-templates>
		<xsl:apply-templates
			select="arelda:dateiRef">
			<xsl:with-param name="depth" select="$depth+1" />
			<xsl:with-param name="sig" select="$signature" />
		</xsl:apply-templates>
	</xsl:template>


	<!-- Dossier -->
	<xsl:template match="arelda:dossier">
		<xsl:param name="depth" />
		<xsl:param name="sig" />
		<xsl:variable name="signature">
			<xsl:value-of select="$sig" />
			<xsl:text>.dossier</xsl:text>
			<xsl:number level="single" />
		</xsl:variable>
		<xsl:element
			name="identity">
			<!-- 3.1.2 Titel -->
			<xsl:element name="title">
				<xsl:value-of select="arelda:titel" />
			</xsl:element>
			<!-- 3.1.1 Signatur -->
			<xsl:element
				name="referenceCode">
				<xsl:value-of select="$signature" />
			</xsl:element>
			<xsl:element
				name="depth">
				<xsl:value-of select="$depth" />
			</xsl:element>
			<xsl:element
				name="identitaet">
				<xsl:value-of select="./@id"/>
			</xsl:element>
		</xsl:element>
		<xsl:apply-templates
			select="arelda:dokument">
			<xsl:with-param name="depth" select="$depth+1" />
			<xsl:with-param name="sig" select="$signature" />
		</xsl:apply-templates>
		<xsl:apply-templates
			select="arelda:dateiRef">
			<xsl:with-param name="depth" select="$depth+1" />
			<xsl:with-param name="sig" select="$signature" />
		</xsl:apply-templates>
		<xsl:apply-templates
			select="arelda:dossier">
			<xsl:with-param name="depth" select="$depth+1" />
			<xsl:with-param name="sig" select="$signature" />
		</xsl:apply-templates>
		<xsl:apply-templates
			select="arelda:mappe">
			<xsl:with-param name="depth" select="$depth+1" />
			<xsl:with-param name="sig" select="$signature" />
		</xsl:apply-templates>
	</xsl:template>
	<!-- Dokument GEVER -->
	<xsl:template match="arelda:dokument">
		<xsl:param name="depth" />
		<xsl:param name="sig" />
		<xsl:variable name="signature">
			<xsl:value-of select="$sig" />
			<xsl:text>_dokument</xsl:text>
			<xsl:number level="single" />
		</xsl:variable>
		<xsl:element
			name="identity">
			<!-- 3.1.2 Titel -->
			<xsl:element name="title">
				<xsl:value-of select="arelda:titel" />
			</xsl:element>
			<!-- 3.1.1 Signatur -->
			<xsl:element
				name="referenceCode">
				<xsl:value-of select="$signature" />
			</xsl:element>
			<xsl:element
				name="depth">
				<xsl:value-of select="$depth" />
			</xsl:element>
			<xsl:element
				name="identitaet">
			<xsl:value-of select="./@id"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>


		<!-- Dokument FILE -->
		<!-- This part is disabled now, we do not need a referenceNo for teh dateiRef -->
	<xsl:template match="arelda:dateiRef---------Disable----------">
		<xsl:param name="depth" />
		<xsl:param name="sig" />
		<xsl:variable name="signature">
			<xsl:value-of select="$sig" />
			<xsl:text>_dateiRef</xsl:text>
			<xsl:number level="single" />
		</xsl:variable>
		<xsl:element
			name="identity">
			<!-- 3.1.2 Titel -->
			<xsl:element name="title">
				<xsl:value-of select="." />
			</xsl:element>
			<!-- 3.1.1 Signatur -->
			<xsl:element
				name="referenceCode">
				<xsl:value-of select="$signature" />
			</xsl:element>
			<xsl:element
				name="depth">
				<xsl:value-of select="$depth" />
			</xsl:element>
		</xsl:element>
	</xsl:template>

</xsl:stylesheet>


	
