<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
		xmlns:rico="https://www.ica.org/standards/RiC/ontology#"
		xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- named template RICdate -->
	<xsl:template name="RICdate">
		<xsl:param name="range"/>
		<xsl:param name="type"/>
		<xsl:param name="comment"/>
		<xsl:if test="not ($range/arelda:von/arelda:datum/text() = 'keine Angabe' and $range/arelda:bis/arelda:datum/text() = 'keine Angabe')">
			<xsl:choose>
				<!-- point of Time -->
				<xsl:when test="$range/arelda:datum">
					<xsl:element name="rico:singleDate">
						<xsl:attribute name="rdf:datatype">http://www.w3.org/2001/XMLSchema#date</xsl:attribute>
						<xsl:value-of select="$range/arelda:datum"/>
					</xsl:element>
					<xsl:if test="$range/arelda:ca/text() = 'true'">
						<xsl:element name="rico:dateQualifier">
							<xsl:attribute name="xml:lang">en</xsl:attribute>
							<xsl:text>approximately</xsl:text>
						</xsl:element>
					</xsl:if>
				</xsl:when>
				<!-- from Date - to Date -->
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="string-length(string($range/arelda:von/arelda:datum)) = 4">
							<xsl:element name="rico:beginningDate">
								<xsl:attribute name="rdf:datatype">http://www.w3.org/2001/XMLSchema#date</xsl:attribute>
								<xsl:value-of select="$range/arelda:von/arelda:datum"/>
							</xsl:element>
							<xsl:if test="$range/arelda:von/arelda:ca/text() = 'true'">
								<xsl:element name="rico:dateQualifier">
									<xsl:attribute name="xml:lang">en</xsl:attribute>
									<xsl:text>approximately from</xsl:text>
								</xsl:element>
							</xsl:if>
						</xsl:when>
						<xsl:when test="string-length(string($range/arelda:von/arelda:datum)) = 10">
							<xsl:element name="rico:beginningDate">
								<xsl:attribute name="rdf:datatype">http://www.w3.org/2001/XMLSchema#date</xsl:attribute>
								<xsl:value-of select="$range/arelda:von/arelda:datum"/>
							</xsl:element>
							<xsl:if test="$range/arelda:von/arelda:ca/text() = 'true'">
								<xsl:element name="rico:dateQualifier">
									<xsl:attribute name="xml:lang">en</xsl:attribute>
									<xsl:text>approximately from</xsl:text>
								</xsl:element>
							</xsl:if>
						</xsl:when>
						<xsl:when test="$range/arelda:von/arelda:datum/text() = 'keine Angabe'">
							<xsl:element name="rico:beginningDate">
								<xsl:attribute name="xml:lang">en</xsl:attribute>
								<xsl:text>unknown</xsl:text>
							</xsl:element>
						</xsl:when>
						<xsl:otherwise/>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="string-length(string($range/arelda:bis/arelda:datum)) = 4">
							<xsl:element name="rico:endDate">
								<xsl:attribute name="rdf:datatype">http://www.w3.org/2001/XMLSchema#date</xsl:attribute>
								<xsl:value-of select="$range/arelda:bis/arelda:datum"/>
							</xsl:element>
							<xsl:if test="$range/arelda:bis/arelda:ca/text() = 'true'">
								<xsl:element name="rico:dateQualifier">
									<xsl:attribute name="xml:lang">en</xsl:attribute>
									<xsl:text>approximately to</xsl:text>
								</xsl:element>
							</xsl:if>
						</xsl:when>
						<xsl:when test="string-length(string($range/arelda:bis/arelda:datum)) = 10">
							<xsl:element name="rico:endDate">
								<xsl:attribute name="rdf:datatype">http://www.w3.org/2001/XMLSchema#date</xsl:attribute>
								<xsl:value-of select="$range/arelda:bis/arelda:datum"/>
							</xsl:element>
							<xsl:if test="$range/arelda:bis/arelda:ca/text() = 'true'">
								<xsl:element name="rico:dateQualifier">
									<xsl:attribute name="xml:lang">en</xsl:attribute>
									<xsl:text>approximately to</xsl:text>
								</xsl:element>
							</xsl:if>
						</xsl:when>
						<xsl:when test="$range/arelda:bis/arelda:datum/text() = 'keine Angabe'">
							<xsl:element name="rico:endDate">
								<xsl:attribute name="xml:lang">en</xsl:attribute>
								<xsl:text>unknown</xsl:text>
							</xsl:element>
						</xsl:when>
						<xsl:otherwise/>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
			<!-- comment Date -->
			<xsl:if test="string-length(string($comment)) > 0">
				<xsl:element name="commentDate">
					<xsl:attribute name="xml:lang"><xsl:value-of select="$lang"/></xsl:attribute>
					<xsl:value-of select="$comment"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
