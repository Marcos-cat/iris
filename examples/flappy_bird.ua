# Experimental!
I ~ "../lib.ua"

BirdX             ← 100
Gravity           ← 0.5
JumpSpeed         ← ¯10
PipeSpawnPosition ← 640
PipeGap           ← 90
PipeMovementSpeed ← 4
GapsBetweenPipes  ← 300

WindowWidth  ← 640
WindowHeight ← 480

I~Open WindowWidth_WindowHeight "Rayua Flappy Bird"
I~Screen!°FPS 60

┌─╴Pipe
  ~[X Top Bottom Scored Id]
  TopRect    ← [⊃(⊟X⊙0|⊟64 Top)]
  BottomRect ← [⊃(⊟⊃X Bottom|⊟64 -⊙WindowHeight Bottom)]
  Spawn      ← New ⊙(⊃-+ PipeGap +140×⚂-280WindowHeight 0 ⌊×1000⚂)

  DrawTop ↚ I~Draw~Texture~Map ⊓⊃(
    ⊟⊃[⊃[×32◿4Id ⊙48] 32_32] [⊃[×32◿4Id ⊙24] 32_32] # From ?
  | ⊟⊃[⊃[⊃(X|-64Top)] 64_64] [⊃[⊃X 0] [64 -64Top]]  #  To ?
  )(0_0 0 get "pipes" °◌)

  DrawBottom ↚ I~Draw~Texture~Map ⊓⊃(
    ⊟⊃[⊃[×32◿4Id ⊙0] 32_32] [⊃[×32◿4Id ⊙24] 32_32]                          # From ?
  | ⊟⊃[⊃[⊃(X|Bottom)] 64_64] [⊃[⊃(X|+64Bottom)] [64 -⊙WindowHeight Bottom]] #  To ?
  )(0_0 0 get "pipes" °◌)

  Draw ← ≡⊃(DrawTop+1|DrawBottom)
└─╴

┌─╴Bird
  ~[Y ← ÷2WindowHeight|YSpeed ← 0]

  Size   ← ⊟.48
  Center ← ÷2Size
  # Assumes sprite-centered origin
  RenderRect ↚ ⊂[BirdX Y]⟜Size
  HitboxRect ← ⊟-◡⋅÷₂ ⊃(⊟BirdX +2 Y|⊟.35)

  OutOfBounds        ↚ ↥⊃<₀(>WindowHeight) Y
  CollidingWithPipes ↚ /↥ I~Collide~Rects⊓(Bird~HitboxRect|⊂≡Pipe!⊃TopRect BottomRect)

  # ? Bird Pipes
  Dead ← ↥⊃OutOfBounds CollidingWithPipes

  # ? FlapSpeed Bird
  Draw ← I~Draw~Texture~Map ⊓⊃(
    ⊓[⊟⊙0×16◿4⌊×8×I~Time ⊙16_16] RenderRect # From To ?
  | Center ×4÷WindowHeight YSpeed ◌         # Origin Angle ?
  )(get "bird" °◌)
└─╴

┌─╴State
  |Menu {HighScore}
  |Game {Bird Pipes Score HighScore}
  |GameOver {Bird Pipes Score HighScore DeathTime}

  New ← Game ⊃(
    Bird!(°⊸YSpeed JumpSpeed Bird~New)
  | ≡Pipe~Spawn +50+WindowWidth×GapsBetweenPipes⇡4
  | 0)
└─╴

HandleMenuState ← |1 (
  Bird!(Draw 0.5 New)
  I~Draw~Centered~Text Black 60 [÷2WindowWidth 180] "Uiua Bird"

  ⨬⋅"Press space to start" $"High score: _" ⊸±⊸State~Menu~HighScore
  I~Draw~Centered~Text Black 40 [÷2WindowWidth 280]

  # When space is pressed - create a new game state
  I~Key~Pressed‼@\s(State~New State~Menu~HighScore)
)

DrawScore ← I~Draw~Text Black 20 20_20 $"Score: _"

ShouldBeScored ← ×Pipe!⊃(< BirdX +64X|¬Scored)

HandleGameState ← (
  ⊸(¬Bird~Dead State~Game!⊃Bird Pipes)
  ⨬( # The bird collided with something, go to game over state and log the time of death
    State!(GameOver °Game) ⊙I~Time
  | # The bird is still alive, update the game state

    # Add speed to bird position
    ⍜State~Game~Bird Bird!(⍜Y+⟜YSpeed)

    # Increment vertical bird speed
    ⍜(Bird~YSpeed State~Game~Bird|+Gravity)

    # Move the pipes
    ⍜(≡Pipe~X State~Game~Pipes|-PipeMovementSpeed)

    # Find the number of unscored pipes that are past the screen
    # (Should normally be at most 1 at a time)
    ⟜(/+≡ShouldBeScored State~Game~Pipes)

    # Increment the score for each of them
    ⍜State~Game~Score+

    # Mark the pipes past the bird as scored
    ⍜(▽⌅⊸≡ShouldBeScored State~Game~Pipes|≡°⊸Pipe~Scored 1)

    # Remove pipes off screen
    ⍜State~Game~Pipes(▽⊸≡(>¯64Pipe~X))

    # Spawn new pipes when there aren't enough
    <4⧻⊸State~Game~Pipes
    ⍥⍜State~Game~Pipes(⊂Pipe~Spawn +240 ×3GapsBetweenPipes)

    # Draw screen
    ⟜(Pipe~Draw State~Game~Pipes)
    ⟜(Bird~Draw 1 State~Game~Bird)
    ⟜(DrawScore State~Game~Score)

    # When space is pressed - jump
    I~Key~Pressed‼@\s(°⊸(Bird~YSpeed State~Game~Bird) JumpSpeed)
  )
)

HandleGameOverState ← (
  # Add speed to bird position
  ⍜State~GameOver~Bird Bird!(
    ⍜Y+⟜YSpeed
    # If the bird goes below the screen, clamp position and
    # set speed so that the rotation is straight down
    ⤚>-⊢Center WindowHeight⊸Y
    ⨬⋅∘(°⊸YSpeed 30 ⍜⊙Y⊙◌)
  )

  # Increment vertical bird speed
  ⍜(Bird~YSpeed State~GameOver~Bird|+Gravity)

  # Draw screen
  ⟜(Pipe~Draw State~GameOver~Pipes)
  ⟜(Bird~Draw 0 State~GameOver~Bird)
  ⟜(DrawScore State~GameOver~Score)

  ⊸{⊃("Game over"
    | $"Your score: _" State~GameOver~Score
    | "Press space to restart")}
  I~Draw~Centered~Text Black 40_40_20 ⍉⊟÷₂WindowWidth +180×70⇡3

  # Draw white flash with opacity based on the time elapsed since game over
  ↥0+1-I~Time ⊸State~GameOver~DeathTime
  I~Draw~Rect ⊂White⊙(WindowWidth_WindowHeight 0_0)

  # When space is pressed - create a new game state
  ⍥(State~Menu ↥State~GameOver!⊃Score HighScore) I~Key~Pressed @\s
)

File ← $".____" Sep ThisFileDir Sep ∘

State~Menu 0
map⟜≡(I~Texture~Load File $"_.png") {"bird" "pipes"}

⬚∘I~Loop!(
  I~Draw~Background 0.4_0.7_1

  ⍣(⍩HandleMenuState ⍜°State~Menu∘
  | ⍩HandleGameState ⍜°State~Game∘
  | ⍩HandleGameOverState ⍜°State~GameOver∘
  | ⍤$"Invalid state: _":0
  )
)
