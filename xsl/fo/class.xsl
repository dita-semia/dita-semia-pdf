<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl	= "http://www.w3.org/1999/XSL/Transform"
	xmlns:xs	= "http://www.w3.org/2001/XMLSchema" 
	xmlns:ds	= "http://www.dita-semia.org"
	exclude-result-prefixes="#all">

	<xsl:variable name="CLASS_TOPIC"		as="xs:string"	select="' topic/topic '"/>
	<xsl:variable name="CLASS_LINK"			as="xs:string"	select="' topic/link '"/>
	<xsl:variable name="CLASS_FIG"			as="xs:string"	select="' topic/fig '"/>
	<xsl:variable name="CLASS_TABLE"		as="xs:string"	select="' topic/table '"/>
	<xsl:variable name="CLASS_TITLE"		as="xs:string"	select="' topic/title '"/>
	
	<xsl:variable name="CLASS_TOPICREF"		as="xs:string"	select="' map/topicref '"/>
	
	<xsl:variable name="CLASS_FRONTMATTER"	as="xs:string"	select="' bookmap/frontmatter '"/>
	<xsl:variable name="CLASS_CHAPTER"		as="xs:string"	select="' bookmap/chapter '"/>
	<xsl:variable name="CLASS_APPENDIX"		as="xs:string"	select="' bookmap/appendix '"/>
	<xsl:variable name="CLASS_BACKMATTER"	as="xs:string"	select="' bookmap/backmatter '"/>
		
</xsl:stylesheet>
