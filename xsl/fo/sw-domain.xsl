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


	<xsl:template match="*[contains(@class,' sw-d/filepath ')]">
		<fo:inline xsl:use-attribute-sets="filepath">
			<xsl:call-template name="commonattributes"/>
			<fo:basic-link>
				<xsl:attribute name="external-destination">
					<xsl:text>url('</xsl:text>
					<xsl:value-of select="replace(text(), '\\', '/')"/>
					<xsl:text>')</xsl:text>
				</xsl:attribute>
				<xsl:apply-templates/>
			</fo:basic-link>
		</fo:inline>
	</xsl:template>

</xsl:stylesheet>
