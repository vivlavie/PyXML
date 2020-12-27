VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ContentHandlerImpl"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Implements IVBSAXContentHandler

Public m_oReader As IMXReaderControl
Private m_oLocator As IVBSAXLocator
Private m_strSaxophonist As String
Private m_bIsSaxophone As Boolean
Private m_strBandName As String
Private m_bIsName As Boolean
Private m_strBandType As String

Private Sub IVBSAXContentHandler_characters(strChars As String)
    If (m_bIsName) Then m_strBandName = m_strBandName + strChars
        
    If (m_bIsSaxophone) Then m_strSaxophonist = m_strSaxophonist + strChars
End Sub

Private Property Set IVBSAXContentHandler_documentLocator(ByVal RHS As MSXML2.IVBSAXLocator)
    Set m_oLocator = RHS
End Property

Private Sub IVBSAXContentHandler_endDocument()
    Form1.lstResults.AddItem ("... finished")
End Sub

Private Sub IVBSAXContentHandler_endElement(strNamespaceURI As String, strLocalName As String, strQName As String)
    If (m_bIsSaxophone) Then
        Form1.lstResults.AddItem ("The saxophonist in " + m_strBandName + " (" + m_strBandType + ") is " + m_strSaxophonist)
        m_bIsSaxophone = False
    End If
        
    If (m_bIsName) Then m_bIsName = False
End Sub

Private Sub IVBSAXContentHandler_endPrefixMapping(strPrefix As String)
    
End Sub

Private Sub IVBSAXContentHandler_ignorableWhitespace(strChars As String)

End Sub

Private Sub IVBSAXContentHandler_processingInstruction(strTarget As String, strData As String)

End Sub

Private Sub IVBSAXContentHandler_skippedEntity(strName As String)

End Sub

Private Sub IVBSAXContentHandler_startDocument()
    Form1.lstResults.AddItem ("Starting ...")
End Sub

Private Sub IVBSAXContentHandler_startElement(strNamespaceURI As String, strLocalName As String, strQName As String, ByVal oAttributes As MSXML2.IVBSAXAttributes)
Dim typeAttr As Long

    On Error Resume Next
    
    If (strQName = "band") Then
        typeAttr = oAttributes.getIndexFromQName("type")
            
        If (Err.Number <> 0) Then
            Form1.lstResults.AddItem ("Error in " + m_oLocator.systemId() + " at line " + Str(m_oLocator.lineNumber()) + ", column " + Str(m_oLocator.columnNumber()))
            Form1.lstResults.AddItem ("Band type not specified")
            m_oReader.abort
        End If
       
        m_strBandType = oAttributes.getValue(typeAttr)
        
    ElseIf (strQName = "name") Then
        m_bIsName = True
        m_bIsSaxophone = False
        m_strBandName = ""
        
    ElseIf (strQName = "saxophone") Then
        m_bIsName = False
        m_bIsSaxophone = True
        m_strSaxophonist = ""
        
    Else
        m_bIsName = False
        m_bIsSaxophone = False
    End If
End Sub

Private Sub IVBSAXContentHandler_startPrefixMapping(strPrefix As String, strURI As String)

End Sub
