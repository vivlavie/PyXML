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
   Response.Write vbTab & "<Description>" & Err.Description & "</Description>" & vbNewLine
   Response.Write "</Error>"
   Response.End
End If

rsReturn.Save Response, 1

Set rsReturn = Nothing
%>
