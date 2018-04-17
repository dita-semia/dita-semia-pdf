<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:rx="http://www.renderx.com/XSL/Extensions"
    version="2.0">
	
	
	<xsl:attribute-set name ="__lotf__content" use-attribute-sets="base-font">
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-size">11pt</xsl:attribute>
		<xsl:attribute name="space-before">0pt</xsl:attribute>
		<xsl:attribute name="space-after">0pt</xsl:attribute>
		<xsl:attribute name="font-family"><xsl:value-of select="$fontFamilyTitle"/></xsl:attribute>
		<xsl:attribute name="text-align">start</xsl:attribute>
		<xsl:attribute name="text-align-last">start</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name ="__lotf__leader">
		<xsl:attribute name="leader-pattern">dots</xsl:attribute>
		<xsl:attribute name="text-align">right</xsl:attribute>
		<xsl:attribute name="leader-pattern-width">2mm</xsl:attribute>
		<xsl:attribute name="leader-alignment">reference-area</xsl:attribute>
	</xsl:attribute-set>
	
</xsl:stylesheet>
