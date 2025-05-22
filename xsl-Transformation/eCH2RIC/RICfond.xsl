<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rico="https://www.ica.org/standards/RiC/ontology#" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!--   -->
	<!-- Ablieferung - Provenienz - Ordnungssystem -->
	<xsl:template match="arelda:ablieferung">
		<!-- $signature -->
		<xsl:variable name="signature">
			<xsl:call-template name="RICreference">
				<xsl:with-param name="signature">
					<xsl:value-of select="$archsig"/>
					<xsl:text>.</xsl:text>
					<xsl:number/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<!-- $aktenbildner -->
		<xsl:variable name="aktenbildner">
			<xsl:choose>
				<xsl:when test="$creator">
					<xsl:value-of select="$creator"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>agent_</xsl:text>
					<xsl:value-of select="generate-id(arelda:provenienz/arelda:aktenbildnerName)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- $ablieferndeStelle -->
		<xsl:variable name="ablieferndeStelle">
			<xsl:choose>
				<xsl:when test="$submissionbody">
					<xsl:value-of select="$submissionbody"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>agent_</xsl:text>
					<xsl:value-of select="generate-id(arelda:ablieferndeStelle)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!--   -->
		<!-- rico:RecordSet Fonds -->
		<xsl:element name="rdf:Description">
			<xsl:attribute name="rdf:about"><xsl:value-of select="$signature"/></xsl:attribute>
			<!-- label -->
			<xsl:element name="rdfs:label">
				<xsl:attribute name="xml:lang">en</xsl:attribute>
				<xsl:text>Fonds</xsl:text>
			</xsl:element>
			<!-- Record Set -->
			<xsl:element name="rdf:type">
				<xsl:attribute name="rdf:resource">https://www.ica.org/standards/RiC/ontology#RecordSet</xsl:attribute>
			</xsl:element>
			<!--   -->
			<!-- 3.1.4 Verzeichnungsstufe -->
			<!-- RecordSet Type -->
			<xsl:element name="rico:hasRecordSetType">
				<xsl:attribute name="rdf:resource">https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#Fonds</xsl:attribute>
			</xsl:element>
			<!--   -->
			<!-- 3.1.1 Signatur -->
			<!-- identifier -->
			<xsl:element name="rico:identifier">
				<xsl:value-of select="$signature"/>
			</xsl:element>
			<!--   -->
			<!-- 3.1.2 Titel -->
			<!-- title -->
			<xsl:variable name="title">
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
			</xsl:variable>
			<xsl:element name="rico:title">
				<xsl:attribute name="xml:lang"><xsl:value-of select="$lang"/></xsl:attribute>
				<xsl:value-of select="$title"/>
			</xsl:element>
			<!--   -->
			<!-- 3.1.3 Entstehungszeitraum / Laufzeit -->
			<!-- beginningDate - endDate -->
			<xsl:choose>
				<xsl:when test="arelda:entstehungszeitraum">
					<xsl:call-template name="RICdate">
						<xsl:with-param name="range" select="arelda:entstehungszeitraum"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="arelda:ordnungssystem/arelda:anwendungszeitraum">
					<xsl:call-template name="RICdate">
						<xsl:with-param name="range" select="arelda:ordnungssystem/arelda:anwendungszeitraum"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
			<!--   -->
			<!-- 3.1.5 Umfang (Menge und Abmessung) -->
			<!--   -->
			<!-- 3.2.1 Name der Provenienzstelle -->
			<!-- has Provenance -->
			<xsl:if test="arelda:provenienz/arelda:aktenbildnerName/text()">
				<xsl:element name="rico:hasProvenance">
					<xsl:attribute name="rdf:resource"><xsl:value-of select="$aktenbildner"/></xsl:attribute>
				</xsl:element>
			</xsl:if>
			<!--   -->
			<!-- 3.2.2 Verwaltungsgeschichte / Biographische Angaben 
			<xsl:if test="arelda:provenienz/arelda:geschichteAktenbildner/text()">
				<xsl:element name="adminBioHistory">
					<xsl:value-of select="arelda:provenienz/arelda:geschichteAktenbildner"/>
				</xsl:element>
			</xsl:if>
			-->
			<!--   -->
			<!-- 3.2.3 Bestandesgeschichte 
			<xsl:if test="arelda:provenienz/arelda:systemBeschreibung/text()">
				<xsl:element name="archivalHistory">
					<xsl:value-of select="arelda:provenienz/arelda:systemBeschreibung/text()"/>
				</xsl:element>
			</xsl:if>
			-->
			<!--   -->
			<!-- 3.2.4 Abgebende Stelle -->
			<xsl:if test="arelda:ablieferndeStelle/text()">
				<xsl:element name="rico:createdBy">
					<xsl:attribute name="rdf:resource"><xsl:value-of select="$ablieferndeStelle"/></xsl:attribute>
				</xsl:element>
			</xsl:if>
			<!--   -->
			<!-- 3.3.1 Form und Inhalt 
			<xsl:if test="arelda:ablieferungsteile/text()">
				<xsl:element name="scopeContent">
					<xsl:element name="content">
						<xsl:value-of select="arelda:ablieferungsteile"/>
					</xsl:element>
				</xsl:element>
			</xsl:if>
			-->
			<!--   -->
			<!-- 3.3.2 Bewertung und Kassation 
			<xsl:if test="arelda:referenzBewertungsentscheid/text()">
				<xsl:element name="appraisalDestruction">
					<xsl:value-of select="arelda:referenzBewertungsentscheid"/>
				</xsl:element>
			</xsl:if>
			-->
			<!--   -->
			<!-- 3.4.1 Zugangsbestimmungen -->
			<!--   -->
			<!-- 3.4.4 Physische Beschaffenheit und technische Anforderungen -->
			<!--   -->
			<!-- 3.6.1 Allgemeine Anmerkungen -->
			<xsl:if test="arelda:bemerkung/text()">
				<xsl:element name="rico:descriptiveNote">
					<xsl:value-of select="arelda:bemerkung"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="arelda:provenienz/arelda:bemerkung/text()">
				<xsl:element name="rico:descriptiveNote">
					<xsl:value-of select="arelda:provenienz/arelda:bemerkung"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="arelda:ordnungssystem/arelda:bemerkung/text()">
				<xsl:element name="rico:descriptiveNote">
					<xsl:value-of select="arelda:ordnungssystem/arelda:bemerkung"/>
				</xsl:element>
			</xsl:if>
			<!--   -->
			<!-- included In-->
			<xsl:element name="rico:includedIn">
				<xsl:attribute name="rdf:resource"><xsl:call-template name="RICreference"><xsl:with-param name="signature"><xsl:value-of select="$archsig"/></xsl:with-param></xsl:call-template></xsl:attribute>
			</xsl:element>
			<!-- includes -->
			<xsl:for-each select="arelda:ordnungssystem/arelda:ordnungssystemposition">
				<xsl:element name="rico:includes">
					<xsl:attribute name="rdf:resource"><xsl:call-template name="RICreference"><xsl:with-param name="signature"><xsl:value-of select="$signature"/><xsl:text>.</xsl:text><xsl:number/></xsl:with-param></xsl:call-template></xsl:attribute>
				</xsl:element>
			</xsl:for-each>
			<!--   -->
		</xsl:element>
		<!--   -->
		<!-- Agents -->
		<!-- 3.2.1 Name der Provenienzstelle -->
		<xsl:element name="rdf:Description">
			<xsl:attribute name="rdf:about"><xsl:value-of select="$aktenbildner"/></xsl:attribute>
			<!-- label -->
			<xsl:element name="rdfs:label">
				<xsl:attribute name="xml:lang">en</xsl:attribute>
				<xsl:text>Creator</xsl:text>
			</xsl:element>
			<!-- describes -->
			<xsl:element name="rico:describes">
				<xsl:attribute name="xml:lang">en</xsl:attribute>
				<xsl:text>creator</xsl:text>
			</xsl:element>
			<!-- Provenance Of -->
			<xsl:element name="rico:isProvenanceOf">
				<xsl:value-of select="$signature"/>
			</xsl:element>
			<!-- Corporate Body -->
			<xsl:element name="rdf:type">
				<xsl:attribute name="rdf:resource">https://www.ica.org/standards/RiC/ontology#CorporateBody</xsl:attribute>
			</xsl:element>
			<!-- name -->
			<xsl:if test="arelda:provenienz/arelda:aktenbildnerName/text()">
				<xsl:element name="rico:name">
					<xsl:attribute name="xml:lang"><xsl:value-of select="$lang"/></xsl:attribute>
					<xsl:value-of select="arelda:provenienz/arelda:aktenbildnerName"/>
				</xsl:element>
			</xsl:if>
		</xsl:element>
		<!--   -->
		<!-- 3.2.4 Abgebende Stelle -->
		<xsl:element name="rdf:Description">
			<xsl:attribute name="rdf:about"><xsl:value-of select="$ablieferndeStelle"/></xsl:attribute>
			<!-- label -->
			<xsl:element name="rdfs:label">
				<xsl:attribute name="xml:lang">en</xsl:attribute>
				<xsl:text>Submission Body</xsl:text>
			</xsl:element>
			<!-- describes -->
			<xsl:element name="rico:describes">
				<xsl:attribute name="xml:lang">en</xsl:attribute>
				<xsl:text>submission body</xsl:text>
			</xsl:element>
			<!-- Creator Of -->
			<xsl:element name="rico:isCreatorOf">
				<xsl:value-of select="$signature"/>
			</xsl:element>
			<!-- Corporate Body -->
			<xsl:element name="rdf:type">
				<xsl:attribute name="rdf:resource">https://www.ica.org/standards/RiC/ontology#CorporateBody</xsl:attribute>
			</xsl:element>
			<!-- name -->
			<xsl:if test="arelda:ablieferndeStelle/text()">
				<xsl:element name="rico:name">
					<xsl:attribute name="xml:lang"><xsl:value-of select="$lang"/></xsl:attribute>
					<xsl:value-of select="arelda:ablieferndeStelle"/>
				</xsl:element>
				<xsl:element name="dcterms:creator">
					<xsl:attribute name="xml:lang"><xsl:value-of select="$lang"/></xsl:attribute>
					<xsl:value-of select="arelda:ablieferndeStelle"/>
				</xsl:element>
			</xsl:if>
		</xsl:element>
		<!--   -->
		<!-- Call: Ordnungsystem -->
		<xsl:apply-templates select="arelda:ordnungssystem"/>
	</xsl:template>
	<!--   -->
	<!-- Call: Ordnungsystemposition -->
	<xsl:template match="arelda:ordnungssystem">
		<xsl:apply-templates select="arelda:ordnungssystemposition">
			<xsl:with-param name="sig">
				<xsl:value-of select="$archsig"/>
				<xsl:text>.</xsl:text>
				<xsl:number/>
			</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>
	<!--   -->
</xsl:stylesheet>
