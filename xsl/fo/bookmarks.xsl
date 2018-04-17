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


	<xsl:template match="*[contains(@class, ' topic/topic ')]" mode="bookmark">
		<xsl:variable name="mapTopicref" select="key('map-id', @id)[1]"/>
		<xsl:variable name="topicTitle">
			<xsl:variable name="tempTitle" as="node()*">
				<xsl:call-template name="getNavTitle"/>
			</xsl:variable>
			<xsl:sequence select="ds:removeTitleFormatting($tempTitle)"/>
		</xsl:variable>
		
		<xsl:choose>
			<xsl:when test="$mapTopicref[@toc = 'yes' or not(@toc)] or not($mapTopicref)">
				<fo:bookmark>
					<xsl:attribute name="internal-destination">
						<xsl:call-template name="generate-toc-id"/>
					</xsl:attribute>
					<xsl:if test="$bookmarkStyle!='EXPANDED'">
						<xsl:attribute name="starting-state">hide</xsl:attribute>
					</xsl:if>
					<fo:bookmark-title>
						<xsl:value-of select="replace(normalize-space($topicTitle), '&#xAD;', '')"/>
					</fo:bookmark-title>
					<xsl:apply-templates mode="bookmark"/>
				</fo:bookmark>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates mode="bookmark"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	<!-- Bookmark für sections erzeugen -->
	<xsl:template match="*[contains(@class, ' topic/section ')]" mode="bookmark" priority="10">
		<xsl:variable name="title">
			<xsl:variable name="tempTitle" as="node()*">
				<xsl:call-template name="getNavTitle"/>
			</xsl:variable>
			<xsl:sequence select="ds:removeTitleFormatting($tempTitle)"/>
		</xsl:variable>
		
		<xsl:choose>
			<xsl:when test="string(normalize-space($title)) = ''">
				<xsl:apply-templates mode="#current"/>
			</xsl:when>
			<xsl:otherwise>
				<fo:bookmark>
					<xsl:attribute name="internal-destination">
						<xsl:call-template name="generate-toc-id"/>
					</xsl:attribute>
					<xsl:attribute name="starting-state">hide</xsl:attribute>
					<fo:bookmark-title>
						<xsl:value-of select="normalize-space($title)"/>
					</fo:bookmark-title>
					<xsl:apply-templates mode="#current"/>
				</fo:bookmark>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- create bookmark for body, when it contains other bookmarks and at east one the same level there is at least on topic with child topics to seperate the topics from the content.  -->
	<xsl:template match="*[contains(@class, ' topic/body ')]" mode="bookmark" priority="10">
		<xsl:variable name="content" as="node()*">
			<xsl:apply-templates mode="#current"/>
		</xsl:variable>

		<xsl:variable name="topics" 		as="element()*"	select="parent::*/parent::*/*[contains(@class, ' topic/topic ')]"/>
		<xsl:variable name="topicrefs" 		as="element()*"	select="key('map-id', parent::*/@id)/parent::*/*[contains(@class, ' map/topicref ')]"/>
		
		<xsl:variable name="childTopics" 	as="element()*"	select="$topics/*[contains(@class, ' topic/topic ')]"/>
		<xsl:variable name="childTopicrefs" as="element()*"	select="$topicrefs/*[contains(@class, ' map/topicref ')]"/>
		
		<xsl:choose>
			<xsl:when test="empty($content/self::fo:bookmark)">
				<!-- no bookmarks -->
			</xsl:when>
			<xsl:when test="exists($childTopics | $childTopicrefs)">
				<!-- wrap -->
				<fo:bookmark>
					<xsl:attribute name="internal-destination">
						<xsl:call-template name="generate-toc-id">
							<xsl:with-param name="element" select="parent::*"/>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:attribute name="starting-state">hide</xsl:attribute>
					<fo:bookmark-title>
						<xsl:text>Inhalt</xsl:text>
					</fo:bookmark-title>
					<xsl:sequence select="$content"/>
				</fo:bookmark>
			</xsl:when>
			<xsl:otherwise>
				<!-- direct children -->
				<xsl:sequence select="$content"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	<!-- Create bookmark for 1st letter in gc-d/sorted-dl -->
	<xsl:template match="*[contains(@class, ' gc-d/sorted-dl ')]/*[contains(@class, ' topic/dlentry ')]" mode="bookmark" priority="10">
		<xsl:variable name="prevDt"		as="element()?"		select="preceding-sibling::*[1]/*[contains(@class, ' topic/dt ')]"/>
		<xsl:variable name="currStart"	as="xs:string?" 	select="upper-case(substring(*[contains(@class, ' topic/dt ')][1], 1, 1))"/>
		<xsl:variable name="prevStart"	as="xs:string?" 	select="upper-case(substring($prevDt, 1, 1))"/>
		
		<xsl:if test="exists($currStart) and not($prevStart = $currStart)">
			<fo:bookmark>
				<xsl:attribute name="internal-destination" select="@id"/>
				<xsl:attribute name="starting-state">hide</xsl:attribute>
				<fo:bookmark-title>
					<xsl:value-of select="$currStart"/>
					<xsl:text>...</xsl:text>
				</fo:bookmark-title>
			</fo:bookmark>
		</xsl:if>
	</xsl:template>
	
	
	<!-- bookmark for li with title -->
	<xsl:template match="*[contains(@class, ' topic/li ')][*[contains(@class, ' topic/title ')]]" mode="bookmark" priority="10">
		<fo:bookmark>
			<xsl:attribute name="internal-destination" select="@id"/>
			<xsl:attribute name="starting-state">hide</xsl:attribute>
			<fo:bookmark-title>
				<xsl:value-of select="normalize-space(title)"/>
			</fo:bookmark-title>
			<xsl:apply-templates select="*" mode="#current"/>
		</fo:bookmark>
	</xsl:template>
	
	
	<!-- bookmark for dlentry with outputclass bullet-list-titles, numbered-list-titles and table -->
	<xsl:template match="*[contains(@class, ' topic/dl ')][@outputclass = ('bullet-list-titles', 'numbered-list-titles', 'table')]/*[contains(@class, ' topic/dlentry ')][*[contains(@class, ' topic/dt ')]]" mode="bookmark" priority="9">
		<xsl:variable name="dt" as="xs:string?" select="normalize-space(string-join(*[contains(@class, ' topic/dt ')], ' '))"/>
		<xsl:choose>
			<xsl:when test="string($dt) != ''">
				<fo:bookmark>
					<xsl:attribute name="internal-destination">
						<xsl:call-template name="generate-toc-id">
							<xsl:with-param name="element" select="."/>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:attribute name="starting-state">hide</xsl:attribute>
					<fo:bookmark-title>
						<xsl:if test="parent::*/@outputclass = 'numbered-list-titles'">
							<xsl:number count="*[contains(@class, ' topic/dlentry ')]" format="1. "/>
						</xsl:if>
						<xsl:value-of select="$dt"/>
					</fo:bookmark-title>
					<xsl:apply-templates select="*" mode="#current"/>
				</fo:bookmark>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="*" mode="#current"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
</xsl:stylesheet>
