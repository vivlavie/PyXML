<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" encoding="UTF-8"/>

<xsl:variable name="name">Fred</xsl:variable>

<xsl:template match="/">
  <xsl:variable name="name">Barney</xsl:variable>
  <xsl:value-of select="$name"/>
</xsl:template>
</xsl:stylesheet>
