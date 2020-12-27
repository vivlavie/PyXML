<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                                                                 version="1.0">
  <xsl:output media-type="text/html" method="xml"/>

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
      .cssproperties {table;border:inset 3px black;}
      .headers {display:table-header-group;}
      .header { display:table-cell;
                padding:5px;
                background-color:navy;
                color:white;
                font-weight:bold;
                border:outset 2px black;}
      .properties {display:table-row-group}
      .property {display:table-row;}
      .propName {display:table-cell;padding:5px;}
      .propDesc {display:table-cell;padding:5px;}
      .analog {display:table-cell;}
      .row0 {background-color:lightBlue;}
      .row1 {background-color:white;}
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





