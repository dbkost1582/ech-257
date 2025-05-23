<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xs="http://www.w3.org/2001/XMLSchema" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
		xmlns:rico="https://www.ica.org/standards/RiC/ontology#"
		xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- named template RICreference -->
	<xsl:template name="RICreference">
		<xsl:param name="signature"/>
		<xsl:variable name="sig">
			<xsl:text>_</xsl:text>
			<xsl:value-of select="$signature"/>
		</xsl:variable>

			<xsl:choose>
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
					<xsl:apply-templates select="$reffile//reference/*[name()=$sig]" mode="refNo"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$signature"/>
				</xsl:otherwise>
			</xsl:choose>

	</xsl:template>
	<!--                                         -->
	<xsl:template match="*" mode="refNo">
		<xsl:value-of select="referenceNo"/>
	</xsl:template>
</xsl:stylesheet>
