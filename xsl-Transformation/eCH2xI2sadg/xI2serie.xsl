<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="ISADG" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- Ordnungsystemposition -->
	<xsl:template match="arelda:ordnungssystemposition">
		<xsl:param name="sig" />
		<xsl:param name="astyle" />
		<xsl:variable name="signature">
			<xsl:value-of select="$sig" />
			<xsl:if test="$astyle='fortlaufend'">
			<xsl:text>.ordnungssystemposition</xsl:text>
			<xsl:number level="any"/>
			</xsl:if>
			<xsl:if test="$astyle='dezimal'">
			<xsl:text>.ordnungssystemposition</xsl:text>
			<xsl:number level="single"/>
			</xsl:if>	
		</xsl:variable>
		<xsl:element name="archivalDescription">
			<xsl:element name="identity">
				<xsl:attribute name="isadId">1</xsl:attribute>
				<!-- 3.1.1 Signatur -->
				<xsl:call-template name="xI2reference">
					<xsl:with-param name="signature" select="$signature" />
				</xsl:call-template>
				<!-- 3.1.2 Titel -->
				<xsl:element name="title">
					<xsl:attribute name="isadId">1.2</xsl:attribute>
					<xsl:attribute name="origin">//ordnungssystemposition/titel</xsl:attribute>
					<xsl:attribute name="obligation">mandatory</xsl:attribute>
					<xsl:value-of select="arelda:titel" />
				</xsl:element>
				<!-- 3.1.3 Entstehungszeitraum / Laufzeit -->
				<!--   -->
				<!-- 3.1.4 Verzeichnungsstufe -->
				<xsl:element name="descriptionLevel">
					<xsl:attribute name="isadId">1.4</xsl:attribute>
					<xsl:attribute name="origin">ingest</xsl:attribute>
					<xsl:attribute name="obligation">mandatory</xsl:attribute>
					<xsl:text>series</xsl:text>
				</xsl:element>
				<!-- 3.1.5 Umfang (Menge und Abmessung) -->
				<!--   -->
			</xsl:element>
			<!-- 3.2.1 Name der Provenienzstelle -->
			<xsl:if test="arelda:federfuehrendeOrganisationseinheit/text()">
				<xsl:element name="context">
					<xsl:attribute name="isadId">2</xsl:attribute>
					<xsl:element name="creator">
						<xsl:attribute name="isadId">2.1</xsl:attribute>
						<xsl:attribute name="origin">//ordnungssystemposition/federfuehrendeOrganisationseinheit</xsl:attribute>
						<xsl:value-of select="arelda:federfuehrendeOrganisationseinheit" />
					</xsl:element>
				</xsl:element>
			</xsl:if>
			<!--   -->
			<!-- 3.2.2 Verwaltungsgeschichte / Biographische Angaben -->
			<!--   -->
			<!-- 3.2.3 Bestandesgeschichte -->
			<!--   -->
			<!-- 3.2.4 Abgebende Stelle -->
			<!-- 3.3.1 Form und Inhalt -->

			<xsl:if test="local-name(.)='ordnungssystemposition'">
				<xsl:if test="@reihung">
					<xsl:element name="contentStructure">
						<xsl:element name="arrangement">
							<xsl:attribute name="isadId">3.4</xsl:attribute>
							<xsl:element name="property">
								<xsl:attribute name="origin">//ordnungssystemposition</xsl:attribute>
									<xsl:attribute name="key">reihung</xsl:attribute>
									<xsl:value-of select="@reihung" />
							</xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:if>
			</xsl:if>
			<!--   -->
			<!-- 3.3.2 Bewertung und Kassation -->

			<!--   -->
			<!-- 3.3.2 Bewertung und Kassation -->
			<!--   -->
			<!-- 3.4 Zugangs- und Benutzungsbedingungen -->
			<xsl:call-template name="xI2access">
				<!-- 3.4.1 Zugangsbestimmungen -->
				<!-- 3.4.4 Physische Beschaffenheit und technische Anforderungen -->
				<xsl:with-param name="orig">//ordnungssystemposition</xsl:with-param>
			</xsl:call-template>
			<!--   -->
			<!-- 3.6.1 Allgemeine Anmerkungen -->
			<!--   -->
			<!-- additionalReference -->
			<xsl:if test="arelda:nummer/text()">
				<xsl:element name="additionalReference">
					<xsl:element name="recordReference">
						<xsl:attribute name="origin">//ordnungssystemposition/nummer</xsl:attribute>
						<xsl:value-of select="arelda:nummer" />
					</xsl:element>
				</xsl:element>
			</xsl:if>
			<!-- additionalData -->
			<xsl:if test="arelda:zusatzDaten">
				<xsl:element name="additionalData">
					<xsl:element name="mdWrap">
						<xsl:attribute name="type">content</xsl:attribute>
						<!-- additionalData zusatzDaten -->
						<xsl:for-each select="arelda:zusatzDaten/arelda:merkmal">
							<xsl:element name="property">
								<xsl:attribute name="origin">//ordnungssystemposition/zusatzDaten/merkmal</xsl:attribute>
								<xsl:attribute name="key">
									<xsl:value-of select="./@name" />
								</xsl:attribute>
								<xsl:value-of select="./text()" />
							</xsl:element>
						</xsl:for-each>
					</xsl:element>
					<xsl:element name="mdWrap"><!-- additionalData zusatzDaten, content -->
						<xsl:attribute name="type">vendor</xsl:attribute>
							<xsl:element name="property">
								<xsl:attribute name="origin">ingest</xsl:attribute>
									<xsl:attribute name="key">
										<xsl:text>vendor example key</xsl:text>
									</xsl:attribute>
								<xsl:text>vendor example value</xsl:text>
							</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:if>
			<!--   -->
			<xsl:apply-templates select="arelda:ordnungssystemposition">
				<xsl:with-param name="sig" select="$signature" />
				<xsl:with-param name="astyle" select="$astyle" />
			</xsl:apply-templates>
			<xsl:apply-templates select="arelda:mappe">
				<xsl:with-param name="sig" select="$signature" />
				<xsl:with-param name="astyle" select="$astyle" />
			</xsl:apply-templates>
			<xsl:apply-templates select="arelda:dossier">
				<xsl:with-param name="sig" select="$signature" />
				<xsl:with-param name="astyle" select="$astyle" />
			</xsl:apply-templates>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
