<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" encoding="UTF-8"/>

<xsl:template match="/">
  <xsl:choose>
    <xsl:when test="number(employee/@FullSecurity)">
      <xsl:copy-of select="/"/>
    </xsl:when>
    <xsl:otherwise>
      <employee FullSecurity="{employee/@FullSecurity}">
        <xsl:for-each select="employee/*[not(self::salary)]">
          <xsl:copy-of select="."/>
        </xsl:for-each>
      </employee>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>
</xsl:stylesheet>
