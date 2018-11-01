<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="2.0" 
	xmlns:xsl	= "http://www.w3.org/1999/XSL/Transform"
	xmlns:xs	= "http://www.w3.org/2001/XMLSchema"
	xmlns:xsi	= "http://www.w3.org/2001/XMLSchema-instance"
	xmlns:ds	= "http://www.dita-semia.org"
	exclude-result-prefixes="#all">
	
	
	<xsl:function name="ds:getVersionText" as="xs:string">
		<xsl:param name="bookmetaData" 	as="element()*"/>
		
		<xsl:variable name="versionNummerCurr" 	as="xs:string?" select="ds:getRevFilterText($bookmetaData[@name = 'VersionNumber'], ('', 'unchanged', 'dsd:added'))"/>
		<xsl:variable name="versionDatumCurr" 	as="xs:string?" select="ds:getRevFilterText($bookmetaData[@name = 'VersionDate'], 	('', 'unchanged', 'dsd:added'))"/>
		<xsl:variable name="versionCurr"		as="xs:string?"	select="string-join(($versionNummerCurr, $versionDatumCurr), ', ')"/>
		<xsl:variable name="versionNummerPrev" 	as="xs:string?" select="ds:getRevFilterText($bookmetaData[@name = 'VersionNumber'],	('', 'unchanged', 'dsd:deleted'))"/>
		<xsl:variable name="versionDatumPrev" 	as="xs:string?" select="ds:getRevFilterText($bookmetaData[@name = 'VersionDate'], 	('', 'unchanged', 'dsd:deleted'))"/>
		<xsl:variable name="versionPrev"		as="xs:string?"	select="string-join(($versionNummerPrev, $versionDatumPrev), ', ')"/>
		
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
	</xsl:function>
	

	<xsl:function name="ds:getRevFilterText" as="xs:string?">
		<xsl:param name="node"			as="node()?"/>
		<xsl:param name="statusList"	as="xs:string+"/>
		
		<xsl:variable name="textList" 	as="xs:string*" select="$node//text()[string((ancestor::*/@rev)[last()]) = $statusList]"/>
		<xsl:variable name="joined" 	as="xs:string?" select="normalize-space(string-join($textList, ''))"/>
		<xsl:sequence select="if ($joined = '') then () else $joined"/>
	</xsl:function>
	

</xsl:transform>