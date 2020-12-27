<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" encoding="UTF-8"/>

<!--
<xsl:template match="/">
  <element>
    <xsl:apply-templates/>
  </element>
</xsl:template>
-->

<xsl:template match="Element">
<Element>
<Name>
    <xsl:value-of select="@Name" disable-output-escaping="yes"/>
</Name>
<Goal>
    <xsl:value-of select="@Goal" disable-output-escaping="yes"/>
</Goal>
</Element>
</xsl:template>
</xsl:stylesheet>
