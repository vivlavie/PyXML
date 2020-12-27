<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output media-type="text/html" method="xml"/>
  <xsl:param name="theme" select="'red'"/>   
  <xsl:template match="/">
    <html>
      <head>
        <title>Table Properties</title>
      </head>
      <body>
        <xsl:apply-templates select="cssproperties"/>
       </body>
    </html>
  </xsl:template>

  <xsl:template match="cssproperties">
    <style>
   <xsl:value-of select="document('themes.xml')/stylesheets/style[@id=$theme]"/>
    </style>
    <table class="cssproperties">
      <xsl:apply-templates select="headers"/>
      <xsl:apply-templates select="properties"/>
    </table>
  </xsl:template>
   
  <xsl:template match="headers">
    <thead class="{name(.)}">
      <xsl:apply-templates select="header"/>
    </thead>
  </xsl:template>

  <xsl:template match="header">
    <th class="{name(.)}"><xsl:value-of select="."/></th>
  </xsl:template>

  <xsl:template match="properties">
    <tbody class="{name(.)}">
      <xsl:apply-templates select="property"/>
    </tbody>
  </xsl:template>

  <xsl:template match="property">
    <tr class="{name(.)} row{position() mod 2}">
      <xsl:apply-templates select="*" mode="properties"/>
    </tr>
  </xsl:template>

  <xsl:template match="*" mode="properties">
    <td class="{name(.)}">
      <xsl:apply-templates select="."/>
    </td>
  </xsl:template>

  <xsl:template match="analog" mode="properties">
    <td class="{name(.)}">
      &lt;<xsl:apply-templates select="."/>&gt;
    </td>
  </xsl:template>

</xsl:stylesheet>






