<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
	xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" 
	xmlns:dcterms="http://purl.org/dc/terms/" 
	xmlns:rico="https://www.ica.org/standards/RiC/ontology#" 
	xmlns:arelda="http://bar.admin.ch/arelda/v4" 
	exclude-result-prefixes="xs xsi arelda">
	<!--   -->
	<!-- !DOCTYPE rdf:RDF
	<xsl:output method="xml" doctype-system="rico.dtd" encoding="UTF-8" indent="yes" media-type="application/xml"/> 
	-->
	<xsl:output method="xml" encoding="UTF-8" indent="yes" media-type="application/xml"/>
	<!--   -->
	<!-- parameter -->
	<xsl:param name="fondtitle"/>
	<xsl:param name="archsig"/>
	<xsl:param name="reffilename"/>
	<xsl:variable name="reffile" select="document($reffilename)"/>
	<xsl:param name="creator"/>
	<xsl:param name="submissionbody"/>
	<xsl:param name="packagename"/>
	<!-- $baseuri -> $base -->
	<xsl:param name="baseuri"/>
		<xsl:variable name="base">
		<xsl:choose>
			<xsl:when test="$baseuri">
				<xsl:value-of select="$baseuri"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>http://arelda_v4.0.ch/</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<!-- $language -> $lang -->
	<xsl:param name="language"/>
	<xsl:variable name="lang">
		<xsl:choose>
			<xsl:when test="$language">
				<xsl:value-of select="$language"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>de</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<!--   -->
	<!-- helper functions and named templates -->
	<xsl:include href="RICdate.xsl"/>
	<xsl:include href="RICaccess.xsl"/>
	<xsl:include href="RICreference.xsl"/>
	<!--   -->
	<!-- Ablieferung - Provenienz -->
	<xsl:include href="RICfond.xsl"/>
	<!--   -->
	<!-- root node transformation sets namespace and schema location -->
	<xsl:template match="/arelda:paket">
		<rdf:RDF>
			<xsl:attribute name="xml:base"><xsl:value-of select="$base"/></xsl:attribute>
			<!--   -->
			<!-- Packet / SIP -->
			<xsl:element name="rdf:Description">
				<xsl:attribute name="rdf:about"><xsl:value-of select="$archsig"/></xsl:attribute>
				<!-- label -->
				<xsl:element name="rdfs:label">
					<xsl:attribute name="xml:lang">en</xsl:attribute>
					<xsl:text>Package</xsl:text>
				</xsl:element>
				<!-- Record Resource -->
				<xsl:element name="rdf:type">
					<xsl:attribute name="rdf:resource">https://www.ica.org/standards/RiC/ontology#RecordResource</xsl:attribute>
				</xsl:element>
				<!-- technical Characteristics -->
				<xsl:element name="rico:technicalCharacteristics">
					<xsl:value-of select="arelda:ablieferung/@xsi:type"/>
				</xsl:element>
				<xsl:element name="rico:technicalCharacteristics">
					<xsl:value-of select="namespace-uri()"/>
				</xsl:element>
				<!-- identifier -->
				<xsl:if test="*/arelda:ablieferungsnummer/text()">
					<xsl:element name="rico:identifier">
						<xsl:value-of select="*/arelda:ablieferungsnummer"/>
					</xsl:element>
				</xsl:if>
				<!-- title -->
				<xsl:if test="*/*/arelda:registratur/text()">
					<xsl:element name="rico:title">
						<xsl:attribute name="xml:lang"><xsl:value-of select="$lang"/></xsl:attribute>
						<xsl:value-of select="*/*/arelda:registratur"/>
					</xsl:element>
				</xsl:if>
				<!-- includes -->
				<xsl:element name="rico:includes">
					<xsl:attribute name="rdf:resource"><xsl:call-template name="RICreference"><xsl:with-param name="signature"><xsl:value-of select="$archsig"/><xsl:text>.</xsl:text><xsl:number/></xsl:with-param></xsl:call-template></xsl:attribute>
				</xsl:element>
			</xsl:element>
			<!--   -->
			<!-- Call: Fonds -->
			<xsl:apply-templates select="arelda:ablieferung"/>
			<!--   -->
		</rdf:RDF>
	</xsl:template>
	<!--   -->
	<!-- Ordnungsystemposition -->
	<xsl:include href="RICserie.xsl"/>
	<!--   -->
	<!-- Dossier -->
	<xsl:include href="RICfile.xsl"/>
	<!--   -->
	<!-- Dokument -->
	<xsl:include href="RICitem.xsl"/>
</xsl:stylesheet>
