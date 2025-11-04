# Experimental!
I ~ "gh: Marcos-cat/iris" ~ Color Draw Key Window

W ← 1024

~P [
  θ₁ ← η
  θ₂ ← η/3
  θ′₁ ← 0
  θ′₂ ← ¯8
  L₁ ← 250
  L₂ ← 150
  M₁ ← 100
  M₂ ← 500
  G ← 1e3
]

~S [
  Play ← 0
  Edit ← ∞
]

F ← ℂ÷₂W 200

# https://www.myphysicslab.com/pendulum/double-pendulum-en.html
Δθ ← -P!⊃θ₂ θ₁
Q  ← /+P!⊃[×2M₁|M₂|¯×⊃(M₂|∂∿×2Δθ)]
θ″₁ ← ÷P!⊃(
  ×⊃L₁ Q
| /+⊃[
    ¯/×⊃[G|+×2⊃M₁ M₂|∿θ₁]
  | ¯/×⊃[M₂|G|∿-×2⊃θ₂ θ₁]
  | ¯/×⊃[
      2 | ∿Δθ | M₂
    | +⊃(×⊃(ⁿ₂θ′₂|L₂)|/×⊃[ⁿ₂θ′₁|L₁|∂∿Δθ])]
  ]
)
θ″₂ ← ÷P!⊃(
  ×⊃L₂ Q
| /×⊃[
    2 | ∿Δθ
  | /+⊃[
      /×⊃[ⁿ₂θ′₁|L₁|+⊃M₁ M₂]
    | /×⊃[G|+⊃M₁ M₂|∂∿θ₁]
    | /×⊃[ⁿ₂θ′₂|L₂|M₂|∂∿Δθ]]
  ]
)

Sim ← P!⍜(
  ⊙⊙(∩⊟⊃(θ′₁|θ₁|θ′₂|θ₂))
| ˜∩(↘₁\(+×)Window~Dt⊂)
) ⊸⊃θ″₁ θ″₂

Pos ← \+[F∩(×ℂ°∠)P!⊃(θ₁|L₁|θ₂|L₂)]

P S

I~Open W "Pendulum"
I~Loop!(
  Draw~Background Color~Base

  ⊸P!⊃(Window~FPS|M₁|M₂|L₁|L₂|G)
  $$ FPS: _
  $$ M1 M2: _ _ 
  $$ L1 L2: _ _ 
  $$ G: _
  $$ Pause [Space]
  Draw~Text!°⊸Font"examples/Uiua386.ttf" Color~Red 32 ℂ16 16
  ⊙S!(
    Key~Pressed‼@\s⍜Play¬
    °⊸Edit ⬚∞⊢⊚ Key~Down "12345"
  )

  ⊸≠∞◡⋅S~Edit
  P!⨬◌⍜⨬(M₁|M₂|L₁|L₂|G)(⁅+×Window~Dt×500/-Key~Down "jk")
  P!⍜⊃(M₁|M₂|L₁|L₂|G)∩₅(↥10)
  ⍥Sim◡⋅S~Play

  ⊸⊃(
    Draw~Circle Color~Red ⊃(⊂20 √⊟P!⊃M₁ M₂|Pos)
  | Draw~Line Color~Red 8 ⧈⊙∘ Pos
  )
)
