<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="2.0"
	xmlns:xs				= "http://www.w3.org/2001/XMLSchema" 
	xmlns:xsl				= "http://www.w3.org/1999/XSL/Transform" 
	xmlns:ditaarch			=  "http://dita.oasis-open.org/architecture/2005/"
	xmlns:opentopic			= "http://www.idiominc.com/opentopic"
	xmlns:opentopic-func	= "http://www.idiominc.com/opentopic/exsl/function"
	xmlns:ds				= "http://www.dita-semia.org"
	exclude-result-prefixes	= "#all">
	
	<!--list-->
	<xsl:attribute-set name="ol">
		<xsl:attribute name="provisional-distance-between-starts">
			<xsl:call-template name="ds:list-label-length"/>
			<xsl:text>em * 0.6</xsl:text>
		</xsl:attribute>
		<xsl:attribute name="keep-with-previous.within-page">
			<xsl:call-template name="ds:list-keep-with-introduction"/>
		</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:template name="ds:list-label-length">
		<!-- Das Template wird auch bei dl mit @outputclass = numbered-list-titles ausgeführt. -->
		<xsl:variable as="xs:integer*" name="labels">					
			<xsl:variable name="depth" select="count(ancestor-or-self::*[(contains(@class, ' topic/ol ')) or (contains(@class, ' topic/dl ') and (@outputclass = $DL_OUTPUTCLASS_NUMBERED_LIST_TITLES))])"/>
			<xsl:variable as="xs:string" name="format">
				<xsl:call-template name="getVariable">
					<xsl:with-param name="id" select="concat('Ordered List Format ', $depth)"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:for-each select="*[contains(@class, ' topic/li ') or contains(@class, ' topic/dlentry ')]">
				<xsl:variable name="s">
					<xsl:call-template name="getVariable">
						<xsl:with-param name="id" select="concat('Ordered List Number ', $depth)"/>
						<xsl:with-param as="element()*" name="params">
							<number>
								<xsl:number format="{$format}"/>
							</number>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>
				<xsl:sequence select="string-length(normalize-space($s))"/>
			</xsl:for-each>
		</xsl:variable>
		<xsl:sequence select="max($labels)"/>
	</xsl:template>

	<xsl:template name="ds:list-keep-with-introduction">
		<!-- Motivation: Eine Liste sollte immer mit einem Text eingeleitet werden. -->
		<xsl:choose>
			<xsl:when test="contains(preceding-sibling::*[1]/@class, ' topic/p ')">always</xsl:when>
			<xsl:otherwise>auto</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:attribute-set name="ul">
		<xsl:attribute name="keep-with-previous.within-page">
			<xsl:call-template name="ds:list-keep-with-introduction"/>
		</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="ds:li.title">
		<xsl:attribute name="font-weight"					>bold</xsl:attribute>
		<xsl:attribute name="keep-with-next.within-column"	>always</xsl:attribute>
	</xsl:attribute-set>
	
	
	
	<xsl:attribute-set name="ds:dlhead-table">
		<xsl:attribute name="background-color"	>rgb(192,192,192)</xsl:attribute>
		<xsl:attribute name="font-size"			>12pt</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="ds:dlentry-table">
	</xsl:attribute-set>
	
	
	
</xsl:stylesheet>
