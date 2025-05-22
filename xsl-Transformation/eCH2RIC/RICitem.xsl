<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:rico="https://www.ica.org/standards/RiC/ontology#" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!--   -->
	<!-- Item ++++++++++++++++++++ type GEVER ++++++++++++++++++++++++++++++++ -->
	<xsl:template match="arelda:dokument">
		<xsl:param name="sig"/>
		<!-- $signature -->
		<xsl:variable name="signature">
			<xsl:call-template name="RICreference">
				<xsl:with-param name="signature">
					<xsl:value-of select="$sig"/>
					<xsl:text>_</xsl:text>
					<xsl:number/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<!--   -->
		<!-- rico:Record Item -->
		<xsl:element name="rdf:Description">
			<xsl:attribute name="rdf:about"><xsl:value-of select="$signature"/></xsl:attribute>
			<!-- label -->
			<xsl:element name="rdfs:label">
				<xsl:attribute name="xml:lang">en</xsl:attribute>
				<xsl:text>Item</xsl:text>
			</xsl:element>
			<!-- Record Set -->
			<xsl:element name="rdf:type">
				<xsl:attribute name="rdf:resource">https://www.ica.org/standards/RiC/ontology#Record</xsl:attribute>
			</xsl:element>
			<!--   -->
			<!-- 3.1.4 Verzeichnungsstufe -->
			<!-- RecordSet Type -->
			<xsl:element name="rico:hasRecordSetType">
				<xsl:attribute name="rdf:resource">https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#Item</xsl:attribute>
			</xsl:element>
			<!--   -->
			<!-- 3.1.1 Signatur -->
			<!-- identifier -->
			<xsl:element name="rico:identifier">
				<xsl:value-of select="$signature"/>
			</xsl:element>
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
			<!-- 3.1.3 Entstehungszeitraum / Registrierdatum -->
			<xsl:if test="arelda:registrierdatum/arelda:datum">
				<xsl:element name="dcterms:created">
					<xsl:value-of select="arelda:registrierdatum/arelda:datum"/>
				</xsl:element>
			</xsl:if>
			<!--   -->
			<!-- 3.1.5 Umfang (Menge und Abmessung) -->
			<!--   -->
			<!-- 3.2.1 Name der Provenienzstelle [Autor] -->
			<xsl:if test="arelda:autor/text()">
				<xsl:element name="dcterms:creator">
					<xsl:value-of select="arelda:autor"/>
				</xsl:element>
			</xsl:if>
			<!--   -->
			<!-- 3.2.2 Verwaltungsgeschichte / Biographische Angaben -->
			<!--   -->
			<!-- 3.2.3 Bestandesgeschichte -->
			<!--   -->
			<!-- 3.2.4 Abgebende Stelle -->
			<!--   -->
			<!-- 3.3.1 Form und Inhalt -->
			<!-- technical Characteristics -->
			<xsl:if test="arelda:dokumenttyp">
				<xsl:element name="rico:technicalCharacteristics">
					<xsl:value-of select="arelda:dokumenttyp/text()"/>
				</xsl:element>
			</xsl:if>
			<!--   -->
			<!-- 3.3.2 Bewertung und Kassation -->
			<!--   -->
			<!-- 3.4.1 Zugangsbestimmungen -->
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
				<xsl:attribute name="rdf:resource"><xsl:call-template name="RICreference"><xsl:with-param name="signature"><xsl:value-of select="$sig"/></xsl:with-param></xsl:call-template></xsl:attribute>
			</xsl:element>
			<!--   -->
			<!-- 1. Instantiation ++++++++++++++++++++++++++++++++ -->
			<xsl:element name="rico:hasInstantiation">
				<xsl:element name="rico:Instantiation">
					<xsl:attribute name="rdf:about"><xsl:value-of select="$signature"/><xsl:text>-i1</xsl:text></xsl:attribute>
					<!-- instantiates -->
					<xsl:element name="rico:instantiates">
						<xsl:attribute name="rdf:resource"><xsl:value-of select="$signature"/></xsl:attribute>
					</xsl:element>
					<!-- titel -->
					<xsl:element name="rico:title">
						<xsl:attribute name="xml:lang"><xsl:value-of select="$lang"/></xsl:attribute>
						<xsl:value-of select="arelda:titel"/>
					</xsl:element>
					<!-- entstehungszeitraum -->
					<xsl:if test="arelda:entstehungszeitraum">
						<xsl:call-template name="RICdate">
							<xsl:with-param name="range" select="arelda:entstehungszeitraum"/>
						</xsl:call-template>
					</xsl:if>
					<!-- dokumenttyp -->
					<xsl:if test="arelda:dokumenttyp">
						<xsl:element name="rico:technicalCharacteristics">
							<xsl:value-of select="arelda:dokumenttyp/text()"/>
						</xsl:element>
					</xsl:if>
					<!-- bemerkung -->
					<xsl:if test="arelda:bemerkung/text()">
						<xsl:element name="rico:descriptiveNote">
							<xsl:value-of select="arelda:bemerkung"/>
						</xsl:element>
					</xsl:if>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!-- Item ++++++++++++++++++++ type FILES +++++++++++++++++++++++++++++++++ -->
	<xsl:template match="arelda:dateiRef">
		<xsl:param name="sig"/>
		<!-- $signature -->
		<xsl:variable name="signature">
			<xsl:call-template name="RICreference">
				<xsl:with-param name="signature">
					<xsl:value-of select="$sig"/>
					<xsl:text>_</xsl:text>
					<xsl:number/>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<!-- $fileid -->
		<xsl:variable name="fileid">
			<xsl:value-of select="."/>
		</xsl:variable>
		<xsl:element name="rdf:Description">
			<xsl:attribute name="rdf:about"><xsl:value-of select="$signature"/></xsl:attribute>
			<!-- label -->
			<xsl:element name="rdfs:label">
				<xsl:attribute name="xml:lang">en</xsl:attribute>
				<xsl:text>Item</xsl:text>
			</xsl:element>
			<!-- Record Set -->
			<xsl:element name="rdf:type">
				<xsl:attribute name="rdf:resource">https://www.ica.org/standards/RiC/ontology#Record</xsl:attribute>
			</xsl:element>
			<!--   -->
			<!-- 3.1.4 Verzeichnungsstufe -->
			<!-- RecordSet Type -->
			<xsl:element name="rico:hasRecordSetType">
				<xsl:attribute name="rdf:resource">https://www.ica.org/standards/RiC/vocabularies/recordSetTypes#Item</xsl:attribute>
			</xsl:element>
			<!--   -->
			<!-- 3.1.1 Signatur -->
			<!-- identifier -->
			<xsl:element name="rico:identifier">
				<xsl:value-of select="$signature"/>
			</xsl:element>
			<!-- 3.1.2 Titel -->
			<!-- title -->
			<xsl:element name="rico:title">
				<xsl:attribute name="xml:lang"><xsl:value-of select="$lang"/></xsl:attribute>
				<xsl:choose>
					<xsl:when test="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:originalName">
						<xsl:value-of select="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:originalName/text()"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:name/text()"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
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
			<!-- 3.4.1 Zugangsbestimmungen -->
			<!-- 3.4.4 Physische Beschaffenheit und technische Anforderungen
			<xsl:element name="physTech">
				<xsl:choose>
					<xsl:when test="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]">
						<xsl:text>digital</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>not_defined</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
			 -->
			<!--   -->
			<!-- 3.6.1 Allgemeine Anmerkungen -->
			<xsl:if test="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:eigenschaft/text()">
				<xsl:element name="rico:descriptiveNote">
					<xsl:value-of select="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:eigenschaft/text()"/>
				</xsl:element>
			</xsl:if>
			<!--   -->
			<!-- included In-->
			<xsl:element name="rico:includedIn">
				<xsl:attribute name="rdf:resource"><xsl:call-template name="RICreference"><xsl:with-param name="signature"><xsl:value-of select="$sig"/></xsl:with-param></xsl:call-template></xsl:attribute>
			</xsl:element>
			<!--   -->
			<!-- 1. Instantiation ++++++++++++++++++++++++++++++++ -->
			<xsl:element name="rico:hasInstantiation">
				<xsl:element name="rico:Instantiation">
					<xsl:attribute name="rdf:about"><xsl:value-of select="$signature"/><xsl:text>-i1</xsl:text></xsl:attribute>
					<!-- instantiates -->
					<xsl:element name="rico:instantiates">
						<xsl:attribute name="rdf:resource"><xsl:value-of select="$signature"/></xsl:attribute>
					</xsl:element>
					<!-- title -->
					<xsl:element name="rico:title">
						<xsl:attribute name="xml:lang"><xsl:value-of select="$lang"/></xsl:attribute>
						<xsl:choose>
							<xsl:when test="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:originalName">
								<xsl:value-of select="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:originalName/text()"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:name/text()"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:element>
					<!-- eigenschaft -->
					<xsl:if test="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:eigenschaft/text()">
						<xsl:element name="rico:descriptiveNote">
							<xsl:value-of select="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:eigenschaft/text()"/>
						</xsl:element>
					</xsl:if>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
