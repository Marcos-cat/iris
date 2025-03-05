# Experimental!
Rayua ~ "git: github.com/uiua-lang/rayua"

ToRayColor ↚ ⌅(⍜°⍉⬚255↙₄⁅) ×255
BoxStrings ↚ ⌅(⍥∵₁□=1⊸type|∵°□)

# Transformations
┌─╴Transform
  Up    ← ℂ0 ¯1
  Down  ← ¯Up
  Left  ← ℂ¯1 0
  Right ← ¯Left

  CImpl ↚ ⍉⊟°ℂ
  # Convert an array from complex coordinates to vector cooridinates
  # Coordinates ? Complex
  Coords ← ⌅(⍥CImpl=3⊸type|⍥°CImpl=0⊸type)

  Grid ← ˜ℂ⊢₂°⍉°⊡
└─╴
T ← Transform

┌─╴Collide
  # Check if two rectangles collide
  Rects ← /×/⊂> ⇌ ∩(⊟∵⊙∘) ⊙: ∩(°⊟\+°⍉₂T~Coords)

  # Check if two circles collide
  # ? Radius₁ Center₁ Radius₂ Center₂
  Circles ← <⊓(+|⌵-∩°T~Coords)⊙:

  # Check if a point is inside a circle
  # ? Radius Center Point
  CirclePoint ← ≤⊙(⌵-∩°T~Coords)

  # Check if a point is inside a rectangle
  # ? Rect Point
  RectPoint ← ×××∩°ℂ⊓⌟≥≤ °⊟\+°⍉ ∩°T~Coords

  # Check if a rectangle and a circle collide
  # ? Rect Radius Center
  RectCircle ← > ⌵- ⊸(↥⊙↧) °⊟\+°⍉°T~Coords ⊙:
└─╴

┌─╴Color
  # A color with an opacity of zero
  Clear ← [0 0 0 0]

  # Convert an rgb color to a Uiua color
  Rgb ← ÷255

  # Convert a hexadecimal string into a color
  # Color ? HexString
  Hex ← Rgb +×16∩⍉ ⧈°⊟¤¤2 °⍉ ⊗⊙HexDigits ⬚@f∵◇(↘=@#⊸⊢) BoxStrings ¯⌵
└─╴

# Draw different shapes onto the screen
┌─╴Draw
  IsColor ↚ ⊃(⍤.∊3_4⊣△|°0type)

  # Fill the whole screen with a color
  # ? Color
  Background ← Rayua~ClearBackground ToRayColor

  # Draw a line on the screen
  # Use a fill to set the thickness
  # ? Color A B
  Line ← (
    ⊓(∵₁□ToRayColor|∩(∵₁□T~Coords))
    ⍣(∵◇Rayua~DrawLineEx⊙⊙(°0⊸type°◌)|∵◇Rayua~DrawLine) ⤚⋅⊙∘
  )

  # Draw a circle on the screen
  # ? Color Radius Center
  Circle ← ∵◇Rayua~DrawCircle ⤚⋅: ⊓(∵₁□ToRayColor|∘|∵₁□T~Coords)

  # Draw a sector of a circle on the screen
  # The two angles (Start and Angle) are given in rotations 0-1
  # 0 is the top of the screen
  # ? Color Radius Start Angle Center 
  Sector ← (
    ⊓(∵₁□ToRayColor|∘|∩(-90×360) ⟜+ ⊙⟜(×32)|∵₁□T~Coords)
    ∵◇Rayua~DrawCircleSector ⤚⋅⤙⊙⊙⊙⊙◌
  )

  Text! ↚ ∵◇^0 ⤚⋅⤚⋅: ⊓(∵₁□ToRayColor|∘|∵₁□T~Coords|∵⍚$"_"BoxStrings)

  # Print text to the screen
  # ? Color Size Position Text
  Text ← Text!Rayua~DrawText

  # Draw a rectangle on the screen
  # ? Color Size Position
  Rect ← ∵◇Rayua~DrawRectangle ⤚⋅: ⊓(∵₁□ToRayColor|∩(∵₁□T~Coords))

  # Draw a square on the screen
  # ? Color Size Position
  Square ← Rect ⊙∵(↯2)

  ┌─╴Centered
    # Print horizontally centered text to the screen
    # ? Color Size Position Text
    Text ← Text!Rayua~DrawTextCentered

    # Draw a centered rectangle on the screen
    # ? Color Size Position
    Rect ← Draw~Rect⊙⟜(-÷₂∩°T~Coords)

    # Draw a centered square on the screen
    # ? Color Size Position
    Square ← Rect ⊙(ℂ.)

    Circle ← Draw~Circle
  └─╴

  ┌─╴Outline
    # Draw a rectangle outline onto the screen
    # ? Color Size Position
    Rect ← ∵◇Rayua~DrawRectangleLines⤚⋅: ⊓(∵₁□ToRayColor|∩(∵₁□T~Coords))

    # Draw a square outline on the screen
    # ? Color Size Position
    Square ← Rect ⊙∵(↯2)

    # Draw a circle outline on the screen
    # ? Color Radius Center
    Circle ← ∵◇Rayua~DrawCirclesLines ⤚⋅: ⊓(∵₁□ToRayColor|∘|∵₁□T~Coords)

    # Draw the outline of the sector of a circle on the screen
    # The two angles (Start and Angle) are given in rotations 0-1
    # 0 is the top of the screen
    # ? Color Radius Start Angle Center
    Sector ← (
      ⊓(∵₁□ToRayColor|∘|∩(-90×360) ⟜+ ⊙⟜(×32)|∵₁□T~Coords)
      ∵◇Rayua~DrawCircleSectorLines ⤚⋅⤙⊙⊙⊙⊙◌
    )
  └─╴

  ┌─╴Texture
    # Load a texture from a filepath
    # Texture ? Path
    Load ← (Rayua~LoadTexture)

    # Unload a texture, freeing it's memory
    Unload ← (Rayua~UnloadTexture)

    # Get the dimensions of a texture
    Size ← ℂ∵₁Rayua~Texture!⊃Width Height

    FillColor ↚ (∵₁□ ToRayColor ⍣(⊸IsColor °◌|White))

    # Draw a loaded texture onto the screen
    # Provide a fill to draw with a color
    # ? Position Texture
    Draw ← ∵◇Rayua~DrawTexture : ⊓(∵₁□T~Coords|∵₁□|FillColor)
    Call ← Draw

    # Draw a portion of a texture onto the screen
    # 
    # This function takes two rectangles. The first is the section of the texture to draw, and the second is where to draw it.
    # The next parameters are to rotate the To rectangle at some Angle, centered around an Origin.
    # Provide a fill to draw with a color
    # ? From To Origin Angle Texture
    Map ← (
      ⊓(∩(∵₂(□♭)T~Coords)|∵₁□T~Coords|×360|∵₁□|FillColor)
      ∵◇Rayua~DrawTexturePro ⤙⊙⊙⊙⊙◌
    )
  └─╴
└─╴

Texture ← Draw~Texture

┌─╴Key
  (⍚˙$"_ ← ∘Rayua~Key~_  # The keycode for the _ key\n"
  )^!(Backspace|Tab|Enter|Delete|Home|End|Insert|PageUp|PageDown|Escape|Pause|LeftControl|RightControl|LeftShift|RightShift)
  Space ← @\s

  Fix ↚ ⍥⋅Tab⊸=@\t ⍥⋅Enter⊸=@\n

  # Check if a key was pressed once
  # ? Key
  Pressed ← ∵◇(Rayua~IsKeyPressed Fix)

  # Check if a key is down
  # ? Key
  Down ← ∵◇(Rayua~IsKeyDown Fix)

  # Call a function when a key is pressed
  # 
  # The first function is the key to run the function on (or identity to take from the stack)
  # The second function will be called when the key is pressed
  # ? Key Function
  Pressed‼ ← ⍥(^1)Pressed ^0

  # Call a function when a key is down
  # 
  # The first function is the key to run the function on (or identity to take from the stack)
  # The second function will be called when the key is down
  # ? Key Function
  Down‼ ← ⍥(^1)Down ^0

  # Get the characters that the user has typed
  # 
  # This function returns a string of queued characters
  # If the user has not typed since the function was called, the string will be empty
  Typed ← (⍥(⊂:▽⊸≠@\0Rayua~GetCharPressed)∞ "")

  # Get the key codes that the user has typed
  # 
  # This function returns an array of queued key codes
  # If the user has not typed since the function was called, the array will be empty
  TypedCodes ← (⍥(⊂:▽⊸≠0Rayua~GetKeyPressed)∞ [])

  # Emulate a text input on a string
  # 
  # This function edits a string based on the user's keyboard inputs
  # Typing alphanumerics will append to the string, as well as non-printing characters like newline, space, and tab
  # The string will also respect backspace and the Delete key to clear the string
  Input ← (
    ⊸˜∊Delete TypedCodes ⊂:Typed
    ⨬(⍥(⍜↻↘₂-₁⊸⊗@\0) ⧻⊚⊸=@\0 ⊂: ˜⊏"\0\n\t"▽⊸≠∞⬚∞˜⊗[Backspace Enter Tab]
    | ⋅⋅"")
  )

  # Get an arrow key for a specific direction
  # ^: Up, v: Down, <: Left, >: Right
  # Key ? Character
  Arrow ← get⊙(map "^v<>" Rayua~Key![Up Down Left Right])

  # Get a particular function key
  # Key ? Number
  F ← get⊙(map⍜¯⇡12 +290⇡12)

  Impl ↚ ▽⊙Transform![Up Left Down Right]⨬(Down|Pressed)

  # Returns array of direction constants for WASD keys pressed
  # Takes a boolean to choose between keypress and keydown
  # Direction ? Pressed
  WASD ← Impl⊙"wasd"

  # Returns array of direction constants for arrow keys pressed
  # Takes a boolean to choose between keypress and keydown
  # Direction ? Pressed
  UDLR ← Impl⊙(Arrow "^v<>")
└─╴

┌─╴Mouse
  (⍚˙$"_ ← ∘Rayua~MouseButton~_  # The code for the _ mouse button\n"
  )^!(Left|Right|Middle|Side|Extra|Forward|Back)

  # Check if a mouse button was pressed once
  # ? Button
  Pressed ← ∵Rayua~IsMouseButtonPressed

  # Check if a mouse button is down
  # ? Button
  Down ← ∵Rayua~IsMouseButtonDown

  # The current position of the mouse
  Pos ← (°T~Coords Rayua~GetMousePosition)

  # How many pixels the mouse has moved since the last frame
  Change ← (°T~Coords Rayua~GetMouseDelta)

  # Hide the mouse from the user
  Hide ← ⌅(Rayua~HideCursor|Rayua~ShowCursor)

  # Call a function on the mouse position when a button is pressed
  # 
  # The first function is the button to run the function on (or identity to take from the stack)
  # The second function will be called with the mouse position as its first argument
  # ? Button Function
  Pressed‼ ← ⍥(^1 Pos)Pressed ^0

  # Call a function on the mouse position when a button is down
  # 
  # The first function is the button to run the function on (or identity to take from the stack)
  # The second function will be called with the mouse position as its first argument
  # ? Button Function
  Down‼ ← ⍥(^1 Pos)Down ^0

  # Check if the mouse is on the screen
  OnScreen ← (Rayua~IsCursorOnScreen)
└─╴

┌─╴Screen
  # Check if the screen is fullscreen
  # Inverse will set the screen state
  Full ← ⌅(Rayua~IsWindowFullscreen|⍥Rayua~ToggleFullscreen≠Rayua~IsWindowFullscreen)

  # Get the size of the screen
  # Inverse will set the size
  Size ← °T~Coords⊟ ⌅(Rayua~GetRenderWidth Rayua~GetRenderHeight|Rayua~SetWindowSize °Full 1)

  # Get the size of the screen when it is fullscreen
  FullSize ← °T~Coords⊟ Rayua!⊃GetMonitorWidth GetMonitorHeight (Rayua~GetCurrentMonitor)

  # Get the current FPS
  # Inverse will set the target FPS for the screen
  FPS ← ⌅(Rayua~GetFPS|Rayua~SetTargetFPS)
└─╴

# Open a new screen with title
# ? Size Title
Open ← Rayua~InitWindow ⊓(°⊟ ⍥(↯2)≍[]⊸△ T~Coords|$"_")

# Number of seconds since the screen opened
# Seconds ? 
Time ← (Rayua~GetTime)

# Delta-time since last frame in seconds
Dt ← (Rayua~GetFrameTime)

Loop! ← (
  ⍢(Rayua~BeginDrawing
    ^0
    Rayua~EndDrawing
  | ¬ Rayua~WindowShouldClose
  )
  Rayua~CloseWindow
)
