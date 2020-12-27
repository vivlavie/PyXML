<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
    <html>
      <head><title>Regional Information</title></head>
      <body>
      <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="store">
    <P>Store Name:
    <xsl:value-of select="name" />
    </P>
    <xsl:variable name="regionCode" select="region" />
    <xsl:variable name="regions" 
                  select="document('regions.xml')//*[local-name()='region']" />
    <xsl:for-each select="$regions">
      <xsl:if test="$regionCode=code" >
        <p>Contact:
          <xsl:value-of select="phone" />
        </p>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>

