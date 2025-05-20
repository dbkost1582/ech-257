<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns="urn:isbn:1-931666-22-9" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- named template EADdate -->
	<xsl:template name="EADdate">
		<xsl:param name="range"/>
		<xsl:if test="not ($range/arelda:von/arelda:datum/text() = 'keine Angabe' and $range/arelda:bis/arelda:datum/text() = 'keine Angabe')">
			<xsl:element name="unitdate">
				<xsl:attribute name="label">creationPeriod</xsl:attribute>
				<xsl:choose>
					<xsl:when test="string-length(string($range/arelda:von/arelda:datum)) = 4">
						<xsl:if test="$range/arelda:von/arelda:ca/text() = 'true'">
							<xsl:text>ca.</xsl:text>
						</xsl:if>
						<xsl:value-of select="$range/arelda:von/arelda:datum"/>
					</xsl:when>
					<xsl:when test="string-length(string($range/arelda:von/arelda:datum)) = 10">
						<xsl:if test="$range/arelda:von/arelda:ca/text() = 'true'">
							<xsl:text>ca.</xsl:text>
						</xsl:if>
						<xsl:value-of select="$range/arelda:von/arelda:datum"/>
					</xsl:when>
					<xsl:when test="$range/arelda:von/arelda:datum/text() = 'keine Angabe'">
						<xsl:text>unknown</xsl:text>
					</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
				<xsl:text>/</xsl:text>
				<xsl:choose>
					<xsl:when test="string-length(string($range/arelda:bis/arelda:datum)) = 4">
						<xsl:if test="$range/arelda:bis/arelda:ca/text() = 'true'">
							<xsl:text>ca.</xsl:text>
						</xsl:if>
						<xsl:value-of select="$range/arelda:bis/arelda:datum"/>
					</xsl:when>
					<xsl:when test="string-length(string($range/arelda:bis/arelda:datum)) = 10">
						<xsl:if test="$range/arelda:bis/arelda:ca/text() = 'true'">
							<xsl:text>ca.</xsl:text>
						</xsl:if>
						<xsl:value-of select="$range/arelda:bis/arelda:datum"/>
					</xsl:when>
					<xsl:when test="$range/arelda:bis/arelda:datum/text() = 'keine Angabe'">
						<xsl:text>unknown</xsl:text>
					</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
