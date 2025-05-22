<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rico="https://www.ica.org/standards/RiC/ontology#" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!--   -->
	<!-- Dossier -->
	<xsl:template match="arelda:dossier">
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
		<!-- rico:RecordSet File -->
		<xsl:element name="rdf:Description">
			<xsl:attribute name="rdf:about"><xsl:value-of select="$signature"/></xsl:attribute>
			<!-- label -->
			<xsl:element name="rdfs:label">
				<xsl:attribute name="xml:lang">en</xsl:attribute>
				<xsl:text>File</xsl:text>
			</xsl:element>
			<!-- Record Set -->
			<xsl:element name="rdf:type">
				<xsl:attribute name="rdf:resource">https://www.ica.org/standards/RiC/ontology#RecordSet</xsl:attribute>
			</xsl:element>
			<!--   -->
			<!-- 3.1.4 Verzeichnungsstufe -->
			<!-- RecordSet Type -->
			<xsl:element name="rico:hasRecordSetType">
				<xsl:attribute name="rdf:resource">https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#File</xsl:attribute>
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
			<xsl:if test="arelda:entstehungszeitraum">
				<xsl:call-template name="RICdate">
					<xsl:with-param name="range" select="arelda:entstehungszeitraum"/>
				</xsl:call-template>
			</xsl:if>
			<!--   -->
			<!-- 3.1.5 Umfang (Menge und Abmessung)
			<xsl:if test="arelda:umfang/text()">
				<xsl:element name="extentMedium">
					<xsl:element name="medium">
						<xsl:value-of select="arelda:umfang/text()"/>
					</xsl:element>
				</xsl:element>
			</xsl:if>
			 -->
			<!--   -->
			<!-- 3.2.1 Name der Provenienzstelle -->
			<!--   -->
			<!-- 3.2.2 Verwaltungsgeschichte / Biographische Angaben -->
			<!--   -->
			<!-- 3.2.3 Bestandesgeschichte
			<xsl:if test="arelda:zusatzmerkmal/text()">
				<xsl:element name="archivalHistory">
					<xsl:value-of select="arelda:zusatzmerkmal/text()"/>
				</xsl:element>
			</xsl:if>
			 -->
			<!--   -->
			<!-- 3.2.4 Abgebende Stelle -->
			<!--   -->
			<!-- 3.3.1 Form und Inhalt
			<xsl:if test="arelda:formInhalt or arelda:Inhalt">
				<xsl:element name="scopeContent">
					<xsl:if test="arelda:formInhalt">
						<xsl:element name="scope">
							<xsl:choose>
								<xsl:when test="arelda:formInhalt/text()='Fotos'">
									<xsl:text>image</xsl:text>
								</xsl:when>
								<xsl:when test="arelda:formInhalt/text()='Film'">
									<xsl:text>video</xsl:text>
								</xsl:when>
								<xsl:when test="arelda:formInhalt/text()='Video'">
									<xsl:text>video</xsl:text>
								</xsl:when>
								<xsl:when test="arelda:formInhalt/text()='Datenbanken'">
									<xsl:text>structured_data</xsl:text>
								</xsl:when>
								<xsl:when test="arelda:formInhalt/text()='Tondokumente'">
									<xsl:text>audio</xsl:text>
								</xsl:when>
								<xsl:when test="arelda:formInhalt/text()='schriftliche Unterlagen'">
									<xsl:text>text</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>hybrid</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:element>
					</xsl:if>
					<xsl:if test="arelda:Inhalt">
						<xsl:element name="content">
							<xsl:value-of select="arelda:Inhalt/text()"/>
						</xsl:element>
					</xsl:if>
				</xsl:element>
			</xsl:if>
			 -->
			<!--   -->
			<!-- 3.3.2 Bewertung und Kassation -->
			<!--   -->
			<!-- 3.4.1 Zugangsbestimmungen  -->
			<xsl:call-template name="RICaccess">
				<xsl:with-param name="position" select="."/>
			</xsl:call-template>
			<!--   -->
			<!-- 3.4.4 Physische Beschaffenheit und technische Anforderungen -->
			<xsl:if test="arelda:erscheinungsform">
				<xsl:element name="rico:hasRepresentationType">
					<xsl:attribute name="xml:lang">en</xsl:attribute>
					<xsl:choose>
						<xsl:when test="arelda:erscheinungsform/text()='digital'">
							<xsl:text>digital</xsl:text>
						</xsl:when>
						<xsl:when test="arelda:erscheinungsform/text()='nicht digital'">
							<xsl:text>analog</xsl:text>
						</xsl:when>
						<xsl:when test="arelda:erscheinungsform/text()='gemischt'">
							<xsl:text>hybrid</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>not_defined</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
			</xsl:if>
			<!--   -->
			<!-- 3.6.1 Allgemeine Anmerkungen -->
			<xsl:if test="arelda:bemerkung/text()">
				<xsl:element name="rico:descriptiveNote">
					<xsl:value-of select="arelda:bemerkung"/>
				</xsl:element>
			</xsl:if>
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
			<!-- includes GEVER Item -->
			<xsl:for-each select="arelda:dokument">
				<xsl:element name="rico:includes">
					<xsl:attribute name="rdf:resource">
						<xsl:call-template name="RICreference">
							<xsl:with-param name="signature">
								<xsl:value-of select="$signature"/>
								<xsl:text>_</xsl:text>
								<xsl:number/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
				</xsl:element>
			</xsl:for-each>
			<!-- includes FILES Item -->
			<xsl:for-each select="arelda:dateiRef">
				<xsl:element name="rico:includes">
					<xsl:attribute name="rdf:resource">
						<xsl:call-template name="RICreference">
							<xsl:with-param name="signature">
								<xsl:value-of select="$signature"/>
								<xsl:text>_</xsl:text>
								<xsl:number/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
				</xsl:element>
			</xsl:for-each>
			<!-- includes Sub Files -->
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
		<!--  GEVER SIP -->
			<xsl:apply-templates select="arelda:dokument">
			<xsl:with-param name="sig">
				<xsl:value-of select="$sig"/>
				<xsl:text>.</xsl:text>
				<xsl:number/>
			</xsl:with-param>
			</xsl:apply-templates>
		<!--  FILE SIP -->
			<xsl:apply-templates select="arelda:dateiRef">
			<xsl:with-param name="sig">
				<xsl:value-of select="$sig"/>
				<xsl:text>.</xsl:text>
				<xsl:number/>
			</xsl:with-param>
			</xsl:apply-templates>
		<!--
			<xsl:apply-templates select="arelda:dateiRef">
				<xsl:with-param name="sig" select="$signature"/>
			</xsl:apply-templates>
			 -->
		<!-- Call: Sug-Dossier -->
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
