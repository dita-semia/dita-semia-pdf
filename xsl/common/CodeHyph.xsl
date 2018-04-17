<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet exclude-result-prefixes="#all" version="2.0"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<!--
		Bedingungen, dass ein (zu berücksichtigender) Bezeichner vorliegt:
		  - Ist länger als 5 Zeichen.
	
		Positionen für (zusätzliche) Trennstellen:
		  - nach einem Punkt, Unterstrich oder @, wenn ein Buchstabe oder eine Ziffer folgt
		  - nach mindestens zwei Kleinbuchstaben, wenn ein Großbuchstabe folgt
		  - nach mindestens zwei Buchstaben, wenn mindestens zwei Ziffern folgen
		  - nach mindestens zwei Ziffern, wenn mindestens zwei Buchstaben folgen
	-->
	<xsl:template match="text()" mode="codeHyph">
		<xsl:analyze-string select="." regex="[^\s]{{5,}}">
			<xsl:matching-substring>
				<xsl:sequence select="replace(replace(replace(replace(.,
					'([.@_])([a-zßäöüA-ZÄÖÜ0-9])', '$1­$2'),
					'([a-zßäöü]{2})([A-ZÄÖÜ])', '$1­$2'),
					'([a-zßäöüA-ZÄÖÜ]{2})([0-9]{2})', '$1­$2'),
					'([0-9]{2})([a-zßäöüA-ZÄÖÜ]{2})', '$1­$2')"/>
			</xsl:matching-substring>
			<xsl:non-matching-substring>
				<xsl:sequence select="."/>
			</xsl:non-matching-substring>
		</xsl:analyze-string>
	</xsl:template>
	
	<!-- Default-Regeln -->
	<xsl:template match="attribute() | comment() | processing-instruction()" mode="codeHyph">
		<xsl:copy/>
	</xsl:template>
	
	<xsl:template match="document-node() | element()" mode="codeHyph">
		<xsl:copy>
			<xsl:apply-templates select="attribute() | node()" mode="#current"/>
		</xsl:copy>
	</xsl:template>

	</xsl:stylesheet>
