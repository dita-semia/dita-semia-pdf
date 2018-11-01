<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="2.0"
	xmlns:xs				= "http://www.w3.org/2001/XMLSchema" 
	xmlns:xsl				= "http://www.w3.org/1999/XSL/Transform" 
	xmlns:ditaarch			=  "http://dita.oasis-open.org/architecture/2005/"
	xmlns:opentopic			= "http://www.idiominc.com/opentopic"
	xmlns:opentopic-func	= "http://www.idiominc.com/opentopic/exsl/function"
	xmlns:ds				= "http://www.dita-semia.org"
	exclude-result-prefixes	= "#all">
	
	
	<xsl:attribute-set name="xref" use-attribute-sets="common.link">
		<xsl:attribute name="color">inherit</xsl:attribute>
		<xsl:attribute name="font-style">
			<xsl:choose>
				<xsl:when test="@outputclass = 'advanced-keyref'">inherit</xsl:when>
				<xsl:otherwise>italic</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
	</xsl:attribute-set>

</xsl:stylesheet>
