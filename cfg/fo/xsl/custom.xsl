<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl	= "http://www.w3.org/1999/XSL/Transform"
	xmlns:xs	= "http://www.w3.org/2001/XMLSchema"
	xmlns:fo	= "http://www.w3.org/1999/XSL/Format">
	
	<xsl:import href="plugin:org.dita-semia.resolver:xsl/fo/dl-attr.xsl"/>
	<xsl:import href="plugin:org.dita-semia.resolver:xsl/fo/dl-outputclasses.xsl"/>
	<xsl:import href="plugin:org.dita-semia.resolver:xsl/fo/advanced-keyref.xsl"/>

	<xsl:include href="embedded-svg.xsl"/>
	
	<xsl:include href="highlight-xsltconref.xsl"/>
	<xsl:include href="highlight-conbat.xsl"/>
	

</xsl:stylesheet>