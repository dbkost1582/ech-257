<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<xsl:output method="xml" encoding="UTF-8" indent="yes" media-type="application/xml"/>
	<xsl:template match="/reference">
		<xsl:element name="reference">
			<xsl:element name="identity">
				<xsl:apply-templates select="identity[depth='0']"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<!--                                                              -->
	<xsl:template match="identity">
		<xsl:variable name="thisidentityId" select="generate-id(.)"/>
		<xsl:variable name="depth" select="depth"/>
		<xsl:variable name="descendants">
			<xsl:apply-templates select="following-sibling::identity[depth = $depth + 1][generate-id(preceding-sibling::identity[depth = $depth][1]) = $thisidentityId]"/>
		</xsl:variable>
		<xsl:variable name="descendantsNb">
			<xsl:value-of select="count(following-sibling::identity[depth = $depth + 1][generate-id(preceding-sibling::identity[depth = $depth][1]) = $thisidentityId])"/>
		</xsl:variable>
		<xsl:element name="ref">
			<xsl:attribute name="code"><xsl:value-of select="referenceCode"/></xsl:attribute>
			<xsl:attribute name="no"><xsl:value-of select="referenceNo"/></xsl:attribute>
			<xsl:attribute name="depth"><xsl:value-of select="depth"/></xsl:attribute>
		</xsl:element>
		<xsl:if test="$descendantsNb &gt; 0">
			<xsl:element name="identity">
				<xsl:copy-of select="$descendants"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
