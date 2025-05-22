<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="ISADG" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- Ordnungsystemposition -->
	<xsl:template match="arelda:mappe">
		<xsl:param name="sig" />
		<xsl:param name="astyle"/>
		<xsl:variable name="signature">
			<xsl:value-of select="$sig" />
			<xsl:if test="$astyle='fortlaufend'">
			<xsl:text>.mappe</xsl:text>
			<xsl:number level="any"/>
			</xsl:if>
			<xsl:if test="$astyle='dezimal'">
			<xsl:text>.mappe</xsl:text>
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
					<xsl:attribute name="origin">//mappe/titel</xsl:attribute>
					<xsl:attribute name="obligation">mandatory</xsl:attribute>
					<xsl:value-of select="arelda:titel" />
				</xsl:element>
				<xsl:if test="arelda:eroeffnungsdatum">
					<xsl:call-template name="xI2date">
						<xsl:with-param name="range" select="arelda:eroeffnungsdatum" />
						<xsl:with-param name="orig">//mappe/eroeffnungsdatum</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<!--   -->
				<!-- 3.1.4 Verzeichnungsstufe -->
				<xsl:element name="descriptionLevel">
					<xsl:attribute name="isadId">1.4</xsl:attribute>
					<xsl:attribute name="origin">ingest</xsl:attribute>
					<xsl:attribute name="obligation">mandatory</xsl:attribute>
					<xsl:attribute name="nameOtherLevel">mappe</xsl:attribute>
					<xsl:text>other level</xsl:text>
				</xsl:element>
			</xsl:element>
			<!-- 3.2.1 Name der Provenienzstelle -->
			<!--   -->
			<!-- 3.2.2 Verwaltungsgeschichte / Biographische Angaben -->
			<!--   -->
			<!-- 3.2.3 Bestandesgeschichte -->
			<!--   -->
			<!-- 3.2.4 Abgebende Stelle -->
			<!--   -->
			<xsl:if test="arelda:formInhalt or arelda:inhalt or arelda:dateiRef">
				<xsl:element name="contentStructure">
					<xsl:attribute name="isadId">3</xsl:attribute>
					<!-- 3.3.1 Form und Inhalt -->
					<xsl:element name="scopeContent">
						<xsl:attribute name="isadId">3.1</xsl:attribute>
						<xsl:if test="arelda:inhalt">
							<xsl:element name="content">
								<xsl:attribute name="origin">//mappe/inhalt</xsl:attribute>
								<xsl:value-of select="arelda:inhalt/text()" />
							</xsl:element>
						</xsl:if>
					</xsl:element>

					<xsl:if test="local-name(.)='mappe'">
						<xsl:if test="@reihung">	
							<xsl:element name="arrangement">
								<xsl:attribute name="isadId">3.4</xsl:attribute>
								<xsl:element name="property">
									<xsl:attribute name="origin">//mappe</xsl:attribute>						
									<xsl:attribute name="key">reihung</xsl:attribute>
									<xsl:value-of select="@reihung" />			
							</xsl:element>
						</xsl:element>
						</xsl:if>
					</xsl:if>
					<!--  FILE SIP -->
					<xsl:apply-templates 
					select="arelda:dateiRef">
					<xsl:with-param name="sig" select="$signature" />
					</xsl:apply-templates>

					<!--   -->
					<!-- 3.3.2 Bewertung und Kassation -->
				</xsl:element>
			</xsl:if>
			<!--   -->
			<!--   -->
			<!-- 3.6.1 Allgemeine Anmerkungen -->
			<xsl:if test="arelda:bemerkung/text()">
				<xsl:element name="notes">
					<xsl:attribute name="isadId">6</xsl:attribute>
					<xsl:element name="note">
						<xsl:attribute name="isadId">6.1</xsl:attribute>
						<xsl:attribute name="origin">//mappe/bemerkung</xsl:attribute>
						<xsl:value-of select="arelda:bemerkung" />
					</xsl:element>
				</xsl:element>
			</xsl:if>
			<!-- additionalData -->
			<xsl:if test="arelda:zusatzDaten">
				<xsl:element name="additionalData">
					<xsl:element name="mdWrap">
						<!-- additionalData zusatzDaten -->
						<xsl:attribute name="type">content</xsl:attribute>
						<xsl:for-each select="arelda:zusatzDaten/arelda:merkmal">
							<xsl:element name="property">
								<xsl:attribute name="origin">//mappe/zusatzDaten/merkmal</xsl:attribute>
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

			<!--  GEVER SIP -->
			<xsl:apply-templates select="arelda:dokument">
				<xsl:with-param name="sig" select="$signature" />
				<xsl:with-param name="astyle" select="$astyle" />
			</xsl:apply-templates>
	
			<!-- There are three possible cases in eCH0160 v1.2
			A Binder is the Name of the otherLevel=mappe Element.
			GEVER: Binder/Mappe with file/dossier and document/item
			FILE:  Binder/Mappe with Ordnungssystemposition/series, Dossier/file and document/item
			FILE Ablieferung/fond: Binder/Mappe with Binder/Mappe and document/item 
		
			only document occurs in all three cases, threfore the existence of the other elements has to be checked separately-->

			<xsl:if test="arelda:dossier">
				<!--  Sub-mappe -->
				<xsl:apply-templates select="arelda:dossier">
					<xsl:with-param name="sig" select="$signature" />
					<xsl:with-param name="astyle" select="$astyle" />
				</xsl:apply-templates>
			</xsl:if>

			<xsl:if test="arelda:ordnungssystemposition">
				<!--  Sub-mappe -->
				<xsl:apply-templates select="arelda:ordnungssystemposition">
					<xsl:with-param name="sig" select="$signature" />
					<xsl:with-param name="astyle" select="$astyle" />
				</xsl:apply-templates>
			</xsl:if>

			<xsl:if test="arelda:mappe">
				<!--  Sub-mappe -->
				<xsl:apply-templates select="arelda:mappe">
					<xsl:with-param name="sig" select="$signature" />
					<xsl:with-param name="astyle" select="$astyle" />
				</xsl:apply-templates>
			</xsl:if>

		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
