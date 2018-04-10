#include <String.au3>
#include <Inet.au3>
#include <Array.au3>
#include <GuiComboBox.au3>
#include <GUIConstantsEx.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

;criando a GUI

$FormBanco = GUICreate("Banco de Dados", 300, 91, 192, 124)
$Progress1 = GUICtrlCreateProgress(16, 40, 268, 17)
$LabelAtualizando1 = GUICtrlCreateLabel("Atualizando banco de dados, por favor aguarde:", 16, 16, 280, 17)
$LabelAtualizando2 = GUICtrlCreateLabel("Preparando...", 16, 64, 280, 17)
GUISetState(@SW_SHOW)

Global $nhero
$miniaturabool = MsgBox(3,"Fotos","Deseja baixar as miniaturas dos herois, pode ser util quando lançou um heroi novo ou quando a miniatura de um heroi sofreu update, caso contrario não")
if $miniaturabool = 2 Then Exit

;processo inicial

DirRemove("heroes", 1)
Sleep(100)
$erro = DirCreate ("heroes")
if $erro = 0 Then erropasta()

if $miniaturabool = 6 Then
	Sleep(100)
	DirRemove("pics", 1)
	Sleep(100)
	$erro = DirCreate ("pics")
	if $erro = 0 Then erropasta()
	EndIf

GUICtrlSetData($LabelAtualizando2,'Fazendo download de informações iniciais')
Global $dadocarry = _INetGetSource("https://dota2.gamepedia.com/Category:Carries",True)
if @error = Not 0 Then errodownload()
Global $dadosuporte = _INetGetSource("https://dota2.gamepedia.com/Category:Supports",True)
if @error = Not 0 Then errodownload()
Local $carrys = _StringBetween($dadocarry, '<li><a href="/', '/a></li>')
Local $suportes = _StringBetween($dadosuporte, '<li><a href="/', '/a></li>')
Global $carry[UBound($carrys)-3]
Global $suporte[UBound($suportes)-3]

For $ab = 0 To (UBound($carry)-1)
	$carry1 = _StringBetween($carrys[$ab], '>', '<')
	$carry[$ab] = StringLower(StringReplace($carry1[0], " ", "-"))
Next

For $ab = 0 To (UBound($suporte)-1)
	$suporte1 = _StringBetween($suportes[$ab], '>', '<')
	$suporte[$ab] = StringLower(StringReplace($suporte1[0], " ", "-"))
Next

;baixando lista de herois

$herosite = _INetGetSource("https://www.dotabuff.com/heroes/played",True)
if @error = Not 0 Then errodownload()
$hero1 = _StringBetween($herosite, '/tooltip" src=', '%<div class="bar bar-default"><div class="segment segment-win"')
$nhero = UBound($hero1)

For $ab = 0 To (UBound($hero1)-1)
	$heropic1 = _StringBetween($hero1[$ab], '"', '"')
	$heropic = "https://www.dotabuff.com" & $heropic1[0]

	$hero2 = _StringBetween($hero1[$ab], '">', '/a></td>')
	$hero3 = _StringBetween($hero2[0], '>', '<')
	$winrate = StringRight($hero1[$ab], 5)

	$hero = StringLower(StringReplace(StringReplace($hero3[0], " ", "-"),"&#39;",""))
	$erro = FileExists("heroes")
	if $erro = 0 Then errodir()
	IniWrite("heroes\Heroes.ini","Lista de Herois",$hero,$winrate)

;baixando miniaturas

	if $miniaturabool = 6 Then
	GUICtrlSetData($LabelAtualizando2,'Fazendo download de miniatura: ' & _StringProper(StringReplace($hero, "-", " ")))
	$erro = FileExists("pics")
	if $erro = 0 Then errodir()
	$downloadpic = InetGet($heropic, "pics\"&$hero&".jpg", $INET_FORCERELOAD, $INET_DOWNLOADBACKGROUND)
	if $downloadpic = 0 Then errodownload()

	Do
		Sleep(100)
	Until InetGetInfo($downloadpic, $INET_DOWNLOADCOMPLETE)
	InetClose($downloadpic)
	GUICtrlSetData($Progress1,(($ab+1)/$nhero)*7.72)
	EndIf

Next

;baixando os dados

$linenumber = 1
While 1
	$linenumber += 1
	$erro = FileExists("heroes")
	if $erro = 0 Then errodir()
	$line = FileReadLine("heroes\Heroes.ini", $linenumber)
	If @error = -1 Then ExitLoop
	$linehero = _StringBetween($line, '', '=')
	SearchSite($linehero[0])
	GUICtrlSetData($Progress1,7.72+(($linenumber-1)/$nhero)*92.28)
	Wend

GUICtrlSetData($Progress1,100)

;fim do programa

Exit

Func SearchSite($hero)
	GUICtrlSetData($LabelAtualizando2,'Fazendo download de dados: ' & _StringProper(StringReplace($hero, "-", " ")))

;Lanes

	$dadosite = _INetGetSource("https://www.dotabuff.com/heroes/"&$hero,True)
	if @error = Not 0 Then errodownload()
	$dadostring1 = _StringBetween($dadosite, 'XPM</th>', 'Trending Guide<small>')
	$dadostring = _StringBetween($dadostring1[0], '<tr><td>', '</td>')
	$dadoint1 = _StringBetween($dadostring1[0], '</td><td data-value="', '<div')
	Local $num = 0
	Local $sum = 0
	Local $dadoint[UBound($dadostring)]

	For $ab = 0 To (UBound($dadoint1)-1) Step 2
	$dadoint2 = _StringBetween($dadoint1[$ab], '>', '%')
		$dadoint[$num] = $dadoint2[0]
		$num += 1
	Next

	if $dadostring[0] = "Safe Lane" Then
		for $ab = 0 To (UBound($carry)-1)
			if $hero = $carry[$ab] Then
				$erro = FileExists("heroes")
				if $erro = 0 Then errodir()
				IniWrite("heroes\Lanes.ini","Carry",$hero,$dadoint[0])
				EndIf
		Next

		for $ab = 0 To (UBound($suporte)-1)
			if $hero = $suporte[$ab] Then
				$erro = FileExists("heroes")
				if $erro = 0 Then errodir()
				IniWrite("heroes\Lanes.ini","Suporte",$hero,$dadoint[0])
				EndIf
		Next
		Else
	$erro = FileExists("heroes")
	if $erro = 0 Then errodir()
	IniWrite("heroes\Lanes.ini",$dadostring[0],$hero,$dadoint[0])
	EndIf

	$num = 0

	For $ab = 1 To (UBound($dadoint)-1)
		if $dadoint[$ab] > 30 Then
				if $dadostring[$ab] = "Safe Lane" Then

					for $ab = 0 To (UBound($carry)-1)
						if $hero = $carry[$ab] Then
							$erro = FileExists("heroes")
							if $erro = 0 Then errodir()
							IniWrite("heroes\Lanes.ini","Carry",$hero,$dadoint[0])
							EndIf
					Next

					for $ab = 0 To (UBound($suporte)-1)
						if $hero = $suporte[$ab] Then
							$erro = FileExists("heroes")
							if $erro = 0 Then errodir()
							IniWrite("heroes\Lanes.ini","Suporte",$hero,$dadoint[0])
							EndIf
					Next

				Else
				$erro = FileExists("heroes")
				if $erro = 0 Then errodir()
				IniWrite("heroes\Lanes.ini",$dadostring[$ab],$hero,$dadoint[$ab])
				EndIf
			$num += 1
		Else
			ExitLoop
		EndIf
	Next

	For $ab = $num+1 To (UBound($dadoint)-1)
		$sum+=$dadoint[$ab]
	Next

	$erro = FileExists("heroes")
	if $erro = 0 Then errodir()
	$sum += IniRead ("heroes\Lanes.ini", "Roaming", $hero, 0)

	if $sum > 50 Then
		$erro = FileExists("heroes")
		if $erro = 0 Then errodir()
		IniWrite("heroes\Lanes.ini","Roaming",$hero,$sum)
		EndIf

;confrontos

	$dadosite = _INetGetSource("https://www.dotabuff.com/heroes/"&$hero&"/matchups",True)
	if @error = Not 0 Then errodownload()
	$dadostring = _StringBetween($dadosite, '<a class="link-type-hero" href="/heroes/', '/a></td><td data-value="')
	$dadoint = _StringBetween($dadosite, '</a></td><td data-value="', '<div class="bar bar-default">')

	For $ab = 0 To (UBound($dadostring)-1)
		$dadost = _StringBetween($dadostring[$ab], '>', '<')
		$dadoi = _StringBetween($dadoint[$ab], '>', '%')
		$erro = FileExists("heroes")
		if $erro = 0 Then errodir()
		IniWrite("heroes\"&$hero&".ini","Confrontos",$dadost[0],$dadoi[0])
	Next

EndFunc

Func errodownload()
	MsgBox(0,"Erro","Erro ao fazer download das informações, verifique sua conexão e se os sites dotabuff e dota da gamepedia estão online e tente novamente.")
	Exit
EndFunc

Func errodir()
	MsgBox(0,"Erro","Não foi encontrada a pasta de destino, foste ela removida enquanto o programa rodava? Tente novamente.")
	Exit
EndFunc

Func erropasta()
	$opc = MsgBox(4,"Erro","Não foi possível criar a pasta no local de destino, verifique o local de instalação e tente novamente.")
	Exit
	EndFunc