<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="ISADG" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- named template xIaccess -->
	<xsl:template name="xIaccess">
		<xsl:param name="position"/>
		<xsl:element name="accessConditions">
			<xsl:if test="arelda:datenschutz">
				<xsl:element name="hasPrivacyProtection">
					<xsl:value-of select="arelda:datenschutz"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="arelda:oeffentlichkeitsstatus">
				<xsl:element name="openToThePublic">
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
			<xsl:if test="arelda:klassifizierungskategorie">
				<xsl:element name="classification">
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
			<xsl:if test="arelda:oeffentlichkeitsstatusBegruendung">
				<xsl:element name="otherAccessConditions">
					<xsl:value-of select="arelda:oeffentlichkeitsstatusBegruendung/text()"/>
				</xsl:element>
			</xsl:if>
			<xsl:if test="arelda:sonstigeBestimmungen">
				<xsl:element name="accessConditionsNotes">
					<xsl:value-of select="arelda:sonstigeBestimmungen/text()"/>
				</xsl:element>
			</xsl:if>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
