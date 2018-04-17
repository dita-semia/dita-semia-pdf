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
	
	<!-- glossentry shold look like a section -->
	
	<xsl:template match="*[contains(@class, ' glossentry/glossentry ')]">
		<fo:block>
			<xsl:call-template name="commonattributes"/>
			<fo:block>
				<xsl:attribute name="id">
					<xsl:call-template name="generate-toc-id"/>
				</xsl:attribute>
				<fo:block xsl:use-attribute-sets="section.title">
					<xsl:apply-templates select="*[contains(@class, ' glossentry/glossterm ')]/node()"/>
				</fo:block>
				<fo:block xsl:use-attribute-sets="__glossary__def">
					<xsl:apply-templates select="*[contains(@class, ' glossentry/glossdef ')]/node()"/>
				</fo:block>
			</fo:block>
		</fo:block>
	</xsl:template>
	
		
</xsl:stylesheet>
