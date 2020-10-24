#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <IE.au3>

$f_tryAttach=0
$f_visible=1
$f_wait=1
$oIE = _IECreate ( "http://www.autoitscript.com/", $f_tryAttach, $f_visible, $f_wait )
$oImgs = _IEImgGetCollection ( $oIE )
ConsoleWrite ( "+ There are " & @extended & " images on the page : " & @Crlf )

For $oImg In $oImgs
    $_Url = $oImg.src
    ConsoleWrite ( "- Img Info src= " & $oImg.src & @Crlf )
    InetGet ( $_URL, @DesktopDir & '' & _GetFullNameByUrl ( $_URL ), 1, 0 )
Next
_IEQuit ( $oIE )
Exit

Func _GetFullNameByUrl ( $_FileUrl )
    $_FileName = StringSplit ( $_FileUrl, '/' )
    If Not @error Then Return $_FileName[$_FileName[0]]
EndFunc ;==> _GetFullNameByUrl ( )