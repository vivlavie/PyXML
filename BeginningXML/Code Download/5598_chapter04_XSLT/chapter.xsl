<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="UTF-8"/>

<xsl:template match="/">
  <html>
  <head><title><xsl:value-of select="chapter/title"/></title></head>
  <body>
  <h1><xsl:value-of select="chapter/title"/></h1>

  <h2>Table of Contents</h2>
  <ol>
    <xsl:apply-templates select="chapter/section" mode="TOC"/>
  </ol>

  <xsl:apply-templates select="chapter/section" mode="body"/>

  </body>
  </html>
</xsl:template>

<xsl:template match="section" mode="TOC">
    <li><A href="{concat('#section', position())}"><xsl:value-of select="text()"/></a></li>
</xsl:template>

<xsl:template match="section" mode="body">
  <a name="{concat('section', position())}"><h2><xsl:value-of select="text()"/></h2></a>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="paragraph">
  <p><xsl:apply-templates/></p>
</xsl:template>
<xsl:template match="important">
  <b><xsl:apply-templates/></b>
</xsl:template>

<xsl:template match="/chapter/section/text()"><!--do nothing--></xsl:template>
</xsl:stylesheet>
