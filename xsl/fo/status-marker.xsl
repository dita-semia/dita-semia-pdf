<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="2.0"
	xmlns:xs				= "http://www.w3.org/2001/XMLSchema" 
	xmlns:xsl				= "http://www.w3.org/1999/XSL/Transform"
	xmlns:fo				= "http://www.w3.org/1999/XSL/Format"
	xmlns:svg				= "http://www.w3.org/2000/svg" 
	xmlns:ditaarch			=  "http://dita.oasis-open.org/architecture/2005/"
	xmlns:opentopic			= "http://www.idiominc.com/opentopic"
	xmlns:opentopic-func	= "http://www.idiominc.com/opentopic/exsl/function"
	xmlns:ds				= "http://www.dita-semia.org"
	xmlns:gdvdl				= "http://www.gdv-dl.de"
	exclude-result-prefixes	= "#all">
	
	
	<xsl:template match="*[contains(@class, ' topic/p ')][@status]">
		<xsl:call-template name="InsertStatusMarker">
			<xsl:with-param name="inline" 	select="true()"/>
			<xsl:with-param name="append"	select="false()"/>
		</xsl:call-template>
	</xsl:template>
	
	
	<xsl:template match="*[contains(@class, ' topic/sli ')][@status]">
		<xsl:call-template name="InsertStatusMarker">
			<xsl:with-param name="inline" 	select="true()"/>
			<xsl:with-param name="append"	select="false()"/>
		</xsl:call-template>
	</xsl:template>
	
	
	<xsl:template match="*[contains(@class, ' topic/shortdesc ')][@status]">
		<xsl:call-template name="InsertStatusMarker">
			<xsl:with-param name="inline" 	select="true()"/>
			<xsl:with-param name="append"	select="false()"/>
		</xsl:call-template>
	</xsl:template>
	
	
	<xsl:template match="*[contains(@class, ' topic/ul ')][@status]" priority="100">
		<xsl:call-template name="StatusMarker">
			<xsl:with-param name="inline"	select="false()"/>
			<xsl:with-param name="prefix"	select="'('"/>
			<xsl:with-param name="suffix"	select="':) '"/>
		</xsl:call-template>
		<xsl:next-match/>
	</xsl:template>
	
	
	<xsl:template match="*[contains(@class, ' topic/section ')][@status]/*[contains(@class, ' topic/title ')][1]">
		<xsl:call-template name="InsertStatusMarker">
			<xsl:with-param name="inline" 			select="true()"/>
			<xsl:with-param name="append"			select="true()"/>
			<xsl:with-param name="statusElement"	select="parent::*"/>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template match="*[contains(@class, ' topic/topic ')][@status]/*[contains(@class, ' topic/title ')]" mode="getTitle" priority="10">
		<xsl:call-template name="InsertStatusMarker">
			<xsl:with-param name="inline" 			select="true()"/>
			<xsl:with-param name="append"			select="true()"/>
			<xsl:with-param name="statusElement"	select="parent::*"/>
		</xsl:call-template>
	</xsl:template>


	<xsl:template match="*[contains(@class, ' topic/strow ')][@status]/*[contains(@class, ' topic/stentry ')][1]">
		<xsl:call-template name="InsertStatusMarker">
			<xsl:with-param name="inline" 			select="false()"/>
			<xsl:with-param name="append"			select="true()"/>
			<xsl:with-param name="statusElement"	select="parent::*"/>
		</xsl:call-template>
	</xsl:template>
	
	
	<xsl:template match="*[contains(@class, ' topic/dlentry ')][@status]/*[contains(@class, ' topic/dt ')][1]" mode="#default dl-bullet-list-titles dl-numbered-list-titles dl-tree dl-table dl-parameter-table dl-header-table" priority="10">
		<xsl:call-template name="InsertStatusMarker">
			<xsl:with-param name="inline" 			select="true()"/>
			<xsl:with-param name="append"			select="true()"/>
			<xsl:with-param name="statusElement"	select="parent::*"/>
		</xsl:call-template>
	</xsl:template>
	
	
	<xsl:template match="*[contains(@class, ' topic/dlentry ')][@status]/*[contains(@class, ' topic/dt ')][1]" mode="dl-bullet-list-dashes" priority="10">
		<xsl:call-template name="InsertStatusMarker">
			<xsl:with-param name="inline" 			select="true()"/>
			<xsl:with-param name="append"			select="false()"/>
			<xsl:with-param name="statusElement"	select="parent::*"/>
		</xsl:call-template>
	</xsl:template>
	
	
	<xsl:template name="InsertStatusMarker">
		<xsl:param name="inline"			as="xs:boolean"/>
		<xsl:param name="append"			as="xs:boolean"/>
		<xsl:param name="statusElement"		as="element()"	select="."/>
		<xsl:param name="noStatusMarker" 	as="xs:boolean"	select="false()" tunnel="yes"/>
		
		<xsl:choose>
			<xsl:when test="$noStatusMarker">
				<xsl:next-match/>	
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="fo" as="element()">
					<xsl:next-match/>
				</xsl:variable>
				<xsl:call-template name="InsertStatusMarkerIntoElement">
					<xsl:with-param name="element"	select="$fo"/>
					<xsl:with-param name="append"	select="$append"/>
					<xsl:with-param name="marker" as="node()*">
						<xsl:call-template name="StatusMarker">
							<xsl:with-param name="statusElement"	select="$statusElement"/>
							<xsl:with-param name="inline"			select="$inline"/>
							<xsl:with-param name="prefix"			select="if ($inline and $append) then ' (' else '('"/>
							<xsl:with-param name="suffix"			select="if ($inline and not($append)) then ':) ' else if (not($append)) then ':)' else ')'"/>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="InsertStatusMarkerIntoElement">
		<xsl:param name="element"	as="element()"/>
		<xsl:param name="append"	as="xs:boolean"/>
		<xsl:param name="marker"	as="node()?"/>
		
		<xsl:variable name="isMarkerInline" as="xs:boolean" select="exists($marker/self::fo:inline)"/>
		
		<!--<xsl:message>InsertStatusMarkerIntoElement element: <xsl:value-of select="name($element)"/></xsl:message>-->
		
		<xsl:for-each select="$element">
			<xsl:copy>
				<xsl:copy-of select="attribute()"/>
				
				<xsl:variable name="child" 			as="node()?" 	select="node()[self::element() | self::text()][not(self::fo:list-item-label)][if ($append) then last() else 1]"/>
				<xsl:variable name="isChildInline" 	as="xs:boolean" select="exists($child/self::fo:inline | $child/self::text())"/>
				<xsl:variable name="isChildBlock" 	as="xs:boolean" select="exists($child/self::fo:block)"/>
				
				<!--<xsl:message>  child:<xsl:value-of select="name($child)"/>, isChildInline: <xsl:value-of select="$isChildInline"/>, isChildBlock: <xsl:value-of select="$isChildBlock"/></xsl:message>-->
				
				<xsl:choose>
					<xsl:when test="($isMarkerInline and $isChildInline) or (not($isMarkerInline) and $isChildBlock) or not($child/self::element())">
						<!-- valid position or no further recursion possible, so insert marker here -->
						<xsl:if test="not($append)">
							<xsl:copy-of select="$marker"/>
						</xsl:if>
						<xsl:copy-of select="node()"/>
						<!--<xsl:message>  insert marker: <xsl:copy-of select="$marker"/></xsl:message>-->
						<xsl:if test="$append">
							<xsl:copy-of select="$marker"/>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<!-- no valid position, so recurse into child -->
						<xsl:copy-of select="$child/preceding-sibling::node()"/>
						<!--<xsl:message>  recurse...</xsl:message>-->
						<xsl:call-template name="InsertStatusMarkerIntoElement">
							<xsl:with-param name="element"	select="$child"/>
							<xsl:with-param name="append"	select="$append"/>
							<xsl:with-param name="marker"	select="$marker"/>
						</xsl:call-template>
						<xsl:copy-of select="$child/following-sibling::node()"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:copy>
		</xsl:for-each>
	</xsl:template>
	

	
	<xsl:template name="StatusMarker">
		<xsl:param name="statusElement"	as="element()"	select="."/>
		<xsl:param name="inline" 		as="xs:boolean" select="true()"/>
		<xsl:param name="prefix" 		as="xs:string"/>
		<xsl:param name="suffix" 		as="xs:string"/>
		
		<xsl:variable name="text" as="xs:string?" select="
			if 		($statusElement/@status = 'new') 		then 'neu'
			else if ($statusElement/@status = 'deleted') 	then 'entfallen'
			else if ($statusElement/@status = 'changed') 	then 'geändert'
			else if ($statusElement/@status = 'unchanged') 	then 'unverändert'
			else ()"/>
		
		<xsl:if test="$text">
			
			<xsl:variable name="content" as="text()*">
				<xsl:value-of select="$prefix"/>
				<xsl:value-of select="$text"/>
				<xsl:value-of select="$suffix"/>
			</xsl:variable>
			
			<xsl:choose>
				<xsl:when test="$inline">
					<fo:inline xsl:use-attribute-sets="gdvdl:status-marker-inline">
						<xsl:processing-instruction name="STATUS-MARKER"/>
						<xsl:sequence select="$content"/>
					</fo:inline>
				</xsl:when>
				<xsl:otherwise>
					<fo:block xsl:use-attribute-sets="gdvdl:status-marker-block">
						<xsl:processing-instruction name="STATUS-MARKER"/>
						<xsl:sequence select="$content"/>
					</fo:block>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		
	</xsl:template>
	

</xsl:stylesheet>
