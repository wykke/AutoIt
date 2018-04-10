#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <String.au3>
#include <Inet.au3>
#include <Array.au3>


#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("Login", 202, 140, 192, 124)
$lusuario = GUICtrlCreateLabel("Usuario", 16, 16, 40, 17)
$lsenha = GUICtrlCreateLabel("Senha", 16, 48, 35, 17)
Global $busuario = GUICtrlCreateInput("", 64, 16, 121, 21)
Global $bsenha = GUICtrlCreateInput("", 64, 48, 121, 21)
Global $blogin = GUICtrlCreateButton("Login", 40, 88, 75, 25, $BS_DEFPUSHBUTTON)
Global $lLogando = GUICtrlCreateLabel("", 130, 94, 54, 17)
Global $Site = 'https://anotepad.com/notes/gyrrnn'
Global $usuario, $vusuario
Global $idusuario
Global $encontrou = False
Global $senha, $vsenha
Global $data

GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $blogin
			logar()
	EndSwitch
WEnd

Func logar()
	GUICtrlSetData($lLogando,'Logando...')
	$usuario = GUICtrlRead($busuario)
	$senha = GUICtrlRead($bsenha)
	$data = _INetGetSource($Site,True)
	$vusuario = _StringBetween($data, '&lt;usuario&gt;', '&lt;senha&gt;',1)
	$vsenha = _StringBetween($data, '&lt;senha&gt;', '&lt;usuario&gt;',1)
	GUICtrlSetData($lLogando,'')
	For $ab = 0 To (UBound($vusuario)-1)
		If($usuario = $vusuario[$ab]) Then
			$encontrou = True
			$idusuario = $ab
		EndIf
	Next

	if($encontrou = true) Then
		if($senha = $vsenha[$idusuario]) Then
			MsgBox(0,'Login','Logado com sucesso')
			pag2()
		Else
			MsgBox(0,'Login','Senha Incorreta')
		EndIf
	ElseIf ($data = '') Then
		MsgBox(0,'Login','Não foi possivel conectar')
		Else
		MsgBox(0,'Login','Usuario não existe')
	EndIf
	$encontrou = False
EndFunc

Func pag2()
#Region ### START Koda GUI section ### Form=
$Form2 = GUICreate("Form1", 500, 500, 192, 124)
$Label2 = GUICtrlCreateLabel("Label1", 32, 48, 36, 17)
GUIDelete($Form1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd
EndFunc
