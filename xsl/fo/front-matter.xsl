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
	
	<!--cover-->
	<xsl:template name="createFrontCoverContents">
		
		<fo:block-container absolute-position="fixed" top="105mm" right="20mm" left="25mm" bottom="20mm" text-align="right">
			
			<xsl:if test="exists($bookTitleMain)">
				<fo:block font-size="40pt" font-family="{$fontFamilyTitle}" space-after="6mm" line-height="40pt">
					<xsl:value-of select="ds:makeCoverTitle($bookTitleMain)"/>
				</fo:block>
			</xsl:if>
			
			<xsl:if test="exists($bookTitleAlt)">
				<fo:block font-size="40pt" font-family="{$fontFamilyTitle}" space-after="6mm" line-height="40pt">
					<xsl:value-of select="ds:makeCoverTitle($bookTitleAlt)"/>
				</fo:block>
			</xsl:if>
			
			<xsl:if test="exists($versionText)">
				<fo:block font-size="20pt" font-family="{$fontFamilyTitle}">
					<xsl:value-of select="$versionText"/>
				</fo:block>	
			</xsl:if>
			
			<xsl:if test="exists($productLogo)">
				<fo:block-container absolute-position="fixed" top="35mm" right="20mm" left="25mm" bottom="20mm" text-align="center">
					<fo:block>
						<fo:external-graphic
							scaling			= "uniform" 
							content-width	= "80mm"
							src				= "url('{$customizationDir.url}common/artwork/{$productLogo}')"/>
					</fo:block>
				</fo:block-container>
			</xsl:if>
			
			<xsl:if test="$companyLogo">
				<fo:block-container absolute-position="fixed" top="205mm" right="20mm" left="25mm" bottom="20mm" text-align="center">
					<fo:block>
						<fo:external-graphic
							scaling			= "uniform" 
							content-height	= "50mm"
							src				= "url('{$customizationDir.url}common/artwork/{$companyLogo}')"/>
					</fo:block>
				</fo:block-container>
			</xsl:if>
		</fo:block-container>
	</xsl:template>
	
	<xsl:function name="ds:makeCoverTitle">
		<xsl:param name="title" as="xs:string?"/>
		<xsl:sequence select="$title"/>
	</xsl:function>
	
</xsl:stylesheet>
