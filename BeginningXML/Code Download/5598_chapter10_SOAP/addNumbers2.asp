<%@ Language=VBScript %>
<%
Response.ContentType = "text/xml"
Response.AddHeader "SOAPAction", "addNumbersResult"

Dim xdRequestXML
Dim sNumber1, sNumber2
Dim nResult

Set xdRequestXML = Server.CreateObject("MSXML.DOMDocument")
xdRequestXML.load Request

sNumber1 = xdRequestXML.selectSingleNode("/addNumbers/numOne").text
sNumber2 = xdRequestXML.selectSingleNode("/addNumbers/numTwo").text

On Error Resume Next
nResult = CLng(sNumber1) + CLng(sNumber2)

If Err.number <> 0 Or Request.ServerVariables("HTTP_SOAPAction") <> "addNumbers" Then
   Response.Write ErrorXML()
Else
   Response.Write SuccessXML(nResult)
End If


Function ErrorXML()
	Dim sXML

	sXML = "<Error><Reason>Invalid numbers</Reason></Error>"

	ErrorXML = sXML
End Function

Function SuccessXML(sResult)
	Dim sXML

	sXML = "<addNumbers>" & vbNewLine
	sXML = sXML & "<result>" & sResult & "</result>" & vbNewLine
	sXML = sXML & "</addNumbers>"

	SuccessXML = sXML
End Function
%>