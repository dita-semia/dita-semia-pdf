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

	<xsl:variable name="bookmetaData" 	as="element()*" select="/*/opentopic:map/*[contains(@class, ' map/topicmeta ')]/*[contains(@class, ' topic/data ')]"/>
	
	<xsl:variable name="versionNummerCurr" 	as="xs:string?" select="ds:getRevFilterText($bookmetaData[@name = 'VersionNumber'], ('', 'unchanged', 'dsd:added'))"/>
	<xsl:variable name="versionDatumCurr" 	as="xs:string?" select="ds:getRevFilterText($bookmetaData[@name = 'VersionDate'], 	('', 'unchanged', 'dsd:added'))"/>
	<xsl:variable name="versionCurr"		as="xs:string?"	select="string-join(($versionNummerCurr, $versionDatumCurr), ', ')"/>
	<xsl:variable name="versionNummerPrev" 	as="xs:string?" select="ds:getRevFilterText($bookmetaData[@name = 'VersionNumber'],	('', 'unchanged', 'dsd:deleted'))"/>
	<xsl:variable name="versionDatumPrev" 	as="xs:string?" select="ds:getRevFilterText($bookmetaData[@name = 'VersionDate'], 	('', 'unchanged', 'dsd:deleted'))"/>
	<xsl:variable name="versionPrev"		as="xs:string?"	select="string-join(($versionNummerPrev, $versionDatumPrev), ', ')"/>
	<xsl:variable name="versionText" 	as="xs:string?">
		<xsl:choose>
			<xsl:when test="$versionCurr = $versionPrev">
				<xsl:sequence select="concat('Version ', $versionCurr)"/>
			</xsl:when>
			<xsl:when test="$versionNummerCurr = $versionNummerPrev">
				<xsl:sequence select="concat('Diff v', $versionCurr, ' zu ', $versionDatumPrev)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:sequence select="concat('Diff v', $versionCurr, ' zu v', $versionNummerPrev)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable> 
	<xsl:variable name="fusszeileTitel" as="xs:string?" select="normalize-space(string-join($bookmetaData[@name = 'FusszeileTitel']//text()[not(matches(., '^\s+$'))], ''))"/>

	<xsl:variable name="bookTitleMain" 	as="xs:string?" select="/*/opentopic:map/*[contains(@class, ' bookmap/booktitle ')]/*[contains(@class, ' bookmap/mainbooktitle ')]"/>
	
	<xsl:variable name="bookTitleAlt" 	as="xs:string?" select="/*/opentopic:map/*[contains(@class, ' bookmap/booktitle ')]/*[contains(@class, ' bookmap/booktitlealt ')]"/>

	<xsl:function name="ds:getRevFilterText" as="xs:string?">
		<xsl:param name="node"			as="node()?"/>
		<xsl:param name="statusList"	as="xs:string+"/>
		
		<xsl:variable name="textList" 	as="xs:string*" select="$node//text()[string((ancestor::*/@rev)[last()]) = $statusList]"/>
		<xsl:variable name="joined" 	as="xs:string?" select="normalize-space(string-join($textList, ''))"/>
		<xsl:sequence select="if ($joined = '') then () else $joined"/>
	</xsl:function>

</xsl:stylesheet>
