<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="2.0"
	xmlns:xs				= "http://www.w3.org/2001/XMLSchema" 
	xmlns:xsl				= "http://www.w3.org/1999/XSL/Transform" 
	xmlns:ditaarch			=  "http://dita.oasis-open.org/architecture/2005/"
	xmlns:opentopic			= "http://www.idiominc.com/opentopic"
	xmlns:opentopic-func	= "http://www.idiominc.com/opentopic/exsl/function"
	xmlns:ds				= "http://www.dita-semia.org"
	exclude-result-prefixes	= "#all">
	
	<xsl:attribute-set name="codeblock">
		<xsl:attribute name="font-family"		select="$fontFamilyCode"/>
		<xsl:attribute name="font-size"			>10pt</xsl:attribute>
		<xsl:attribute name="color"				>black</xsl:attribute>
		<xsl:attribute name="font-weight"		>normal</xsl:attribute>
		<xsl:attribute name="font-style"		>normal</xsl:attribute>
		<xsl:attribute name="text-decoration"	>none</xsl:attribute>
		<xsl:attribute name="space-before">
			<xsl:call-template name="ds:paragraphSpaceBefore"/>		
		</xsl:attribute>
		<xsl:attribute name="space-after">
			<xsl:call-template name="ds:paragraphSpaceAfter"/>
		</xsl:attribute>
		<xsl:attribute name="text-align"		>start</xsl:attribute>
		<xsl:attribute name="start-indent"		>0</xsl:attribute>
		<xsl:attribute name="line-height"		>120%</xsl:attribute>
		<xsl:attribute name="padding-top"		>1.0mm</xsl:attribute>
		<xsl:attribute name="padding-right"		>1.0mm</xsl:attribute>
		<xsl:attribute name="padding-bottom"	>0.5mm</xsl:attribute>
		<xsl:attribute name="padding-left"		>1.0mm</xsl:attribute>
		<xsl:attribute name="end-indent"		>from-parent(end-indent) + 0pt</xsl:attribute>
		<xsl:attribute name="widows"			>5</xsl:attribute>
		<xsl:attribute name="orphans"			>5</xsl:attribute>
		<xsl:attribute name="margin-left"		>0</xsl:attribute>
		<xsl:attribute name="margin-right"		>0</xsl:attribute>
		<xsl:attribute name="background-color"	>rgb(240,240,240)</xsl:attribute>
		<xsl:attribute name="border-style"		>dashed</xsl:attribute>
		<xsl:attribute name="border-color"		>rgb(128,128,128)</xsl:attribute>
		<xsl:attribute name="border-width"		>0.3mm</xsl:attribute>
		<xsl:attribute name="hyphenate"			>false</xsl:attribute>
	</xsl:attribute-set>
	
	
	<xsl:attribute-set name="codeph">
		<xsl:attribute name="font-family"		select="$fontFamilyCode"/>
		<xsl:attribute name="font-size"		>0.9em</xsl:attribute>
		<!--<xsl:attribute name="font-weight"	select="if (ancestor::*[contains(@class, ' topic/title ')]) then 'bold' else 'normal'"/>-->
	</xsl:attribute-set>
	
</xsl:stylesheet>
