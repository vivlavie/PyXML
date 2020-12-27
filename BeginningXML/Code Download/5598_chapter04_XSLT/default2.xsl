<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" encoding="UTF-8"/>

<xsl:template match="first">
  First name:  <xsl:value-of select="."/>
</xsl:template>
<xsl:template match="text() | @*">
  <!--do nothing-->
</xsl:template>

</xsl:stylesheet>
