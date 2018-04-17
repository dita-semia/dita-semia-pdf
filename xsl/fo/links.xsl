<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="2.0"
	xmlns:xs				= "http://www.w3.org/2001/XMLSchema" 
	xmlns:xsl				= "http://www.w3.org/1999/XSL/Transform"
	xmlns:svg				= "http://www.w3.org/2000/svg" 
	xmlns:fo				= "http://www.w3.org/1999/XSL/Format"
	xmlns:ditaarch			=  "http://dita.oasis-open.org/architecture/2005/"
	xmlns:opentopic			= "http://www.idiominc.com/opentopic"
	xmlns:opentopic-func	= "http://www.idiominc.com/opentopic/exsl/function"
	xmlns:ds				= "http://www.dita-semia.org"
	exclude-result-prefixes	= "#all">

	<!-- Topic-Nummer in Querverweisen ergänzen -->
	<xsl:template match="*[contains(@class, ' topic/topic ')][*[contains(@class, ' topic/title ')]]" mode="retrieveReferenceTitle">
		<xsl:variable name="title" as="node()*">
			<xsl:apply-templates select="*[contains(@class, ' topic/title ')]" mode="getTitle"/>
		</xsl:variable>
		<xsl:sequence select="ds:removeTitleFormatting($title)"/>
	</xsl:template>
	
	<!-- keine Seitenangabe bei Links innerhalb des Topics -->
	<xsl:template name="insertPageNumberCitation">
		<xsl:param name="isTitleEmpty" as="xs:boolean" select="false()"/>
		<xsl:param name="destination" as="xs:string"/>
		<xsl:param name="element" as="element()?"/>
		
		<xsl:variable name="currTopic" as="element()?" select="ancestor-or-self::*[contains(@class, ' topic/topic ')][1]"/>
		<xsl:variable name="destTopic" as="element()?" select="$element/ancestor-or-self::*[contains(@class, ' topic/topic ')][1]"/>
		
		<xsl:choose>
			<xsl:when test="not($element) or ($destination = '')"/>
			<xsl:when test="$isTitleEmpty">
				<fo:inline>
					<xsl:call-template name="getVariable">
						<xsl:with-param name="id" select="'Page'"/>
						<xsl:with-param name="params">
							<pagenum>
								<fo:inline>
									<fo:page-number-citation ref-id="{$destination}"/>
								</fo:inline>
							</pagenum>
						</xsl:with-param>
					</xsl:call-template>
				</fo:inline>
			</xsl:when>
			<xsl:when test="$currTopic = $destTopic">
				<!-- keine Ausgabe -->
			</xsl:when>
			<xsl:otherwise>
				<fo:inline>
					<xsl:call-template name="getVariable">
						<xsl:with-param name="id" select="'On the page'"/>
						<xsl:with-param name="params">
							<pagenum>
								<fo:inline>
									<fo:page-number-citation ref-id="{$destination}"/>
								</fo:inline>
							</pagenum>
						</xsl:with-param>
					</xsl:call-template>
				</fo:inline>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- 
		Sonderbehandlung, wenn nicht schon expliziter Link-Inhalt angegeben ist:
		- für ol/li mit title den title berücksichtigen, 
		- für dlentry in dl mit outputclass numbered-list-titles die Numemr ergänzen
	-->
	<xsl:template match="*[not(processing-instruction()[name()='ditaot'][.='usertext'])]" mode="insertReferenceTitle">
		<xsl:param name="href"/>
		<xsl:param name="titlePrefix"/>
		<xsl:param name="destination"/>
		<xsl:param name="element"/>
		
		<xsl:variable name="referenceContent">
			<xsl:choose>
				<xsl:when test="not($element) or ($destination = '')">
					<xsl:text>#none#</xsl:text>
				</xsl:when>
				<xsl:when test="contains($element/@class,' topic/li ') and 
								contains($element/parent::*/@class,' topic/ol ') and
								($element/*[contains(@class, ' topic/title ')])">
					<xsl:apply-templates select="$element" mode="retrieveReferenceTitle"/>
				</xsl:when>
				<xsl:when test="contains($element/@class,' topic/li ') and 
								contains($element/parent::*/@class,' topic/ol ')">
					<!-- SF Bug 1839827: This causes preprocessor text to be used for links to OL/LI -->
					<xsl:text>#none#</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="$element" mode="retrieveReferenceTitle"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:if test="not($titlePrefix = '')">
			<xsl:call-template name="getVariable">
				<xsl:with-param name="id" select="$titlePrefix"/>
			</xsl:call-template>
		</xsl:if>

		<xsl:choose>
			<xsl:when test="not($element) or ($destination = '') or $referenceContent='#none#'">
				<xsl:choose>
					<xsl:when test="*[not(contains(@class,' topic/desc '))] | text()">
						<xsl:apply-templates select="*[not(contains(@class,' topic/desc '))] | text()"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$href"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="$referenceContent"/>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	
	<xsl:template match="*[contains(@class, ' topic/li ')]" mode="retrieveReferenceTitle">
		<xsl:variable name="title" as="element()?" select="*[contains(@class, ' topic/title ')][1]"/>
		<xsl:choose>
			<xsl:when test="$title">
				<xsl:if test="contains(parent::*/@class, ' topic/ol ')">
					<xsl:number format="1. " count="*[contains(@class, ' topic/li ')]"/>
				</xsl:if>
				<xsl:variable name="text">
					<xsl:apply-templates select="*[contains(@class, ' topic/title ')]" mode="insert-text"/>
				</xsl:variable>
				<xsl:value-of select="normalize-space($text)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:next-match/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="*[contains(@class, ' topic/dl ')][@outputclass = 'numbered-list-titles']/*[contains(@class, ' topic/dlentry ')]" mode="retrieveReferenceTitle">
		<xsl:number format="1. " count="*[contains(@class, ' topic/dlentry ')]"/>
		<xsl:variable name="text">
			<xsl:apply-templates select="*[contains(@class, ' topic/dt ')]" mode="insert-text"/>
		</xsl:variable>
		<xsl:value-of select="normalize-space($text)"/>
	</xsl:template>

</xsl:stylesheet>
