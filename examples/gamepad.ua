# Experimental!
I ~ "gh: Marcos-cat/iris"

DarkGray  ← ↯3 0.2
LightGray ← ↯3 0.8

# Color ? Down
ButtonColor ← ⨬DarkGray LightGray

I~Open 640_480 "Gamepad example"

°I~Window~FPS 60

I~Loop!(
  I~Draw~Background "#767c82"

  # Sticks
  ×30 I~Gamepad~Stick 0 [0 1]
  +ℂ⊟⤙˜-640 240 280
  ButtonColor I~Gamepad!(Down 0 Button![LeftStick RightStick])
  I~Draw~Circle⊙30

  # Face buttons
  +ℂ480 200 ×30 I~Transform![Down Right Left Up]
  I~Gamepad!(Down 0 Button![South East West North])
  I~Draw~Circle⊙15 ButtonColor

  # D-pad
  +ℂ160 200 ×30 I~Transform![Down Right Up Left]
  ˙⊂⊟⊸⇌30_20
  I~Gamepad!(Down 0 Button![Down Right Up Left])
  I~Draw~Rect!°⊸Centered 1 ButtonColor

  # Bumpers
  ℂ[⊃-+] 200 320 130
  50_20
  I~Gamepad!(Down 0 Button![LeftBumper RightBumper])
  I~Draw~Rect!°⊸Centered 1 ButtonColor

  # Triggers
  90
  -×30 I~Gamepad~Trigger 0 [0 1]
  ℂ[⊃-+]200 320
  35_40
  I~Gamepad!(Down 0 Button![LeftTrigger RightTrigger])
  I~Draw~Rect!°⊸Centered 1 ButtonColor
)
