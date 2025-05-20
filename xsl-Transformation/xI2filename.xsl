<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="ISADG" xmlns:arelda="http://bar.admin.ch/arelda/v4" xmlns:php="http://php.net/xsl"><!-- named template xI2filename -->
	<xsl:template name="xI2filename">
		<xsl:param name="fileid"/><!-- Here the attribute "reihung" of dokument is transformed from eCH0160 to xisadg -->
		<xsl:if test="local-name(.)=&apos;dokument&apos;">
			<xsl:element name="arrangement">
				<xsl:attribute name="isadId">3.4</xsl:attribute>
				<xsl:if test="@reihung">
					<xsl:element name="property">
						<xsl:attribute name="origin">//dokument</xsl:attribute>
						<xsl:attribute name="key">reihung</xsl:attribute>
						<xsl:value-of select="@reihung"/>
					</xsl:element>
				</xsl:if>
			</xsl:element>
		</xsl:if><!-- First we check if the referenced file exists at all --><!--   -->
		<xsl:if test="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid] or /arelda:paket/arelda:inhaltsverzeichnis/arelda:datei[@id=$fileid]">
				<xsl:element name="arrangement">
					<xsl:attribute name="isadId">3.4</xsl:attribute>
					<xsl:attribute name="xpointer">
						<xsl:text>premis.xml#xpointer(</xsl:text>
						<xsl:value-of select="php:function(&apos;sha1&apos;,$fileid)"></xsl:value-of>
						<xsl:text>)</xsl:text>
					</xsl:attribute><!-- Then we check, if the attribute to the reference file exists. -->
					<xsl:if test="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:name">
						<xsl:element name="property">
							<xsl:attribute name="origin">//ordner/name + //datei/name</xsl:attribute>
							<xsl:for-each select="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:name/text()">
								<xsl:for-each select="ancestor::*">
									<xsl:if test="./arelda:name">
										<xsl:if test="./arelda:name/text() != &apos;content&apos;">
											<xsl:text>/</xsl:text>
											<xsl:value-of select="./arelda:name/text()"/>
										</xsl:if>
									</xsl:if>
								</xsl:for-each>
							</xsl:for-each>
						</xsl:element>
					</xsl:if>
					<xsl:if test="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:originalName">
						<xsl:element name="property">
							<xsl:attribute name="origin">//ordner/originalName + //datei/originalName</xsl:attribute>
							<xsl:for-each select="/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$fileid]/arelda:originalName/text()">
								<xsl:for-each select="ancestor::*">
									<xsl:if test="./arelda:originalName">
										<xsl:if test="./arelda:originalName/text() != &apos;content&apos;">
											<xsl:text>/</xsl:text>
											<xsl:value-of select="./arelda:originalName/text()"/>
										</xsl:if>
									</xsl:if>
								</xsl:for-each>
							</xsl:for-each>
						</xsl:element>
					</xsl:if>
					<xsl:if test="/arelda:paket/arelda:inhaltsverzeichnis/arelda:datei[@id=$fileid]/arelda:name">
						<xsl:element name="property">
							<xsl:attribute name="origin">//datei/name</xsl:attribute>
							<xsl:for-each select="/arelda:paket/arelda:inhaltsverzeichnis/arelda:datei[@id=$fileid]/arelda:name/text()">
								<xsl:for-each select="ancestor::*">
									<xsl:if test="./arelda:name">
										<xsl:if test="./arelda:name/text() != &apos;content&apos;">
											<xsl:text>/</xsl:text>
											<xsl:value-of select="./arelda:name/text()"/>
										</xsl:if>
									</xsl:if>
								</xsl:for-each>
							</xsl:for-each>
						</xsl:element>
					</xsl:if>
					<xsl:if test="/arelda:paket/arelda:inhaltsverzeichnis/arelda:datei[@id=$fileid]/arelda:originalName">
						<xsl:element name="property">
							<xsl:attribute name="origin">//datei/originalName</xsl:attribute>
							<xsl:for-each select="/arelda:paket/arelda:inhaltsverzeichnis/arelda:datei[@id=$fileid]/arelda:originalName/text()">
								<xsl:for-each select="ancestor::*">
									<xsl:if test="./arelda:originalName">
										<xsl:if test="./arelda:originalName/text() != &apos;content&apos;">
											<xsl:text>/</xsl:text>
											<xsl:value-of select="./arelda:originalName/text()"/>
										</xsl:if>
									</xsl:if>
								</xsl:for-each>
							</xsl:for-each>
						</xsl:element>
					</xsl:if><!-- Here the attributes of dateiRef are transformed from eCH0160 to xisadg --><!-- Für jedes Attribut (reihung, version, information, repraesentation) muss ich
				eine separate Prüfung wie unten machen --><!-- Punkt steht für Elementtyp, zwei Punkte (..) stehen für Elternelementtyp --><!-- Zuerst MUSS geprüft werden, ob der aktuelle Knoten ein Dokument ist (Gever-Fall
				wie im xI2item.xsl beschrieben. -->
					<xsl:choose>
						<xsl:when test="local-name(..)=&apos;dokument&apos; and local-name(.)=&apos;dateiRef&apos;">
							<xsl:if test="./@version">
								<xsl:element name="property">
									<xsl:attribute name="origin">//dokument/dateiRef</xsl:attribute>
									<xsl:attribute name="key">version</xsl:attribute>
									<xsl:value-of select="./@version"/>
								</xsl:element>
							</xsl:if>
							<xsl:call-template name="repraesentationFunction">
								<xsl:with-param name="paramorigin" select=" &apos;//dokument/dateiRef&apos; "/>
							</xsl:call-template>
								<xsl:call-template name="informationFunction">
									<xsl:with-param name="paramorigin" select=" &apos;//dossier/dateiRef&apos; "/>
								</xsl:call-template>
							<xsl:if test="./@reihung">
								<xsl:element name="property">
									<xsl:attribute name="origin">//dokument/dateiRef</xsl:attribute>
									<xsl:attribute name="key">reihung</xsl:attribute>
									<xsl:value-of select="./@reihung"/>
								</xsl:element>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise><!-- Erst nachdem Dokument geprüft ist (Dateien nur in Dokumenten) und dies
						nicht der GEVER-Fall ist (otherwise), wird der FILES-Fall geprüft, 
		(Dateien auch in Mappen und Dossiers möglich) -->
							<xsl:if test="local-name(..)=&apos;mappe&apos; and local-name(.)=&apos;dateiRef&apos;">
								<xsl:if test="./@version">
									<xsl:element name="property">
										<xsl:attribute name="origin">//mappe/dateiRef</xsl:attribute>
										<xsl:attribute name="key">version</xsl:attribute>
										<xsl:value-of select="./@version"/>
									</xsl:element>
								</xsl:if>
								<xsl:call-template name="repraesentationFunction">
									<xsl:with-param name="paramorigin" select=" &apos;//mappe/dateiRef&apos; "/>
								</xsl:call-template>
								<xsl:call-template name="informationFunction">
									<xsl:with-param name="paramorigin" select=" &apos;//dossier/dateiRef&apos; "/>
								</xsl:call-template>
								<xsl:if test="./@reihung">
									<xsl:element name="property">
										<xsl:attribute name="origin">//mappe/dateiRef</xsl:attribute>
										<xsl:attribute name="key">reihung</xsl:attribute>
										<xsl:value-of select="./@reihung"/>
									</xsl:element>
								</xsl:if>
							</xsl:if>
							<xsl:if test="local-name(..)=&apos;dossier&apos; and local-name(.)=&apos;dateiRef&apos;">
								<xsl:if test="./@version">
									<xsl:element name="property">
										<xsl:attribute name="origin">//dossier/dateiRef</xsl:attribute>
										<xsl:attribute name="key">version</xsl:attribute>
										<xsl:value-of select="./@version"/>
									</xsl:element>
								</xsl:if>
								<xsl:call-template name="repraesentationFunction">
									<xsl:with-param name="paramorigin" select=" &apos;//dossier/dateiRef&apos; "/>
								</xsl:call-template>
								<xsl:call-template name="informationFunction">
									<xsl:with-param name="paramorigin" select=" &apos;//dossier/dateiRef&apos; "/>
								</xsl:call-template>
								<xsl:if test="./@reihung">
									<xsl:element name="property">
										<xsl:attribute name="origin">//dossier/dateiRef</xsl:attribute>
										<xsl:attribute name="key">reihung</xsl:attribute>
										<xsl:value-of select="./@reihung"/>
									</xsl:element>
								</xsl:if>
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:element>
		</xsl:if>
	</xsl:template><!-- Call this function if an empty space is in the value of the "representation" or
	"information" Attribute of arrangement  -->
	<xsl:template name="repraesentationFunction">
		<xsl:param name="paramorigin"/>
		<xsl:element name="property">
			<xsl:attribute name="origin">
				<xsl:value-of select="$paramorigin"></xsl:value-of>
			</xsl:attribute>
			<xsl:attribute name="key">repraesentation</xsl:attribute>
			<xsl:if test="./@repraesentation">
				<xsl:variable name="representationValue" select="string(./@repraesentation)"/>
				<xsl:variable name="delimiter" select="&apos; &apos;"/>
				<xsl:choose>
					<xsl:when test="contains($representationValue, $delimiter)">
						<xsl:call-template name="splitEveryEmptySpace">
							<xsl:with-param name="pText2" select="$representationValue"/>
							<xsl:with-param name="delimit" select="$delimiter"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="HashIDSingle">
							<xsl:with-param name="pText" select="$representationValue"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:element>
	</xsl:template><!-- pText Puts the input value of the function in the parameter pText -->

	<xsl:template name="informationFunction">
		<xsl:param name="paramorigin"/>
		<xsl:element name="property">
			<xsl:attribute name="origin">
				<text>ingest</text>
			</xsl:attribute>
			<xsl:attribute name="key">information</xsl:attribute>
			<xsl:if test="./@information">
				<xsl:variable name="informationValue" select="string(./@information)"/>
				<xsl:variable name="delimiter" select="&apos; &apos;"/>
				<xsl:choose>
					<xsl:when test="contains($informationValue, $delimiter)">
						<xsl:call-template name="splitEveryEmptySpace">
							<xsl:with-param name="pText2" select="$informationValue"/>
							<xsl:with-param name="delimit" select="$delimiter"/>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="HashIDSingle">
							<xsl:with-param name="pText" select="$informationValue"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:element>
	</xsl:template><!-- pText Puts the input value of the function in the parameter pText -->


	<xsl:template name="splitEveryEmptySpace">
		<xsl:param name="delimit" select="."/>
		<xsl:param name="pText2" select="."/>
		<xsl:if test="string-length($pText2)">
			<xsl:choose>
				<xsl:when test="contains($pText2, $delimit)">
					<xsl:call-template name="HashIDMany">
						<xsl:with-param name="pText" select="substring-before($pText2, $delimit)"/>
					</xsl:call-template>
					<xsl:call-template name="splitEveryEmptySpace">
						<xsl:with-param name="pText2" select="substring-after($pText2,&apos; &apos;)"/>
						<xsl:with-param name="delimit" select="$delimit"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="HashIDSingle">
						<xsl:with-param name="pText" select="$pText2"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	
	<!-- Creates and returns a Hash-Value out of the ID -->
	<xsl:template name="HashIDMany">
		<xsl:param name="pText" select="."/>
		<xsl:call-template name="HashIDSingle">
			<xsl:with-param name="pText" select="$pText"/>
		</xsl:call-template>
		<xsl:text></xsl:text>
	</xsl:template>

	<!-- First we check if an dateiRef or an entity with this ID exists -->
	<xsl:template name="HashIDSingle">
		<xsl:param name="pText" select="."/>
		<xsl:if test="string-length($pText)">
			<xsl:choose>
				<xsl:when test="boolean(/arelda:paket/arelda:inhaltsverzeichnis/arelda:ordner//arelda:datei[@id=$pText] or /arelda:paket/arelda:inhaltsverzeichnis/arelda:datei[@id=$pText])">
					<xsl:text>premis.xml#xpointer(</xsl:text>
					<xsl:value-of select="php:function(&apos;sha1&apos;,$pText)"></xsl:value-of>
					<xsl:text>) </xsl:text>
				</xsl:when>
				<!-- If the information-text corresponds to an ID of an archival entity then return the corresponding xIsadg-ID -->
				<xsl:when test="$idfilexml/root/*[name()=$pText]">
						<xsl:value-of select="$idfilexml/root/*[name()=$pText]"></xsl:value-of>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>other:</xsl:text>
					<xsl:text></xsl:text>
					<xsl:value-of select="$pText"></xsl:value-of>
					<xsl:text></xsl:text>
					<xsl:text> ist not a valid reference</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>