<%@ Language=VBScript %>
<%
Response.ContentType = "text/xml"
Response.AddHeader "SOAPAction", "http://www.sernaferna.com/soap/addNumbers#addNumbersResult"

Dim xdRequestXML
Dim sNumber1, sNumber2
Dim nResult

Set xdRequestXML = Server.CreateObject("MSXML.DOMDocument")
xdRequestXML.load Request

sNumber1 = xdRequestXML.documentElement.firstChild.firstChild.firstChild.text
sNumber2 = xdRequestXML.documentElement.firstChild.firstChild.lastChild.text

On Error Resume Next
nResult = CLng(sNumber1) + CLng(sNumber2)

If Err.number <> 0 Then
   Response.Write ErrorXML("Client", "Invalid numbers", sNumber1, sNumber2)
ElseIf Request.ServerVariables("HTTP_SOAPAction") <> "http://www.sernaferna.com/soap/addNumbers#addNumbers" Then
   Response.Write ErrorXML("Client", "Procedure not understood", Request.ServerVariables("SOAPAction"), sNumber2)
Else
   Response.Write SuccessXML(nResult)
End If

Function ErrorXML(sFaultCode, sFaultString, sNumOne, sNumTwo)
   Dim sXML

   sXML = "<SOAP-ENV:Envelope xmlns:SOAP-ENV="
   sXML = sXML & "'http://schemas.xmlsoap.org/soap/envelope/'>"
   sXML = sXML  & vbNewLine & "<SOAP-ENV:Body>" & vbNewLine
   sXML = sXML & "<SOAP-ENV:Fault>" & vbNewLine
   sXML = sXML & "<faultcode>soap:" & sFaultCode & "</faultcode>" & vbNewLine
   sXML = sXML & "<faultstring>" & sFaultString & "</faultstring>" & vbNewLine
   sXML = sXML & "<faultactor>http://www.sernaferna.com/"
   sXML = sXML & "SOAP/addNumbers3.asp</faultactor>" & vbNewLine
   sXML = sXML & "<detail>" & vbNewLine
   sXML = sXML & "<an:addNumbersDetail "
   sXML = sXML & "xmlns:an='http://www.sernaferna.com/soap/addNumbers/'>"
   sXML = sXML & vbNewLine & "<an:numOne>" & sNumOne & "</an:numOne>" & vbNewLine
   sXML = sXML & "<an:numTwo>" & sNumTwo & "</an:numTwo>" & vbNewLine
   sXML = sXML & "</an:addNumbersDetail>" & vbNewLine
   sXML = sXML & "</detail>" & vbNewLine
   sXML = sXML & "</SOAP-ENV:Fault>" & vbNewLine
   sXML = sXML & "</SOAP-ENV:Body>" & vbNewLine
   sXML = sXML & "</SOAP-ENV:Envelope>"
   ErrorXML = sXML
End Function

Function SuccessXML(sResult)
   Dim sXML

   sXML = "<SOAP-ENV:Envelope xmlns:SOAP-ENV="
   sXML = sXML & "'http://schemas.xmlsoap.org/soap/envelope/'>"
   sXML = sXML & vbNewLine & "<SOAP-ENV:Body>" & vbNewLine
   sXML = sXML & "<an:addNumbersResponse "
   sXML = sXML & "xmlns:an='http://www.sernaferna.com/soap/addNumbers'>"
   sXML = sXML & vbNewLine
   sXML = sXML & "<response>" & sResult & "</response>" & vbNewLine
   sXML = sXML & "</an:addNumbersResponse>" & vbNewLine
   sXML = sXML & "</SOAP-ENV:Body>" & vbNewLine
   sXML = sXML & "</SOAP-ENV:Envelope>"

   SuccessXML = sXML
End Function
%>

