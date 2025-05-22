<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="ISADG" xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- named template xI2date -->
	<xsl:template name="xI2date">
		<xsl:param name="range"/>
		<xsl:param name="orig"/>
		<xsl:param name="comment"/>
		<xsl:if test="not ($range/arelda:von/arelda:datum/text() = 'keine Angabe' and $range/arelda:bis/arelda:datum/text() = 'keine Angabe')">
			<xsl:element name="dates">
				<xsl:attribute name="isadId">1.3</xsl:attribute>
				<xsl:attribute name="origin"><xsl:value-of select="$orig"/></xsl:attribute>
				<!-- call xI2impledate -->
				<xsl:call-template name="xI2simpledate">
					<xsl:with-param name="range" select="$range"/>
					<xsl:with-param name="comment" select="$comment"/>
				</xsl:call-template>
			</xsl:element>
		</xsl:if>
		<xsl:if test="($range/arelda:von/arelda:datum/text() = 'keine Angabe' and $range/arelda:bis/arelda:datum/text() = 'keine Angabe')">
			<xsl:element name="dates">
				<xsl:attribute name="isadId">1.3</xsl:attribute>
				<xsl:attribute name="origin"><xsl:value-of select="$orig"/></xsl:attribute>
					<xsl:element name="fromDate">
						<xsl:text>unknown</xsl:text>
					</xsl:element>
				<xsl:element name="toDate">
						<xsl:text>unknown</xsl:text>
				</xsl:element>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- named template xI2impledate -->
	<xsl:template name="xI2simpledate">
		<xsl:param name="range"/>
		<xsl:param name="comment"/>
		<xsl:if test="not ($range/arelda:von/arelda:datum/text() = 'keine Angabe' and $range/arelda:bis/arelda:datum/text() = 'keine Angabe')">
			<xsl:choose>
				<!-- point of Time -->
				<xsl:when test="$range/arelda:datum">
					<xsl:element name="pointofTime">
						<xsl:if test="$range/arelda:ca/text() = 'true'">
							<xsl:attribute name="circa">true</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="$range/arelda:datum"/>
					</xsl:element>
				</xsl:when>
				<!-- from Date - to Date -->
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="string-length(string($range/arelda:von/arelda:datum)) = 4">
							<xsl:element name="fromDate">
								<xsl:if test="$range/arelda:von/arelda:ca/text() = 'true'">
									<xsl:attribute name="circa">true</xsl:attribute>
								</xsl:if>
								<xsl:value-of select="$range/arelda:von/arelda:datum"/>
							</xsl:element>
						</xsl:when>
						<xsl:when test="string-length(string($range/arelda:von/arelda:datum)) = 10">
							<xsl:element name="fromDate">
								<xsl:if test="$range/arelda:von/arelda:ca/text() = 'true'">
									<xsl:attribute name="circa">true</xsl:attribute>
								</xsl:if>
								<xsl:value-of select="$range/arelda:von/arelda:datum"/>
							</xsl:element>
						</xsl:when>
						<xsl:when test="$range/arelda:von/arelda:datum/text() = 'keine Angabe'">
							<xsl:element name="fromDate">
								<xsl:text>unknown</xsl:text>
							</xsl:element>
						</xsl:when>
						<xsl:otherwise/>
					</xsl:choose>
					<xsl:choose>
						<xsl:when test="string-length(string($range/arelda:bis/arelda:datum)) = 4">
							<xsl:element name="toDate">
								<xsl:if test="$range/arelda:bis/arelda:ca/text() = 'true'">
									<xsl:attribute name="circa">true</xsl:attribute>
								</xsl:if>
								<xsl:value-of select="$range/arelda:bis/arelda:datum"/>
							</xsl:element>
						</xsl:when>
						<xsl:when test="string-length(string($range/arelda:bis/arelda:datum)) = 10">
							<xsl:element name="toDate">
								<xsl:if test="$range/arelda:bis/arelda:ca/text() = 'true'">
									<xsl:attribute name="circa">true</xsl:attribute>
								</xsl:if>
								<xsl:value-of select="$range/arelda:bis/arelda:datum"/>
							</xsl:element>
						</xsl:when>
						<xsl:when test="$range/arelda:bis/arelda:datum/text() = 'keine Angabe'">
							<xsl:element name="toDate">
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
					<xsl:value-of select="$comment"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>

		<xsl:if test="($range/arelda:von/arelda:datum/text() = 'keine Angabe' and $range/arelda:bis/arelda:datum/text() = 'keine Angabe')">
			<xsl:element name="dates">
				<xsl:attribute name="isadId">1.3</xsl:attribute>
				<xsl:attribute name="origin"><xsl:value-of select="$orig"/></xsl:attribute>
					<xsl:element name="fromDate">
						<xsl:text>unknown</xsl:text>
					</xsl:element>
					<xsl:element name="toDate">
						<xsl:text>unknown</xsl:text>
					</xsl:element>
			</xsl:element>
		</xsl:if>

	</xsl:template>
</xsl:stylesheet>
