<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<!-- showrecipes.xsl -->
	<!-- Written by Chris Dix, 2001 -->

	<xsl:template match="/">
		<xsl:variable name="recipeList" select="//*[local-name() = 'recipe']" />
		<TABLE bgcolor="white" border="1" bordercolor="#111111" cellspacing="0" cellpadding="3" style="font-size:10pt; font-family:Verdana; color:black;">
			<xsl:if test="not($recipeList)">
				<tr><td>No match</td></tr>
			</xsl:if>
			<xsl:for-each select="$recipeList">
				<tr><td>
				<p><B><xsl:value-of select="child::*[local-name() = 'name']"/></B> by <xsl:value-of select="child::*[local-name() = 'author']"/></p>
				<xsl:variable name="ingredientList" select="child::*[local-name() = 'ingredients']" />
				<xsl:variable name="directionList" select="child::*[local-name() = 'directions']" />

				<xsl:for-each select="$ingredientList">
					<xsl:variable name="ingItems" select="child::*[local-name() = 'ingredient']" />
					<xsl:for-each select="$ingItems">
						<p>   <xsl:value-of select="."/></p>
					</xsl:for-each>	  
				</xsl:for-each>	  
				<xsl:for-each select="$directionList">
					<xsl:variable name="dirItems" select="child::*[local-name() = 'direction']" />
					<xsl:for-each select="$dirItems">
						<p><b><xsl:value-of select="position()"/></b>. <xsl:value-of select="."/></p>
					</xsl:for-each>	  
				</xsl:for-each>	  
				</td></tr>
			</xsl:for-each>
		</TABLE>
	</xsl:template>

</xsl:stylesheet>
