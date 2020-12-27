<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" encoding="UTF-8"/>

<xsl:template match="/">
  <xsl:for-each select="/person/name">
    <xsl:call-template name="name">
      <xsl:with-param name="first">Fred</xsl:with-param>
      <xsl:with-param name="last">Garvin</xsl:with-param>
    </xsl:call-template>
  </xsl:for-each>
</xsl:template>

<xsl:template name="name">
  <xsl:param name="first"><xsl:value-of select="first"/></xsl:param>
  <xsl:param name="last"><xsl:value-of select="last"/></xsl:param>

  First:  <xsl:value-of select="$first"/>
  Last:  <xsl:value-of select="$last"/>
</xsl:template>
</xsl:stylesheet>
