<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="2.0"
	xmlns:xs				= "http://www.w3.org/2001/XMLSchema" 
	xmlns:xsl				= "http://www.w3.org/1999/XSL/Transform"
	xmlns:svg				= "http://www.w3.org/2000/svg" 
	xmlns:fo				= "http://www.w3.org/1999/XSL/Format"
	xmlns:ot-placeholder	= "http://suite-sol.com/namespaces/ot-placeholder"
	xmlns:ds				= "http://www.dita-semia.org"
	exclude-result-prefixes	= "#all">
	
	

	<xsl:template match="*[contains(@class, ' topic/topic ')]" mode="toc">
		<xsl:param name="include"/>
						
		<xsl:variable name="topicLevel" as="xs:integer">
			<xsl:apply-templates select="." mode="get-topic-level"/>
		</xsl:variable>
		<xsl:if test="$topicLevel &lt; $tocMaximumLevel">
			<xsl:variable name="mapTopicref" select="key('map-id', @id)[1]"/>
			
			<xsl:choose>
				<xsl:when test="$retain-bookmap-order and $mapTopicref/self::*[contains(@class, ' bookmap/notices ')]"/>
				<xsl:when test="$mapTopicref[@toc = 'yes' or not(@toc)] or (not($mapTopicref) and $include = 'true')">
					
					<xsl:variable name="navTitle">
						<xsl:call-template name="getNavTitle">
							<xsl:with-param name="noStatusMarker" select="true()" tunnel="yes"/>
						</xsl:call-template>
					</xsl:variable>
					
					<xsl:variable name="navTitleNum" 	as="node()*" select="$navTitle/fo:table/fo:table-body/fo:table-row/fo:table-cell[1]/fo:block/node()"/>
					<xsl:variable name="navTitleTxt" 	as="node()*">
						<xsl:choose>
							<xsl:when test="exists($navTitle/fo:table)">
								<xsl:sequence select="$navTitle/fo:table/fo:table-body/fo:table-row/fo:table-cell[2]/fo:block/node()"/>
							</xsl:when>
							<xsl:when test="exists($navTitle/fo:block)">
								<xsl:sequence select="$navTitle/fo:block/node()"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:sequence select="$navTitle"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					
					<xsl:call-template name="ds:createTocEntry">
						<xsl:with-param name="topicLevel"	select="$topicLevel"/>
						<xsl:with-param name="navTitleNum" 	select="$navTitleNum"/>
						<xsl:with-param name="navTitleTxt" 	select="$navTitleTxt"/>
						<xsl:with-param name="destId" as="xs:string">
							<xsl:call-template name="generate-toc-id"/>
						</xsl:with-param>
						<xsl:with-param name="isLeaf"		select="$topicLevel = ($tocMaximumLevel - 1)"/>
					</xsl:call-template>

					<xsl:apply-templates mode="toc">
						<xsl:with-param name="include" select="'true'"/>
					</xsl:apply-templates>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates mode="toc">
						<xsl:with-param name="include" select="'true'"/>
					</xsl:apply-templates>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	
	
	<xsl:template match="ot-placeholder:tablelist" mode="toc">
		<xsl:if test="//*[contains(@class, ' topic/table ')]/*[contains(@class, ' topic/title ' )]">
			<xsl:call-template name="ds:createTocEntry">
				<xsl:with-param name="navTitleTxt" as="node()*">
					<xsl:call-template name="getVariable">
						<xsl:with-param name="id" select="'List of Tables'"/>
					</xsl:call-template>
				</xsl:with-param>
				<xsl:with-param name="destId"	select="$id.lot"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	
	<xsl:template match="ot-placeholder:figurelist" mode="toc">
		<xsl:if test="//*[contains(@class, ' topic/fig ')]/*[contains(@class, ' topic/title ' )]">
			<xsl:call-template name="ds:createTocEntry">
				<xsl:with-param name="navTitleTxt" as="node()*">
					<xsl:call-template name="getVariable">
						<xsl:with-param name="id" select="'List of Figures'"/>
					</xsl:call-template>
				</xsl:with-param>
				<xsl:with-param name="destId"	select="$id.lof"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	
	<xsl:template name="ds:createTocEntry">
		<xsl:param name="topicLevel"	as="xs:integer"	select="1"/>
		<xsl:param name="navTitleNum" 	as="node()*"/>
		<xsl:param name="navTitleTxt" 	as="node()*"/>
		<xsl:param name="destId" 		as="xs:string"/>
		<xsl:param name="isLeaf"		as="xs:boolean" select="true()"/>
		
		<xsl:variable name="fontSizeTitle" 	as="xs:double" 	select="$fontSizeTocTitle	[min(($topicLevel, last()))]"/>
		<xsl:variable name="fontSizePage" 	as="xs:double" 	select="$fontSizeTocPage	[min(($topicLevel, last()))]"/>
		<xsl:variable name="spaceBefore" 	as="xs:double" 	select="$spaceBeforeToc		[min(($topicLevel, last()))]"/>
		<xsl:variable name="spaceAfter" 	as="xs:double" 	select="$spaceAfterToc		[min(($topicLevel, last()))]"/>
		<xsl:variable name="marginLeft" 	as="xs:double" 	select="$marginLeftToc		[min(($topicLevel, last()))]"/>
		<xsl:variable name="numWidth" 		as="xs:double" 	select="$numWidthToc		[min(($topicLevel, last()))]"/>
		
		<xsl:choose>
			<xsl:when test="$navTitleNum">
				<fo:list-block
						space-before						= "{$spaceBefore}mm" 
						space-after							= "{$spaceAfter}mm"
						margin-left							= "{$marginLeft}mm"
						provisional-distance-between-starts	= "{$numWidth}mm"
						font-family							= "{$fontFamilyTitle}">
					
					<!--<xsl:attribute name="color">
						<xsl:call-template name="e:profilingColor"/>
					</xsl:attribute>-->
					
					<xsl:call-template name="ds:tocFlagging">
						<xsl:with-param name="isLeaf" select="$isLeaf"/>
					</xsl:call-template>
					
					<fo:list-item>
						<fo:list-item-label end-indent="label-end()">
							<fo:block font-size="{$fontSizeTitle}pt">
								<fo:basic-link internal-destination="{$destId}" xsl:use-attribute-sets="__toc__link">
									<xsl:sequence select="$navTitleNum"/>
								</fo:basic-link>
							</fo:block>
							
						</fo:list-item-label>
						<fo:list-item-body start-indent="body-start()">
							<fo:block text-align-last="justify" font-size="{$fontSizeTitle}pt">
								<fo:basic-link internal-destination="{$destId}" xsl:use-attribute-sets="__toc__link">
									<fo:inline xsl:use-attribute-sets="__toc__title">
										<xsl:value-of select="normalize-space(string-join($navTitleTxt, ''))"/>
									</fo:inline>
									<xsl:if test="@status">
										<xsl:call-template name="StatusMarker">
											<xsl:with-param name="prefix"			select="' ('"/>
											<xsl:with-param name="suffix"			select="')'"/>
										</xsl:call-template>
									</xsl:if>
									<fo:inline font-size="{$fontSizePage}pt" xsl:use-attribute-sets="__toc__page-number">
										<fo:leader xsl:use-attribute-sets="__toc__leader"/>
										<fo:page-number-citation ref-id="{$destId}"/>
									</fo:inline>
								</fo:basic-link>
							</fo:block>
						</fo:list-item-body>
					</fo:list-item>
				</fo:list-block>
			</xsl:when>
			<xsl:otherwise>
				<fo:block
					space-before	= "{$spaceBefore}mm" 
					space-after		= "{$spaceAfter}mm"
					margin-left		= "{$marginLeft}mm"
					font-family		= "{$fontFamilyTitle}"
					text-align-last	= "justify" 
					font-size		= "{$fontSizeTitle}pt">
					
					<!--<xsl:attribute name="color">
						<xsl:call-template name="e:profilingColor"/>
					</xsl:attribute>-->
					
					<xsl:call-template name="ds:tocFlagging">
						<xsl:with-param name="isLeaf" select="$isLeaf"/>
					</xsl:call-template>
					
					<fo:basic-link internal-destination="{$destId}" xsl:use-attribute-sets="__toc__link">
						<fo:inline xsl:use-attribute-sets="__toc__title">
							<xsl:value-of select="normalize-space(string-join($navTitleTxt, ''))"/>
						</fo:inline>
						<fo:inline font-size="{$fontSizePage}pt" xsl:use-attribute-sets="__toc__page-number">
							<fo:leader xsl:use-attribute-sets="__toc__leader"/>
							<fo:page-number-citation ref-id="{$destId}"/>
						</fo:inline>
					</fo:basic-link>
				</fo:block>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:text>&#x0A;</xsl:text><!-- erleichert die Fehlersuche be FOP-Warnungen mit Zeilenangabe im topic.fo -->
	</xsl:template>
	
	<xsl:template match="*[contains(@class, ' glossentry/glossentry ')]" mode="toc" priority="10">
	<!--<xsl:message select="."/>-->
	</xsl:template>

	<xsl:template name="ds:tocFlagging">
		<xsl:param name="isLeaf" as="xs:boolean"/>
		
		<xsl:variable name="refContent" as="element()*" select="if ($isLeaf) then *[not(contains(@class,' topic/title '))] else *[contains(@class,' topic/body ')]"/>
		
		<xsl:variable name="ditavalStartprop" as="element()*" select="ancestor-or-self::*/*[contains(@class,' ditaot-d/ditaval-startprop ')][1]"/>
		<xsl:choose>
			<xsl:when test="exists($ditavalStartprop)">
				<xsl:apply-templates select="$ditavalStartprop" mode="flag-attributes"/>
			</xsl:when>
			<xsl:when test="exists($refContent[ds:containsRelevantChange(.)])">
				<xsl:apply-templates select="$ds:changedDitavalStartprop" mode="flag-attributes"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
