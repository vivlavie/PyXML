<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="UTF-8"/>

<xsl:template match="/ | * | @*">
  <xsl:copy>
    <xsl:apply-templates select="* | @* | text()"/>
</xsl:copy>
</xsl:template>

<xsl:template match="salary[not(number(parent::employee/@FullSecurity))]">
  <!--do not process this node-->
</xsl:template>
</xsl:stylesheet>
