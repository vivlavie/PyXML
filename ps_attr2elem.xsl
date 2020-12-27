<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" encoding="UTF-8"/>
<xsl:template match="/">
<?xml-stylesheet type="text/css" href="ps.css" ?>
  <PerformanceStandard>
    <xsl:apply-templates select="/DEFAULT/Element"/>
  </PerformanceStandard>
</xsl:template>

<xsl:template match="Element">
<Element>
    <xsl:apply-templates select="@*"/>
    <xsl:apply-templates select="SubElements"/>
    <xsl:apply-templates select="Functionality"/>
</Element>
</xsl:template>
<xsl:template match="@*">
  <xsl:element name="{name()}"><xsl:value-of select="."/></xsl:element>
</xsl:template>
<xsl:template match="SubElements">
  <xsl:for-each select="SubElement">
	  <SubElement>		  
			<xsl:apply-templates select="@*"/>		  
	  </SubElement>
  </xsl:for-each>
</xsl:template>
<xsl:template match="Functionality">
  <Functionality>
  <xsl:for-each select="FunctionalRequirement">
	  <FunctionalRequirement>		  
			<xsl:apply-templates select="@*"/>		  	  
	  </FunctionalRequirement>		  
  </xsl:for-each>
  </Functionality>
</xsl:template>
</xsl:stylesheet>
