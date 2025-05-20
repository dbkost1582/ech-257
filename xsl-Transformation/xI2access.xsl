<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="ISADG" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- named template xI2access -->
	<xsl:template name="xI2access">
		<xsl:param name="orig" />
		<!--   -->
		<!-- 3.4 Zugangs- und Benutzungsbedingungen -->
		<xsl:if test="arelda:datenschutz or arelda:oeffentlichkeitsstatus or arelda:klassifizierungskategorie or arelda:oeffentlichkeitsstatusBegruendung or arelda:sonstigeBestimmungen or arelda:schutzfrist or arelda:schutzfristenkategorie or arelda:referenzSchutzfristenFormular or arelda:schutzfristenBegruendung or arelda:erscheinungsform">
			<xsl:element name="conditionsAccessUse">
				<xsl:attribute name="isadId">4</xsl:attribute>
				<xsl:if test="arelda:datenschutz or arelda:oeffentlichkeitsstatus or arelda:klassifizierungskategorie or arelda:oeffentlichkeitsstatusBegruendung or arelda:sonstigeBestimmungen or arelda:schutzfrist or arelda:schutzfristenkategorie or arelda:referenzSchutzfristenFormular or arelda:schutzfristenBegruendung">
					<!-- 3.4.1 Zugangsbestimmungen -->
					<xsl:element name="accessConditions">
						<xsl:attribute name="isadId">4.1</xsl:attribute>
						<!--   -->
						<xsl:if test="arelda:datenschutz">
							<xsl:element name="hasPrivacyProtection">
								<xsl:attribute name="origin">
									<xsl:value-of select="$orig" />
									<xsl:text>/datenschutz</xsl:text>
								</xsl:attribute>
								<xsl:value-of select="arelda:datenschutz" />
							</xsl:element>
						</xsl:if>
						<!--   -->
						<xsl:if test="arelda:oeffentlichkeitsstatus">
							<xsl:element name="openToThePublic">
								<xsl:attribute name="origin">
									<xsl:value-of select="$orig" />
									<xsl:text>/oeffentlichkeitsstatus</xsl:text>
								</xsl:attribute>
								<xsl:choose>
									<xsl:when test="arelda:oeffentlichkeitsstatus/text()='einsehbar' or arelda:oeffentlichkeitsstatus/text()='accessible'">
										<xsl:text>public</xsl:text>
									</xsl:when>
									<xsl:when test="arelda:oeffentlichkeitsstatus/text()='nicht einsehbar' or arelda:oeffentlichkeitsstatus/text()='not accessible'">
										<xsl:text>not public</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>other:</xsl:text> <xsl:value-of select="arelda:oeffentlichkeitsstatus/text()" />
									</xsl:otherwise>
								</xsl:choose>
							</xsl:element>
						</xsl:if>
						<!--   -->
						<xsl:if test="arelda:klassifizierungskategorie">
							<xsl:element name="classification">
								<xsl:attribute name="origin">
									<xsl:value-of select="$orig" />
									<xsl:text>/klassifizierungskategorie</xsl:text>
								</xsl:attribute>
								<xsl:choose>
									<xsl:when test="arelda:klassifizierungskategorie/text()='geheim'or arelda:klassifizierungskategorie/text()='streng vertraulich'">
										<xsl:text>secret</xsl:text>
									</xsl:when>
									<xsl:when test="arelda:klassifizierungskategorie/text()='vertraulich'">
										<xsl:text>confidential</xsl:text>
									</xsl:when>
									<xsl:when test="arelda:klassifizierungskategorie/text()='interner gebrauch' or arelda:klassifizierungskategorie/text()='Interner Gebrauch' or arelda:klassifizierungskategorie/text()='interner Gebrauch'">
										<xsl:text>in_house</xsl:text>
									</xsl:when>
									<xsl:when test="arelda:klassifizierungskategorie/text()='nur für hausinternen gebrauch' or arelda:klassifizierungskategorie/text()='Nur für hausinternen Gebrauch'or arelda:klassifizierungskategorie/text()='nur für hausinternen Gebrauch'">
									<xsl:text>in_house</xsl:text>
									</xsl:when>
									<xsl:when test="arelda:klassifizierungskategorie/text()='nur fuer hausinternen gebrauch' or arelda:klassifizierungskategorie/text()='Nur fuer hausinternen Gebrauch' or arelda:klassifizierungskategorie/text()='nur fuer hausinternen Gebrauch'">
									<xsl:text>in_house</xsl:text>
									</xsl:when>
									<xsl:when test="arelda:klassifizierungskategorie/text()='intern'">
									<xsl:text>in_house</xsl:text>
									</xsl:when>
									<xsl:when test="arelda:klassifizierungskategorie/text()='nicht klassifiziert'">
										<xsl:text>unclassified</xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>other:</xsl:text> <xsl:value-of select="arelda:klassifizierungskategorie/text()" />
									</xsl:otherwise>
								</xsl:choose>
							</xsl:element>
						</xsl:if>

						<!--   -->
						<xsl:if test="arelda:oeffentlichkeitsstatusBegruendung">
							<xsl:element name="otherAccessConditions">
								<xsl:attribute name="origin">
									<xsl:value-of select="$orig" />
									<xsl:text>/oeffentlichkeitsstatusBegruendung</xsl:text>
								</xsl:attribute>
								<xsl:value-of select="arelda:oeffentlichkeitsstatusBegruendung/text()" />
							</xsl:element>
						</xsl:if>
						<!--   -->
						<xsl:if test="arelda:sonstigeBestimmungen">
							<xsl:element name="accessConditionsNotes">
								<xsl:attribute name="origin">
									<xsl:value-of select="$orig" />
									<xsl:text>/sonstigeBestimmungen</xsl:text>
								</xsl:attribute>
								<xsl:value-of select="arelda:sonstigeBestimmungen/text()" />
							</xsl:element>
						</xsl:if>
						<!--   -->
						<xsl:if test="arelda:schutzfrist">
							<xsl:element name="retentionPeriod">
								<xsl:attribute name="origin">
									<xsl:value-of select="$orig" />
									<xsl:text>/schutzfrist</xsl:text>
								</xsl:attribute>
								<xsl:value-of select="arelda:schutzfrist" />
							</xsl:element>
						</xsl:if>
						<!--   -->
						<xsl:if test="arelda:schutzfristenkategorie">
							<xsl:element name="retentionPeriodConditions">
								<xsl:attribute name="origin">
									<xsl:value-of select="$orig" />
									<xsl:text>/schutzfristenkategorie</xsl:text>
								</xsl:attribute>
								<xsl:value-of select="arelda:schutzfristenkategorie" />
							</xsl:element>
						</xsl:if>
						<!--   -->
						<xsl:if test="arelda:referenzSchutzfristenFormular">
							<xsl:element name="retentionPeriodNotes">
								<xsl:attribute name="origin">
									<xsl:value-of select="$orig" />
									<xsl:text>/referenzSchutzfristenFormular</xsl:text>
								</xsl:attribute>
								<xsl:value-of select="arelda:referenzSchutzfristenFormular" />
							</xsl:element>
						</xsl:if>
						<!--   -->
						<xsl:if test="arelda:schutzfristenBegruendung">
							<xsl:element name="retentionPeriodNotes">
								<xsl:attribute name="origin">
									<xsl:value-of select="$orig" />
									<xsl:text>/schutzfristenBegruendung</xsl:text>
								</xsl:attribute>
								<xsl:value-of select="arelda:schutzfristenBegruendung" />
							</xsl:element>
						</xsl:if>
						<!--   -->
					</xsl:element>
				</xsl:if>
				<!-- 3.4.4 Physische Beschaffenheit und technische Anforderungen -->
				<xsl:if test="arelda:erscheinungsform">
					<xsl:element name="physTech">
						<xsl:attribute name="isadId">4.4</xsl:attribute>
						<!-- <xsl:attribute name="origin">ingest</xsl:attribute> -->
						<xsl:attribute name="origin">
							<xsl:value-of select="$orig" />
							<xsl:text>/erscheinungsform</xsl:text>
						</xsl:attribute>
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
							<xsl:when test="arelda:erscheinungsform/text()=''">
									<xsl:text>keine Angabe</xsl:text>
							</xsl:when>
							<xsl:otherwise>
							<xsl:text>other:</xsl:text> <xsl:value-of select="arelda:erscheinungsform/text()"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:element>
				</xsl:if>
				<!-- 3.4.4 Originalinhalt von arelda:erscheinungsform -->
				<!-- <xsl:if test="arelda:erscheinungsform">
					<xsl:element name="physTech">
						<xsl:attribute name="isadId">4.4</xsl:attribute>
						<xsl:attribute name="origin">
							<xsl:value-of select="$orig" />
							<xsl:text>/erscheinungsform</xsl:text>
						</xsl:attribute>
						<xsl:value-of select="arelda:erscheinungsform/text()" />
					</xsl:element>
				</xsl:if> -->
				<!--   -->
			</xsl:element>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>