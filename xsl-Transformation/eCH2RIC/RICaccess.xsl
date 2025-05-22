<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rico="https://www.ica.org/standards/RiC/ontology#"
		xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- named template RICaccess -->
	<xsl:template name="RICaccess">
		<xsl:param name="position"/>
		<!-- 3.4.1 Zugangsbestimmungen -->
		<!-- Datenschutz -->
		<xsl:if test="arelda:datenschutz/text()='true'">
			<xsl:element name="rico:conditionsOfUse">
				<xsl:attribute name="xml:lang">en</xsl:attribute>
				<xsl:text>protected</xsl:text>
			</xsl:element>
		</xsl:if>
		<!-- Öffentlichkeitsstatus -->
		<xsl:if test="arelda:oeffentlichkeitsstatus">
			<xsl:element name="rico:conditionsOfAccess">
				<xsl:attribute name="xml:lang">en</xsl:attribute>
				<xsl:choose>
					<xsl:when test="arelda:oeffentlichkeitsstatus/text()='einsehbar' or arelda:oeffentlichkeitsstatus/text()='accessible'">
						<xsl:text>public</xsl:text>
					</xsl:when>
					<xsl:when test="arelda:oeffentlichkeitsstatus/text()='nicht einsehbar' or arelda:oeffentlichkeitsstatus/text()='not accessible'">
						<xsl:text>not public</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>undefined</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
		<!-- Öffentlichkeitsstatus Begruendung -->
		<xsl:if test="arelda:oeffentlichkeitsstatusBegruendung">
			<xsl:element name="rico:conditionsOfAccess">
				<xsl:attribute name="xml:lang"><xsl:value-of select="$lang"/></xsl:attribute>
				<xsl:value-of select="arelda:oeffentlichkeitsstatusBegruendung/text()"/>
			</xsl:element>
		</xsl:if>
		<!-- Klassifizierungskategorie -->
		<xsl:if test="arelda:klassifizierungskategorie">
			<xsl:element name="rico:classification">
				<xsl:attribute name="xml:lang">en</xsl:attribute>
				<xsl:choose>
					<xsl:when test="arelda:klassifizierungskategorie/text()='geheim'">
						<xsl:text>secret</xsl:text>
					</xsl:when>
					<xsl:when test="arelda:klassifizierungskategorie/text()='vertraulich'">
						<xsl:text>confidential</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>unclassified</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
		<!-- sonstige Bestimmungen -->
		<xsl:if test="arelda:sonstigeBestimmungen">
			<xsl:element name="rico:descriptiveNote">
				<xsl:value-of select="arelda:sonstigeBestimmungen/text()"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
