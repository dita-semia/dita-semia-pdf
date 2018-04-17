<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="2.0"
	xmlns:xs				= "http://www.w3.org/2001/XMLSchema" 
	xmlns:xsl				= "http://www.w3.org/1999/XSL/Transform" 
	xmlns:ditaarch			=  "http://dita.oasis-open.org/architecture/2005/"
	xmlns:opentopic			= "http://www.idiominc.com/opentopic"
	xmlns:opentopic-func	= "http://www.idiominc.com/opentopic/exsl/function"
	xmlns:ds				= "http://www.dita-semia.org"
	exclude-result-prefixes	= "#all">
	
	<xsl:attribute-set name="ds:header">
		<xsl:attribute name="space-before">0</xsl:attribute>
		<xsl:attribute name="space-before.conditionality">retain</xsl:attribute>
		<xsl:attribute name="font-family" 	select="$fontFamilyTitle"/>
		<xsl:attribute name="margin-top"	select="'19mm'"/>
		<xsl:attribute name="border-bottom"	select="'solid black 0.5pt'"/>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="odd__header" use-attribute-sets="ds:header">
		<xsl:attribute name="text-align">end</xsl:attribute>
		<xsl:attribute name="end-indent">0</xsl:attribute>
		<xsl:attribute name="margin-left"	select="$page-margin-inside"/>
		<xsl:attribute name="margin-right"	select="$page-margin-outside"/>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="even__header" use-attribute-sets="ds:header">
		<xsl:attribute name="start-indent">0</xsl:attribute>
		<xsl:attribute name="margin-left"	select="$page-margin-outside"/>
		<xsl:attribute name="margin-right"	select="$page-margin-inside"/>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="ds:header_inner">
		<xsl:attribute name="background-color"	select="'transparent'"/>
		<xsl:attribute name="padding-top"		select="'0mm'"/>
		<xsl:attribute name="padding-bottom"	select="'0mm'"/>
		<xsl:attribute name="padding-left"		select="'0mm'"/>
		<xsl:attribute name="padding-right"		select="'0mm'"/>
		
	</xsl:attribute-set>
	
	<xsl:attribute-set name="ds:body_header_line_1">
		<xsl:attribute name="font-size"		>12pt</xsl:attribute>
		<xsl:attribute name="space-after"	>0.0mm</xsl:attribute>
		<xsl:attribute name="wrap-option"	>no-wrap</xsl:attribute>
		<xsl:attribute name="color"			>inherit</xsl:attribute>	
	</xsl:attribute-set>
	
	<xsl:attribute-set name="ds:body_header_line_2">
		<xsl:attribute name="font-size"		>10pt</xsl:attribute>
		<xsl:attribute name="margin-top"	>0.5mm</xsl:attribute>
		<xsl:attribute name="space-after"	>1.0mm</xsl:attribute>
		<xsl:attribute name="wrap-option"	>no-wrap</xsl:attribute>
		<xsl:attribute name="font-family"	>inherit</xsl:attribute>
	</xsl:attribute-set>
	
	
	<xsl:attribute-set name="odd__footer">
		<xsl:attribute name="text-align">end</xsl:attribute>
		<xsl:attribute name="end-indent">0</xsl:attribute>
		<xsl:attribute name="space-after">0</xsl:attribute>
		<xsl:attribute name="space-after.conditionality">retain</xsl:attribute>
		<xsl:attribute name="margin-left"	select="$page-margin-inside"/>
		<xsl:attribute name="margin-right"	select="$page-margin-outside"/>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="even__footer">
		<xsl:attribute name="start-indent">0</xsl:attribute>
		<xsl:attribute name="space-after">0</xsl:attribute>
		<xsl:attribute name="space-after.conditionality">retain</xsl:attribute>
		<xsl:attribute name="margin-left"	select="$page-margin-outside"/>
		<xsl:attribute name="margin-right"	select="$page-margin-inside"/>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="region-after">
		<xsl:attribute name="display-align">auto</xsl:attribute>	<!-- let the footer begin right at the bottom of the body -->
	</xsl:attribute-set>
	
</xsl:stylesheet>
