<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" encoding="UTF-8"/>

<xsl:template match="/">
  <people>
    <xsl:apply-templates select="people/name"/>
  </people>
</xsl:template>

<xsl:template match="name">
  <name>
    <xsl:apply-templates select="@*"/>
  </name>
</xsl:template>

<xsl:template match="@*">
  <xsl:element name="{local-name()}"><xsl:value-of select="."/></xsl:element>
</xsl:template>
</xsl:stylesheet>
