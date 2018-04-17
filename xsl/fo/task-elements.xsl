<?xml version='1.0'?>
<xsl:stylesheet version="2.0"
	xmlns:xs				= "http://www.w3.org/2001/XMLSchema" 
	xmlns:xsl				= "http://www.w3.org/1999/XSL/Transform"
	xmlns:svg				= "http://www.w3.org/2000/svg" 
	xmlns:fo				= "http://www.w3.org/1999/XSL/Format"
	xmlns:dita2xslfo		= "http://dita-ot.sourceforge.net/ns/200910/dita2xslfo"
	xmlns:ds				= "http://www.dita-semia.org"
	exclude-result-prefixes	= "#all">

	<xsl:param name="GENERATE-TASK-LABELS">YES</xsl:param>
	
	<!-- kein Fallback -->
	<xsl:template match="*" mode="dita2xslfo:retrieve-task-heading">
		<xsl:param name="pdf2-string"/>
		<xsl:param name="common-string"/>
		
		<xsl:call-template name="getVariable">
			<xsl:with-param name="id" select="$pdf2-string"/>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template match="*[contains(@class, ' task/stepxmp ')]">
		<fo:block xsl:use-attribute-sets="li.itemgroup">
			<xsl:call-template name="commonattributes"/>
			<fo:block xsl:use-attribute-sets="ds:stepxmp-heading">Beispiel:</fo:block>
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

</xsl:stylesheet>
