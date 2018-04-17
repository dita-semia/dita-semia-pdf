<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="2.0"
	xmlns:xs				= "http://www.w3.org/2001/XMLSchema" 
	xmlns:xsl				= "http://www.w3.org/1999/XSL/Transform"
	xmlns:svg				= "http://www.w3.org/2000/svg" 
	xmlns:fo				= "http://www.w3.org/1999/XSL/Format"
	xmlns:dita-ot			= "http://dita-ot.sourceforge.net/ns/201007/dita-ot"
	xmlns:ds				= "http://www.dita-semia.org"
	exclude-result-prefixes	= "#all">

	
	<xsl:template match="@id" mode="dlentry-id-for-fop">
		<!-- fo:inline erzeugt eine Leerzeile bei nachfolgendem fo:block. Daher ändern auf fo:block gegenüber tables_fop.xsl -->
		<fo:block id="{.}"/>
	</xsl:template>
	
	
	
	<!--table-->
	
	<xsl:template match="*[contains(@class, ' topic/tbody ')]" name="topic.tbody">
		<fo:table-body xsl:use-attribute-sets="tgroup.tbody">
			<xsl:call-template name="commonattributes"/>
			<xsl:apply-templates/>
		</fo:table-body>
	</xsl:template>
	
	
	<xsl:template match="*[contains(@class, ' topic/thead ')]/*[contains(@class, ' topic/row ')][*[contains(@class, ' topic/entry ')][@rotate = 90]]">
		<xsl:variable name="scaling" as="xs:double" select="(ancestor::*[contains(@class, ' topic/table ')]/@scale div 100, 1.0)[1]"/>
		<xsl:variable name="ds:rowHeight" as="xs:double">
			<xsl:variable name="listHeight" as="xs:double+">
				<xsl:for-each select="*[contains(@class, ' topic/entry ')][@rotate = 90]">
					<xsl:variable name="content" as="node()*">
						<xsl:call-template name="processEntryContent"/>
					</xsl:variable>
					<xsl:sequence select="ds:getFoMaxWordLen($content, $fontFamilyBody, xs:integer(12 * $scaling * 10), true()) div 10"/>	
				</xsl:for-each>
			</xsl:variable>
			<xsl:sequence select="max($listHeight)"/>
		</xsl:variable>
		
		<fo:table-row xsl:use-attribute-sets="thead.row">
			<xsl:call-template name="commonattributes"/>
			<xsl:apply-templates>
				<xsl:with-param name="ds:rowHeight" select="$ds:rowHeight" tunnel="yes"/>
			</xsl:apply-templates>
		</fo:table-row>
	</xsl:template>
	
	<xsl:template match="*[contains(@class, ' topic/thead ')]/*[contains(@class, ' topic/row ')]/*[contains(@class, ' topic/entry ')][@rotate = 90]">
		<xsl:param name="ds:rowHeight" as="xs:double" tunnel="yes"/>
		
		<fo:table-cell xsl:use-attribute-sets="thead.row.entry">
			<xsl:call-template name="commonattributes"/>
			<xsl:call-template name="applySpansAttrs"/>
			<xsl:call-template name="applyAlignAttrs"/>
			<xsl:call-template name="generateTableEntryBorder"/>
			<fo:block xsl:use-attribute-sets="thead.row.entry__content">
				<xsl:apply-templates select="." mode="ancestor-start-flag"/>
				<xsl:variable name="content" as="node()*">
					<xsl:call-template name="processEntryContent"/>
				</xsl:variable>
				<fo:block-container 
						reference-orientation="{if (ancestor::*[contains(@class, ' topic/table ')]/@orient = 'land') then -90 else 90}"
						inline-progression-dimension.optimum="{ds:ptToMm($ds:rowHeight)}mm">
					<fo:block text-align="left" start-indent="0" end-indent="0" hyphenate="false">
						<xsl:for-each select="$content">
							<xsl:copy>
								<xsl:copy-of select="attribute() except (@text-align | @start-indent | @end-indent | @hyphenate), node()"/>
							</xsl:copy>
						</xsl:for-each>
					</fo:block>
				</fo:block-container>	
				<xsl:apply-templates select="." mode="ancestor-end-flag"/>
			</fo:block>
		</fo:table-cell>
	</xsl:template>
	
	<!-- add whitespace for empty cells -->
	<xsl:template name="processEntryContent">
		<xsl:variable name="entryNumber" select="@dita-ot:x" as="xs:integer"/>
		<xsl:variable name="colspec" select="ancestor::*[contains(@class, ' topic/tgroup ')][1]/*[contains(@class, ' topic/colspec ')][position() = $entryNumber]"/>
		<xsl:variable name="char" as="xs:string?">
			<xsl:choose>
				<xsl:when test="@char">
					<xsl:value-of select="@char"/>
				</xsl:when>
				<xsl:when test="$colspec/@char">
					<xsl:value-of select="$colspec/@char"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="charoff" as="xs:integer">
			<xsl:choose>
				<xsl:when test="@charoff">
					<xsl:sequence select="xs:integer(@charoff)"/>
				</xsl:when>
				<xsl:when test="$colspec/@charoff">
					<xsl:sequence select="xs:integer($colspec/@charoff)"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:sequence select="xs:integer(50)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="exists($char) and string-length($char) ne 0">
				<xsl:call-template name="processCharAlignment">
					<xsl:with-param name="char" select="$char"/>
					<xsl:with-param name="charoff" select="$charoff"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="content" as="node()*">
					<xsl:apply-templates/>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="exists($content)">
						<xsl:sequence select="$content"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>&#xA0;</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="*[contains(@class, ' topic/strow ')]/@id">
		<!-- ID will be set on content block by attribute set. IDs ontable rows are not supported by FOP. -->
	</xsl:template>
		
</xsl:stylesheet>
