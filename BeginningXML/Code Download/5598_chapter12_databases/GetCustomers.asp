<%@ Language=VBScript %>
<%
Response.ContentType = "text/xml"

Dim cnnNorthWind, rsReturn
Dim sSQLStatement

sSQLStatement = "SELECT * FROM Customers"

On Error Resume Next
Set cnnNorthWind = Server.CreateObject("ADODB.Connection")
cnnNorthWind.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Program Files\Microsoft Office\Office\Samples\Nwind.mdb;Persist Security Info=False"
cnnNorthWind.CursorLocation = 3 'adUseClient
cnnNorthWind.Open
Set rsReturn = cnnNorthWind.Execute(sSQLStatement)
Set cnnNorthWind = Nothing

If Err.number <> 0 Then
	Response.Write "<Error>" & vbNewLine
	Response.Write vbTab & "<Description>" & Err.Description & _
					"</Description>" & vbNewLine
	Response.Write "</Error>" & vbNewLine
	Response.End
End If

Response.Write "<?xml version='1.0' encoding='ISO-8859-1'?>" & vbNewLine
Response.Write "<Customers>" & vbNewLine

While Not rsReturn.EOF
	Response.Write vbTab & "<Customer ID='"
	Response.Write rsReturn("CustomerID")
	Response.Write "'>" & vbNewLine
	
	Response.Write vbTab & vbTab & "<CompanyName>" & rsReturn("CompanyName") & _
						     "</CompanyName>" & vbNewLine
	Response.Write vbTab & vbTab & "<ContactName>" & rsReturn("ContactName") & _
						     "</ContactName>" & vbNewLine
	Response.Write vbTab & vbTab & "<ContactTitle>" & rsReturn("ContactTitle") _
						   & "</ContactTitle>" & vbNewLine
	Response.Write vbTab & vbTab & "<Address>" & rsReturn("Address") & _
						     "</Address>" & vbNewLine
	Response.Write vbTab & vbTab & "<City>" & rsReturn("City") & _
						     "</City>" & vbNewLine
	Response.Write vbTab & vbTab & "<Region>" & rsReturn("Region") & _
						     "</Region>" & vbNewLine
	Response.Write vbTab & vbTab & "<PostalCode>" & rsReturn("PostalCode") & _
						     "</PostalCode>" & vbNewLine
	Response.Write vbTab & vbTab & "<Country>" & rsReturn("Country") & _
						     "</Country>" & vbNewLine
	Response.Write vbTab & vbTab & "<Phone>" & rsReturn("Phone") & _
						     "</Phone>" & vbNewLine
	Response.Write vbTab & vbTab & "<Fax>" & rsReturn("Fax") & _
						     "</Fax>" & vbNewLine
	
	Response.Write vbTab & "</Customer>" & vbNewLine
	Response.Flush
	
	rsReturn.MoveNext
Wend

Response.Write "</Customers>"

Set rsReturn = Nothing
%>
