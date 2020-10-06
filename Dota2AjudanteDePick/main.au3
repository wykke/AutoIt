#include <String.au3>
#include <Inet.au3>
#include <Array.au3>
#include <GuiComboBox.au3>
#include <GUIConstantsEx.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <GuiScrollBars.au3>

#Region Start Read Ini
Global $heroeslist = IniReadSection("heroes\Heroes.ini","Lista de Herois")
if @error = Not 0 Then _erroatt()
Global $vantage[UBound($heroeslist)-1][2]
Global $nextgui
Global $lastgui
#EndRegion

#Region ### START Koda GUI section ###
$FormMain = GUICreate("WyKKe's Dota 2 Assistance", 745, 437, 186, 166)
$MenuArquivo = GUICtrlCreateMenu("&Arquivo")
$MenuBanco = GUICtrlCreateMenuItem("Atualizar Banco de dados", $MenuArquivo)
$MenuAjuda = GUICtrlCreateMenu("A&juda")
$MenuReport = GUICtrlCreateMenuItem("Reportar Erro", $MenuAjuda)
$MenuAtt = GUICtrlCreateMenuItem("Verificar Atualizaçőes", $MenuAjuda)
$MenuSobre = GUICtrlCreateMenuItem("Sobre", $MenuAjuda)
$Tab1 = GUICtrlCreateTab(8, 8, 729, 401)

;Picks

$TabSheet1 = GUICtrlCreateTabItem("Picks")
GUICtrlSetState(-1,$GUI_SHOW)

$Label1 = GUICtrlCreateLabel("Sou do:", 28, 49, 41, 17)
$Label2 = GUICtrlCreateLabel("Selecione os Heroes:", 28, 89, 105, 17)
$Label3 = GUICtrlCreateLabel("Radiant", 28, 121, 41, 17)
$Label4 = GUICtrlCreateLabel("Dire", 204, 121, 23, 17)

$RadioTime1 = GUICtrlCreateRadio("Radiant", 76, 49, 57, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$RadioTime2 = GUICtrlCreateRadio("Dire", 140, 49, 113, 17)

$ComboHeroes1 = GUICtrlCreateCombo("", 28, 145, 145, 25, BitOR($CBS_DROPDOWN,$WS_VSCROLL))
$ComboHeroes2 = GUICtrlCreateCombo("", 28, 177, 145, 25, BitOR($CBS_DROPDOWN,$WS_VSCROLL))
$ComboHeroes3 = GUICtrlCreateCombo("", 28, 209, 145, 25, BitOR($CBS_DROPDOWN,$WS_VSCROLL))
$ComboHeroes4 = GUICtrlCreateCombo("", 28, 241, 145, 25, BitOR($CBS_DROPDOWN,$WS_VSCROLL))
$ComboHeroes5 = GUICtrlCreateCombo("", 28, 273, 145, 25, BitOR($CBS_DROPDOWN,$WS_VSCROLL))
$ComboHeroes6 = GUICtrlCreateCombo("", 204, 145, 145, 25, BitOR($CBS_DROPDOWN,$WS_VSCROLL))
$ComboHeroes7 = GUICtrlCreateCombo("", 204, 177, 145, 25, BitOR($CBS_DROPDOWN,$WS_VSCROLL))
$ComboHeroes8 = GUICtrlCreateCombo("", 204, 209, 145, 25, BitOR($CBS_DROPDOWN,$WS_VSCROLL))
$ComboHeroes9 = GUICtrlCreateCombo("", 204, 241, 145, 25, BitOR($CBS_DROPDOWN,$WS_VSCROLL))
$ComboHeroes10 = GUICtrlCreateCombo("", 204, 273, 145, 25, BitOR($CBS_DROPDOWN,$WS_VSCROLL))

$Pic1 = GUICtrlCreatePic("", 384, 144, 80, 45)
$Pic2 = GUICtrlCreatePic("", 384, 192, 80, 45)
$Pic3 = GUICtrlCreatePic("", 384, 240, 80, 45)
$Pic4 = GUICtrlCreatePic("", 384, 288, 80, 45)
$Pic5 = GUICtrlCreatePic("", 384, 336, 80, 45)
$Pic6 = GUICtrlCreatePic("", 524, 144, 80, 45)
$Pic7 = GUICtrlCreatePic("", 524, 192, 80, 45)
$Pic8 = GUICtrlCreatePic("", 524, 240, 80, 45)
$Pic9 = GUICtrlCreatePic("", 524, 288, 80, 45)
$Pic10 = GUICtrlCreatePic("", 524, 336, 80, 45)

$Label5 = GUICtrlCreateLabel("Radiant (Win Rate %)", 384, 104, 200, 17)
$Label6 = GUICtrlCreateLabel("Dire (Win Rate %)", 524, 104, 200, 17)
$Labelw1 = GUICtrlCreateLabel("", 474, 160, 36, 17)
$Labelw2 = GUICtrlCreateLabel("", 474, 208, 36, 17)
$Labelw3 = GUICtrlCreateLabel("", 474, 256, 36, 17)
$Labelw4 = GUICtrlCreateLabel("", 474, 304, 36, 17)
$Labelw5 = GUICtrlCreateLabel("", 474, 352, 36, 17)
$Labelw6 = GUICtrlCreateLabel("", 614, 160, 36, 17)
$Labelw7 = GUICtrlCreateLabel("", 614, 208, 36, 17)
$Labelw8 = GUICtrlCreateLabel("", 614, 256, 36, 17)
$Labelw9 = GUICtrlCreateLabel("", 614, 304, 36, 17)
$Labelw10 = GUICtrlCreateLabel("", 614, 352, 36, 17)

$BotaoReset = GUICtrlCreateButton("Reset", 28, 336, 75, 25)

;sugestőes de picks

$TabSheet2 = GUICtrlCreateTabItem("Sugestőes de Picks")

$Labelcarry = GUICtrlCreateLabel("Carry (Vantagem %)", 28, 49, 200, 17)
Global $picc[5]
Global $Labelc[5]
$Picc[0] = GUICtrlCreatePic("", 28, 80, 80, 45)
$Picc[1] = GUICtrlCreatePic("", 28, 128, 80, 45)
$Picc[2] = GUICtrlCreatePic("", 28, 176, 80, 45)
$Picc[3] = GUICtrlCreatePic("", 28, 224, 80, 45)
$Picc[4] = GUICtrlCreatePic("", 28, 272, 80, 45)
$Labelc[0] = GUICtrlCreateLabel("2", 118, 96, 36, 17)
$Labelc[1] = GUICtrlCreateLabel("1", 118, 144, 36, 17)
$Labelc[2] = GUICtrlCreateLabel("3", 118, 192, 36, 17)
$Labelc[3] = GUICtrlCreateLabel("4", 118, 240, 36, 17)
$Labelc[4] = GUICtrlCreateLabel("5", 118, 288, 36, 17)

$Labelmid = GUICtrlCreateLabel("Mid (Vantagem %)", 168, 49, 200, 17)
Global $picm[5]
Global $Labelm[5]
$Picm[0] = GUICtrlCreatePic("", 168, 80, 80, 45)
$Picm[1] = GUICtrlCreatePic("", 168, 128, 80, 45)
$Picm[2] = GUICtrlCreatePic("", 168, 176, 80, 45)
$Picm[3] = GUICtrlCreatePic("", 168, 224, 80, 45)
$Picm[4] = GUICtrlCreatePic("", 168, 272, 80, 45)
$Labelm[0] = GUICtrlCreateLabel("1", 258, 96, 36, 17)
$Labelm[1] = GUICtrlCreateLabel("2", 258, 144, 36, 17)
$Labelm[2] = GUICtrlCreateLabel("3", 258, 192, 42, 17)
$Labelm[3] = GUICtrlCreateLabel("4", 258, 240, 42, 17)
$Labelm[4] = GUICtrlCreateLabel("5", 258, 288, 42, 17)

$Labelofflane = GUICtrlCreateLabel("Offlane (Vantagem %)", 308, 49, 200, 17)
Global $pico[5]
Global $Labelo[5]
$Pico[0] = GUICtrlCreatePic("", 308, 80, 80, 45)
$Pico[1] = GUICtrlCreatePic("", 308, 128, 80, 45)
$Pico[2] = GUICtrlCreatePic("", 308, 176, 80, 45)
$Pico[3] = GUICtrlCreatePic("", 308, 224, 80, 45)
$Pico[4] = GUICtrlCreatePic("", 308, 272, 80, 45)
$Labelo[0] = GUICtrlCreateLabel("1", 398, 96, 42, 17)
$Labelo[1] = GUICtrlCreateLabel("2", 398, 144, 42, 17)
$Labelo[2] = GUICtrlCreateLabel("3", 398, 192, 42, 17)
$Labelo[3] = GUICtrlCreateLabel("4", 398, 240, 42, 17)
$Labelo[4] = GUICtrlCreateLabel("5", 398, 288, 42, 17)

$Labelroam = GUICtrlCreateLabel("Sup 4 (Vantagem %)", 448, 49, 200, 17)
Global $picr[5]
Global $Labelr[5]
$Picr[0] = GUICtrlCreatePic("", 448, 80, 80, 45)
$Picr[1] = GUICtrlCreatePic("", 448, 128, 80, 45)
$Picr[2] = GUICtrlCreatePic("", 448, 176, 80, 45)
$Picr[3] = GUICtrlCreatePic("", 448, 224, 80, 45)
$Picr[4] = GUICtrlCreatePic("", 448, 272, 80, 45)
$Labelr[0] = GUICtrlCreateLabel("1", 538, 96, 42, 17)
$Labelr[1] = GUICtrlCreateLabel("2", 538, 144, 42, 17)
$Labelr[2] = GUICtrlCreateLabel("3", 538, 192, 42, 17)
$Labelr[3] = GUICtrlCreateLabel("4", 538, 240, 42, 17)
$Labelr[4] = GUICtrlCreateLabel("5", 538, 288, 42, 17)

$Labelsup = GUICtrlCreateLabel("Sup 5 (Vantagem %)", 588, 49, 200, 17)
Global $pics[5]
Global $Labels[5]
$Pics[0] = GUICtrlCreatePic("", 588, 80, 80, 45)
$Pics[1] = GUICtrlCreatePic("", 588, 128, 80, 45)
$Pics[2] = GUICtrlCreatePic("", 588, 176, 80, 45)
$Pics[3] = GUICtrlCreatePic("", 588, 224, 80, 45)
$Pics[4] = GUICtrlCreatePic("", 588, 272, 80, 45)
$Labels[0] = GUICtrlCreateLabel("1", 678, 96, 42, 17)
$Labels[1] = GUICtrlCreateLabel("2", 678, 144, 42, 17)
$Labels[2] = GUICtrlCreateLabel("3", 678, 192, 42, 17)
$Labels[3] = GUICtrlCreateLabel("4", 678, 240, 42, 17)
$Labels[4] = GUICtrlCreateLabel("5", 678, 288, 42, 17)

GUISetState(@SW_SHOW)

#Region Controles

Func _ControlesString()
	$linenumber = 1
	$Heroes = ""
	While 1
		$linenumber += 1
		$erro = FileExists("heroes\Heroes.ini")
		$lineHeroes = FileReadLine("heroes\Heroes.ini", $linenumber)
		If @error = -1 Then ExitLoop
		$lineHeroes1 = _StringBetween($lineHeroes, '', '=')
		$lineHeroes2 = StringReplace($lineHeroes1[0], "-", " ")
		$lineHeroes2 = _StringProper($lineHeroes2)
		if  $lineHeroes2 = "Anti Mage" Then $lineHeroes2 = "Anti-mage"
		$Heroes = $Heroes & '|' & $lineHeroes2
	Wend
	StringTrimRight($Heroes,1)
	Return $Heroes
EndFunc

GUICtrlSetState($RadioTime1, $GUI_CHECKED)
GUICtrlSetData($ComboHeroes1, _ControlesString())
GUICtrlSetData($ComboHeroes2, _ControlesString())
GUICtrlSetData($ComboHeroes3, _ControlesString())
GUICtrlSetData($ComboHeroes4, _ControlesString())
GUICtrlSetData($ComboHeroes5, _ControlesString())
GUICtrlSetData($ComboHeroes6, _ControlesString())
GUICtrlSetData($ComboHeroes7, _ControlesString())
GUICtrlSetData($ComboHeroes8, _ControlesString())
GUICtrlSetData($ComboHeroes9, _ControlesString())
GUICtrlSetData($ComboHeroes10,_ControlesString())
#EndRegion

#Region ComboHeroes
GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")
Func WM_COMMAND($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg
	Local $hWndFrom, $iIDFrom, $iCode
	$hWndFrom = $lParam
	$iIDFrom = BitAND($wParam, 0xFFFF)
	$iCode = BitShift($wParam, 16)
	Switch $hWndFrom
		Case $ComboHeroes1, GUICtrlGetHandle($ComboHeroes1)
			AComp($ComboHeroes1,$iCode)
		Case $ComboHeroes2, GUICtrlGetHandle($ComboHeroes2)
			AComp($ComboHeroes2,$iCode)
		Case $ComboHeroes3, GUICtrlGetHandle($ComboHeroes3)
			AComp($ComboHeroes3,$iCode)
		Case $ComboHeroes4, GUICtrlGetHandle($ComboHeroes4)
			AComp($ComboHeroes4,$iCode)
		Case $ComboHeroes5, GUICtrlGetHandle($ComboHeroes5)
			AComp($ComboHeroes5,$iCode)
		Case $ComboHeroes6, GUICtrlGetHandle($ComboHeroes6)
			AComp($ComboHeroes6,$iCode)
		Case $ComboHeroes7, GUICtrlGetHandle($ComboHeroes7)
			AComp($ComboHeroes7,$iCode)
		Case $ComboHeroes8, GUICtrlGetHandle($ComboHeroes8)
			AComp($ComboHeroes8,$iCode)
		Case $ComboHeroes9, GUICtrlGetHandle($ComboHeroes9)
			AComp($ComboHeroes9,$iCode)
		Case $ComboHeroes10, GUICtrlGetHandle($ComboHeroes10)
			AComp($ComboHeroes10,$iCode)
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc

Func AComp($Combo,$iCode)
	if $iCode = $CBN_SETFOCUS Then $nextgui = ""
	if $iCode = $CBN_EDITCHANGE Then
		$lastgui = $nextgui
		_GUICtrlComboBox_AutoComplete($Combo)
		$nextgui = GUICtrlRead($Combo)
		$herocombo = StringLower(StringReplace(GUICtrlRead($Combo), " ", "-"))
		if not($lastgui = $nextgui) Then
			if Not(_ArraySearch($heroeslist,$herocombo) = -1) Then
			_Atualizar ("")
			Else
			_Atualizar ($combo)
			EndIf
		EndIf
	EndIf
EndFunc
#EndRegion
#EndRegion ### END Koda GUI section ###

Func _Resetar()
	GUICtrlSetData($ComboHeroes1,"")
	GUICtrlSetData($ComboHeroes2,"")
	GUICtrlSetData($ComboHeroes3,"")
	GUICtrlSetData($ComboHeroes4,"")
	GUICtrlSetData($ComboHeroes5,"")
	GUICtrlSetData($ComboHeroes6,"")
	GUICtrlSetData($ComboHeroes7,"")
	GUICtrlSetData($ComboHeroes8,"")
	GUICtrlSetData($ComboHeroes9,"")
	GUICtrlSetData($ComboHeroes10,"")
	GUICtrlSetData($ComboHeroes1, _ControlesString())
	GUICtrlSetData($ComboHeroes2, _ControlesString())
	GUICtrlSetData($ComboHeroes3, _ControlesString())
	GUICtrlSetData($ComboHeroes4, _ControlesString())
	GUICtrlSetData($ComboHeroes5, _ControlesString())
	GUICtrlSetData($ComboHeroes6, _ControlesString())
	GUICtrlSetData($ComboHeroes7, _ControlesString())
	GUICtrlSetData($ComboHeroes8, _ControlesString())
	GUICtrlSetData($ComboHeroes9, _ControlesString())
	GUICtrlSetData($ComboHeroes10,_ControlesString())

	GUICtrlDelete($Pic1)
	GUICtrlDelete($Pic2)
	GUICtrlDelete($Pic3)
	GUICtrlDelete($Pic4)
	GUICtrlDelete($Pic5)
	GUICtrlDelete($Pic6)
	GUICtrlDelete($Pic7)
	GUICtrlDelete($Pic8)
	GUICtrlDelete($Pic9)
	GUICtrlDelete($Pic10)
	Global $Pic1 = GUICtrlCreatePic("", 384, 144, 80, 45)
	Global $Pic2 = GUICtrlCreatePic("", 384, 192, 80, 45)
	Global $Pic3 = GUICtrlCreatePic("", 384, 240, 80, 45)
	Global $Pic4 = GUICtrlCreatePic("", 384, 288, 80, 45)
	Global $Pic5 = GUICtrlCreatePic("", 384, 336, 80, 45)
	Global $Pic6 = GUICtrlCreatePic("", 524, 144, 80, 45)
	Global $Pic7 = GUICtrlCreatePic("", 524, 192, 80, 45)
	Global $Pic8 = GUICtrlCreatePic("", 524, 240, 80, 45)
	Global $Pic9 = GUICtrlCreatePic("", 524, 288, 80, 45)
	Global $Pic10 = GUICtrlCreatePic("", 524, 336, 80, 45)
	_Atualizar("")
EndFunc

Func _Atualizar($combo)
	if not($combo == $ComboHeroes1) then
	$hero1 = StringLower(StringReplace(GUICtrlRead($ComboHeroes1), " ", "-"))
	Else
	$hero1 = ""
	EndIf
	if not($combo == $ComboHeroes2) then
	$hero2 = StringLower(StringReplace(GUICtrlRead($ComboHeroes2), " ", "-"))
	Else
	$hero2 = ""
	EndIf
	if not($combo == $ComboHeroes3) then
	$hero3 = StringLower(StringReplace(GUICtrlRead($ComboHeroes3), " ", "-"))
	Else
	$hero3 = ""
	EndIf
	if not($combo == $ComboHeroes4) then
	$hero4 = StringLower(StringReplace(GUICtrlRead($ComboHeroes4), " ", "-"))
	Else
	$hero4 = ""
	EndIf
	if not($combo == $ComboHeroes5) then
	$hero5 = StringLower(StringReplace(GUICtrlRead($ComboHeroes5), " ", "-"))
	Else
	$hero5 = ""
	EndIf
	if not($combo == $ComboHeroes6) then
	$hero6 = StringLower(StringReplace(GUICtrlRead($ComboHeroes6), " ", "-"))
	Else
	$hero6 = ""
	EndIf
	if not($combo == $ComboHeroes7) then
	$hero7 = StringLower(StringReplace(GUICtrlRead($ComboHeroes7), " ", "-"))
	Else
	$hero7 = ""
	EndIf
	if not($combo == $ComboHeroes8) then
	$hero8 = StringLower(StringReplace(GUICtrlRead($ComboHeroes8), " ", "-"))
	Else
	$hero8 = ""
	EndIf
	if not($combo == $ComboHeroes9) then
	$hero9 = StringLower(StringReplace(GUICtrlRead($ComboHeroes9), " ", "-"))
	Else
	$hero9 = ""
	EndIf
	if not($combo == $ComboHeroes10) then
	$hero10 = StringLower(StringReplace(GUICtrlRead($ComboHeroes10), " ", "-"))
	Else
	$hero10 = ""
	EndIf

	GUICtrlSetData($Labelw1,$heroeslist[_ArraySearch($heroeslist,$hero1)][1])
	GUICtrlSetData($Labelw2,$heroeslist[_ArraySearch($heroeslist,$hero2)][1])
	GUICtrlSetData($Labelw3,$heroeslist[_ArraySearch($heroeslist,$hero3)][1])
	GUICtrlSetData($Labelw4,$heroeslist[_ArraySearch($heroeslist,$hero4)][1])
	GUICtrlSetData($Labelw5,$heroeslist[_ArraySearch($heroeslist,$hero5)][1])
	GUICtrlSetData($Labelw6,$heroeslist[_ArraySearch($heroeslist,$hero6)][1])
	GUICtrlSetData($Labelw7,$heroeslist[_ArraySearch($heroeslist,$hero7)][1])
	GUICtrlSetData($Labelw8,$heroeslist[_ArraySearch($heroeslist,$hero8)][1])
	GUICtrlSetData($Labelw9,$heroeslist[_ArraySearch($heroeslist,$hero9)][1])
	GUICtrlSetData($Labelw10,$heroeslist[_ArraySearch($heroeslist,$hero10)][1])

	GUICtrlSetImage($Pic1,"pics\"&$hero1&".jpg")
	GUICtrlSetImage($Pic2,"pics\"&$hero2&".jpg")
	GUICtrlSetImage($Pic3,"pics\"&$hero3&".jpg")
	GUICtrlSetImage($Pic4,"pics\"&$hero4&".jpg")
	GUICtrlSetImage($Pic5,"pics\"&$hero5&".jpg")
	GUICtrlSetImage($Pic6,"pics\"&$hero6&".jpg")
	GUICtrlSetImage($Pic7,"pics\"&$hero7&".jpg")
	GUICtrlSetImage($Pic8,"pics\"&$hero8&".jpg")
	GUICtrlSetImage($Pic9,"pics\"&$hero9&".jpg")
	GUICtrlSetImage($Pic10,"pics\"&$hero10&".jpg")

	if GUICtrlRead($RadioTime1) = $GUI_CHECKED Then
		;radiant
		$herow6 = IniReadSection("heroes\"&$hero6&".ini","Confrontos")
		$herow7 = IniReadSection("heroes\"&$hero7&".ini","Confrontos")
		$herow8 = IniReadSection("heroes\"&$hero8&".ini","Confrontos")
		$herow9 = IniReadSection("heroes\"&$hero9&".ini","Confrontos")
		$herow10 = IniReadSection("heroes\"&$hero10&".ini","Confrontos")

		$vantage = $heroeslist
		For $ab = 0 To (UBound($heroeslist)-1)
			$vantage[$ab][1] = 0
		Next

		if UBound($herow6) > 0 Then
			For $ab = 1 To (UBound($herow6)-1)
				$vantage[_ArraySearch($vantage,$herow6[$ab][0])][1] += $herow6[$ab][1]
			Next
		EndIf
		if UBound($herow7) > 0 Then
			For $ab = 1 To (UBound($herow7)-1)
				$vantage[_ArraySearch($vantage,$herow7[$ab][0])][1] += $herow7[$ab][1]
			Next
		EndIf
		if UBound($herow8) > 0 Then
			For $ab = 1 To (UBound($herow8)-1)
				$vantage[_ArraySearch($vantage,$herow8[$ab][0])][1] += $herow8[$ab][1]
			Next
		EndIf
		if UBound($herow9) > 0 Then
			For $ab = 1 To (UBound($herow9)-1)
				$vantage[_ArraySearch($vantage,$herow9[$ab][0])][1] += $herow9[$ab][1]
			Next
		EndIf
		if UBound($herow10) > 0 Then
			For $ab = 1 To (UBound($herow10)-1)
				$vantage[_ArraySearch($vantage,$herow10[$ab][0])][1] += $herow10[$ab][1]
			Next
		EndIf
		_ArraySort($vantage,0,0,0,1)
		_AtualizarPag2($vantage)
	Else
		;dire
		$herow1 = IniReadSection("heroes\"&$hero1&".ini","Confrontos")
		$herow2 = IniReadSection("heroes\"&$hero2&".ini","Confrontos")
		$herow3 = IniReadSection("heroes\"&$hero3&".ini","Confrontos")
		$herow4 = IniReadSection("heroes\"&$hero4&".ini","Confrontos")
		$herow5 = IniReadSection("heroes\"&$hero5&".ini","Confrontos")

		$vantage = $heroeslist
		For $ab = 0 To (UBound($heroeslist)-1)
			$vantage[$ab][1] = 0
		Next

		if UBound($herow1) > 0 Then
			For $ab = 1 To (UBound($herow1)-1)
				$vantage[_ArraySearch($vantage,$herow1[$ab][0])][1] += $herow1[$ab][1]
			Next
		EndIf
		if UBound($herow2) > 0 Then
			For $ab = 1 To (UBound($herow2)-1)
				$vantage[_ArraySearch($vantage,$herow2[$ab][0])][1] += $herow2[$ab][1]
			Next
		EndIf
		if UBound($herow3) > 0 Then
			For $ab = 1 To (UBound($herow3)-1)
				$vantage[_ArraySearch($vantage,$herow3[$ab][0])][1] += $herow3[$ab][1]
			Next
		EndIf
		if UBound($herow4) > 0 Then
			For $ab = 1 To (UBound($herow4)-1)
				$vantage[_ArraySearch($vantage,$herow4[$ab][0])][1] += $herow4[$ab][1]
			Next
		EndIf
		if UBound($herow5) > 0 Then
			For $ab = 1 To (UBound($herow5)-1)
				$vantage[_ArraySearch($vantage,$herow5[$ab][0])][1] += $herow5[$ab][1]
			Next
		EndIf
		_ArraySort($vantage,0,0,0,1)
		_AtualizarPag2($vantage)
	EndIf
EndFunc

Func _AtualizarPag2($ver)

	$ab = 0
	$offlane = 0
	$carry = 0
	$mid = 0
	$suport4 = 0
	$suport5 = 0

	While 1
		$ab+=1
		if $offlane < 5 And Not(IniRead("heroes\Lanes.ini","Off Lane",$ver[$ab][0],0)=0) Then
			GUICtrlSetImage($Pico[$offlane],"pics\"&$ver[$ab][0]&".jpg")
			GUICtrlSetData($labelo[$offlane],$ver[$ab][1]*(-1))
			$offlane += 1
		EndIf
		if $carry < 5 And Not(IniRead("heroes\Lanes.ini","Carry",$ver[$ab][0],0)=0) Then
			GUICtrlSetImage($Picc[$carry],"pics\"&$ver[$ab][0]&".jpg")
			GUICtrlSetData($labelc[$carry],$ver[$ab][1]*(-1))
			$carry += 1
		EndIf
		if $mid < 5 And Not(IniRead("heroes\Lanes.ini","Mid Lane",$ver[$ab][0],0)=0) Then
			GUICtrlSetImage($Picm[$mid],"pics\"&$ver[$ab][0]&".jpg")
			GUICtrlSetData($labelm[$mid],$ver[$ab][1]*(-1))
			$mid += 1
		EndIf
		if $suport4 < 5 And (Not(IniRead("heroes\Lanes.ini","Jungle",$ver[$ab][0],0)=0) Or Not(IniRead("heroes\Lanes.ini","Roaming",$ver[$ab][0],0)=0) Or Not(IniRead("heroes\Lanes.ini","Suporte",$ver[$ab][0],0)=0)) Then
			GUICtrlSetImage($Picr[$suport4],"pics\"&$ver[$ab][0]&".jpg")
			GUICtrlSetData($labelr[$suport4],$ver[$ab][1]*(-1))
			$suport4 += 1
		EndIf
		if $suport5 < 5 And Not(IniRead("heroes\Lanes.ini","Suporte",$ver[$ab][0],0)=0) Then
			GUICtrlSetImage($Pics[$suport5],"pics\"&$ver[$ab][0]&".jpg")
			GUICtrlSetData($labels[$suport5],$ver[$ab][1]*(-1))
			$suport5 += 1
		EndIf
		If $offlane=5 and $carry=5 and $mid=5 and $suport4=5 and $suport5=5 Then ExitLoop
	WEnd
EndFunc


While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $ComboHeroes1
			_Atualizar("")
		Case $ComboHeroes2
			_Atualizar("")
		Case $ComboHeroes3
			_Atualizar("")
		Case $ComboHeroes4
			_Atualizar("")
		Case $ComboHeroes5
			_Atualizar("")
		Case $ComboHeroes6
			_Atualizar("")
		Case $ComboHeroes7
			_Atualizar("")
		Case $ComboHeroes8
			_Atualizar("")
		Case $ComboHeroes9
			_Atualizar("")
		Case $ComboHeroes10
			_Atualizar("")

		Case $MenuBanco
			$confir = MsgBox(4,"Vocę tem certeza?","Vocę tem certeza que quer atualizar o banco de dado? Isso pode demorar alguns minutos!")
			if $confir = 6 Then ShellExecute("CriadorDoBD.exe")
			if @error = not 0 Then
				MsgBox(0,"Erro","Năo foi encontrado o arquivo de atualizaçăo no seu computador, reinstale o programa e tente novamente")
			Else
				Exit
			EndIf
		Case $MenuReport
		Case $MenuAtt
		Case $MenuSobre
		Case $BotaoReset
			_Resetar()
	EndSwitch
WEnd

Func _erroatt()
	$confir = MsgBox(4,"Atualizar banco de dados?","Parece que năo foi encontrado alguma informaçăo em seu computador. Gostaria de atualizar o banco de dados para solucionar esse problema? Isso pode demorar alguns minutos! Se escolher năo, o programa năo funcionará direito")
			if $confir = 6 Then ShellExecute("CriadorDoBD.exe")
			if @error = not 0 Then
				MsgBox(0,"Erro","Năo foi encontrado o arquivo de atualizaçăo no seu computador, reinstale o programa e tente novamente")
			Else
				Exit
			EndIf
EndFunc
