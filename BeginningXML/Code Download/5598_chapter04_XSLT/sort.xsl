<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" encoding="UTF-8"/>

<xsl:template match="/">
  <people>
    <xsl:for-each select="people/name">
      <xsl:sort select="last"/>
      <xsl:sort select="first"/>
      <xsl:copy-of select="."/>
    </xsl:for-each>
  </people>
</xsl:template>
</xsl:stylesheet>
