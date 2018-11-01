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
	
	<!--list-->
	<xsl:template match="*[contains(@class, ' topic/ul ')]/*[contains(@class, ' topic/li ')]">
		
		<fo:list-item xsl:use-attribute-sets="ul.li">
			<xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')]" mode="flag-attributes"/>
			<!--<xsl:call-template name="e:compactSpacing"/>-->
			<xsl:call-template name="ds:listItemOrphanWidows"/>
			<fo:list-item-label xsl:use-attribute-sets="ul.li__label">
				<fo:block xsl:use-attribute-sets="ul.li__label__content">
					<xsl:call-template name="commonattributes"/>
					<xsl:call-template name="ds:listItemLabel"/>
				</fo:block>
			</fo:list-item-label>
			<fo:list-item-body xsl:use-attribute-sets="ul.li__body">
				<fo:block xsl:use-attribute-sets="ul.li__content">
					<xsl:apply-templates/>
				</fo:block>
			</fo:list-item-body>
		</fo:list-item>
		
	</xsl:template>
	
	
	<xsl:template match="*[contains(@class, ' topic/ol ')]/*[contains(@class, ' topic/li ')]">
		
		<xsl:variable name="depth" select="count(ancestor::*[contains(@class, ' topic/ol ')])"/>
		
		<xsl:variable name="format">
			<xsl:call-template name="getVariable">
				<xsl:with-param name="id" select="concat('Ordered List Format ', $depth)"/>
			</xsl:call-template>
		</xsl:variable>
		
		<fo:list-item xsl:use-attribute-sets="ol.li">
			<xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')]" mode="flag-attributes"/>
			<!--<xsl:call-template name="e:compactSpacing"/>-->
			<xsl:call-template name="ds:listItemOrphanWidows"/>
			<fo:list-item-label xsl:use-attribute-sets="ol.li__label">
				<fo:block xsl:use-attribute-sets="ol.li__label__content">
					<fo:inline>
						<xsl:call-template name="commonattributes"/>
					</fo:inline>
					<xsl:call-template name="getVariable">
						<xsl:with-param name="id" select="concat('Ordered List Number ', $depth)"/>
						<xsl:with-param as="element()*" name="params">
							<number>
								<xsl:number format="{$format}"/>
							</number>
						</xsl:with-param>
					</xsl:call-template>
				</fo:block>
			</fo:list-item-label>
			<fo:list-item-body xsl:use-attribute-sets="ol.li__body">
				<fo:block xsl:use-attribute-sets="ol.li__content">
					<xsl:apply-templates/>
				</fo:block>
			</fo:list-item-body>
		</fo:list-item>
		
	</xsl:template>
	
	<xsl:template match="*[contains(@class, ' topic/li ')]/*[contains(@class, ' topic/title ')]">
		<fo:block xsl:use-attribute-sets="ds:li.title">
			<xsl:call-template name="commonattributes"/>
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>
	
	<xsl:template match="*[contains(@class, ' topic/sl ')]/*[contains(@class, ' topic/sli ')]">

		<fo:list-item xsl:use-attribute-sets="sl.sli">
			<xsl:call-template name="ds:listItemOrphanWidows"/>
			<xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')]" mode="flag-attributes"/>
			<fo:list-item-label xsl:use-attribute-sets="sl.sli__label">
				<fo:block xsl:use-attribute-sets="sl.sli__label__content">
					<xsl:call-template name="commonattributes"/>
					<xsl:call-template name="ds:listItemLabel"/>
				</fo:block>
			</fo:list-item-label>
			<fo:list-item-body xsl:use-attribute-sets="sl.sli__body">
				<fo:block xsl:use-attribute-sets="sl.sli__content">
					<xsl:apply-templates/>
				</fo:block>
			</fo:list-item-body>
		</fo:list-item>
	</xsl:template>


	<xsl:template name="ds:listItemLabel">
		<xsl:variable name="depth" as="xs:integer" select="count(ancestor::*[contains(@class, ' topic/sl ') or contains(@class, ' topic/ul ') or (contains(@class, ' topic/dl ') and (@outputclass = 'bullet-list-titles'))])"/>
		<xsl:call-template name="getVariable">
			<xsl:with-param name="id" select="concat('Unordered List bullet ', $depth)"/>
		</xsl:call-template>
	</xsl:template>


	<xsl:template name="ds:listItemOrphanWidows">
		<xsl:if test="exists(preceding-sibling::*) and (count(preceding-sibling::*) lt $listOrphans)">
			<xsl:attribute name="keep-with-previous.within-column">1</xsl:attribute>
		</xsl:if>
		<xsl:if test="exists(following-sibling::*) and (count(following-sibling::*) lt $listWidows)">
			<xsl:attribute name="keep-with-next.within-column">1</xsl:attribute>
		</xsl:if>
	</xsl:template>
	
	
</xsl:stylesheet>
