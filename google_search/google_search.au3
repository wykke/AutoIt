#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include <IE.au3>

Local $oIE = _IECreate("http://www.google.de/#q=shrek")

Local $sMyString = "ARK | Intel®"
Local $oLinks = _IELinkGetCollection($oIE)
For $oLink In $oLinks
    Local $sLinkText = _IEPropertyGet($oLink, "innerText")
    If StringInStr($sLinkText, $sMyString) Then
        _IEAction($oLink, "click")
        ExitLoop
    EndIf
Next