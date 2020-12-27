<%@ Language=VBScript %>
<%
Response.ContentType = "text/xml"

Dim sNumber1, sNumber2
Dim nResult

sNumber1 = Request.QueryString.Item("numOne")
sNumber2 = Request.QueryString.Item("numTwo")

On Error Resume Next
nResult = CLng(sNumber1) + CLng(sNumber2)

If Err.number <> 0 Then
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