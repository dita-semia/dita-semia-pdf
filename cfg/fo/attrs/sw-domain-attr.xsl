<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="2.0"
	xmlns:xs				= "http://www.w3.org/2001/XMLSchema" 
	xmlns:xsl				= "http://www.w3.org/1999/XSL/Transform" 
	xmlns:ditaarch			=  "http://dita.oasis-open.org/architecture/2005/"
	xmlns:opentopic			= "http://www.idiominc.com/opentopic"
	xmlns:opentopic-func	= "http://www.idiominc.com/opentopic/exsl/function"
	xmlns:ds				= "http://www.dita-semia.org"
	exclude-result-prefixes	= "#all">



	<xsl:attribute-set name="msgblock">
		<xsl:attribute name="font-family"		select="$fontFamilyBody"/>
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
	
	
	<xsl:attribute-set name="filepath" use-attribute-sets="base-font">
		<xsl:attribute name="font-family">inherit</xsl:attribute>
		<xsl:attribute name="font-style">italic</xsl:attribute>
	</xsl:attribute-set>

</xsl:stylesheet>
