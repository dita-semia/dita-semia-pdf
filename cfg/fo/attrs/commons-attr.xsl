<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl	= "http://www.w3.org/1999/XSL/Transform"
	xmlns:xs	= "http://www.w3.org/2001/XMLSchema"
	xmlns:fo	= "http://www.w3.org/1999/XSL/Format" 
	xmlns:ds	= "http://www.dita-semia.org"
	exclude-result-prefixes	= "#all">
	
	<xsl:variable name="STANDARD_P_SPACE"	as="xs:string" select="'0.4em'"/>
	<xsl:variable name="EMBEDDED_P_SPACE"	as="xs:string" select="'0.2em'"/>
	<xsl:variable name="COMPACT_P_SPACE"	as="xs:string" select="'0.1em'"/>

	<xsl:attribute-set name="__fo__root" use-attribute-sets="base-font">
		<xsl:attribute name="font-family" select="$fontFamilyBody"/>
		<xsl:attribute name="xml:lang" select="translate($locale, '_', '-')"/>
		<xsl:attribute name="writing-mode" select="$writing-mode"/>
	</xsl:attribute-set>
	
	<xsl:template name="ds:paragraphSpace">
		<xsl:choose>
			<xsl:when test="ancestor-or-self::*/@compact = 'yes'">
				<xsl:value-of select="$COMPACT_P_SPACE"/>
			</xsl:when>
			<xsl:when test="ancestor::*[contains(@class, ' topic/table ') or 
										contains(@class, ' topic/simpletable ') or 
										contains(@class, ' topic/dl ') or 
										contains(@class, ' topic/li ') or 
										contains(@class, ' topic/sli ')]">
				<xsl:value-of select="$EMBEDDED_P_SPACE"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$STANDARD_P_SPACE"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	<xsl:template name="ds:paragraphSpaceBefore">
		<xsl:call-template name="ds:paragraphSpace"/>
	</xsl:template>
		
	<xsl:template name="ds:paragraphSpaceAfter">
		<xsl:choose>
			<xsl:when test="contains(@class, ' topic/p ') and (following-sibling::*[1]/@compact = 'yes')">
				<xsl:value-of select="$COMPACT_P_SPACE"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="ds:paragraphSpace"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:attribute-set name="topic" use-attribute-sets="base-font">
		<xsl:attribute name="hyphenate"	>true</xsl:attribute>
	</xsl:attribute-set>
	
	

	<xsl:attribute-set name="common.title">
		<xsl:attribute name="font-family" select="$fontFamilyTitle"/>
		<xsl:attribute name="keep-together.within-column">always</xsl:attribute>
		<!-- ohne keep-together können durch den id-container-Block zwei aufeinander folgende Titel getrennt werden. -->
	</xsl:attribute-set>
	
	<xsl:attribute-set name="topic.title" use-attribute-sets="common.title">
		<xsl:attribute name="border-after-style">none</xsl:attribute>
		<xsl:attribute name="space-before">0</xsl:attribute>	<!-- Titel auf Level 1 beginnen immer mit einer neuen Seite -->
		<xsl:attribute name="space-after">4mm</xsl:attribute>
		<xsl:attribute name="font-size">20pt</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="padding-top">0</xsl:attribute>
		<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="topic.topic.title" use-attribute-sets="common.title">
		<xsl:attribute name="border-after-style">none</xsl:attribute>
		<xsl:attribute name="space-before">8mm</xsl:attribute>
		<xsl:attribute name="space-after">2.5mm</xsl:attribute>
		<xsl:attribute name="font-size">16pt</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="padding-top">0</xsl:attribute>
		<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="topic.topic.topic.title" use-attribute-sets="common.title">
		<xsl:attribute name="border-after-style">none</xsl:attribute>
		<xsl:attribute name="space-before">8mm</xsl:attribute>
		<xsl:attribute name="space-after">2.5mm</xsl:attribute>
		<xsl:attribute name="font-size">14pt</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="padding-top">0</xsl:attribute>
		<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="topic.topic.topic.topic.title" use-attribute-sets="common.title">
		<xsl:attribute name="border-after-style">none</xsl:attribute>
		<xsl:attribute name="space-before">8mm</xsl:attribute>
		<xsl:attribute name="space-after">2.5mm</xsl:attribute>
		<xsl:attribute name="font-size">14pt</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="padding-top">0</xsl:attribute>
		<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="topic.topic.topic.topic.topic.title" use-attribute-sets="common.title">
		<xsl:attribute name="border-after-style">none</xsl:attribute>
		<xsl:attribute name="space-before">8mm</xsl:attribute>
		<xsl:attribute name="space-after">2.5mm</xsl:attribute>
		<xsl:attribute name="font-size">14pt</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="padding-top">0</xsl:attribute>
		<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="topic.topic.topic.topic.topic.topic.title" use-attribute-sets="common.title">
		<xsl:attribute name="border-after-style">none</xsl:attribute>
		<xsl:attribute name="space-before">8mm</xsl:attribute>
		<xsl:attribute name="space-after">2.5mm</xsl:attribute>
		<xsl:attribute name="font-size">14pt</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-style">normal</xsl:attribute>
		<xsl:attribute name="padding-top">0</xsl:attribute>
		<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="section.title" use-attribute-sets="__fo__root">
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="space-before">5.0mm</xsl:attribute>
		<xsl:attribute name="space-after">2.5mm</xsl:attribute>
		<xsl:attribute name="keep-together.within-column">always</xsl:attribute>
		<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="fig.title" use-attribute-sets="base-font common.title">
		<xsl:attribute name="font-family">inherit</xsl:attribute>
		<xsl:attribute name="font-style">italic</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-size">10pt</xsl:attribute>
		<xsl:attribute name="space-before">3.0mm</xsl:attribute>
		<xsl:attribute name="space-after">0.0mm</xsl:attribute>
		<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
		<xsl:attribute name="keep-with-previous.within-page">auto</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="__force__page__count">
		<xsl:attribute name="force-page-count">no-force</xsl:attribute><!-- avoid blank pages -->
		<!--<xsl:attribute name="force-page-count">
			<xsl:choose>
				<xsl:when test="$double-page-layout">end-on-even</xsl:when>
				<xsl:otherwise>no-force</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>-->
	</xsl:attribute-set>
	
	<xsl:attribute-set name="common.block">
		<xsl:attribute name="space-before">
			<xsl:call-template name="ds:paragraphSpaceBefore"/>		
		</xsl:attribute>
		<xsl:attribute name="space-after">
			<xsl:call-template name="ds:paragraphSpaceAfter"/>
		</xsl:attribute>
		<xsl:attribute name="text-align"	>justify</xsl:attribute>
		<xsl:attribute name="widows"		>5</xsl:attribute>
		<xsl:attribute name="orphans"		>5</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="page-sequence.cover">
		<xsl:attribute name="force-page-count">no-force</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="page-sequence.frontmatter">
		<xsl:attribute name="format">1</xsl:attribute>
	</xsl:attribute-set>


	<xsl:attribute-set name="note__table" use-attribute-sets="common.block">
		<xsl:attribute name="width"							>100%</xsl:attribute>
		<xsl:attribute name="space-before"					>2.5mm</xsl:attribute>
		<xsl:attribute name="space-after"					>2.5mm</xsl:attribute>
		<xsl:attribute name="margin-top"					>2.5mm</xsl:attribute>
		<xsl:attribute name="margin-bottom"					>2.5mm</xsl:attribute>
		<xsl:attribute name="border-top-style"				>solid</xsl:attribute>
		<xsl:attribute name="border-bottom-style"			>solid</xsl:attribute>
		<xsl:attribute name="border-color"					>rgb(192,192,192)</xsl:attribute>
		<xsl:attribute name="border-width"					>0.5mm</xsl:attribute>
		<xsl:attribute name="keep-together.within-column"	>100</xsl:attribute>
		<xsl:attribute name="table-layout"					>fixed</xsl:attribute>	<!-- auto causes warning by FOP -->
	</xsl:attribute-set>
	
	<xsl:attribute-set name="note__image__column">
		<xsl:attribute name="column-width"	>18mm</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="note__text__column">
		<xsl:attribute name="column-width"	>proportional-column-width(1)</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="note__image__entry">
		<xsl:attribute name="padding-top"		>2mm</xsl:attribute>
		<xsl:attribute name="start-indent"		>0pt</xsl:attribute>
		<xsl:attribute name="font-family"		select="$fontFamilyTitle"/>
		<!--<xsl:attribute name="font-size"			>12pt</xsl:attribute>-->
		<xsl:attribute name="text-align"		>center</xsl:attribute>
		<xsl:attribute name="text-align-last"	>center</xsl:attribute>
		<xsl:attribute name="padding-right"		>0</xsl:attribute>
		<xsl:attribute name="end-indent"		>0</xsl:attribute>	<!-- avoid inheritence from possible ancestor cell -->
	</xsl:attribute-set>

	<xsl:attribute-set name="note__text__entry">
		<xsl:attribute name="start-indent"	>0pt</xsl:attribute>
		<xsl:attribute name="padding-left"	>3mm</xsl:attribute>
		<xsl:attribute name="padding-top"	>2mm</xsl:attribute>
		<xsl:attribute name="padding-right"	>1mm</xsl:attribute>
		<xsl:attribute name="padding-bottom">2mm</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="image">
		<xsl:attribute name="border" select="if (@outputclass = 'frame') then 'solid black 1pt' else 'none'"/>
	</xsl:attribute-set>
	
	
</xsl:stylesheet>