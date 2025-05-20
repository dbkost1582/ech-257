<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="ISADG" xmlns:arelda="http://bar.admin.ch/arelda/v4">
<!-- named template insertxIdate -->
	<xsl:template name="insertxIdate">
		<xsl:param name="datum"/>
		<xsl:element name="dates">
			<xsl:choose>
				<xsl:when test="string-length(string($datum/arelda:von/arelda:datum)) = 4">
					<xsl:element name="fromYear">
						<xsl:value-of select="$datum/arelda:von/arelda:datum"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="string-length(string($datum/arelda:von/arelda:datum)) = 10">
					<xsl:element name="fromDate">
						<xsl:value-of select="$datum/arelda:von/arelda:datum"/>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise>
					<xsl:element name="fromDate">
						<xsl:text>unknown</xsl:text>
					</xsl:element>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="string-length(string($datum/arelda:bis/arelda:datum)) = 4">
					<xsl:element name="toYear">
						<xsl:value-of select="$datum/arelda:bis/arelda:datum"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="string-length(string($datum/arelda:bis/arelda:datum)) = 10">
					<xsl:element name="toDate">
						<xsl:value-of select="$datum/arelda:bis/arelda:datum"/>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise>
					<xsl:element name="toDate">
						<xsl:text>unknown</xsl:text>
					</xsl:element>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	</xsl:stylesheet>