<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="2.0" 
	xmlns:xsl	= "http://www.w3.org/1999/XSL/Transform"
	xmlns:xs	= "http://www.w3.org/2001/XMLSchema"
	xmlns:xsi	= "http://www.w3.org/2001/XMLSchema-instance"
	xmlns:cba	= "http://www.dita-semia.org/conbat"
	xmlns:ikd	= "http://www.dita-semia.org/implicit-keydef"
	xmlns:akr	= "http://www.dita-semia.org/advanced-keyref"
	xmlns:xcr	= "http://www.dita-semia.org/xslt-conref"
	exclude-result-prefixes="#all">

	<xsl:template match="/" priority="1000">
		<xsl:if test="exists(//@cba:* | //@ikd:* | //@akr:* | //@xcr:*)">
			<xsl:variable name="attribute" as="attribute()" select="(//@cba:* | //@ikd:* | //@akr:* | //@xcr:*)[1]"/>
			<xsl:message terminate="yes">[DOTX][ERROR]: The input file was not resolved by DITA-SEMIA. There remains (at least) one attribute to be resolved: <xsl:value-of select="name($attribute)"/>. (<xsl:value-of select="base-uri()"/>)</xsl:message>
		</xsl:if>
		<xsl:next-match/>
	</xsl:template>
	

</xsl:transform>