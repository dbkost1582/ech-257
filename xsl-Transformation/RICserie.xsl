<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rico="https://www.ica.org/standards/RiC/ontology#" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!--   -->
	<!-- Ordnungsystemposition -->
	<xsl:template match="arelda:ordnungssystemposition">
		<xsl:param name="sig"/>
		<!-- $signature -->
		<xsl:variable name="signature">
			<xsl:call-template name="RICreference">
				<xsl:with-param name="signature">
					<xsl:value-of select="$sig"/>
					<xsl:text>.</xsl:text>
					<xsl:number/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<!--   -->
		<!-- rico:RecordSet Series -->
		<xsl:element name="rdf:Description">
			<xsl:attribute name="rdf:about"><xsl:value-of select="$signature"/></xsl:attribute>
			<!-- label -->
			<xsl:element name="rdfs:label">
				<xsl:attribute name="xml:lang">en</xsl:attribute>
				<xsl:text>Series</xsl:text>
			</xsl:element>
			<!-- Record Set -->
			<xsl:element name="rdf:type">
				<xsl:attribute name="rdf:resource">https://www.ica.org/standards/RiC/ontology#RecordSet</xsl:attribute>
			</xsl:element>
			<!--   -->
			<!-- 3.1.4 Verzeichnungsstufe -->
			<!-- RecordSet Type -->
			<xsl:element name="rico:hasRecordSetType">
				<xsl:attribute name="rdf:resource">https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#Series</xsl:attribute>
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
			<xsl:element name="rico:title">
				<xsl:attribute name="xml:lang"><xsl:value-of select="$lang"/></xsl:attribute>
				<xsl:value-of select="arelda:titel"/>
			</xsl:element>
			<!--   -->
			<!-- 3.1.3 Entstehungszeitraum / Laufzeit -->
			<!--   -->
			<!-- 3.1.5 Umfang (Menge und Abmessung) -->
			<!--   -->
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
			<!-- 3.4.1 Zugangsbestimmungen  -->
			<xsl:call-template name="RICaccess">
				<xsl:with-param name="position" select="."/>
			</xsl:call-template>
			<!--   -->
			<!-- 3.4.4 Physische Beschaffenheit und technische Anforderungen -->
			<!--   -->
			<!-- 3.6.1 Allgemeine Anmerkungen -->
			<!--   -->
			<!-- included In-->
			<xsl:element name="rico:includedIn">
				<xsl:attribute name="rdf:resource">
					<xsl:call-template name="RICreference">
						<xsl:with-param name="signature">
							<xsl:value-of select="$sig"/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:attribute>
			</xsl:element>
			<!-- includes Series-->
			<xsl:for-each select="arelda:ordnungssystemposition">
				<xsl:element name="rico:includes">
					<xsl:attribute name="rdf:resource">
						<xsl:call-template name="RICreference">
							<xsl:with-param name="signature">
								<xsl:value-of select="$signature"/>
								<xsl:text>.</xsl:text>
								<xsl:number/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
				</xsl:element>
			</xsl:for-each>
			<!-- includes Files -->
			<xsl:for-each select="arelda:dossier">
				<xsl:element name="rico:includes">
					<xsl:attribute name="rdf:resource">
						<xsl:call-template name="RICreference">
							<xsl:with-param name="signature">
								<xsl:value-of select="$signature"/>
								<xsl:text>.</xsl:text>
								<xsl:number/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
				</xsl:element>
			</xsl:for-each>
		<!--   -->
		</xsl:element>
		<!--   -->
		<!-- Call: Ordnungsystemposition rekursiv -->
		<xsl:apply-templates select="arelda:ordnungssystemposition">
			<xsl:with-param name="sig">
				<xsl:value-of select="$sig"/>
				<xsl:text>.</xsl:text>
				<xsl:number/>
			</xsl:with-param>
		</xsl:apply-templates>
		<!--   -->
		<!-- Call: Dossier -->
		<xsl:apply-templates select="arelda:dossier">
			<xsl:with-param name="sig">
				<xsl:value-of select="$sig"/>
				<xsl:text>.</xsl:text>
				<xsl:number/>
			</xsl:with-param>
		</xsl:apply-templates>
		<!--   -->
	</xsl:template>
</xsl:stylesheet>
