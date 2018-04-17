<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="2.0"
	xmlns:xs				= "http://www.w3.org/2001/XMLSchema" 
	xmlns:xsl				= "http://www.w3.org/1999/XSL/Transform" 
	xmlns:ditaarch			=  "http://dita.oasis-open.org/architecture/2005/"
	xmlns:opentopic			= "http://www.idiominc.com/opentopic"
	xmlns:opentopic-func	= "http://www.idiominc.com/opentopic/exsl/function"
	xmlns:ds				= "http://www.dita-semia.org"
	exclude-result-prefixes	= "#all">
	
	
	<xsl:param name="ditaval" 			as="xs:string?"/>
	
	<xsl:param name="pdfFormatter" 		select="'fop'"/>
	<xsl:param name="tocMaximumLevel" 	select="4"/>
	
	
	<xsl:param name="dita-semia.double-page-layout"	as="xs:string?"/>
	
	<xsl:param name="defaultLanguage" 			as="xs:string" select="'de'"/>

	<xsl:variable name="double-page-layout" as="xs:boolean" select="($dita-semia.double-page-layout = 'true')"/>
	
	<xsl:variable name="page-width"			>210mm</xsl:variable>
	<xsl:variable name="page-height"		>297mm</xsl:variable>
	
	<xsl:variable name="page-margin-top"	>41mm</xsl:variable>
	<xsl:variable name="page-margin-bottom"	>24mm</xsl:variable>
	<xsl:variable name="page-margin-outside">30mm</xsl:variable>
	<xsl:variable name="page-margin-inside"	>20mm</xsl:variable>
	
	<xsl:variable name="default-font-size"	>12pt</xsl:variable>
	<xsl:variable name="default-line-height">120%</xsl:variable>
	
	<xsl:variable name="side-col-width"		>0mm</xsl:variable>	<!-- Providing a unit is required tocompensate an FOP bug when calculating with this value. -->
	
	<xsl:variable name="mirror-page-margins" select="$double-page-layout"/>
	
	<xsl:variable name="fontFamilyTitle"	as="xs:string">Franklin Gothic Medium, Helvetica, Arial Unicode MS</xsl:variable>
	<xsl:variable name="fontFamilyBody"		as="xs:string">Palatino Linotype, Times New Roman, Times</xsl:variable>
	<xsl:variable name="fontFamilyCode"		as="xs:string">Consolas, Courier New, monospace</xsl:variable>	
	
	
	<xsl:variable name="productLogo" as="xs:string?"/>
	<xsl:variable name="companyLogo" as="xs:string?"/>
	
	<!-- widths for numbers of topic titles invarious depths -->
	<xsl:variable name="numWidthTitle"				as="xs:double*"	select="(16.0, 16.0, 21.0, 25.0, 29.0, 33.0)"/>

	<!-- TOC -->
	<xsl:variable name="fontSizeTocTitle"	as="xs:double*"	select="(12, 11)"/>
	<xsl:variable name="fontSizeTocPage"	as="xs:double*"	select="(11)"/>
	<xsl:variable name="numWidthToc"		as="xs:double*"	select="(8.0, 13.0, 17.0, 19.0, 23.0, 27.0)"/>
	<xsl:variable name="marginLeftToc"		as="xs:double*"	select="(0.0,  8.0, 21.0, 23.0, 25.0, 27.0)"/>
	<xsl:variable name="spaceBeforeToc"		as="xs:double*"	select="(2.5,  0.7,  0.0)"/>
	<xsl:variable name="spaceAfterToc"		as="xs:double*"	select="(1.0,  0.7,  0.0)"/>

	<!-- tables -->
	<xsl:variable name="headerInnerBorderWidth"		as="xs:double"	select="0.1"/>
	<xsl:variable name="headerOuterBorderWidth"		as="xs:double"	select="0.3"/>
	
	<!-- lists -->
	<xsl:variable name="listWidows"			as="xs:integer"	select="2"/>
	<xsl:variable name="listOrphans"		as="xs:integer"	select="2"/>
	
	
	<xsl:variable name="ds:changedDitavalStartprop" as="element()?">
		<xsl:variable name="ditavalUrl" as="xs:string?"			select="if ($ditaval) then concat('file:/', $ditaval) else ()"/>
		<xsl:variable name="ditavalDoc" as="document-node()?" 	select="if (doc-available($ditavalUrl)) then doc($ditavalUrl) else ()"/>
		<xsl:variable name="revprop"	as="element()?"			select="$ditavalDoc/val/revprop[@action = 'flag'][@val = 'dsd:changed']"/>
		<xsl:if test="$revprop">
			<ditaval-startprop class="+ topic/foreign ditaot-d/ditaval-startprop ">
				<xsl:copy-of select="$revprop"/>
			</ditaval-startprop>
		</xsl:if>
	</xsl:variable>
	
</xsl:stylesheet>
