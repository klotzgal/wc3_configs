;;;HOW TO SETUP;;; First download and install Autohotkey
;;;;;Then Create New Autohotkey Script and copy this into the new .AHK file
;;;;;OR simply download this file, rename and erase .ahk.TXT to just .AHK
;;;;;Place in your WC3 folder and create shortcut on desktop
;;;;;Usually requires right-click and setting to Run as Admin
;;;;;German Keyboards can Switch NumPad 8 from Y to Z at the bottom
;;;;;In WC3 press NumLock to pause Script on/off for chat
;;;;;Now your Invetory hotkeys are switched to TYGHBN
;;;;;Also disables WinKey or Alt+QQ from closing your game
;;;;;If mouse supports extra buttons can be remapped at bottom


#SingleInstance force		;force a single instance
#HotkeyInterval 0		;disable the warning dialog if a key is held down
#InstallKeybdHook		;Forces the unconditional installation of the keyboard hook
#UseHook On			;might increase responsiveness of hotkeys
#MaxThreads 20			;use 20 (the max) instead of 10 threads
SetBatchLines, -1		;makes the script run at max speed
SetKeyDelay , -1, -1		;faster response (might be better with -1, 0)
;Thread, Interrupt , -1, -1	;not sure what this does, could be bad for timers
SetTitleMatchMode Regex
SetDefaultMouseSpeed, 0 ;Move the mouse faster for mouse moving commands

IfExist, Frozen Throne.exe
  menu, tray, Icon, Frozen Throne.exe, 1, 1

;;;;; Variables ;;;;;
bInChatRoom := False
bHealthBarOn := False
Return ; End Auto-Execute Section

; AutoCast Function
AutoCast(iSpellQWERHotkey)
{
  MouseGetPos, iMousePosX, IMousePosY
  if (iSpellQWERHotkey == 1)
  {
    iMouseGotoX := A_ScreenWidth*4//5
    iMouseGotoY := A_ScreenHeight*4//5
  }
  else if (iSpellQWERHotkey == 2)
  {
    iMouseGotoX := A_ScreenWidth*4//5
    iMouseGotoY := A_ScreenHeight*22//25
  }
  else if (iSpellQWERHotkey == 3)
  {    iMouseGotoX := A_ScreenWidth*4//5
    iMouseGotoY := A_ScreenHeight*19//20
  }
  else if (iSpellQWERHotkey == 4)
  {
    iMouseGotoX := A_ScreenWidth*17//20
    iMouseGotoY := A_ScreenHeight*4//5
  }
  else if (iSpellQWERHotkey == 5)
  {
    iMouseGotoX := A_ScreenWidth*17//20
    iMouseGotoY := A_ScreenHeight*22//25
  }
  else if (iSpellQWERHotkey == 6)
  {
    iMouseGotoX := A_ScreenWidth*17//20
    iMouseGotoY := A_ScreenHeight*19//20
  }
  else if (iSpellQWERHotkey == 7)
  {
    iMouseGotoX := A_ScreenWidth*9//10
    iMouseGotoY := A_ScreenHeight*4//5
  }
  else if (iSpellQWERHotkey == 8)
  {
    iMouseGotoX := A_ScreenWidth*9//10
    iMouseGotoY := A_ScreenHeight*22//25
  }
  else if (iSpellQWERHotkey == 9)
  {
    iMouseGotoX := A_ScreenWidth*9//10
    iMouseGotoY := A_ScreenHeight*19//20
  }
  else if (iSpellQWERHotkey == 10)
  {
    iMouseGotoX := A_ScreenWidth*19//20
    iMouseGotoY := A_ScreenHeight*4//5
  }
  else if (iSpellQWERHotkey == 11)
  {
    iMouseGotoX := A_ScreenWidth*19//20
    iMouseGotoY := A_ScreenHeight*22//25
  }
  else if (iSpellQWERHotkey == 12)
  {
    iMouseGotoX := A_ScreenWidth*19//20
    iMouseGotoY := A_ScreenHeight*19//20
  }
  Click, Right, %iMouseGotoX%, %iMouseGotoY%
  MouseMove, %iMousePosX%, %iMousePosY%
}

; QuickCast
QuickCast(key)
{
  SendInput, {%key%}
  Sleep, 10
  Click, Left
  Sleep, 10
  SendInput, {F1}
}

QuickCastS(key)
{
  SendInput, {%key%}
  Sleep, 10
  Click, Left
  Sleep, 10
  SendInput, {F1}
}

SelfCastDoubleTap(key)
{
  SendEvent, {LAlt up}
  Sleep, 10
  SendEvent, {%key% down}
  SendEvent, {%key% up}
  Sleep, 25
  SendEvent, {%key% down}
  SendEvent, {%key% up}
  Sleep, 10
  SendEvent, {LAlt down}
}

QuickCastAttack()
{
    SendEvent, {a}
    Sleep, 10
    Click, Left
}

#ifWinActive ahk_class Warcraft III

;;;;; Enable/disable all hotkeys ;;;;;
~*Enter::
~*NumpadEnter::
Suspend, Permit
if (bInChatRoom == True)
  return
Suspend
if (A_IsSuspended == true)
{
  SetNumLockState, Off
}
else
{
  SetNumLockState, On
  SoundPlay,*48
}
return

;; Escape will cancel chatting, so turn the hotkeys back on
~*Esc::
Suspend, Permit
if (bInChatRoom == True)
  return
Suspend, Off
SetNumLockState, On
return

*NumLock::
Suspend, Permit
bInChatRoom := not bInChatRoom
if (bInChatRoom == True)
{
  Suspend, On
  SetNumLockState, Off
  SoundPlay,*64
}
else
{
  Suspend, Off
  SetNumLockState, On
  SoundPlay,*48
}
return


; Hotkeys Remapper:

; Disable Windows Key
Lwin::return

; Alt + items = self-cast via Warcraft III double-tap behavior.
<!z::SelfCastDoubleTap("Numpad7")
<!Space::SelfCastDoubleTap("Numpad8")
<!x::SelfCastDoubleTap("Numpad4")
<!v::SelfCastDoubleTap("Numpad5")
<!c::SelfCastDoubleTap("Numpad1")
<!b::SelfCastDoubleTap("Numpad2")

; Mini-Map Toggle is kept unchanged.
<!g::<!g
<!t::return
<!a::return

; Inventory Keys:
z::QuickCastS("Numpad7")
Space::QuickCastS("Numpad8")
x::QuickCastS("Numpad4")
v::QuickCastS("Numpad5")
c::QuickCastS("Numpad1")
b::QuickCastS("Numpad2")

; Select hero
1::SendInput, {1}
+1::SendInput, +{1}

;
a::QuickCastAttack()

; QuickCast spells
$q::QuickCast("q")
$w::QuickCast("w")
$e::QuickCast("e")
$r::QuickCast("r")
$d::QuickCast("d")
$f::QuickCast("f")

; User Specified Hotkeys:
Xbutton2::Numpad7
;;Mbutton::Tab
; these^ are middle mouse and extra mouse buttons

; Wheel item quick-casts
WheelUp::QuickCastS("Numpad2")
WheelDown::QuickCastS("Numpad5")

;;LCtrl::Space
;;Space::LCtrl
;To swap the Ctrl key with the Spacebar just remove the ;; from the 2 lines above