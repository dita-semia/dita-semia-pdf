<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="2.0"
	xmlns:xs				= "http://www.w3.org/2001/XMLSchema" 
	xmlns:xsl				= "http://www.w3.org/1999/XSL/Transform" 
	xmlns:ditaarch			=  "http://dita.oasis-open.org/architecture/2005/"
	xmlns:opentopic			= "http://www.idiominc.com/opentopic"
	xmlns:opentopic-func	= "http://www.idiominc.com/opentopic/exsl/function"
	xmlns:ds				= "http://www.dita-semia.org"
	exclude-result-prefixes	= "#all">
	
	<xsl:attribute-set name="table__container">
		<xsl:attribute name="width">
			<xsl:choose>
				<xsl:when test="not(@orient = 'land')">100%</xsl:when>
				<xsl:when test="exists(tgroup/colspec[ends-with(@colwidth, '*')])">
					<!-- for relative witdh set fixed total width and leave some space for section title -->
					<xsl:text>220mm</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<!-- sum absolute values -->
					<xsl:value-of select="string-join(tgroup/colspec/@colwidth, '+')"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute> 
	</xsl:attribute-set>
	
	<!-- table -->
	<xsl:attribute-set name="table" use-attribute-sets="base-font">
		<xsl:attribute name="font-size"			>11pt</xsl:attribute>
	</xsl:attribute-set>
	
	
	<xsl:attribute-set name="table.title" use-attribute-sets="base-font common.title">
		<xsl:attribute name="font-family">inherit</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-style">italic</xsl:attribute>
		<xsl:attribute name="font-size">10pt</xsl:attribute>
		<xsl:attribute name="space-before">3.0mm</xsl:attribute>
		<xsl:attribute name="space-after">0.0mm</xsl:attribute>
		<xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="common.table.body.entry">
		<!-- don't use abolute measures here to properly support @scale for tables -->
		<xsl:attribute name="space-before"					>0.24em</xsl:attribute>
		<xsl:attribute name="space-before.conditionality"	>retain</xsl:attribute>
		<xsl:attribute name="space-after"					>0.12em</xsl:attribute>
		<xsl:attribute name="space-after.conditionality"	>retain</xsl:attribute>
		<xsl:attribute name="start-indent"					>0.24em</xsl:attribute>
		<xsl:attribute name="end-indent"					>0.24em</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="common.table.head.entry" use-attribute-sets="common.table.body.entry">
		<xsl:attribute name="font-weight"					>bold</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="tbody.row">
		<xsl:attribute name="keep-together.within-page"		>100</xsl:attribute>
	</xsl:attribute-set>

	<xsl:attribute-set name="table.tgroup">
		<xsl:attribute name="font-family"		>inherit</xsl:attribute>
		<xsl:attribute name="font-size"			>11pt</xsl:attribute>
		<xsl:attribute name="color"				>inherit</xsl:attribute>
		<xsl:attribute name="font-weight"		>normal</xsl:attribute>
		<xsl:attribute name="font-style"		>normal</xsl:attribute>
		<xsl:attribute name="text-decoration"	>none</xsl:attribute>
		<xsl:attribute name="space-before"		>6pt</xsl:attribute>
		<xsl:attribute name="space-after"		>6pt</xsl:attribute>
		<xsl:attribute name="text-align"		>start</xsl:attribute>
		<xsl:attribute name="start-indent"		>0</xsl:attribute>
		<xsl:attribute name="line-height"		>1.2</xsl:attribute>
		<xsl:attribute name="background-color"	>transparent</xsl:attribute>
		<xsl:attribute name="padding-top"		>0pt</xsl:attribute>
		<xsl:attribute name="padding-right"		>0pt</xsl:attribute>
		<xsl:attribute name="padding-bottom"	>0pt</xsl:attribute>
		<xsl:attribute name="padding-left"		>0pt</xsl:attribute>
		<xsl:attribute name="end-indent"		>0</xsl:attribute>
		<xsl:attribute name="border-color"		>black</xsl:attribute>
	</xsl:attribute-set>
	
	
	<xsl:attribute-set name="tgroup.thead">
		<xsl:attribute name="background-color">rgb(192,192,192)</xsl:attribute>
		<xsl:attribute name="font-size">12pt</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="thead.row.entry">
		<!-- background-color is set for thead -->
	</xsl:attribute-set>
	
	
	<!-- simpletable -->
	<xsl:attribute-set name="simpletable">
		<xsl:attribute name="font-size"			>11pt</xsl:attribute>
		<xsl:attribute name="border-color"		>black</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="sthead">
		<xsl:attribute name="background-color"			>rgb(192,192,192)</xsl:attribute>
		<xsl:attribute name="font-size"					>12pt</xsl:attribute>
		<xsl:attribute name="keep-together.within-page"	>100</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="strow">
		<xsl:attribute name="keep-together.within-page"	>100</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="sthead.stentry">
	</xsl:attribute-set>
	
	<xsl:attribute-set name="strow.stentry">
	</xsl:attribute-set>
	
	<xsl:template name="ds:strowId">
		<xsl:if test="empty(preceding-sibling::*[not(contains(@class, ' ditaot-d/ditaval-startprop '))])">	<!-- only for 1st stentry -->
			<xsl:value-of select="parent::*/@id"/>
		</xsl:if>
	</xsl:template>
	
	<xsl:attribute-set name="sthead.stentry__content" use-attribute-sets="common.table.body.entry common.table.head.entry">
		<xsl:attribute name="id">
			<xsl:call-template name="ds:strowId"/>
		</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="sthead.stentry__keycol-content" use-attribute-sets="common.table.body.entry common.table.head.entry">
		<xsl:attribute name="id">
			<xsl:call-template name="ds:strowId"/>
		</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="strow.stentry__content" use-attribute-sets="common.table.body.entry">
		<xsl:attribute name="id">
			<xsl:call-template name="ds:strowId"/>
		</xsl:attribute>
	</xsl:attribute-set>
	
	<xsl:attribute-set name="strow.stentry__keycol-content" use-attribute-sets="common.table.body.entry common.table.head.entry">
		<xsl:attribute name="id">
			<xsl:call-template name="ds:strowId"/>
		</xsl:attribute>
	</xsl:attribute-set>
	
</xsl:stylesheet>
