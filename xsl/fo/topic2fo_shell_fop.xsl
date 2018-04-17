<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet 
	e:version="2.3" 
	exclude-result-prefixes="ditaarch opentopic e" 
	version="2.0"
	xmlns:ditaarch		="http://dita.oasis-open.org/architecture/2005/"
	xmlns:e				="org.dita-semia.pdf"
	xmlns:opentopic		="http://www.idiominc.com/opentopic"
	xmlns:opentopic-func="http://www.idiominc.com/opentopic/exsl/function"
	xmlns:xs			="http://www.w3.org/2001/XMLSchema" 
	xmlns:xsl			="http://www.w3.org/1999/XSL/Transform">
	
	<!-- DITA-SEMIA - Attribute (oben importieren, damit sie nachfolgend übersteuert werden können) -->
	<xsl:import href="plugin:org.dita-semia.resolver:xsl/fo/dl-attr.xsl"/>
	
	<!--base imports-->
	<xsl:import href="plugin:org.dita-semia.pdf:xsl/fo/class.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:xsl/common/CodeHyph.xsl"/>
	<xsl:import href="plugin:org.dita.base:xsl/common/dita-utilities.xsl"/>
	<xsl:import href="plugin:org.dita.base:xsl/common/dita-textonly.xsl"/>
	<xsl:import href="plugin:org.dita.base:xsl/common/related-links.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/common/attr-set-reflection.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/common/vars.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/basic-settings.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:cfg/fo/attrs/basic-settings.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/layout-masters-attr.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:cfg/fo/attrs/layout-masters-attr.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:cfg/fo/layout-masters.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:cfg/fo/layout-masters.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/links-attr.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:cfg/fo/attrs/links-attr.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/links.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:xsl/fo/links.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:cfg/fo/attrs/dl-attr.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/lists-attr.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:cfg/fo/attrs/lists-attr.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/lists.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:xsl/fo/lists.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/tables-attr.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:cfg/fo/attrs/tables-attr.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/tables.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/root-processing.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:xsl/fo/root-processing.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/commons-attr.xsl"/>
	<!--<xsl:import href="plugin:org.dita-semia.pdf:cfg/fo/attrs/commons-attr.xsl"/>-->	<!-- nach unten geschoben, um fop zu übersteuern -->
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/commons.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:xsl/fo/commons.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:xsl/fo/numbering.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/toc-attr.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:cfg/fo/attrs/toc-attr.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/toc.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:xsl/fo/toc.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/bookmarks.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:xsl/fo/bookmarks.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/index-attr.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/index.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/front-matter-attr.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:cfg/fo/attrs/front-matter-attr.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/front-matter.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:xsl/fo/front-matter.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/preface.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/map-elements-attr.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/map-elements.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/task-elements-attr.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:cfg/fo/attrs/task-elements-attr.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/task-elements.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:xsl/fo/task-elements.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/reference-elements-attr.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/reference-elements.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/sw-domain-attr.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:cfg/fo/attrs/sw-domain-attr.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/sw-domain.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:xsl/fo/sw-domain.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/pr-domain-attr.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:cfg/fo/attrs/pr-domain-attr.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/pr-domain.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:xsl/fo/pr-domain.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/hi-domain-attr.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/hi-domain.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/ui-domain-attr.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/ui-domain.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/ut-domain.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/abbrev-domain.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/markup-domain-attr.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/markup-domain.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/xml-domain-attr.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/xml-domain.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/static-content-attr.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:cfg/fo/attrs/static-content-attr.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/static-content.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:xsl/fo/static-content.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/glossary-attr.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/glossary.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:xsl/fo/glossary.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/lot-lof-attr.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:cfg/fo/attrs/lot-lof-attr.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/lot-lof.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:xsl/fo/lot-lof.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:cfg/fo/attrs/learning-elements-attr.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/learning-elements.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/flagging.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2:xsl/fo/flagging-from-preprocess.xsl"/>

	<!-- DITA-SEMIA resolver -->
	<xsl:import href="plugin:org.dita-semia.resolver:xsl/fo/dl-outputclasses.xsl"/>
	<xsl:import href="plugin:org.dita-semia.resolver:xsl/fo/advanced-keyref.xsl"/>
	
	<!--formatter specific imports-->
	<xsl:import href="plugin:org.dita.pdf2.fop:cfg/fo/attrs/commons-attr_fop.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2.fop:cfg/fo/attrs/tables-attr_fop.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2.fop:cfg/fo/attrs/toc-attr_fop.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2.fop:xsl/fo/root-processing_fop.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2.fop:xsl/fo/index_fop.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2.fop:xsl/fo/tables_fop.xsl"/>
	<xsl:import href="plugin:org.dita.pdf2.fop:xsl/fo/flagging_fop.xsl"/>
	
	<!-- custom imports, that need to override fop and dita-semia-resolver -->
	<xsl:import href="plugin:org.dita-semia.pdf:cfg/fo/attrs/commons-attr.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:xsl/fo/tables.xsl"/>
	<xsl:import href="plugin:org.dita-semia.pdf:xsl/fo/dl-outputclasses.xsl"/>
	
	<!--parameters-->
	
	<xsl:import href="plugin:org.dita-semia.pdf:xsl/common/CheckResolved.xsl"/>
	
	<xsl:template match="/" priority="1000">
		<xsl:message>locale:                    <xsl:value-of select="$locale"/></xsl:message>
		<xsl:message>customizationDir.url:      <xsl:value-of select="$customizationDir.url"/></xsl:message>
		<xsl:message>input.dir.url:             <xsl:value-of select="$input.dir.url"/></xsl:message>
		<xsl:message>DRAFT:                     <xsl:value-of select="DRAFT"/></xsl:message>
		<xsl:message>output.dir.url:            <xsl:value-of select="$output.dir.url"/></xsl:message>
		<xsl:message>work.dir.url:              <xsl:value-of select="work.dir.url"/></xsl:message>
		<xsl:message>artworkPrefix:             <xsl:value-of select="$artworkPrefix"/></xsl:message>
		<xsl:message>publishRequiredCleanup:    <xsl:value-of select="$publishRequiredCleanup"/></xsl:message>
		<xsl:message>artLabel:                  <xsl:value-of select="$artLabel"/></xsl:message>
		<xsl:message>antArgsChapterLayout:      <xsl:value-of select="$antArgsChapterLayout"/></xsl:message>
		<xsl:message>include.rellinks:          <xsl:value-of select="$include.rellinks"/></xsl:message>
		<xsl:message>antArgsGenerateTaskLabels: <xsl:value-of select="$antArgsGenerateTaskLabels"/></xsl:message>
		<xsl:message>pdfFormatter:              <xsl:value-of select="$pdfFormatter"/></xsl:message>
		<xsl:message>bookmap-order:             <xsl:value-of select="$bookmap-order"/></xsl:message>
		<xsl:message>figurelink.style:          <xsl:value-of select="$figurelink.style"/></xsl:message>
		<xsl:message>tablelink.style:           <xsl:value-of select="$tablelink.style"/></xsl:message>
		<xsl:message>variableFiles.url:         <xsl:value-of select="$variableFiles.url"/></xsl:message>
		<xsl:message>defaultLanguage:           <xsl:value-of select="$defaultLanguage"/></xsl:message>
		
		
		<xsl:next-match/>
	</xsl:template>
	
</xsl:stylesheet>
