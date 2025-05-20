<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="urn:isbn:1-931666-22-9" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- named template EADaccess -->
	<xsl:template name="EADaccess">
		<xsl:param name="position"/>
		<xsl:if test="arelda:datenschutz or arelda:oeffentlichkeitsstatus or arelda:klassifizierungskategorie or arelda:oeffentlichkeitsstatusBegruendung or arelda:sonstigeBestimmungen">
			<xsl:element name="accessrestrict">
				<xsl:attribute name="type">restrict</xsl:attribute>
				<xsl:element name="list">
					<!-- Datenschutz -->
					<xsl:if test="arelda:datenschutz">
						<xsl:element name="defitem">
							<xsl:element name="label">hasPrivacyProtection</xsl:element>
							<xsl:element name="item">
								<xsl:value-of select="arelda:datenschutz"/>
							</xsl:element>
						</xsl:element>
					</xsl:if>
					<!-- Öffentlichkeitsstatus -->
					<xsl:if test="arelda:oeffentlichkeitsstatus">
						<xsl:element name="defitem">
							<xsl:element name="label">openToThePublic</xsl:element>
							<xsl:element name="item">
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
						</xsl:element>
					</xsl:if>
					<!-- Klassifizierung -->
					<xsl:if test="arelda:klassifizierungskategorie">
						<xsl:element name="defitem">
							<xsl:element name="label">classification</xsl:element>
							<xsl:element name="item">
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
						</xsl:element>
					</xsl:if>
					<!-- Begründung -->
					<xsl:if test="arelda:oeffentlichkeitsstatusBegruendung">
						<xsl:element name="defitem">
							<xsl:element name="label">otherAccessConditions</xsl:element>
							<xsl:element name="item">
								<xsl:value-of select="arelda:oeffentlichkeitsstatusBegruendung/text()"/>
							</xsl:element>
						</xsl:element>
					</xsl:if>
					<!-- sonstige Bestimmungen -->
					<xsl:if test="arelda:sonstigeBestimmungen">
						<xsl:element name="defitem">
							<xsl:element name="label">accessConditionsNotes</xsl:element>
							<xsl:element name="item">
								<xsl:value-of select="arelda:sonstigeBestimmungen/text()"/>
							</xsl:element>
						</xsl:element>
					</xsl:if>
				</xsl:element>
			</xsl:element>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
