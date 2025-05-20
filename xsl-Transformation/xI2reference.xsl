<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="ISADG" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- named template xI2reference -->
	<xsl:template name="xI2reference">
		<xsl:param name="signature"/>
		<xsl:param name="orig"/>
		<xsl:variable name="sig">
			<xsl:text>_</xsl:text>
			<xsl:value-of select="$signature"/>
		</xsl:variable>
		<xsl:element name="referenceCode">
			<xsl:attribute name="isadId">1.1</xsl:attribute>
			<xsl:attribute name="origin"><xsl:if test="$orig = ''"><xsl:text>archival</xsl:text></xsl:if><xsl:value-of select="$orig"/></xsl:attribute>
			<xsl:attribute name="obligation">inherited</xsl:attribute>
			<xsl:choose>
				<!-- This is the case when the signature is "fortlaufend" -->
				<xsl:when test="$reffile//reference">
					<xsl:value-of select="$archsig"/>
					<xsl:text>.</xsl:text>
					<!-- using XPATH expression to find number for signature in reference file -->
					<!--
					<xsl:value-of select="$reffile//reference/identity[referenceCode=$signature]/referenceNo/text()"/>
					-->
					<!-- loop through reference file to find number for signature in reference file -->
					<!--
					<xsl:for-each select="$reffile//reference/identity">
						<xsl:if test="referenceCode=$signature">
							<xsl:value-of select="referenceNo/text()"/>
						</xsl:if>
					</xsl:for-each>
					-->
					<!-- apply template using select on reference file to find number for signature  -->
					<!-- Apply templates selects the nodes in the DI_Extractor_2022\app\wdir\_signaturereference.xml which should be used -->
					<!-- "reference" is the rootnode of the file _signaturereference.xml -->
					<!-- name() returns the string between the <> of an element -->
					<!-- [] is a condition, [name()] just would mean, that there exists a name, [name()=$sig] means the name corresponds $sig. -->
					<!-- With the asterix * all element nodes (without text, attribute etc.) are chosen, who's names are like the signature --> 
					<!-- only templates with mode=refNo should be applied on the selected nodes -->
					
					<xsl:apply-templates select="$reffile//reference/*[name()=$sig]" mode="refNo"/>
				</xsl:when>
				<xsl:otherwise>
				<!-- This is the case when the signature is "decimal" -->
					<xsl:value-of select="$signature"/>

				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<!--                                         -->
	<!--For any currently chosen nodes the following template is applied                       -->
	<xsl:template match="*" mode="refNo">
		<xsl:value-of select="referenceNo"/>
	</xsl:template>
</xsl:stylesheet>
