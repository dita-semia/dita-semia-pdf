<?xml version='1.0' encoding='utf-8'?>
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
	
	
	<xsl:variable name="MIN_LAST_WORD_LEN"	as="xs:integer"	select="8"/>


	<!-- topic title numbering and formatting -->
	<xsl:template match="*[contains(@class, ' topic/topic ')]/*[contains(@class, ' topic/title ')]" mode="getTitle">
		<xsl:variable name="topic" 		as="element()"	select="parent::*"/>
		
		<xsl:variable name="numLst" as="xs:integer*">
			<xsl:apply-templates select="$topic" mode="GetTopicNum"/>
		</xsl:variable>
		<xsl:variable name="rootTopicRef" as="element()?">
			<xsl:apply-templates select="." mode="GetRootTopicRef"/>
		</xsl:variable>
		
		<xsl:variable name="depth" 			as="xs:integer"	select="count($numLst)"/>
		<xsl:variable name="numWidth" 		as="xs:double?" select="$numWidthTitle[min(($depth, last()))]"/>
		<xsl:variable name="maxTabNumLen" 	as="xs:integer"	select="($depth * 3) - 1"/>	<!-- 2 Ziffern pro Ebene + Punkt dazwischen -->
		<xsl:variable name="titlePrefix"	as="xs:string?">
			<xsl:call-template name="GetTopicTitlePrefix">
				<xsl:with-param name="numLst"		select="$numLst"/>
				<xsl:with-param name="rootTopicRef"	select="$rootTopicRef"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:choose>
			<xsl:when test="string-length($titlePrefix) > $maxTabNumLen">
				<!-- keine Formatierung als Tabelle, da die erste Zelle zu schmal wäre --> 
				<fo:block>
					<xsl:sequence select="$titlePrefix"/>
					<xsl:text> </xsl:text>
					<xsl:apply-templates/>
				</fo:block>
			</xsl:when>
			<xsl:when test="exists($titlePrefix)">
				<fo:table table-layout="fixed" width="100%">
					<fo:table-column column-number="1" column-width="{if (empty($numWidth)) then 0 else $numWidth}mm"/>
					<fo:table-column column-number="2" column-width="proportional-column-width(1)"/>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell margin="0">
								<fo:block>
									<xsl:sequence select="$titlePrefix"/>
								</fo:block>
							</fo:table-cell>
							<fo:table-cell margin="0">
								<fo:block>
									<xsl:apply-templates/>
								</fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</xsl:when>
			<xsl:otherwise>
				<fo:block>
					<xsl:apply-templates/>
				</fo:block>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="*[contains(@class, ' topic/fig ')]/*[contains(@class, ' topic/title ')]" mode="fig.title-number">
		<xsl:call-template name="ds:getEnumerableNum">
			<xsl:with-param name="enumerableClass" select="'topic/fig'"/>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template match="*[contains(@class, ' topic/table ')]/*[contains(@class, ' topic/title ')]" mode="table.title-number">
		<xsl:call-template name="ds:getEnumerableNum">
			<xsl:with-param name="enumerableClass" select="'topic/table'"/>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="ds:getEnumerableNum" as="xs:string?">
		<xsl:param name="enumerableClass" as="xs:string"/>
		
		<xsl:variable name="rootTopicRef" as="element()?">
			<xsl:apply-templates select="." mode="GetRootTopicRef"/>
		</xsl:variable>
		<xsl:variable name="rootNum" as="xs:integer?">
			<xsl:apply-templates select="$rootTopicRef" mode="GetTopicNum"/>
		</xsl:variable>
		<xsl:if test="exists($rootNum)">
			<xsl:variable name="rootTopic" 	as="element()?" select="key('topic-id', $rootTopicRef/@id)"/>
			<xsl:variable name="num"		as="xs:integer"	select="count(key('enumerableByClass', $enumerableClass)[(. &lt;&lt; current()) and (. &gt;&gt; $rootTopic)])"/>
			<xsl:choose>
				<xsl:when test="contains($rootTopicRef/@class, $CLASS_APPENDIX)">
					<xsl:number value="($rootNum, $num)" format="A-1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:number value="($rootNum, $num)" format="1-1"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	
	
	<xsl:template match="*" mode="insertChapterFirstpageStaticContent">
		<!-- no static content, just marker for link target -->
		<fo:block>
			<xsl:attribute name="id">
				<xsl:call-template name="generate-toc-id"/>
			</xsl:attribute>
		</fo:block>
	</xsl:template>
	
	
	<!-- ignore empty title -->
	<xsl:template name="processTopicNotices">
		<fo:page-sequence master-reference="body-sequence" xsl:use-attribute-sets="page-sequence.notice">
			<xsl:call-template name="startPageNumbering"/>
			<xsl:call-template name="insertPrefaceStaticContents"/>
			<fo:flow flow-name="xsl-region-body">
				<fo:block xsl:use-attribute-sets="topic">
					<xsl:call-template name="commonattributes"/>
					<xsl:if test="empty(ancestor::*[contains(@class, ' topic/topic ')])">
						<fo:marker marker-class-name="current-topic-number">
							<xsl:variable name="topicref" select="key('map-id', ancestor-or-self::*[contains(@class, ' topic/topic ')][1]/@id)"/>
							<xsl:for-each select="$topicref">
								<xsl:apply-templates select="." mode="topicTitleNumber"/>
							</xsl:for-each>
						</fo:marker>
						<xsl:apply-templates select="." mode="insertTopicHeaderMarker"/>
					</xsl:if>
					
					<xsl:apply-templates select="*[contains(@class,' topic/prolog ')]"/>
					
					<xsl:call-template name="insertChapterFirstpageStaticContent">
						<xsl:with-param name="type" select="'notices'"/>
					</xsl:call-template>

					<!-- ignore empty title -->
					<xsl:if test="exists(*[contains(@class,' topic/title ')]/(text() | element()))">
						<fo:block xsl:use-attribute-sets="topic.title">
							<xsl:call-template name="pullPrologIndexTerms"/>
							<xsl:for-each select="*[contains(@class,' topic/title ')]">
								<xsl:apply-templates select="." mode="getTitle"/>
							</xsl:for-each>
						</fo:block>
					</xsl:if>
					
					<xsl:choose>
						<xsl:when test="$noticesLayout='BASIC'">
							<xsl:apply-templates select="*[not(contains(@class, ' topic/topic ') or contains(@class, ' topic/title ') or
								contains(@class, ' topic/prolog '))]"/>
							<!--xsl:apply-templates select="." mode="buildRelationships"/-->
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates select="." mode="createMiniToc"/>
						</xsl:otherwise>
					</xsl:choose>
					
					<xsl:apply-templates select="*[contains(@class,' topic/topic ')]"/>
					<xsl:call-template name="pullPrologIndexTerms.end-range"/>
				</fo:block>
			</fo:flow>
		</fo:page-sequence>
	</xsl:template>
	
	<!-- add toc-id -->
	<xsl:template match="*[contains(@class,' topic/section ')]/*[contains(@class,' topic/title ')]">
		<fo:block xsl:use-attribute-sets="section.title">
			<fo:block>
				<xsl:attribute name="id">
					<xsl:call-template name="generate-toc-id">
						<xsl:with-param name="element" select=".."/>
					</xsl:call-template>
				</xsl:attribute>
			</fo:block>
			<xsl:call-template name="commonattributes"/>
			<xsl:apply-templates select="." mode="getTitle"/>
		</fo:block>
	</xsl:template>
	
	<!-- 
		- remove table layout
		- use navtitle if present (provides the ability to set a short version of a title)
	-->
	<xsl:template match="*[contains(@class, ' topic/topic ')]" mode="insertTopicHeaderMarkerContents">
		<xsl:apply-templates select="*[contains(@class,' topic/title ')]" mode="#current"/>
	</xsl:template>
	
	<xsl:template match="*[contains(@class, ' topic/title ')]" mode="insertTopicHeaderMarkerContents">
		<xsl:variable name="navTitleElement" as="element()?" select="following-sibling::*[contains(@class, ' topic/titlealts ')]/*[contains(@class, ' topic/navtitle ')]"/>
		<xsl:choose>
			<xsl:when test="$navTitleElement">
				<xsl:variable name="titlePrefix" as="xs:string?">
					<xsl:if test="contains(parent::*/@class, ' topic/topic ')">
						<xsl:variable name="numLst" as="xs:integer*">
							<xsl:apply-templates select="parent::*" mode="GetTopicNum"/>
						</xsl:variable>
						<xsl:variable name="rootTopicRef" as="element()?">
							<xsl:apply-templates select="." mode="GetRootTopicRef"/>
						</xsl:variable>
						<xsl:call-template name="GetTopicTitlePrefix">
							<xsl:with-param name="numLst"		select="$numLst"/>
							<xsl:with-param name="rootTopicRef"	select="$rootTopicRef"/>
						</xsl:call-template>
					</xsl:if>
				</xsl:variable>
				<xsl:value-of select="string-join(($titlePrefix, $navTitleElement), ' ')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="title" as="node()*">
					<xsl:apply-templates select="." mode="getTitle"/>
				</xsl:variable>
				<xsl:value-of select="ds:removeTitleFormatting($title)" separator=""/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- undo the formatting of a title as table  -->
	<xsl:function name="ds:removeTitleFormatting">
		<xsl:param name="content" as="node()*"/>
		
		<xsl:choose>
			<xsl:when test="$content/self::fo:table">
				<xsl:variable name="cells" as="element()*" select="$content/fo:table-body/fo:table-row[1]/fo:table-cell"/>
				<xsl:sequence select="$cells[1]/fo:block/node()"/>
				<xsl:text> </xsl:text>
				<xsl:sequence select="$cells[2]/fo:block/node()"/>
			</xsl:when>
			<xsl:when test="$content/self::fo:block">
				<xsl:sequence select="$content/self::fo:block/node()"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:sequence select="$content"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:function>
	
	
	<!-- note Element -->
	<xsl:template match="*[contains(@class,' topic/note ')]">
		
		<xsl:variable name="labelText" 	as="xs:string"	select="
				if 		(@type = 'note') 	then 'Hinweis'
				else if (@type = 'tip') 	then 'Tipp'
				else if (@type = 'caution') then 'Vorsicht'
				else '???'"/>
		
		<fo:block>
			<xsl:call-template name="commonattributes"/>
			<xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')]" mode="outofline"/>
			
			<fo:table xsl:use-attribute-sets="note__table">
				<!--<xsl:call-template name="e:profiling"/>-->
				<fo:table-column xsl:use-attribute-sets="note__image__column"/>
				<fo:table-column xsl:use-attribute-sets="note__text__column"/>
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell xsl:use-attribute-sets="note__image__entry">
							<fo:block>
								<xsl:value-of select="$labelText"/>
							</fo:block>
							<fo:block>
								<fo:external-graphic
									scaling			= "uniform" 
									content-width	= "100%"
									src				= "url('{$customizationDir.url}common/artwork/{@type}.svg')"/>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell xsl:use-attribute-sets="note__text__entry">
							<fo:block>
								<xsl:apply-templates/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
			
			<xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-endprop ')]" mode="outofline"/>
		</fo:block>

	</xsl:template>
	
	
	<xsl:template match="*[contains(@class,' topic/fig ')]">		
		<fo:block xsl:use-attribute-sets="fig">
			<xsl:call-template name="commonattributes"/>
			<xsl:call-template name="setFrame"/>
			<xsl:call-template name="setExpanse"/>
			<xsl:if test="not(@id)">
				<xsl:attribute name="id">
					<xsl:call-template name="get-id"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="*"/>	<!-- title above content -->
		</fo:block>
	</xsl:template>
	
	<!-- generate fo:block instead of fo:wrapper for link target elements to avoid additional space before title -->
	<xsl:template match="*" mode="processTopicTitle">
		<xsl:variable name="level" as="xs:integer">
			<xsl:apply-templates select="." mode="get-topic-level"/>
		</xsl:variable>
		<xsl:variable name="attrSet1">
			<xsl:apply-templates select="." mode="createTopicAttrsName">
				<xsl:with-param name="theCounter" select="$level"/>
			</xsl:apply-templates>
		</xsl:variable>
		<xsl:variable name="attrSet2" select="concat($attrSet1, '__content')"/>
		<fo:block>
			<xsl:call-template name="commonattributes"/>
			<xsl:call-template name="processAttrSetReflection">
				<xsl:with-param name="attrSet" select="$attrSet1"/>
				<xsl:with-param name="path" select="'../../cfg/fo/attrs/commons-attr.xsl'"/>
			</xsl:call-template>
			<fo:block>
				<xsl:call-template name="processAttrSetReflection">
					<xsl:with-param name="attrSet" select="$attrSet2"/>
					<xsl:with-param name="path" select="'../../cfg/fo/attrs/commons-attr.xsl'"/>
				</xsl:call-template>
				<xsl:if test="$level = 1">
					<xsl:apply-templates select="." mode="insertTopicHeaderMarker"/>
				</xsl:if>
				<xsl:if test="$level = 2">
					<xsl:apply-templates select="." mode="insertTopicHeaderMarker">
						<xsl:with-param name="marker-class-name" as="xs:string">current-h2</xsl:with-param>
					</xsl:apply-templates>
				</xsl:if>
				<fo:block id="{parent::node()/@id}"/>
				<fo:block>
					<xsl:attribute name="id">
						<xsl:call-template name="generate-toc-id">
							<xsl:with-param name="element" select=".."/>
						</xsl:call-template>
					</xsl:attribute>
				</fo:block>
				<xsl:call-template name="pullPrologIndexTerms"/>
				<xsl:apply-templates select="." mode="getTitle"/>
			</fo:block>
		</fo:block>
	</xsl:template>
	
	
	<!-- no vertical space within compact lists -->
	<xsl:template name="commonattributes">
		<xsl:apply-templates select="@id"/>
		<xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')] | *[contains(@class,' ditaot-d/ditaval-endprop ')]" mode="flag-attributes"/>
	</xsl:template>
	
	
	
	<xsl:function name="ds:getFoMaxWordLen" as="xs:double">
		<xsl:param name="content" 		as="node()*"/>
		<xsl:param name="fontFamily"	as="xs:string"/>
		<xsl:param name="fontSize"		as="xs:integer"/>
		<xsl:param name="fontBold" 		as="xs:boolean"/>
		
		<xsl:variable name="TextList" 	as="xs:string*" 	select="for $i in $content/descendant-or-self::text() return tokenize($i, '\s+')"/>
		<!--<xsl:message>TextList: <xsl:value-of select="string-join($TextList, ' | ')"/></xsl:message>-->
		
		<xsl:variable name="LenList" 	as="xs:double*" 	select="for $i in $TextList return ds:getTextWidth($i, $fontFamily, $fontSize, $fontBold)"/>
		<!--<xsl:message>LenList: <xsl:value-of select="string-join(for $i in $LenList return string($i), ' | ')"/></xsl:message>-->
		
		<xsl:variable name="MaxLen"		as="xs:double"		select="max($LenList)"/>
		<!--<xsl:message>MaxLen: <xsl:value-of select="$MaxLen"/></xsl:message>-->
		
		<xsl:sequence select="$MaxLen"/>
	</xsl:function>
	
	<xsl:function name="ds:getTextWidth" as="xs:double">
		<xsl:param name="text"			as="xs:string"/>
		<xsl:param name="fontFamily"	as="xs:string"/>
		<xsl:param name="fontSize"		as="xs:integer"/>
		<xsl:param name="fontBold" 		as="xs:boolean"/>
		
		<xsl:variable name="jFont" 	xmlns:font	="java:java.awt.Font" 					select="font:new($fontFamily, if ($fontBold) then 1 else 0, $fontSize)"/>
		<xsl:variable name="jAt"	xmlns:at	="java:java.awt.geom.AffineTransform" 	select="at:new()"/>
		<xsl:variable name="jFrc"	xmlns:frc	="java:java.awt.font.FontRenderContext" select="frc:new($jAt, true(), true())"/>
		<xsl:variable name="jRect"	xmlns:font	="java:java.awt.Font" 					select="font:getStringBounds($jFont, $text, $jFrc)"/>
		<xsl:sequence 				xmlns:rect	="java:java.awt.geom.Rectangle2D" 		select="rect:getWidth($jRect)"/>
	</xsl:function>
	
	<xsl:function name="ds:ptToMm" as="xs:double">
		<xsl:param name="Pt" as="xs:double"/>
		<xsl:sequence select="$Pt div (0.75 * 3.779528)"/>
	</xsl:function>
	
	<!-- height = "100%" entfernt (bewirkt bei oXygen 18.0 großen Abstand unter dem Bild -->
	<xsl:template match="*" mode="placeImage">
		<xsl:param name="imageAlign"/>
		<xsl:param name="href"/>
		<xsl:param name="height" as="xs:string?"/>
		<xsl:param name="width" as="xs:string?"/>
		<!--Using align attribute set according to image @align attribute-->
		<xsl:call-template name="processAttrSetReflection">
			<xsl:with-param name="attrSet" select="concat('__align__', $imageAlign)"/>
			<xsl:with-param name="path" select="'../../cfg/fo/attrs/commons-attr.xsl'"/>
		</xsl:call-template>
		<fo:external-graphic src="url('{$href}')" xsl:use-attribute-sets="image">
			<!--Setting image height if defined-->
			<xsl:if test="$height">
				<xsl:attribute name="content-height">
					<!--The following test was commented out because most people found the behavior
                 surprising.  It used to force images with a number specified for the dimensions
                 *but no units* to act as a measure of pixels, *if* you were printing at 72 DPI.
                 Uncomment if you really want it. -->
					<xsl:choose>
						<!--xsl:when test="not(string(number($height)) = 'NaN')">
                        <xsl:value-of select="concat($height div 72,'in')"/>
                      </xsl:when-->
						<xsl:when test="not(string(number($height)) = 'NaN')">
							<xsl:value-of select="concat($height, 'px')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$height"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
			</xsl:if>
			<!--Setting image width if defined-->
			<xsl:if test="$width">
				<xsl:attribute name="content-width">
					<xsl:choose>
						<!--xsl:when test="not(string(number($width)) = 'NaN')">
                        <xsl:value-of select="concat($width div 72,'in')"/>
                      </xsl:when-->
						<xsl:when test="not(string(number($width)) = 'NaN')">
							<xsl:value-of select="concat($width, 'px')"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$width"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="not($width) and not($height) and @scale">
				<xsl:attribute name="content-width">
					<xsl:value-of select="concat(@scale,'%')"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="@scalefit = 'yes' and not($width) and not($height) and not(@scale)">            
				<xsl:attribute name="width">
					<xsl:text>100%</xsl:text>
					<xsl:if test="@outputclass = 'frame'"> - 2pt</xsl:if>
				</xsl:attribute>
				<!--<xsl:attribute name="height">100%</xsl:attribute>-->
				<xsl:attribute name="content-width">scale-down-to-fit</xsl:attribute>
				<xsl:attribute name="content-height">scale-down-to-fit</xsl:attribute>
				<xsl:attribute name="scaling">uniform</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="node() except (text(),
				*[contains(@class, ' topic/alt ') or
				contains(@class, ' topic/longdescref ')])"/>
		</fo:external-graphic>
	</xsl:template>
	
	
	<xsl:template match="*[contains(@class, ' svg-d/svg-container ')]" priority="10">
		<fo:inline>	
			<!-- the fo:inline is required to make sourrounding links work -->
			<fo:block padding-top="-0.1em" padding-bottom="-0.35em">
				<!-- negatve padding is required to avoid a gap around the graphic. font-size 0 doesn't work. -->
				<fo:instream-foreign-object width="100%" content-width="scale-down-to-fit">
					<xsl:call-template name="commonattributes"/>
					<xsl:copy-of select="svg:svg"/>
				</fo:instream-foreign-object>
			</fo:block>
		</fo:inline>
	</xsl:template>
	
	
	<xsl:template match="*[contains(@class, ' akr-d/key-xref ')][@outputclass = 'svg']">
		<xsl:apply-templates select="*"/>
	</xsl:template>
	
	<xsl:template match="processing-instruction('pagebreak')">
		<fo:block break-after="page"/>
	</xsl:template>
	
	<!-- 
		use block for images within fig
		add zero-width-space before deleted inline image
		create colored frame for added/deleted images
	-->
	<xsl:template match="*[contains(@class,' topic/image ')]">
		<xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')]" mode="outofline"/>
		<xsl:choose>
			<xsl:when test="empty(@href)"/>
			<xsl:when test="(@placement = 'break') or (contains(parent::*/@class, ' topic/fig '))">
				<fo:block xsl:use-attribute-sets="image__block">
					<xsl:call-template name="commonattributes"/>
					<xsl:if test="@rev = ('dsd:added', 'dsd:deleted')">
						<xsl:attribute name="border-style" select="'solid'"/>
						<xsl:attribute name="border-width" select="'2pt'"/>
						<xsl:attribute name="border-color" select="ditaval-startprop/revprop/@color"/>
					</xsl:if>
					<xsl:apply-templates select="." mode="placeImage">
						<xsl:with-param name="imageAlign" select="@align"/>
						<xsl:with-param name="href" select="if (@scope = 'external' or opentopic-func:isAbsolute(@href)) then @href else concat($input.dir.url, @href)"/>
						<xsl:with-param name="height" select="@height"/>
						<xsl:with-param name="width" select="@width"/>
					</xsl:apply-templates>
				</fo:block>
				<xsl:if test="$artLabel='yes'">
					<fo:block>
						<xsl:apply-templates select="." mode="image.artlabel"/>
					</fo:block>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="@rev = 'dsd:deleted'">
					<xsl:text>&#x200B;</xsl:text>
				</xsl:if>
				<fo:inline xsl:use-attribute-sets="image__inline">
					<xsl:call-template name="commonattributes"/>
					<xsl:if test="@rev = ('dsd:added', 'dsd:deleted')">
						<xsl:attribute name="border-style" select="'solid'"/>
						<xsl:attribute name="border-width" select="'2pt'"/>
						<xsl:attribute name="border-color" select="ditaval-startprop/revprop/@color"/>
					</xsl:if>
					<xsl:apply-templates select="." mode="placeImage">
						<xsl:with-param name="imageAlign" select="@align"/>
						<xsl:with-param name="href" select="if (@scope = 'external' or opentopic-func:isAbsolute(@href)) then @href else concat($input.dir.url, @href)"/>
						<xsl:with-param name="height" select="@height"/>
						<xsl:with-param name="width" select="@width"/>
					</xsl:apply-templates>
				</fo:inline>
				<xsl:if test="$artLabel='yes'">
					<xsl:apply-templates select="." mode="image.artlabel"/>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-endprop ')]" mode="outofline"/>
	</xsl:template>


	<xsl:template match="*[contains(@class,' topic/draft-comment ')]">
		<xsl:if test="($publishRequiredCleanup = 'yes') or ($DRAFT = 'yes')">
			<fo:block xsl:use-attribute-sets="draft-comment">
				<xsl:call-template name="commonattributes"/>
				<xsl:if test="@disposition | @status">
					<fo:block xsl:use-attribute-sets="draft-comment__label">
						<xsl:text>Disposition: </xsl:text>
						<xsl:value-of select="@disposition"/>
						<xsl:text> / </xsl:text>
						<xsl:text>Status: </xsl:text>
						<xsl:value-of select="@status"/>
					</fo:block>
				</xsl:if>
				<xsl:apply-templates/>
			</fo:block>
		</xsl:if>
	</xsl:template>

	<!-- support flagging -->
	<xsl:template match="*[contains(@class,' topic/body ')]">
		<xsl:variable name="level" as="xs:integer">
			<xsl:apply-templates select="." mode="get-topic-level"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="not(node())"/>
			<xsl:when test="$level = 1">
				<fo:block xsl:use-attribute-sets="body__toplevel">
					<xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')]" mode="flag-attributes"/>
					<xsl:apply-templates/>
				</fo:block>
			</xsl:when>
			<xsl:when test="$level = 2">
				<fo:block xsl:use-attribute-sets="body__secondLevel">
					<xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')]" mode="flag-attributes"/>
					<xsl:apply-templates/>
				</fo:block>
			</xsl:when>
			<xsl:otherwise>
				<fo:block xsl:use-attribute-sets="body">
					<xsl:apply-templates select="*[contains(@class,' ditaot-d/ditaval-startprop ')]" mode="flag-attributes"/>
					<xsl:apply-templates/>
				</fo:block>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
</xsl:stylesheet>
