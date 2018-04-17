<?xml version="1.0" encoding="UTF-8"?>
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
	
	
	<!-- xxxxxxxxxx Body xxxxxxxxxx -->
	
	<xsl:template name="insertBodyOddHeader">
		<fo:static-content flow-name="odd-body-header">
			<fo:block xsl:use-attribute-sets="__body__odd__header">
				<xsl:call-template name="CreateHeaderContent">
					<xsl:with-param name="Right"	select="true()"/>
					<xsl:with-param name="HeaderLine1">
						<fo:retrieve-marker 
							retrieve-class-name	= "current-header" 
							retrieve-position	= "first-including-carryover" 
							retrieve-boundary	= "page-sequence"/>
					</xsl:with-param>
					<xsl:with-param name="HeaderLine2">
						<fo:retrieve-marker 
							retrieve-class-name	= "current-h2" 
							retrieve-position	= "first-including-carryover" 
							retrieve-boundary	= "page-sequence"/>
					</xsl:with-param>
				</xsl:call-template>
			</fo:block>
		</fo:static-content>
	</xsl:template>
	
	<xsl:template name="insertBodyEvenHeader">
		<fo:static-content flow-name="even-body-header">
			<fo:block xsl:use-attribute-sets="__body__even__header">
				<xsl:call-template name="CreateHeaderContent">
					<xsl:with-param name="Right"	select="not($double-page-layout)"/>
					<xsl:with-param name="HeaderLine1">
						<fo:retrieve-marker 
							retrieve-class-name	= "current-header" 
							retrieve-position	= "first-including-carryover" 
							retrieve-boundary	= "page-sequence"/>
					</xsl:with-param>
					<xsl:with-param name="HeaderLine2">
						<fo:retrieve-marker 
							retrieve-class-name	= "current-h2" 
							retrieve-position	= "first-including-carryover" 
							retrieve-boundary	= "page-sequence"/>
					</xsl:with-param>
				</xsl:call-template>
			</fo:block>
		</fo:static-content>
	</xsl:template>
	
	<xsl:template name="insertBodyOddFooter">
		<fo:static-content flow-name="odd-body-footer">
			<fo:block xsl:use-attribute-sets="__body__odd__footer">
				<xsl:call-template name="CreateFooterContent">
					<xsl:with-param name="Right"	select="true()"/>
				</xsl:call-template>
			</fo:block>
		</fo:static-content>
	</xsl:template>
	
	<xsl:template name="insertBodyEvenFooter">
		<fo:static-content flow-name="even-body-footer">
			<fo:block xsl:use-attribute-sets="__body__even__footer">
				<xsl:call-template name="CreateFooterContent">
					<xsl:with-param name="Right"	select="not($double-page-layout)"/>
				</xsl:call-template>
			</fo:block>
		</fo:static-content>
	</xsl:template>
	  
	  
	<!-- xxxxxxxxxx TOC xxxxxxxxxx -->
	
	<xsl:template name="insertTocOddHeader">
		<fo:static-content flow-name="odd-toc-header">
			<fo:block xsl:use-attribute-sets="__toc__odd__header">
				<xsl:call-template name="CreateHeaderContent">
					<xsl:with-param name="Right"	select="true()"/>
					<xsl:with-param name="HeaderLine1">
						<fo:retrieve-marker 
							retrieve-class-name	= "current-header" 
							retrieve-position	= "first-including-carryover" 
							retrieve-boundary	= "page-sequence"/>
					</xsl:with-param>
				</xsl:call-template>
			</fo:block>
		</fo:static-content>
	</xsl:template>
	
	<xsl:template name="insertTocEvenHeader">
		<fo:static-content flow-name="even-toc-header">
			<fo:block xsl:use-attribute-sets="__toc__even__header">
				<xsl:call-template name="CreateHeaderContent">
					<xsl:with-param name="Right"	select="not($double-page-layout)"/>
					<xsl:with-param name="HeaderLine1">
						<fo:retrieve-marker 
							retrieve-class-name	= "current-header" 
							retrieve-position	= "first-including-carryover" 
							retrieve-boundary	= "page-sequence"/>
					</xsl:with-param>
				</xsl:call-template>
			</fo:block>
		</fo:static-content>
	</xsl:template>
	
	<xsl:template name="insertTocOddFooter">
		<fo:static-content flow-name="odd-toc-footer">
			<fo:block xsl:use-attribute-sets="__toc__odd__footer">
				<xsl:call-template name="CreateFooterContent">
					<xsl:with-param name="Right"	select="true()"/>
				</xsl:call-template>
			</fo:block>
		</fo:static-content>
	</xsl:template>
	
	<xsl:template name="insertTocEvenFooter">
		<fo:static-content flow-name="even-toc-footer">
			<fo:block xsl:use-attribute-sets="__toc__even__footer">
				<xsl:call-template name="CreateFooterContent">
					<xsl:with-param name="Right"	select="not($double-page-layout)"/>
				</xsl:call-template>
			</fo:block>
		</fo:static-content>
	</xsl:template>
	
	
	<!-- xxxxxxxxxx Preface xxxxxxxxxx -->
	
	<xsl:template name="insertPrefaceOddHeader">
		<fo:static-content flow-name="odd-body-header">
			<fo:block xsl:use-attribute-sets="__body__odd__header">
				<xsl:call-template name="CreateHeaderContent">
					<xsl:with-param name="Right"	select="true()"/>
				</xsl:call-template>
			</fo:block>
		</fo:static-content>
	</xsl:template>
	
	<xsl:template name="insertPrefaceEvenHeader">
		<fo:static-content flow-name="even-body-header">
			<fo:block xsl:use-attribute-sets="__body__even__header">
				<xsl:call-template name="CreateHeaderContent">
					<xsl:with-param name="Right"	select="not($double-page-layout)"/>
				</xsl:call-template>
			</fo:block>
		</fo:static-content>
	</xsl:template>
	
	<xsl:template name="insertPrefaceOddFooter">
		<fo:static-content flow-name="odd-body-footer">
			<fo:block xsl:use-attribute-sets="__body__odd__footer">
				<xsl:call-template name="CreateFooterContent">
					<xsl:with-param name="Right"	select="true()"/>
				</xsl:call-template>
			</fo:block>
		</fo:static-content>
	</xsl:template>
	
	<xsl:template name="insertPrefaceEvenFooter">
		<fo:static-content flow-name="even-body-footer">
			<fo:block xsl:use-attribute-sets="__body__even__footer">
				<xsl:call-template name="CreateFooterContent">
					<xsl:with-param name="Right"	select="not($double-page-layout)"/>
				</xsl:call-template>
			</fo:block>
		</fo:static-content>
	</xsl:template>
	
	
	<!-- xxxxxxxxxx FrontMatter xxxxxxxxxx -->
	
	<xsl:template name="insertFrontMatterOddFooter">
		<fo:static-content flow-name="odd-body-footer">
			<fo:block xsl:use-attribute-sets="__body__odd__footer">
				<xsl:call-template name="CreateFooterContent">
					<xsl:with-param name="Right"	select="true()"/>
				</xsl:call-template>
			</fo:block>
		</fo:static-content>
	</xsl:template>
	
	<xsl:template name="insertFrontMatterEvenFooter">
		<fo:static-content flow-name="even-body-footer">
			<fo:block xsl:use-attribute-sets="__body__even__footer">
				<xsl:call-template name="CreateFooterContent">
					<xsl:with-param name="Right"	select="not($double-page-layout)"/>
				</xsl:call-template>
			</fo:block>
		</fo:static-content>
	</xsl:template>
	
	
	<!-- xxxxxxxxxx Glossary xxxxxxxxxx -->
	
	<xsl:template name="insertGlossaryOddFooter">
		<fo:static-content flow-name="odd-glossary-footer">
			<fo:block xsl:use-attribute-sets="__glossary__odd__footer">
				<xsl:call-template name="CreateFooterContent">
					<xsl:with-param name="Right"	select="true()"/>
				</xsl:call-template>
			</fo:block>
		</fo:static-content>
	</xsl:template>
	
	<xsl:template name="insertGlossaryEvenFooter">
		<fo:static-content flow-name="even-glossary-footer">
			<fo:block xsl:use-attribute-sets="__glossary__even__footer">
				<xsl:call-template name="CreateFooterContent">
					<xsl:with-param name="Right"	select="not($double-page-layout)"/>
				</xsl:call-template>
			</fo:block>
		</fo:static-content>
	</xsl:template>
	
	
	
	
	<xsl:template name="CreateHeaderContent">
		<xsl:param name="Right"			as="xs:boolean"/>
		<xsl:param name="HeaderLine1"/>
		<xsl:param name="HeaderLine2"/>
		
		<fo:block xsl:use-attribute-sets="ds:header_inner">
			
			<xsl:variable name="TextAlign" as="xs:string" select="if ($Right) then 'right' else 'left'"/>
	
			<fo:block xsl:use-attribute-sets="ds:body_header_line_1" text-align="{$TextAlign}">
				<xsl:sequence select="$HeaderLine1"/>
				<!--Leerzeichen, um bei leeren Blöcken die Linenhöhe zu erhalten-->
				<xsl:text>&#160;</xsl:text>
			</fo:block>
			
			<fo:block xsl:use-attribute-sets="ds:body_header_line_2" text-align="{$TextAlign}">
				<xsl:sequence select="$HeaderLine2"/>
				<!--Leerzeichen, um bei leeren Blöcken die Linenhöhe zu erhalten-->
				<xsl:text>&#160;</xsl:text>
			</fo:block>
			
		</fo:block>

	</xsl:template>
	
	<xsl:template name="CreateFooterContent">
		<xsl:param name="Right"			as="xs:boolean"/>

		<xsl:variable name="ColNumLogo" as="xs:integer" select="if ($Right) then 1 else 3"/>
		<xsl:variable name="ColNumText" as="xs:integer" select="2"/>
		<xsl:variable name="ColNumPage" as="xs:integer" select="if ($Right) then 3 else 1"/>
		
		<xsl:variable name="PageAlign"	as="xs:string"	select="if ($Right) then 'right' 	else 'left'"/>
		<xsl:variable name="LogoAlign"	as="xs:string"	select="if ($Right) then 'left' 	else 'right'"/>
		
		<fo:table table-layout="fixed" width="100%">
			<fo:table-column column-number="{$ColNumPage}" column-width="10%"/>
			<fo:table-column column-number="{$ColNumText}" column-width="70%"/>
			<fo:table-column column-number="{$ColNumLogo}" column-width="20%"/>
			<fo:table-body>
				<fo:table-row>
					<fo:table-cell column-number="{$ColNumLogo}" margin-left="0" margin-right="0">
						<fo:block text-align="{$LogoAlign}">
							<xsl:if test="$companyLogo">
								<fo:external-graphic src="url('{$customizationDir.url}common/artwork/{$companyLogo}')" scaling="uniform" content-width="25mm"/>
							</xsl:if>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell column-number="{$ColNumText}" text-align="center" margin-left="0" margin-right="0">
						<fo:block font-size="9pt" padding-top="8mm">
							<xsl:variable name="centerList" as="xs:string*">
								<xsl:choose>
									<xsl:when test="$fusszeileTitel">
										<xsl:sequence select="$fusszeileTitel"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:sequence select="string-join(($bookTitleMain, $bookTitleAlt), ' – ')"/>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:if test="exists($versionText)">
									<xsl:sequence select="$versionText"/>
								</xsl:if>
							</xsl:variable>
							<xsl:value-of select="string-join($centerList, ' · ')"/>
						</fo:block>
					</fo:table-cell>
					<fo:table-cell column-number="{$ColNumPage}" text-align="{$PageAlign}" margin-left="0" margin-right="0">
						<fo:block font-size="11pt" padding-top="8mm">
							<fo:page-number/>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</fo:table-body>
		</fo:table>
	</xsl:template>
	
</xsl:stylesheet>