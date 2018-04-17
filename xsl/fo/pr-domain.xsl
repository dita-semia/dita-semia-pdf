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
	
	<!-- special treatment for hyphenationwithin identifiers -->
	<xsl:template match="*[contains(@class,' pr-d/codeph ')]">
		<fo:inline xsl:use-attribute-sets="codeph">
			<xsl:call-template name="commonattributes"/>
			<xsl:variable name="content" as="node()*">
				<xsl:apply-templates/>	
			</xsl:variable>
			<xsl:apply-templates select="$content" mode="codeHyph"/>
		</fo:inline>
	</xsl:template>
	
	
</xsl:stylesheet>
