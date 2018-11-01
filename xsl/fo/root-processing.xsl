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
	<xsl:variable name="versionText" 	as="xs:string?" select="ds:getVersionText($bookmetaData)"/> 
		
	<xsl:variable name="fusszeileTitel" as="xs:string?" select="normalize-space(string-join($bookmetaData[@name = 'FusszeileTitel']//text()[not(matches(., '^\s+$'))], ''))"/>

	<xsl:variable name="bookTitleMain" 	as="xs:string?" select="/*/opentopic:map/*[contains(@class, ' bookmap/booktitle ')]/*[contains(@class, ' bookmap/mainbooktitle ')]"/>
	
	<xsl:variable name="bookTitleAlt" 	as="xs:string?" select="/*/opentopic:map/*[contains(@class, ' bookmap/booktitle ')]/*[contains(@class, ' bookmap/booktitlealt ')]"/>


</xsl:stylesheet>
