# Experimental!
Rayua ~ "git: github.com/uiua-lang/rayua"

BoxStrings ↚ ⌅(⍥≡₁□=1⊸type|≡₀°□)
F          ↚ ⍥(⊂@\n)>1⊃⧻/$"_\n_"pretty
Os‼        ↚^ ▽≍os°□₂
S!         ↚^ $"⊃(_)"/$"_|_"˜⍚⊂@∘˜⍚↯@⋅-@a°□₁

# Transformations
┌─╴Transform
  Up    ← ℂ0 ¯1
  Down  ← ¯Up
  Left  ← ℂ¯1 0
  Right ← ¯Left

  CImpl ↚ ⍉⊟°ℂ

  CoordError ↚ ⨬(
    ⨬◌(˜⍤0$"Expected number array with X and Y components, but got shape _")≠2⊸⬚2⊣◌
  | ◌◌
  | ˜⍤0$"Expeced number or complex array, but got a _ array" ⨬"character""box"=1 ⊙◌
  )⊸⨂0_3 ⊃type△

  # Convert an array from complex coordinates to vector cooridinates
  #
  # Returns an array with the shape of the orignal, and an additional 2-long trailing axis.
  # The first component is the `X`, and the second is the `Y`.
  # The imaginary part of a complex number corresponds to `X` and the real part to `Y`.
  # `°Coords` takes vector coordinates and gives the complex equivalent.
  # Coordinates ? Complex
  # Track caller!
  Coords ← ⌅(⍥CImpl=3⊸type ⊸CoordError|⍥°CImpl=0⊸type ⊸CoordError)

  Grid ← ˜ℂ⊢₂°⍉°⊡
└─╴
T ← Transform

┌─╴Collide
  # Check if two rectangles collide
  # Collided ? Size₁ Position₁ Size₂ Position₂
  Rects ← /×/⊂> ⇌ ˜∩(⊟≡₀⊙∘) ∩˜(⟜+∩°⍉∩T~Coords)

  # Check if two circles collide
  # Collided ? Radius₁ Center₁ Radius₂ Center₂
  Circles ← <˜⊓(+|⌵-∩°T~Coords)

  # Check if a point is inside a circle
  # Collided ? Radius Center Point
  CirclePoint ← ≤⊙(⌵-∩°T~Coords)

  # Check if a point is inside a rectangle
  # Collided ? Rect Point
  RectPoint ← ×××∩°ℂ⊓⌟≥≤ °⊟\+°⍉ ∩°T~Coords

  # Check if a rectangle and a circle collide
  # Collided ? Rect Radius Center
  RectCircle ← > ⌵- ↥⊙∪⌟⊸↧∘ °⊟\+°⍉°T~Coords
└─╴

# 0 = Black and white, 1 = Color, 2 = Black and white alpha, 3 = Color alpha
# ? Image
ColorFormat ↚ ⍤"Image does not have a possible color format"⊸≠4 ⨂{[][3][2][4]} □↘₂△
FormatName  ↚ ⍥$"_ with alpha"≥2⟜(⨬("grayscale"|"color")◿₂)

┌─╴Color
  # A color with an opacity of zero
  Clear ← [0 0 0 0]

  # Convert a color from 8-bit rgb to Uiua colors
  #
  # Uiua color channels are represented by values `0-1`, while standard graphics uses integers from `0-255`.
  # Colors are rounded to four decimal places so that they display nicely (this will not affect their 8-bit value.)
  # `°Rgb` converts a Uiua color back to an 8-bit color.
  # Both `Rgb` and `°Rgb` clamp the values to be within the correct ranges.
  # UiuaColor ? RgbColor
  Rgb ← ⌅(↥0↧1⁅₃) ÷255 °⌅(↥0↧255⁅)

  # Convert a hexadecimal string into a color
  #
  # Expects a string in the form `#RRGGBB` where all the letters are hexadecimal digits corresponding to color channels.
  # The leading `#` can be omitted, and alpha channel can also be specified at the end.
  # This function is pervasive, and will convert an array of strings, or an array of box strings into an array of colors.
  # The output will always be non-box, so if a single string has an alpha channel, all of the output will have one too.
  # `°Hex` converts a color back into a hexadecimal string, always including the `#`.
  # Color ? HexString
  # Track caller!
  Hex ← (⌅(
      ⨬(⬚1≡₀◇^|≡₁^)=1⊸type ¯⌵
    | ⨬(⬚@f≡₀◇°^|≡₁°^)=0⊸type))!(
    ⌅(⍤"Hex string must be characters"=1⊸type)
    ⌅(⍥(▽2)⊸(∊3_4⧻) ⍣⌝⊂◌@#|⊂@#)
    ⌅(⍤"Hex string must have 3 or 4 channels"∊[6]_[8]⊸△)
    ⌅(⍤"Hex string has invalid characters"¬⊸˜∊∞) ⬚∞⨂HexDigits
    Rgb ⌝⊥16°⌅≡⬚0↙₂ ≡⇌ ⌅(↯∞_2|♭)
    °⌅(⍤"Color must be numbers"=0⊸type
       ⍤"Color must be 3 or 4 digits"∊[3]_[4]⊸△)
  )

  # Get the alpha channel (transparency) of an image
  #
  # If `Alpha` is called on an image without an alpha channel, a fully opaque one will be added.
  # `⍜Alpha` edits the alpha channel, and `°⊸Alpha` can be used to set it.
  # For either inverse if a scalar is provided the entire alpha channel will be set to it.
  # `0` is fully transparent and `1` is fully opaque.
  # Track caller!
  # AlphaChannel ? Image
  Alpha ← ⊣°⍉ ⌅(⨬(⍉˜⊂1|⍜°⍉⬚1↙₄|∘|∘)⊸ColorFormat)

  Rosewater ← Hex "#f5e0dc"
  Flamingo  ← Hex "#f2cdcd"
  Pink      ← Hex "#f5c2e7"
  Mauve     ← Hex "#cba6f7"
  Red       ← Hex "#f38ba8"
  Maroon    ← Hex "#eba0ac"
  Peach     ← Hex "#fab387"
  Yellow    ← Hex "#f9e2af"
  Green     ← Hex "#a6e3a1"
  Teal      ← Hex "#94e2d5"
  Sky       ← Hex "#89dceb"
  Sapphire  ← Hex "#74c7ec"
  Blue      ← Hex "#89b4fa"
  Lavender  ← Hex "#b4befe"
  Text      ← Hex "#cdd6f4"
  # Color ? Level
  Subtext ← ˜⊏Hex "#a6adc8"_"#bac2de"
  # Color ? Level
  Overlay ← ˜⊏Hex "#6c7086"_"#7f849c"_"#9399b2"
  # Color ? Level
  Surface ← ˜⊏Hex "#313244"_"#45475a"_"#585b70"
  Base    ← Hex "#1e1e2e"
  Mantle  ← Hex "#181825"
  Crust   ← Hex "#11111b"
└─╴

┌─╴Window
  # Check if the window is fullscreen
  #
  # `Full` returns a boolean to tell if the window is in fullscreen mode.
  # `°Full` can be passed a boolean to set the state of fullscreen mode.
  # A common pattern to toggle fullscreen is `⍜Full¬`.
  # IsFullscreen ?
  # Track caller!
  Full ← ⌅(
    Rayua~IsWindowFullscreen
  | ⍥⊸(˜⍤0$"Fullscreen state must be a boolean, but it is _"F)¬≍1⊸∊0_1
    ⍥Rayua~ToggleFullscreen≠Rayua~IsWindowFullscreen)

  # The size of the window
  #
  # The dimensions returned are in pixels.
  # `°Size` sets the size of the window.
  # If the window is in fullscreen mode when `°Size` is called, fullscreen mode with be turned off.
  # Neither dimension of the window can be zero.
  # If a single number is given as the dimensions, it will be used as both the width and the height.
  # Size ?
  # Track caller!
  Size ← (°T~Coords ⌅(
      Os‼macos÷₂ ⊟Rayua~GetRenderWidth Rayua~GetRenderHeight
    | ⍥⊸(˜⍤0$"Window size must be greater than zero, but it is _"F) ¬×⊸⊃(≍1/×>0|≍[2]△) ⌈ ⍥(↯2)≍[]⊸△ °Full 0
      Rayua~SetWindowSize °⊟))

  # Get the size of the window when it is fullscreen
  # FullSize ?
  FullSize ← (°T~Coords⊟ Rayua!⊃GetMonitorWidth GetMonitorHeight Rayua~GetCurrentMonitor)

  # The active FPS (framerate)
  #
  # `FPS` returns the actual framerate, which varies based on how long your device takes to run a frame.
  # `°FPS` sets the maximum FPS. By default, the FPS is unbounded, and frames will be run as fast as possible.
  # `FPS` can take `∞` to have the fastest possible framerate (the default behavior.)
  # FPS ?
  # Track caller!
  FPS ← ⌅(
    Rayua~GetFPS
  | ⍥⊸(˜⍤0$"FPS must be greater than zero, but it is _"F)¬×⊸⊃(>0|≍[]△) ⌈
    Rayua~SetTargetFPS)

  # Delta-time since last frame in seconds
  # DeltaTime ?
  Dt ← (Rayua~GetFrameTime)

  # Sets the trace log to `DEBUG`, printing extra information about what Raylib is doing
  Debug ← Rayua~SetTraceLogLevel Rayua~TraceLogLevel~Debug
└─╴

┌─╴Net
  ≁Tunnel {
    TcpThread
    BoreProc
    RecvPort
    SendAddr ← ∞
    Type ← "connection"
  }
  IsTunnel! ↚ ⊸(⍤$"_ must take a connection"^≍□"connection"⊣)

  # This could probably be done better with a system function for looking at PATH
  HasBore ↚ memo(
    ⍚⍜⇌(↙⊸˜⨂pathsep) /◇⊂⍚⍣&fld[] ⊜□⊸≠ ˜⊏":;" ≍"windows"osfamily &var"PATH"
    ˜∊□ ⊂"bore" ⍥(⊂@.)⊸(±⧻) exeext
    ⍤"`bore` must be installed to use Net. Install it with `$ cargo install bore-cli`"
  )

  # The external bore port that a tunnel reads from
  #
  # This is the port that must be shared to another program to connect them.
  # Calling this on a non-bore tunnel will error
  Port ← ⍤"Port must take a tunnel using bore"⊸(¬≍∞) Tunnel~RecvPort IsTunnel!"Port"

  # ProcStream RecvPort ? LocalPort
  InitBore ↚ (
    HasBore
    ⍣(˜⌞⊙∩&cl &runs ⊜□⊸≠@\s $"bore local _ --to bore.pub"
      ⟜(⋕ ⍜⇌(▽\×⊸∊+@0⇡10 ↘₁) &ru@\n)
    | ˜⍤0"Failed to start a server")
  )

  # Thread ? LocalPort
  StartThread ↚ spawn⍢(⍣(send0°binary ⍜(&tcpa|&rb∞ ⊸&tcpsrt0.5)|⋅&ep)|1) &tcpl $"localhost:_"

  # Start a network tunnel
  #
  # `Start` spawns a thread that reads for incoming data.
  # The optional argument `LocalPort` controls which port on localhost is read to receive values (8080 by default.)
  # Also by default a bore process will be set up to receive data.
  # To disable this and control hosting yourself, set the `UseBore` optional argument to `0`.
  # Tunnel ?
  # Track caller!
  ~Start {LocalPort ← 8080|UseBore ← 1} Tunnel ⊃(⋅StartThread|⨬(∩∞|InitBore)) ⊃(UseBore|LocalPort)

  # End a tunnel connection
  #
  # This cleans up the bore process if the tunnel used bore, and does nothing otherwise.
  # ? Tunnel
  # Track caller!
  End ← ⍥&cl ⊸(¬≍∞) Tunnel~BoreProc IsTunnel!"End"

  # Connect a tunnel to a certain port
  #
  # If using bore, the port given here should be from calling `Port` in a different program on their tunnel.
  # If not using bore, port can be a full IP address with a port.
  # ? Port Tunnel
  # Track caller!
  Connect ← °⊸Tunnel~SendAddr ⍥$"bore.pub:_"⊸(≍0type) ⍣⋕∘ ⊙IsTunnel!"Connect"

  # Check if a tunnel is set up to send values to another
  #
  # IsConnected ? Tunnel
  # Track caller!
  Connected ← ¬≍∞Tunnel~SendAddr IsTunnel!"Connected"

  # Send a value to a different program
  #
  # The tunnel must have been connected to a port with `Connect` in order to send a value.
  # The value can be any array.
  # ? Value Tunnel
  # Track caller!
  Give ← ⍜(&tcpc|˜&w ⊸&tcpswt0.5) ⊃(⋅Tunnel~SendAddr|binary|⍤"You cannot give a value on an unconnected tunnel"Connected◌) ⊙IsTunnel!"Give"

  # Attempt to get a value from a tunnel
  #
  # If `TryGet` is called and no value was sent, and no fill was supplied, it will error.
  # If the optional argument `Block` is `1`, `TryGet` will block the program until a value is sent.
  # Value ? Tunnel
  # Track caller!
  ~TryGet {Block ← 0} ⨬(⍣(tryrecv|°◌|˜⍤0"No value has been sent yet")|recv) ⊓(Block|Tunnel~TcpThread IsTunnel!"Get")

  # Call a function when a value is sent through a tunnel
  Get! ← ⍣(⍩^TryGet)◌ IsTunnel!"Get!"
└─╴

┌─╴Sound
  ≁Data {Buffer Clone}

  # Unload a sound, freeing it's memory
  Unload ← ≡₁(Rayua~UnloadSound ⍤"Cannot free an active sound, only a source sound." Data!⊃Clone Buffer)

  # ActiveSound ? SourceSound
  Play ← Data⊙1 ⊸Rayua~PlaySound Rayua~LoadSoundAlias Data~Buffer

  Start ← ⍜Data~Buffer⊸Rayua~PlaySound
└─╴

ColorArg ↚ |1 ≡₁□ ⨬(
  ⍤"Color must have 1 through 4 channels" ∊⇡₁4⊸⧻₋₁ ⍥¤⊸(≍[]△)
  °Color~Rgb ⍥⍜°⍉⬚1↙₄⊸(=3⊣△) ⍥⍜(⊢°⍉|↯3)⊸(<3⊣△)
| °Color~Rgb ⍥⍜°⍉⬚1↙₄=3⊣⊸△ Color~Hex
| ⬚255≡₀◇ColorArg
| ⍤"Color cannot be complex"0
) ⊸type
SizeArg ↚ ≡₁□ ⍥˙⊟=0⧻⊸△ T~Coords
PosArg  ↚ ≡₁□ T~Coords

IsTexture ↚ ≍□"texture"⬚∞⊣

┌─╴Texture
  ≁Data {Buffer ColorFormat Type ← "texture"}

  # Unload a texture, freeing it's memory
  #
  # Once a texture is unloaded, attempting to draw it will result in an all-black texture.
  # Calling this function multiple times on a texture will not doing anything.
  # ? Texture
  Unload ← Rayua~UnloadTexture Data~Buffer

  # Get the dimensions of a texture
  # Size ? Texture
  Size ← ℂ≡₁(Rayua~Texture!⊃Width Height Data~Buffer)

  # Load a texture from a filepath
  #
  # The file must contain an image, and have the proper extension for the image format.
  # The color format of a texture created this way is always color with an alpha channel.
  # `⍜LoadFile` will load the texture, and then free the memory when the function is over.
  # [NOTE] You cannot load a texture before `Open` is called, it will cause a segfault.
  # Texture ? Path
  LoadFile ← (⌅(^0|⟜∘^0|^1))!(Data ⊙3 Rayua~LoadTexture|Unload)

  # ? Image
  ToFullColor ↚ ⨬(⍉˜⊂1↯3|⍜°⍉⬚1↙₄|⍜°⍉(▽3_1)|∘) ⊸ColorFormat

  # ? Data Image
  ToFormat ↚ |2 ⨬(⊢°⍉|⍜°⍉↙₃|⍜°⍉(⊏0_3)|∘) Data~ColorFormat

  # Reads the literal bytes from the buffer with no processing, only shaping
  ReadImageData ↚ ↯⤙(&memcpy⊙/×) Rayua~Image!(Data⟜[⊃Height Width⊙4]) Data~Buffer

  ToRayImage ↚ ⌅(
    Data ⊃(Rayua~Image ⊃(♭ °Color~Rgb ToFullColor|°⊟⇌△₂|1 7)|ColorFormat)
  | Rayua~UnloadImage ⟜(Data~Buffer|ToFormat|Color~Rgb ReadImageData))

  ImageAndTextureData ↚ ⊓(⊃(⇌△₂) ColorFormat|⊃(⊟°ℂSize) Data~ColorFormat)
  ImageError ↚ ⨬(
    ∩($"_ _"⊓/$"_x_"FormatName) ImageAndTextureData
    ˜⍤0 $"A _ image was provided, but the texture is a _ image."
  )⋅◌ ◡(×˜∩≍ ImageAndTextureData)

  # Get the image in a texture without unloading the texture
  #
  # `Image` remembers the color format of the image you made the texture with. If you provided a grayscale, you will get back a grayscale.
  # `°⊸Image` edits the image in a texture. It takes the new image as the first argument and the texture as the second argument.
  # `⍜Image` gets the image, allows you to change it, and then puts the new image back in the texture.
  # If any of the properties of the image are altered, like the shape or the color format, this function will error.
  # Image ? Texture
  # Track caller!
  Image ← (⌅(^0|⟜^0|^1))!(
    °ToRayImage ⍜Data~Buffer Rayua~LoadImageFromTexture
  | ⟜(Rayua~UpdateTexture Data~Buffer)⊙(♭ °Color~Rgb ToFullColor) ◡˜ImageError)

  # Load a texture from a Uiua image array
  #
  # The provided image can be in any color format a Uiua image can be in, except for complex domain coloring.
  # The formats are defined [in the Uiua tutorial.](https://www.uiua.org/tutorial/images)
  # The format you use to create the texture is the only one that may be used by the texture.
  # Calling `Image` will result in an image of the same format.
  # [NOTE] You cannot load a texture before `Open` is called, it will cause a segfault.
  # Texture ? Image
  LoadImage ← (⌅(^0|^1|⟜∘^0|^2))‼(
    ⍜Data~Buffer Rayua~LoadTextureFromImage ToRayImage
  | Unload⟜Image
  | Unload)

  # Draw a texture on the window
  #
  # `Color` tints a texture a particular color.
  # `Angle` is given in rotations `[0,1]`, clockwise.
  # Optional args: Color Angle Centered
  # ? Texture Size Pos
  ~Draw {Color ← White|Angle ← 0|Centered ← 0} (
    ⊃(Color|Angle|⋅∘|Centered)
    ⊓(ColorArg | ×360◿1 | ≡₁⊃(□Data~Buffer|□⊂0_0⊟°ℂSize)
    | ⊃(≡₀⍚⊂ ⍥(+◡⋅÷₂)¬|⋅⋅÷₂) ⊙˜⊓PosArg SizeArg)
    ≡₀◇Rayua~DrawTexturePro S!cdefba
  )
└─╴

# Draw different shapes onto the window
┌─╴Draw
  # Fill the whole window with a color or texture
  #
  # When given a color, `Background` covers the whole window with that color.
  # When given a texture `Background` scales the texture to fit over the whole window.
  # ? Background
  # Track caller!
  Background ← (
    ⊸IsTexture
    ⨬(Rayua~ClearBackground ⍤"Background does not take multiple colors"≍[4]⊸△ °□ ColorArg
    | Texture~Draw⊙(Window~Size 0_0))
  )

  # Draw a line on the window
  #
  # A line will draw from point A to point B, even if either are outside the window.
  # A width of zero will cause the line not to draw at all.
  # ? Color Width A B
  Line ← ≡₀◇Rayua~DrawLineEx S!cdba ⊓(ColorArg|↥₀⌈|∩PosArg)

  # Draw a circle on the window
  #
  # An angle and a starting position can be supplied to draw a sector of the circle.
  # `Angle` can have the range `[-1,1]` where positive is clockwise.
  # `Start` can have the range `[0,1]` where `0` is upward also moving clockwise.
  # Optional args: Angle Start
  # ? Color Radius Center
  ~Circle {Angle ← 1|Start ← 0} (
    ⊃Angle Start
    ⟜(≍1|⌈×32|∩(-90×360) ⊸+) ⊓(⍜⌵↧₁|◿₁|ColorArg|↥₀⌈|PosArg) # B Segments End Start Color Radius Center ?
    ⨬(≡₀◇Rayua~DrawCircleSector S!fecbad|≡₀◇Rayua~DrawCircle S!fed)
  )

  # ? Font Size
  LoadFont ↚ ⨬(memo(Rayua~LoadFontEx⊙⊙[])|memoRayua~GetFontDefault)⊸≍∞ ⊙(↥₅ ⍥⁅₋₁ ⊸>₁₀₀)

  # Print text to the window
  #
  # `Font` is a filepath pointing to a font file. If not specified, the Raylib font is used.
  # `Spacing` changes how far apart characters are placed from eachother. By default it is 10% of the fontsize.
  # `Centered` centers the text both horizontally and vertically.
  # Optional args: Font Spacing Centered
  # ? Color Size Position Text
  ~Text {Centered ← 0|Font ← ∞|Spacing ← 0} (
    ⊃(Centered|Font|Spacing)
    ⊙(⊓(□|∘|ColorArg|↥₀|PosArg|≡₀⍚$"_"BoxStrings)
      S!afedbc ≡₀⍚LoadFont⊙⤙⊙⊙∘ ⟜(⍥⋅◡⋅÷₁₀◇≍∞)
    ) # Centered Font Text Pos Size Spacing Color ?
    ≡₀◇(Rayua~DrawTextEx⍥(⍜⊙⋅⋅∘- ◡(÷₂Rayua~MeasureTextEx⊙⊙⋅⊙∘)))
  )

  # Draw a rectangle on the window
  #
  # Optional args: Centered
  # ? Color Size Position
  ~Rect [Centered ← 0] ≡₀◇Rayua~DrawRectangle S!bca ⊓(ColorArg|⍥(≡₀⍚-◡⋅÷₂) ⊙˜⊓PosArg SizeArg) ⊃⋅∘Centered # TODO: Change back once pervasion is fixed

  # Draw a square on the window
  #
  # Exactly like `Rect`, except that the size is a scalar instead of a vector
  # Optional args: Centered
  # ? Color Size Position
  ~Square [Centered ← 0] Rect!°⊸Centered ⊓Centered ⊙(⍉↯2 ⍤"Square only takes real numbers, you might intend to use Rect"≠3⊸type)

  PointOrder ↚ <0/+×⊓+-∩⊸↻₁°⊟≡⊟₃

  # Draw a triangle on the window
  #
  # The points `A`, `B`, and `C` may be in any order
  # ? Color A B C
  Triangle ← ≡₀◇(Rayua~DrawTriangle ⍥˜⊙∘◡PointOrder) ⤚⋅⊙⊙∘ ⊓(ColorArg|∩₃PosArg)

  Texture ← Texture~Draw

  RenderTxDims ↚ (°ℂ↥Window!⊃FullSize Size)
  RenderTxRect ↚ (memo[⊃⊓⋅0∘⊓∘¯ RenderTxDims])
  RenderTx     ↚ (memo(Rayua~LoadRenderTexture RenderTxDims))

  # Draw to the Canvas, then draw the canvas to the window
  #
  # Any drawing functions that are executed inside `Canvas!` will be drawn to the global canvas instead of the window.
  # On its own, this is indistinguishable from normal drawing. However, the state of the canvas is maintained even when the window is cleared.
  # This makes certain kinds of graphical programs much simpler, as they don't have to redraw the entire window each frame.
  Canvas! ← (
    Rayua~BeginTextureMode RenderTx
    ^
    Rayua~EndTextureMode
    Rayua~DrawTextureRec⊃(Rayua~RenderTexture~Texture RenderTx|RenderTxRect|[0 0]|[255 255 255 255])
  )
└─╴

┌─╴Key
  (⍚˙$"_ ← ∘Rayua~Key~_  # The keycode for the _ key\n"
  )^!(Backspace|Tab|Enter|Delete|Home|End|Insert|PageUp|PageDown|Escape|Pause|LeftControl|RightControl|LeftShift|RightShift)
  Space ← @\s

  Fix ↚ ⍥⋅Tab⊸=@\t ⍥⋅Enter⊸=@\n

  # Check if a key was pressed once
  # IsPressed ? Key
  Pressed ← ≡₀◇(Rayua~IsKeyPressed Fix)

  # Check if a key is down
  # IsDown ? Key
  Down ← ≡₀◇(Rayua~IsKeyDown Fix)

  # Call a function when a key is pressed
  # 
  # The first function is the key to run the function on (or identity to take from the stack)
  # The second function will be called when the key is pressed
  # ? Key Function
  Pressed‼ ← (
    {/∨ Pressed ⍤"At least one key must be specified"⊸(±⧻) ♭ ^0}
    ⍥(^1) ⨬(°□₁|×⊙(/×Down♭) °□₂) ⊸(-₁⧻)
  )

  # Call a function when a key is down
  # 
  # The first function is the key to run the function on (or identity to take from the stack)
  # The second function will be called when the key is down
  # ? Key Function
  Down‼ ← ⍥(^1) Down ^0

  # Get the characters that the user has typed
  # 
  # This function returns a string of queued characters
  # If the user has not typed since the function was called, the string will be empty
  # TypedChars ? 
  Typed ← (⍥(˜⊂▽⊸≠@\0Rayua~GetCharPressed)∞ "")

  # Get the key codes that the user has typed
  # 
  # This function returns an array of queued key codes
  # If the user has not typed since the function was called, the array will be empty
  # TypedCodes ?
  TypedCodes ← (⍥(˜⊂▽⊸≠0Rayua~GetKeyPressed)∞ [])

  # Emulate a text input on a string
  # 
  # This function edits a string based on the user's keyboard inputs
  # Typing alphanumerics will append to the string, as well as non-printing characters like newline, space, and tab
  # The string will also respect backspace and the Delete key to clear the string
  # EditedText ? Text
  Input ← (
    ⊸˜∊Delete TypedCodes ˜⊂Typed
    ⨬(⍥(⍜↻↘₂-₁⊸˜⨂@\0) ⧻⊚⊸=@\0 ˜⊂ ˜⊏"\0\n\t"▽⊸≠∞⬚∞⨂[Backspace Enter Tab]
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
  ULDR ← Impl⊙(Arrow "^<v>")
└─╴

┌─╴Mouse
  (⍚˙$"_ ← ∘Rayua~MouseButton~_  # The code for the _ mouse button\n"
  )^!(Left|Right|Middle|Side|Extra|Forward|Back)

  # Check if a mouse button was pressed once
  # IsPressed ? Button
  Pressed ← ≡₀Rayua~IsMouseButtonPressed

  # Check if a mouse button is down
  # IsDown ? Button
  Down ← ≡₀Rayua~IsMouseButtonDown

  # The current position of the mouse
  # MousePos ?
  Pos ← (°T~Coords Rayua~GetMousePosition)

  # How many pixels the mouse has moved since the last frame
  # MouseMovementVector ?
  Change ← (°T~Coords Rayua~GetMouseDelta)

  # Hide the mouse from the user
  # 
  # `°Hide` will make the mouse reappear.
  # The user can still use the mouse while it it hidden. The effect is purely visual.
  Hide ← ⌅(Rayua~HideCursor|Rayua~ShowCursor)

  # The direction the mouse is scrolling
  # 
  # Returns `0` if the mouse has not scrolled, and `1` or `¯1` depending on the direction scrolled.
  # The sign may not nicely correspond to 'up' or 'down' since the direction of scrolling depends on the user's device.
  # ScrollDir ?
  Scroll ← (⊣Rayua~GetMouseWheelMoveV)

  # Call a function on the scroll direction when the wheel is scrolled
  # 
  # The function will be called on a value of either `1` or `¯1`, but never `0`
  Scroll! ← ⨬◌^ ⊸≠0 Scroll

  # Call a function when the user drags the mouse
  # 
  # The first function is the mouse button that must be down while dragging. 
  # If it is monadic it will pull from the stack.
  # The second function is called when a drag occurs and is supplied the distance dragged.
  # If the mouse does not move, this will not trigger, thus the distance cannot be zero.
  # ? Button Function
  Drag‼ ← ⨬◌(^1) ×Down ⊙(⊸≠0 Change) ^0

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

  # Check if the mouse is on the window
  # IsOnWindow ?
  OnWindow ← (Rayua~IsCursorOnScreen)
└─╴

# Open a new window with a title
# ? Size Title
Open ← Rayua~InitWindow ⊓(°⊟ ⍥(↯2)≍[]⊸△ T~Coords|$"_") Rayua~SetTraceLogLevel Rayua~TraceLogLevel~Warning

# ? Conditional Body
Loop‼ ← Rayua~CloseWindow ⍢(
  Rayua~EndDrawing ^1 Rayua~BeginDrawing
| ×¬Rayua~WindowShouldClose ^0)

# ? Body
Loop! ← Loop‼1^
