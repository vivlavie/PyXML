<%@Language="VBSCRIPT"%>
<%
  Option Explicit

  Response.ContentType = "text/xml"

  Dim objSource
  Dim objXSL
  Dim strOutput

  Set objSource = Server.CreateObject( "MSXML2.DOMDocument.3.0" )
  Set objXSL = Server.CreateObject( "MSXML2.DOMDocument.3.0" )

  objSource.load Request
  objXSL.load Server.MapPath( "recipes.xsl" )

  strOutput = objSource.transformNode( objXSL )

  Response.Write strOutput

  Set objSource = Nothing
  Set objXSL = Nothing
%>
