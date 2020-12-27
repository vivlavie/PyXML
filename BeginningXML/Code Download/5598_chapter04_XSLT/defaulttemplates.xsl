<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" encoding="UTF-8" />

<xsl:template match="order">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="date">
  Date:  <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="customers">
  Customer:  <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="item">
  Part number:  <xsl:value-of select="part-number"/>
  Description:  <xsl:value-of select="description"/>
  Quantity:  <xsl:value-of select="quantity"/>
</xsl:template>
</xsl:stylesheet>
