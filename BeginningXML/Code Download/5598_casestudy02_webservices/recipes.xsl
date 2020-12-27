<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- recipes.xsl -->
  <!-- Written by Chris Dix, 2001 -->

  <xsl:output method="xml" indent="yes" encoding="utf-8" omit-xml-declaration="yes"/>

  <!-- ThrowFault -->
  <xsl:template name="ThrowFault">
    <xsl:param name="code"/>
    <xsl:param name="str"/>

    <xsl:element name="Fault" namespace="http://schemas.xmlsoap.org/soap/envelope/">
      <xsl:element name="faultcode" namespace="http://schemas.xmlsoap.org/soap/envelope/">
        <xsl:value-of select="$code"/>
      </xsl:element>
      <xsl:element name="faultstring" namespace="http://schemas.xmlsoap.org/soap/envelope/">
        <xsl:value-of select="$str"/>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- ThrowVersionMismatchFault -->
  <xsl:template name="ThrowVersionMismatchFault">
    <xsl:call-template name="ThrowFault">
      <xsl:with-param name="code">SOAP:VersionMismatch</xsl:with-param>
      <xsl:with-param name="str">The version did not match the 1.1 specification.</xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- ThrowNoOperationFault -->
  <xsl:template name="ThrowNoOperationFault">
    <xsl:call-template name="ThrowFault">
      <xsl:with-param name="code">SOAP:Client.NoOperation</xsl:with-param>
      <xsl:with-param name="str">The requested operation does not exist.</xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- ProcessMesage -->
  <xsl:template name="ProcessMessage">
    <xsl:variable name="Envelope" select="child::*[local-name() = 'Envelope']"/>
    <xsl:text disable-output-escaping="yes">&#60;&#63;xml version="1.0" encoding="UTF-8"&#63;&#62;</xsl:text>

    <SOAP:Envelope xmlns:SOAP='http://schemas.xmlsoap.org/soap/envelope/' SOAP:encodingStyle='http://schemas.xmlsoap.org/soap/encoding/' xmlns:SOAP-ENC='http://schemas.xmlsoap.org/soap/encoding/' xmlns:xsd='http://www.w3.org/1999/XMLSchema' xmlns:xsi='http://www.w3.org/1999/XMLSchema-instance'>
      <SOAP:Body>
      <xsl:choose>
        <xsl:when test="$Envelope">
          <xsl:for-each select="$Envelope">
            <xsl:choose>
              <xsl:when test="self::s:*" xmlns:s="http://schemas.xmlsoap.org/soap/envelope/">
                <xsl:variable name="Body" select="child::*[local-name() = 'Body']"/>
                <xsl:for-each select="$Body">
                  <xsl:choose>
                    <xsl:when test="namespace-uri($Body) = 'http://schemas.xmlsoap.org/soap/envelope/'">
                      <xsl:variable name="payload" select="child::*"/>
                      <xsl:choose>
                        <xsl:when test="local-name($payload)='GetRecipes'">
                          <xsl:call-template name="ProcessPayload">
                            <xsl:with-param name="payload" select="$payload"/>
                          </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:call-template name="ThrowNoOperationFault" />
                        </xsl:otherwise>
                      </xsl:choose>  
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:call-template name="ThrowVersionMismatchFault" />
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:for-each>
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="ThrowVersionMismatchFault"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="ThrowVersionMismatchFault"/>
        </xsl:otherwise>
      </xsl:choose>
      </SOAP:Body>
    </SOAP:Envelope>
  </xsl:template>

  <xsl:template name="GetIngredientCount">
    <xsl:param name="recipe" />
    <xsl:param name="ingredientList" />
    
    <xsl:for-each select="$recipe" >
      <xsl:choose>
        <xsl:when test="$ingredientList" >
          <xsl:variable name="curr" select="$ingredientList[1]" />
          <xsl:variable name="rest">
            <xsl:call-template name="GetIngredientCount">
              <xsl:with-param name="recipe" select="$recipe" />
              <xsl:with-param name="ingredientList" select="$ingredientList[position()!=1]" />
            </xsl:call-template>
          </xsl:variable>
          <xsl:variable name="check" select="child::*[local-name()='ingredients']/child::*[local-name()='ingredient'][string()=$curr]" />
          <xsl:choose>
            <xsl:when test="$check">
              <xsl:value-of select="$rest + 1" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$rest" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template name="IsRecipeOk">
    <xsl:param name="recipe" />
    <xsl:param name="ingredientList" />
    
    <xsl:for-each select="$recipe" >
      <xsl:variable name="recipeIngredients" select="child::*[local-name()='ingredients']/child::*[local-name()='ingredient']" />
      <xsl:variable name="foundIngredients">
        <xsl:call-template name="GetIngredientCount">
          <xsl:with-param name="recipe" select="$recipe" />
          <xsl:with-param name="ingredientList" select="$ingredientList" />
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="listCount" select="count($recipeIngredients)" />
      <xsl:if test="number($foundIngredients) >= number($listCount)">1</xsl:if>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template name="ProcessPayload" >
    <xsl:param name="payload" />

    <xsl:element name="GetRecipeResponse" namespace="urn://www.wrox.com/recipes/" >
      <xsl:variable name="recipeList" select="document('recipes.xml')//*[local-name()='recipe']"/>
      <xsl:for-each select="$payload">
        <xsl:variable name="ingredientList" select="//*[local-name()='ingredient']" />
        
        <xsl:element name="recipes" namespace="urn://www.wrox.com/recipes/" >
          <xsl:for-each select="$recipeList">
              <xsl:variable name="recipe" select="." />
              <xsl:variable name="IsRecipeOk">
                <xsl:call-template name="IsRecipeOk">
                  <xsl:with-param name="recipe" select="$recipe" />
                  <xsl:with-param name="ingredientList" select="$ingredientList" />
                </xsl:call-template>
              </xsl:variable>
              <xsl:if test="$IsRecipeOk = '1'" >
                <xsl:copy-of select="$recipe" />
              </xsl:if>
          </xsl:for-each>
        </xsl:element>
      </xsl:for-each>
    </xsl:element>
  </xsl:template>

  <!-- Process the whole document as a SOAP request -->
  <xsl:template match="/">  
    <xsl:call-template name="ProcessMessage" />   
  </xsl:template>

</xsl:stylesheet>
