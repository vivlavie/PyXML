VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Validating Band Analyzer"
   ClientHeight    =   6990
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9990
   LinkTopic       =   "Form1"
   ScaleHeight     =   6990
   ScaleWidth      =   9990
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdParse 
      Caption         =   "Parse"
      Enabled         =   0   'False
      Height          =   495
      Left            =   120
      TabIndex        =   4
      Top             =   2880
      Width           =   9735
   End
   Begin VB.DirListBox Dir1 
      Height          =   2115
      Left            =   120
      TabIndex        =   3
      Top             =   600
      Width           =   4815
   End
   Begin VB.DriveListBox Drive1 
      Height          =   315
      Left            =   120
      TabIndex        =   2
      Top             =   240
      Width           =   4815
   End
   Begin VB.FileListBox File1 
      Height          =   2430
      Left            =   5040
      TabIndex        =   1
      Top             =   240
      Width           =   4815
   End
   Begin VB.ListBox lstResults 
      Height          =   2985
      Left            =   120
      TabIndex        =   0
      Top             =   3480
      Width           =   9735
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdParse_Click()
    Dim strPath As String
    Dim oContentHandler As ContentHandlerImpl
    Dim oErrorHandler As ErrorHandlerImpl
    Dim oReader As SAXXMLReader
   
On Error Resume Next
    
    strPath = File1.Path + "\" + File1.FileName
    
    Set oReader = New SAXXMLReader
    Set oContentHandler = New ContentHandlerImpl
    Set oErrorHandler = New ErrorHandlerImpl
    
    Set oReader.contentHandler = oContentHandler
    Set oReader.errorHandler = oErrorHandler
    
    Set oContentHandler.m_oReader = oReader
    
    oReader.parseURL (strPath)
End Sub

Private Sub Dir1_Change()
    File1.Path = Dir1.Path
End Sub

Private Sub Drive1_Change()
    Dir1.Path = Drive1.Drive
End Sub

Private Sub File1_Click()
    cmdParse.Enabled = True
End Sub

