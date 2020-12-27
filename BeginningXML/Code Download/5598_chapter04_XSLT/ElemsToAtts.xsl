<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <people>
      <xsl:apply-templates/>
    </people>
  </xsl:template>

  <xsl:template match="//name">
    <xsl:element name="name" use-attribute-sets="NameAttributes"/>
  </xsl:template>

  <xsl:attribute-set name="NameAttributes">
    <xsl:attribute name="first"><xsl:value-of select="first"/></xsl:attribute>
    <xsl:attribute name="middle"><xsl:value-of select="middle"/></xsl:attribute>
    <xsl:attribute name="last"><xsl:value-of select="last"/></xsl:attribute>
  </xsl:attribute-set>
</xsl:stylesheet>
