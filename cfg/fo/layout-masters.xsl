<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="2.0"
	xmlns:xs				= "http://www.w3.org/2001/XMLSchema" 
	xmlns:xsl				= "http://www.w3.org/1999/XSL/Transform"
	xmlns:svg				= "http://www.w3.org/2000/svg" 
	xmlns:fo				= "http://www.w3.org/1999/XSL/Format"
	xmlns:ds				= "http://www.dita-semia.org"
	exclude-result-prefixes	= "#all">
	
	<xsl:template match="/" mode="create-page-sequences" priority="10">
		<xsl:call-template name="generate-page-sequence-master">
			<xsl:with-param name="master-name" select="'toc-sequence'"/>
			<xsl:with-param name="master-reference" select="'toc'"/>
			<xsl:with-param name="first" select="false()"/>
			<xsl:with-param name="last" select="false()"/>
		</xsl:call-template>
		<xsl:call-template name="generate-page-sequence-master">
			<xsl:with-param name="master-name" select="'body-sequence'"/>
			<xsl:with-param name="master-reference" select="'body'"/>
			<xsl:with-param name="first" select="false()"/>
			<xsl:with-param name="last" select="false()"/>
		</xsl:call-template>
		<xsl:call-template name="generate-page-sequence-master">
			<xsl:with-param name="master-name" select="'ditamap-body-sequence'"/>
			<xsl:with-param name="master-reference" select="'body'"/>
			<xsl:with-param name="first" select="false()"/>
			<xsl:with-param name="last" select="false()"/>
		</xsl:call-template>
		<xsl:call-template name="generate-page-sequence-master">
			<xsl:with-param name="master-name" select="'index-sequence'"/>
			<xsl:with-param name="master-reference" select="'index'"/>
			<xsl:with-param name="first" select="false()"/>
			<xsl:with-param name="last" select="false()"/>
		</xsl:call-template>
		<xsl:call-template name="generate-page-sequence-master">
			<xsl:with-param name="master-name" select="'front-matter'"/>
			<xsl:with-param name="master-reference" select="'front-matter'"/>
			<xsl:with-param name="first" select="true()"/>
			<xsl:with-param name="last" select="false()"/>
		</xsl:call-template>
		<xsl:if test="$generate-back-cover">
			<xsl:call-template name="generate-page-sequence-master">
				<xsl:with-param name="master-name" select="'back-cover'"/>
				<xsl:with-param name="master-reference" select="'back-cover'"/>
				<xsl:with-param name="first" select="false()"/>
				<xsl:with-param name="last" select="false()"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:call-template name="generate-page-sequence-master">
			<xsl:with-param name="master-name" select="'glossary-sequence'"/>
			<xsl:with-param name="master-reference" select="'glossary'"/>
			<xsl:with-param name="first" select="false()"/>
			<xsl:with-param name="last" select="false()"/>
		</xsl:call-template>
	</xsl:template>
	
</xsl:stylesheet>
