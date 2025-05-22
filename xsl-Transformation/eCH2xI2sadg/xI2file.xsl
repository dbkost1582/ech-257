<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="ISADG"
	xmlns:arelda="http://bar.admin.ch/arelda/v4">
	<!-- Ordnungsystemposition -->
	<!-- Template will be used in case of a arelda:dossier Element -->
	<xsl:template match="arelda:dossier">
		<xsl:param name="sig" />
		<xsl:param name="astyle" />
		<xsl:variable name="signature">
			<xsl:value-of select="$sig" />
			<xsl:if test="$astyle='fortlaufend'">
			<xsl:text>.dossier</xsl:text>
			<xsl:number level="any"/>
			</xsl:if>
			<xsl:if test="$astyle='dezimal'">
			<xsl:text>.dossier</xsl:text>
			<xsl:number level="single"/>
			</xsl:if>	
		</xsl:variable>
		<xsl:element
			name="archivalDescription">
			<xsl:element name="identity">
				<xsl:attribute name="isadId">1</xsl:attribute>
				<!-- 3.1.1 Signatur -->
				<xsl:call-template name="xI2reference">
					<xsl:with-param name="signature" select="$signature" />
				</xsl:call-template>
				<!-- 3.1.2 Titel -->
				<xsl:element
					name="title">
					<xsl:attribute name="isadId">1.2</xsl:attribute>
					<xsl:attribute name="origin">//dossier/titel</xsl:attribute>
					<xsl:attribute name="obligation">mandatory</xsl:attribute>
					<xsl:value-of
						select="arelda:titel" />
				</xsl:element>
				<!-- 3.1.3 Entstehungszeitraum / Laufzeit -->
				<xsl:if
					test="arelda:entstehungszeitraum">
					<xsl:call-template name="xI2date">
						<xsl:with-param name="range" select="arelda:entstehungszeitraum" />
						<xsl:with-param name="orig">//dossier/entstehungszeitraum</xsl:with-param>
						<xsl:with-param name="comment" select="arelda:entstehungszeitraumAnmerkung" />
					</xsl:call-template>
				</xsl:if>
				<xsl:if
					test="arelda:eroeffnungsdatum">
					<xsl:call-template name="xI2date">
						<xsl:with-param name="range" select="arelda:eroeffnungsdatum" />
						<xsl:with-param name="orig">//dossier/eroeffnungsdatum</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if
					test="arelda:abschlussdatum">
					<xsl:call-template name="xI2date">
						<xsl:with-param name="range" select="arelda:abschlussdatum" />
						<xsl:with-param name="orig">//dossier/abschlussdatum</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<!--   -->
				<!-- 3.1.4 Verzeichnungsstufe -->
				<xsl:element
					name="descriptionLevel">
					<xsl:attribute name="isadId">1.4</xsl:attribute>
					<xsl:attribute name="origin">ingest</xsl:attribute>
					<xsl:attribute name="obligation">mandatory</xsl:attribute>
					<xsl:text>file</xsl:text>
				</xsl:element>
				<!-- 3.1.5 Umfang (Menge und Abmessung) nur in FilesSIP -->
				<xsl:if
					test="arelda:umfang/text()">
					<xsl:element name="extentMedium">
						<xsl:attribute name="isadId">1.5</xsl:attribute>
						<xsl:element
							name="description">
							<xsl:attribute name="origin">//dossier/umfang</xsl:attribute>
							<xsl:value-of
								select="arelda:umfang/text()" />
						</xsl:element>
					</xsl:element>
				</xsl:if>
				<!--   -->
			</xsl:element>
			<!-- 3.2.1 Name der Provenienzstelle -->
			<xsl:if
				test="arelda:federfuehrendeOrganisationseinheit/text()">
				<xsl:element name="context">
					<xsl:attribute name="isadId">2</xsl:attribute>
				<xsl:element name="creator">
					<!-- Das 2.1 bezieht sich auf die letzten zwei Stellen von 3.2.1 -->
						<xsl:attribute name="isadId">2.1</xsl:attribute>
					<xsl:attribute name="origin">//dossier/federfuehrendeOrganisationseinheit</xsl:attribute>
					<xsl:value-of
							select="arelda:federfuehrendeOrganisationseinheit" />
					</xsl:element>
				</xsl:element>
			</xsl:if>

			<!--   -->
			<!-- 3.2.2 Verwaltungsgeschichte / Biographische Angaben -->
			<!--   -->
			<!-- 3.2.3 Bestandesgeschichte -->
			<!--   -->
			<!-- 3.2.4 Abgebende Stelle -->
			<!--   -->
			<xsl:if
				test="arelda:formInhalt or arelda:inhalt or arelda:dateiRef">
				<xsl:element name="contentStructure">
					<xsl:attribute name="isadId">3</xsl:attribute>
					<!-- 3.3.1 Form und Inhalt -->
					<xsl:element name="scopeContent">
						<xsl:attribute name="isadId">3.1</xsl:attribute>
						<xsl:if
							test="arelda:formInhalt">
							<xsl:element name="scope">
							<xsl:attribute name="origin">//dossier/formInhalt</xsl:attribute>
								<xsl:choose>
									<xsl:when test="arelda:formInhalt/text()='Fotos'">
										<xsl:text>image</xsl:text>
									</xsl:when>
									<xsl:when test="arelda:formInhalt/text()='Film'">
										<xsl:text>video</xsl:text>
									</xsl:when>
									<xsl:when test="arelda:formInhalt/text()='Video'">
										<xsl:text>video</xsl:text>
									</xsl:when>
									<xsl:when test="arelda:formInhalt/text()='Datenbanken'">
										<xsl:text>structured_data</xsl:text>
									</xsl:when>
									<xsl:when test="arelda:formInhalt/text()='Tondokumente'">
										<xsl:text>audio</xsl:text>
									</xsl:when>
									<xsl:when
										test="arelda:formInhalt/text()='schriftliche Unterlagen'">
										<xsl:text>text</xsl:text>
									</xsl:when>
									<xsl:when
										test="normalize-space(arelda:formInhalt/text())=''">
										<xsl:text></xsl:text>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>other:</xsl:text> <xsl:value-of select="arelda:formInhalt/text()" />
									</xsl:otherwise>
								</xsl:choose>
							</xsl:element>
						</xsl:if>
						<!-- <xsl:if
							test="arelda:formInhalt">
							<xsl:element name="scope">
								<xsl:attribute name="origin">//dossier/formInhalt</xsl:attribute>
								<xsl:value-of
									select="arelda:formInhalt/text()" />
							</xsl:element>
						</xsl:if> -->
						<xsl:if
							test="arelda:inhalt">
							<xsl:element name="content">
								<xsl:attribute name="origin">//dossier/inhalt</xsl:attribute>
								<xsl:value-of
									select="arelda:inhalt/text()" />
							</xsl:element>
						</xsl:if>
					</xsl:element>

					<xsl:if test="local-name(.)='dossier'">
						<xsl:if test="@reihung">
							<xsl:element name="arrangement">		
								<xsl:attribute name="isadId">3.4</xsl:attribute>
								<xsl:element name="property">
									<xsl:attribute name="origin">//dossier</xsl:attribute>
										<xsl:attribute name="key">reihung</xsl:attribute>
										<xsl:value-of select="@reihung" />
								</xsl:element>
							</xsl:element>
						</xsl:if>
					</xsl:if>

					<!--  FILE SIP -->
					<xsl:apply-templates 
					select="arelda:dateiRef">
					<xsl:with-param name="sig" select="$signature" />
					</xsl:apply-templates>

					<!--   -->
					<!-- 3.3.2 Bewertung und Kassation -->
				</xsl:element>
			</xsl:if>
			<!--   -->
			<!-- 3.4 Zugangs- und Benutzungsbedingungen -->
			<xsl:call-template
				name="xI2access">
				<!-- 3.4.1 Zugangsbestimmungen -->
				<!-- 3.4.4 Physische Beschaffenheit und technische Anforderungen -->
				<xsl:with-param name="orig">//dossier</xsl:with-param>
			</xsl:call-template>
			<!--   -->
			<!-- 3.6.1 Allgemeine Anmerkungen -->
			<xsl:if
				test="arelda:bemerkung/text()">
				<xsl:element name="notes">
					<xsl:attribute name="isadId">6</xsl:attribute>
					<xsl:element name="note">
						<xsl:attribute name="isadId">6.1</xsl:attribute>
						<xsl:attribute name="origin">//dossier/bemerkung</xsl:attribute>
						<xsl:value-of select="arelda:bemerkung" />
					</xsl:element>
				</xsl:element>
			</xsl:if>
			<!-- additionalReference -->
			<xsl:element
				name="additionalReference">
				<xsl:if test="arelda:aktenzeichen/text()">
					<xsl:element name="recordReference">
						<xsl:attribute name="origin">//dossier/aktenzeichen</xsl:attribute>
						<xsl:value-of
							select="arelda:aktenzeichen/text()" />
					</xsl:element>
				</xsl:if>
				<xsl:if
					test="arelda:zusatzmerkmal/text()">
					<xsl:element name="recordReference">
						<xsl:attribute name="origin">//dossier/zusatzmerkmal</xsl:attribute>
						<xsl:value-of
							select="arelda:zusatzmerkmal/text()" />
					</xsl:element>
				</xsl:if>
			</xsl:element>
			<!-- additionalData -->
			<xsl:if
				test="arelda:zusatzDaten or arelda:vorgang">
				<xsl:element name="additionalData">
					<xsl:element name="mdWrap">
						<xsl:attribute name="type">content</xsl:attribute>
						<!-- additionalData dossier -->
						<!-- additionalData       vorgang -->
						<xsl:for-each
							select="arelda:vorgang">
							<xsl:choose>
								<xsl:when test="child::*">
									<!-- additionalData       vorgang-aktivitaet -->
									<xsl:element name="property">
										<xsl:attribute name="origin">//dossier/vorgang</xsl:attribute>
										<xsl:attribute
											name="key">Vorgang</xsl:attribute>
										<xsl:if
											test="./@reihung">
											<xsl:element name="property">
												<!-- <xsl:attribute
												name="origin">//dossier/vorgang/@order</xsl:attribute> -->
												<xsl:attribute name="key">Reihung</xsl:attribute>
												<xsl:value-of select="./@reihung" />
											</xsl:element>
										</xsl:if>
										<xsl:for-each
											select="arelda:titel">
											<xsl:element name="property">
												<!-- <xsl:attribute
												name="origin">//dossier/vorgang/titel</xsl:attribute> -->
												<xsl:attribute name="key">Titel</xsl:attribute>
												<xsl:value-of select="./text()" />
											</xsl:element>
										</xsl:for-each>
										<xsl:for-each
											select="arelda:arbeitsanweisung">
											<xsl:element name="property">
												<!-- <xsl:attribute
												name="origin">//dossier/vorgang/arbeitsanweisung</xsl:attribute> -->
												<xsl:attribute name="key">Arbeitsanweisung</xsl:attribute>
												<xsl:value-of select="./text()" />
											</xsl:element>
										</xsl:for-each>
										<xsl:for-each
											select="arelda:federfuehrung">
											<xsl:element name="property">
												<!-- <xsl:attribute
												name="origin">//dossier/vorgang/federfuehrung</xsl:attribute> -->
												<xsl:attribute name="key">Federfuehrung</xsl:attribute>
												<xsl:value-of select="./text()" />
											</xsl:element>
										</xsl:for-each>
										<xsl:for-each
											select="arelda:verweis">
											<xsl:element name="property">
												<!-- <xsl:attribute
												name="origin">//dossier/vorgang/verweis</xsl:attribute> -->
												<xsl:attribute name="key">Verweis</xsl:attribute>
												<xsl:value-of select="./text()" />
											</xsl:element>
										</xsl:for-each>
										<xsl:for-each
											select="arelda:bemerkung">
											<xsl:element name="property">
												<!-- <xsl:attribute
												name="origin">//dossier/vorgang/bemerkung</xsl:attribute> -->
												<xsl:attribute name="key">Bemerkung</xsl:attribute>
												<xsl:value-of select="./text()" />
											</xsl:element>
										</xsl:for-each>
										<xsl:for-each
											select="arelda:zusatzDaten/arelda:merkmal">
											<xsl:element name="property">
												<!-- <xsl:attribute
												name="origin">//dossier/vorgang/zusatzDaten/merkmal</xsl:attribute>  -->
												<xsl:attribute name="key">
													<xsl:value-of select="./@name" />
												</xsl:attribute>
												<xsl:value-of
													select="./text()" />
											</xsl:element>
										</xsl:for-each>
										<!-- additionalData     aktivitaet -->
										<xsl:for-each
											select="arelda:aktivitaet">
											<xsl:element name="property">
												<!-- <xsl:attribute
												name="origin">//dossier/vorgang/aktivitaet</xsl:attribute> -->
												<xsl:attribute name="key">Aktivitaet</xsl:attribute>
												<xsl:if test="./@reihung">
													<xsl:element name="property">
														<!-- <xsl:attribute
														name="origin">//dossier/vorgang/aktivitaet/@order</xsl:attribute> -->
														<xsl:attribute
															name="key">Reihung</xsl:attribute>
														<xsl:value-of
															select="./@reihung" />
													</xsl:element>
												</xsl:if>
												<xsl:for-each
													select="arelda:vorschreibung">
													<xsl:element name="property">
														<!-- <xsl:attribute
														name="origin">//dossier/vorgang/aktivitaet/vorschreibung</xsl:attribute> -->
														<xsl:attribute
															name="key">Vorschreibung</xsl:attribute>
														<xsl:value-of
															select="./text()" />
													</xsl:element>
												</xsl:for-each>
												<xsl:for-each
													select="arelda:anweisung">
													<xsl:element name="property">
														<!-- <xsl:attribute
														name="origin">//dossier/vorgang/aktivitaet/anweisung</xsl:attribute> -->
														<xsl:attribute
															name="key">Anweisung</xsl:attribute>
														<xsl:value-of
															select="./text()" />
													</xsl:element>
												</xsl:for-each>
												<xsl:for-each
													select="arelda:bearbeiter">
													<xsl:element name="property">
														<!-- <xsl:attribute
														name="origin">//dossier/vorgang/aktivitaet/bearbeiter</xsl:attribute> -->
														<xsl:attribute
															name="key">Bearbeiter</xsl:attribute>
														<xsl:value-of
															select="./text()" />
													</xsl:element>
												</xsl:for-each>
												<xsl:for-each
													select="arelda:abschlussdatum">
													<xsl:element name="property">
														<!-- <xsl:attribute
														name="origin">//dossier/vorgang/aktivitaet/abschlussdatum</xsl:attribute> -->
														<xsl:attribute
															name="key">Abschlussdatum</xsl:attribute>
														<xsl:value-of
															select="./text()" />
													</xsl:element>
												</xsl:for-each>
												<xsl:for-each
													select="arelda:verweis">
													<xsl:element name="property">
														<!-- <xsl:attribute
														name="origin">//dossier/vorgang/aktivitaet/verweis</xsl:attribute> -->
														<xsl:attribute
															name="key">Verweis</xsl:attribute>
														<xsl:value-of
															select="./text()" />
													</xsl:element>
												</xsl:for-each>
												<xsl:for-each
													select="arelda:bemerkung">
													<xsl:element name="property">
														<!-- <xsl:attribute
														name="origin">//dossier/vorgang/aktivitaet/bemerkung</xsl:attribute> -->
														<xsl:attribute
															name="key">Bemerkung</xsl:attribute>
														<xsl:value-of
															select="./text()" />
													</xsl:element>
												</xsl:for-each>
												<xsl:for-each
													select="arelda:zusatzDaten/arelda:merkmal">
													<xsl:element name="property">
														<!-- <xsl:attribute
														name="origin">//dossier/vorgang/aktivitaet/zusatzDaten/merkmal</xsl:attribute>  -->
														<xsl:attribute
															name="key">
															<xsl:value-of select="./@name" />
														</xsl:attribute>
														<xsl:value-of
															select="./text()" />
													</xsl:element>
												</xsl:for-each>
											</xsl:element>
										</xsl:for-each>
									</xsl:element>
								</xsl:when>
								<xsl:otherwise>
									<xsl:element name="property">
										<xsl:attribute name="origin">//dossier/vorgang</xsl:attribute>
										<xsl:attribute
											name="key">simpleVorgang</xsl:attribute>
										<xsl:value-of
											select="./text()" />
									</xsl:element>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
						<!-- additionalData zusatzDaten -->
						<xsl:for-each
							select="arelda:zusatzDaten/arelda:merkmal">
							<xsl:element name="property">
								<xsl:attribute name="origin">//dossier/zusatzDaten/merkmal</xsl:attribute>
								<xsl:attribute
									name="key">
									<xsl:value-of select="./@name" />
								</xsl:attribute>
								<xsl:value-of
									select="./text()" />
							</xsl:element>
						</xsl:for-each>
					</xsl:element>
					<xsl:element name="mdWrap"><!-- additionalData zusatzDaten, content -->
						<xsl:attribute name="type">vendor</xsl:attribute>
							<xsl:element name="property">
								<xsl:attribute name="origin">ingest</xsl:attribute>
									<xsl:attribute name="key">
										<xsl:text>vendor example key</xsl:text>
									</xsl:attribute>
								<xsl:text>vendor example value</xsl:text>
							</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:if>
			<!--  GEVER SIP -->
			<!-- Applies the template to the all of dokument-Elements of the current node-->
			<xsl:apply-templates
				select="arelda:dokument">
				<xsl:with-param name="sig" select="$signature" />
				<xsl:with-param name="astyle" select="$astyle" />
			</xsl:apply-templates>
			<!--  Sub-Dossier -->
			<xsl:apply-templates
				select="arelda:dossier">
				<xsl:with-param name="sig" select="$signature" />
				<xsl:with-param name="astyle" select="$astyle" />
			</xsl:apply-templates>
			<!--  Sub-Mappe -->
			<xsl:apply-templates
				select="arelda:mappe">
				<xsl:with-param name="sig" select="$signature" />
				<xsl:with-param name="astyle" select="$astyle" />
			</xsl:apply-templates>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
