<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="2.0"
	xmlns:xs				= "http://www.w3.org/2001/XMLSchema" 
	xmlns:xsl				= "http://www.w3.org/1999/XSL/Transform" 
	xmlns:ditaarch			=  "http://dita.oasis-open.org/architecture/2005/"
	xmlns:opentopic			= "http://www.idiominc.com/opentopic"
	xmlns:opentopic-func	= "http://www.idiominc.com/opentopic/exsl/function"
	xmlns:ds				= "http://www.dita-semia.org"
	exclude-result-prefixes	= "#all">
	
	<xsl:attribute-set name="region-body.odd">
		<xsl:attribute name="column-count">1</xsl:attribute>
		<xsl:attribute name="column-gap">12pt</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="region-body.even">
		<xsl:attribute name="column-count">1</xsl:attribute>
		<xsl:attribute name="column-gap">12pt</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="region-bodyfrontmatter.odd">
		<xsl:attribute name="column-count">1</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="region-bodyfrontmatter.even">
		<xsl:attribute name="column-count">1</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="region-bodyindex.odd">
		<xsl:attribute name="column-count">2</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="region-bodyindex.even">
		<xsl:attribute name="column-count">2</xsl:attribute>
	</xsl:attribute-set>
	
</xsl:stylesheet>
