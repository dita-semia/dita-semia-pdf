<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="2.0"
	xmlns:xs				= "http://www.w3.org/2001/XMLSchema" 
	xmlns:xsl				= "http://www.w3.org/1999/XSL/Transform"
	xmlns:fo				= "http://www.w3.org/1999/XSL/Format"
	xmlns:ds				= "http://www.dita-semia.org"
	exclude-result-prefixes	= "#all">
	
	<xsl:function name="ds:containsRelevantChange" as="xs:boolean">
		<xsl:param name="element" as="element()"/>
		
		<xsl:apply-templates select="$element" mode="isChanged"/>
	</xsl:function>
	
	
	<xsl:template match="*[contains(@class, ' topic/related-links ')]" mode="isChanged" priority="10" as="xs:boolean">
		<xsl:sequence select="false()"/>	<!-- ignore changes within list of related links -->
	</xsl:template>

	<xsl:template match="*[contains(@class, ' topic/ph ')][matches(., '^\s+$')]" mode="isChanged" priority="5" as="xs:boolean">
		<xsl:sequence select="false()"/>	<!-- ignore changes only consisting of whitespaces -->
	</xsl:template>

	<xsl:template match="element()" mode="isChanged" as="xs:boolean">
		<xsl:choose>
			<xsl:when test="@rev = ('dsd:added', 'dsd:deleted')">
				<!-- element is marked as change -->
				<xsl:sequence select="true()"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- recurse into content -->
				<xsl:sequence select="exists(*[ds:containsRelevantChange(.)])"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>
