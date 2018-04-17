<?xml version="1.0" encoding="UTF-8"?>
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
	
	
	<!-- mode: GetTopicTitlePrefix -->
	
	<xsl:template name="GetTopicTitlePrefix" as="xs:string?">
		<xsl:param name="numLst"	as="xs:integer*">
			<xsl:apply-templates select="." mode="GetTopicNum"/>
		</xsl:param>
		<xsl:param name="rootTopicRef" as="element()?">
			<xsl:apply-templates select="." mode="GetRootTopicRef"/>
		</xsl:param>

		<xsl:choose>
			<xsl:when test="contains($rootTopicRef/@class, $CLASS_FRONTMATTER)"/>
			<xsl:when test="contains($rootTopicRef/@class, $CLASS_BACKMATTER)"/>
			<xsl:when test="(contains($rootTopicRef/@class, $CLASS_APPENDIX)) and (count($numLst) = 1)">
				<xsl:variable name="num" as="xs:string?">
					<xsl:number value="$numLst" format="A.1"/>
				</xsl:variable>
				<xsl:sequence select="concat('Anhang ', $num, ': ')"/>
			</xsl:when>
			<xsl:when test="contains($rootTopicRef/@class, $CLASS_APPENDIX)">
				<xsl:number value="$numLst" format="A.1"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:number value="$numLst" format="1.1"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	
	<!-- mode: GetTopicNum -->
	
	<xsl:template match="*[contains(@class, $CLASS_CHAPTER)]" mode="GetTopicNum" as="xs:integer*" priority="2">
		<xsl:sequence select="count(preceding-sibling::*[contains(@class, $CLASS_CHAPTER)]) + 1"/>
	</xsl:template>

	<xsl:template match="*[contains(@class, $CLASS_APPENDIX)]" mode="GetTopicNum" as="xs:integer*" priority="2">
		<xsl:sequence select="count(preceding-sibling::*[contains(@class, $CLASS_APPENDIX)]) + 1"/>
	</xsl:template>
	
	<xsl:template match="*[contains(@class, $CLASS_TOPICREF)]" mode="GetTopicNum" as="xs:integer*">
		<xsl:apply-templates select="parent::*" mode="#current"/>
		<xsl:sequence select="count(preceding-sibling::*[contains(@class, $CLASS_TOPICREF)]) + 1"/>
	</xsl:template>
	
	<xsl:template match="*[contains(@class, $CLASS_TOPIC)]/*[contains(@class, $CLASS_TOPIC)]" mode="GetTopicNum" as="xs:integer*" priority="2">
		<xsl:apply-templates select="parent::*" mode="#current"/>
		<xsl:sequence select="count(preceding-sibling::*[contains(@class, $CLASS_TOPIC)]) + 1"/>
	</xsl:template>
	
	<xsl:template match="*[contains(@class, $CLASS_TOPIC)]" mode="GetTopicNum" as="xs:integer*">
		<xsl:apply-templates select="key('map-id', @id)[1]" mode="#current"/>
	</xsl:template>
	
	
	<xsl:template match="node()" mode="GetTopicNum">
		<!-- default: abort recursion -->
	</xsl:template>
		
		
		
	<!-- mode: GetRootTopicRef -->
	
	<xsl:template match="*[contains(@class, $CLASS_TOPICREF)]/*[contains(@class, $CLASS_TOPICREF)]" mode="GetRootTopicRef" as="element()?" priority="2">
		<xsl:apply-templates select="parent::*" mode="#current"/>
	</xsl:template>
	
	<xsl:template match="*[contains(@class, $CLASS_TOPICREF)]" mode="GetRootTopicRef" as="element()?">
		<xsl:sequence select="."/>
	</xsl:template>

	<xsl:template match="*[contains(@class, $CLASS_TOPIC)]/*[contains(@class, $CLASS_TOPIC)]" mode="GetRootTopicRef" as="element()?" priority="2">
		<xsl:apply-templates select="parent::*" mode="#current"/>
	</xsl:template>
	
	<xsl:template match="*[contains(@class, $CLASS_TOPIC)]" mode="GetRootTopicRef" as="element()?">
		<xsl:apply-templates select="key('map-id', @id)[1]" mode="#current"/>
	</xsl:template>
	
	<xsl:template match="node()" mode="GetRootTopicRef" as="element()?">
		<xsl:apply-templates select="parent::*" mode="#current"/>
	</xsl:template>
	

</xsl:stylesheet>
