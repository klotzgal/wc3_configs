; Warcraft III / DotA hotkeys for AutoHotkey v1.
; Inventory: Z, Space, X, V, C, B and the mouse wheel.
; NumLock pauses the hotkeys; Enter suspends them for chat.

#SingleInstance force		;force a single instance
#HotkeyInterval 0		;disable the warning dialog if a key is held down
#UseHook On			;might increase responsiveness of hotkeys
#MaxThreads 20			;allow up to 20 concurrent threads (default 10)
SetBatchLines, -1		;makes the script run at max speed
SetKeyDelay , -1, -1		;faster response (might be better with -1, 0)
SetTitleMatchMode Regex

IfExist, Frozen Throne.exe
  menu, tray, Icon, Frozen Throne.exe, 1, 1

;;;;; Variables ;;;;;
bInChatRoom := False
Return ; End Auto-Execute Section

; QuickCast
; Do not send F1 afterward: it reselects the hero and can recenter the camera.
QuickCast(key)
{
  SendInput, {%key%}
  Sleep, 10
  Click, Left
}

SelfCastDoubleTap(key)
{
  ; A single send keeps physical Alt out of both item-slot taps.
  SetKeyDelay, 80, 50
  SendEvent, {%key%}{%key%}
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
z::QuickCast("Numpad7")
Space::QuickCast("Numpad8")
x::QuickCast("Numpad4")
v::QuickCast("Numpad5")
c::QuickCast("Numpad1")
b::QuickCast("Numpad2")

; Quick-cast attack order.
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

; Wheel item quick-casts
WheelUp::QuickCast("Numpad2")
WheelDown::QuickCast("Numpad5")
; Shift+wheel is intercepted too, but Shift stays held for the target click.
+WheelUp::QuickCast("Numpad2")
+WheelDown::QuickCast("Numpad5")
