<?xml version='1.0'?>
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


	<xsl:template match="*[contains(@class, ' topic/table ')][child::*[contains(@class, ' topic/title ')]]" mode="list.of.tables">
		<xsl:variable name="title" as="element()*" select="*[contains(@class, ' topic/title ')]"/>
		<xsl:call-template name="ds:createLotfEntry">
			<xsl:with-param name="navTitleNum" as="node()*">
				<xsl:call-template name="getVariable">
					<xsl:with-param name="id" select="'Table.title'"/>
					<xsl:with-param name="params">
						<number>
							<xsl:apply-templates select="$title" mode="table.title-number"/>
						</number>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
			<xsl:with-param name="navTitleTxt" as="node()*">
				<xsl:apply-templates select="$title/node()"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>


	<xsl:template match="*[contains(@class, ' topic/fig ')][child::*[contains(@class, ' topic/title ')]]" mode="list.of.figures">
		<xsl:variable name="title" as="element()*" select="*[contains(@class, ' topic/title ')]"/>
		<xsl:call-template name="ds:createLotfEntry">
			<xsl:with-param name="navTitleNum" as="node()*">
				<xsl:call-template name="getVariable">
					<xsl:with-param name="id" select="'Figure.title'"/>
					<xsl:with-param name="params">
						<number>
							<xsl:apply-templates select="$title" mode="fig.title-number"/>
						</number>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
			<xsl:with-param name="navTitleTxt" as="node()*">
				<xsl:apply-templates select="$title/node()"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="ds:createLotfEntry">
		<xsl:param name="navTitleNum" 	as="node()*"/>
		<xsl:param name="navTitleTxt" 	as="node()*"/>
		
		<xsl:variable name="destId" as="xs:string">
			<xsl:call-template name="get-id"/>
		</xsl:variable>
		
		<fo:block xsl:use-attribute-sets="__lotf__indent">
			
			<xsl:variable name="ditavalStartprop" as="element()*" select="ancestor-or-self::*/*[contains(@class,' ditaot-d/ditaval-startprop ')]"/>
			<xsl:choose>
				<xsl:when test="exists($ditavalStartprop)">
					<xsl:apply-templates select="$ditavalStartprop" mode="flag-attributes"/>
				</xsl:when>
				<xsl:when test="exists(descendant::*[starts-with(@rev, 'dsd:')])">
					<xsl:apply-templates select="$ds:changedDitavalStartprop" mode="flag-attributes"/>
				</xsl:when>
			</xsl:choose>

			<xsl:choose>
				<xsl:when test="$navTitleNum">
					<fo:list-block xsl:use-attribute-sets="__lotf__content" provisional-distance-between-starts="20mm">
						<fo:list-item>
							<fo:list-item-label end-indent="label-end()">
								<fo:block>
									<fo:basic-link internal-destination="{$destId}" xsl:use-attribute-sets="__toc__link">
										<xsl:sequence select="$navTitleNum"/>
									</fo:basic-link>
								</fo:block>
							</fo:list-item-label>
							<fo:list-item-body start-indent="body-start()">
								<fo:block text-align-last="justify">
									<fo:basic-link internal-destination="{$destId}" xsl:use-attribute-sets="__toc__link">
										<fo:inline xsl:use-attribute-sets="__lotf__title">
											<xsl:sequence select="$navTitleTxt"/>
										</fo:inline>
										<fo:inline xsl:use-attribute-sets="__lotf__page-number">
											<fo:leader xsl:use-attribute-sets="__lotf__leader"/>
											<fo:page-number-citation ref-id="{$destId}"/>
										</fo:inline>
									</fo:basic-link>
								</fo:block>
							</fo:list-item-body>
						</fo:list-item>
					</fo:list-block>
				</xsl:when>
				<xsl:otherwise>
					<fo:block xsl:use-attribute-sets="__lotf__content">
						<fo:basic-link internal-destination="{$destId}" xsl:use-attribute-sets="__toc__link">
							<fo:inline xsl:use-attribute-sets="__lotf__title">
								<xsl:sequence select="$navTitleTxt"/>
							</fo:inline>
							<fo:inline xsl:use-attribute-sets="__lotf__page-number">
								<fo:leader xsl:use-attribute-sets="__lotf__leader"/>
								<fo:page-number-citation ref-id="{$destId}"/>
							</fo:inline>
						</fo:basic-link>
					</fo:block>
				</xsl:otherwise>
			</xsl:choose>
		</fo:block>
		<xsl:text>&#x0A;</xsl:text><!-- erleichert die Fehlersuche be FOP-Warnungen mit Zeilenangabe im topic.fo -->
	</xsl:template>

</xsl:stylesheet>
