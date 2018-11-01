<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="2.0"
	xmlns:xs				= "http://www.w3.org/2001/XMLSchema" 
	xmlns:xsl				= "http://www.w3.org/1999/XSL/Transform" 
	xmlns:ditaarch			=  "http://dita.oasis-open.org/architecture/2005/"
	xmlns:opentopic			= "http://www.idiominc.com/opentopic"
	xmlns:opentopic-func	= "http://www.idiominc.com/opentopic/exsl/function"
	xmlns:ds				= "http://www.dita-semia.org"
	exclude-result-prefixes	= "#all">
	
	
	<!-- dl with outputclass "numbered-list-titles" -->
	
	<xsl:template name="ds:dl-numbered-list-label-length">
		<xsl:variable as="xs:integer*" name="labels">
			<xsl:variable name="depth" select="1"/>	<!-- no nesting supported -->
			<xsl:variable as="xs:string" name="format">
				<xsl:call-template name="getVariable">
					<xsl:with-param name="id" select="concat('Ordered List Format ', $depth)"/>
				</xsl:call-template>
			</xsl:variable>
			<xsl:for-each select="*[contains(@class, ' topic/dlentry ')]">
				<xsl:variable name="s">
					<xsl:call-template name="getVariable">
						<xsl:with-param name="id" select="concat('Ordered List Number ', $depth)"/>
						<xsl:with-param as="element()*" name="params">
							<number>
								<xsl:number format="{$format}"/>
							</number>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:variable>
				<xsl:sequence select="string-length(normalize-space($s))"/>
			</xsl:for-each>
		</xsl:variable>
		<xsl:sequence select="max($labels)"/>
	</xsl:template>
	
	
	<xsl:attribute-set name="ds:dlhead-tree" use-attribute-sets="ds:dlentry-tree">
		<xsl:attribute name="font-weight"		>bold</xsl:attribute>
		<xsl:attribute name="background-color"	>rgb(192,192,192)</xsl:attribute>
		<xsl:attribute name="font-size"			>12pt</xsl:attribute>
	</xsl:attribute-set>
	

</xsl:stylesheet>
