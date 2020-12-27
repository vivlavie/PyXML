<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="UTF-8"/>

<xsl:template match="/">
  <html>
  <head>
  <title><xsl:value-of select="employee/name"/></title>
  </head>
  <body>
  <h1>Employee: <xsl:value-of select="employee/name"/></h1>
  <p>Department: <xsl:value-of select="employee/department"/></p>
  <p><xsl:apply-templates select="employee/phone"/></p>
  <xsl:if test="number(employee/@FullSecurity)">
    <p>Salary: <xsl:value-of select="employee/salary"/></p>
  </xsl:if>
  <p>Location: <xsl:apply-templates select="employee/area"/></p>
  </body>
  </html>
</xsl:template>

<xsl:template match="phone">
  Phone: <xsl:value-of select="text()"/> x<xsl:value-of select="extension"/>
</xsl:template>

<xsl:template match="area">
  <xsl:choose>
    <xsl:when test="number(.) = 1">Toronto</xsl:when>
    <xsl:when test="number(.) = 2">London</xsl:when>
    <xsl:when test="number(.) = 3">New York</xsl:when>
    <xsl:when test="number(.) = 4">Tokyo</xsl:when>
    <xsl:otherwise>Unknown Location</xsl:otherwise>    
  </xsl:choose>
</xsl:template>
</xsl:stylesheet>
