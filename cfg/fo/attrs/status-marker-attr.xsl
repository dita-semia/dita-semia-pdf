<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="2.0"
	xmlns:xs				= "http://www.w3.org/2001/XMLSchema" 
	xmlns:xsl				= "http://www.w3.org/1999/XSL/Transform" 
	xmlns:ditaarch			=  "http://dita.oasis-open.org/architecture/2005/"
	xmlns:opentopic			= "http://www.idiominc.com/opentopic"
	xmlns:opentopic-func	= "http://www.idiominc.com/opentopic/exsl/function"
	xmlns:ds				= "http://www.dita-semia.org"
	xmlns:gdvdl				= "http://www.gdv-dl.de"
	exclude-result-prefixes	= "#all">
	
	
	<xsl:attribute-set name="gdvdl:status-marker">
		<xsl:attribute name="font-family"	select="$fontFamilyBody"/>
		<xsl:attribute name="font-size"		>0.8em</xsl:attribute>
		<xsl:attribute name="font-weight"	>normal</xsl:attribute>
		<xsl:attribute name="font-style"	>italic</xsl:attribute>
		<xsl:attribute name="color"			>rgb(112,112,178)</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="gdvdl:status-marker-inline" use-attribute-sets="gdvdl:status-marker">
		
	</xsl:attribute-set>
	
	
	<xsl:attribute-set name="gdvdl:status-marker-block" use-attribute-sets="gdvdl:status-marker">
		
	</xsl:attribute-set>	
	
	
</xsl:stylesheet>
