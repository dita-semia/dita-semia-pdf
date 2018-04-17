<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="2.0"
	xmlns:xs				= "http://www.w3.org/2001/XMLSchema" 
	xmlns:xsl				= "http://www.w3.org/1999/XSL/Transform" 
	xmlns:ditaarch			=  "http://dita.oasis-open.org/architecture/2005/"
	xmlns:opentopic			= "http://www.idiominc.com/opentopic"
	xmlns:opentopic-func	= "http://www.idiominc.com/opentopic/exsl/function"
	xmlns:ds				= "http://www.dita-semia.org"
	exclude-result-prefixes	= "#all">
	
	<xsl:variable name="toc.text-indent" select="'0mm'"/>	<!-- don't indend the 1st line different from the others -->
	
	<xsl:attribute-set name="__toc__indent__booklist" use-attribute-sets="__toc__indent">
		<xsl:attribute name="start-indent"><xsl:value-of select="$side-col-width"/> + <xsl:value-of select="$toc.text-indent"/></xsl:attribute>
		<xsl:attribute name="space-before">5pt</xsl:attribute>
		<xsl:attribute name="space-after">5pt</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="__toc__header" use-attribute-sets="common.title">
		<xsl:attribute name="border-after-style">none</xsl:attribute>
		<xsl:attribute name="space-before">4mm</xsl:attribute>
		<xsl:attribute name="space-after">4mm</xsl:attribute>
		<xsl:attribute name="font-size">20pt</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="padding-top">0</xsl:attribute>
		<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="__toc__leader">
		<xsl:attribute name="leader-pattern">dots</xsl:attribute>
		<xsl:attribute name="text-align">right</xsl:attribute>
		<xsl:attribute name="leader-pattern-width">2mm</xsl:attribute>
		<xsl:attribute name="leader-alignment">reference-area</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="__toc__page-number">
		<xsl:attribute name="start-indent">0</xsl:attribute>
		<xsl:attribute name="keep-together.within-line">always</xsl:attribute>
		<xsl:attribute name="padding-left">1mm</xsl:attribute>
	</xsl:attribute-set>
	
</xsl:stylesheet>
