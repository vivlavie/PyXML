<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" encoding="UTF-8"/>

<xsl:template match="/">
  <people>
    <xsl:for-each select="people/name">
      <name>
        <xsl:apply-templates select="@*"/>
      </name>
    </xsl:for-each>
  </people>
</xsl:template>

<xsl:template match="@*">
  <xsl:element name="{name()}"><xsl:value-of select="."/></xsl:element>
</xsl:template>
</xsl:stylesheet>
