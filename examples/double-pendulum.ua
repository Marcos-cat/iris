# Experimental!
I ~ "gh: Marcos-cat/iris" ~ Color Draw Key Window

W ← 1024

F  ← ℂ÷₂W 200
L₁ ← 250
L₂ ← 150
M₁ ← 100
M₂ ← 100
Mt ← +M₁M₂
G  ← 1000

# https://www.myphysicslab.com/pendulum/double-pendulum-en.html
Δθ ← ˜-∩⊣
Q  ← +×₂M₁+M₂ ¯×M₂∂∿×₂Δθ
θ″₁ ← ÷⊃(
  ×L₁ Q
| /+⊃[
    ¯×₂×G×Mt∿⊣
  | ¯×M₂×G∿˜-⊙×₂∩⊣
  | ¯×₂×M₂ ×⊃(∿Δθ|+⊃(
        ×L₂ⁿ₂⋅⊢
      | ×L₁×⊃(ⁿ₂⊢|∂∿˜-∩⊣)))
  ]
)
θ″₂ ← ÷⊃(
  ×L₂ Q
| ×⊃(
    ×₂∿Δθ
  | /+⊃[
      ×L₁×Mt ⁿ₂⊢
    | ×G×Mt ∂∿⊣
    | ×⊃(ⁿ₂⋅⊢|×L₂×M₂ ∂∿Δθ)]
  ))

0

[1 η] [0 η/3] # [θ₁' θ₁] [θ₂' θ₂]

I~Open W "Pendulum"
I~Loop!(
  Draw~Background Color~Base

  Window~FPS
  $$ FPS: _
  $$ Pause [Space]
  Draw~Text!°⊸Font"examples/Uiua386.ttf" Color~Red 32 ℂ16 16

  Key~Pressed‼@\s ⊙⊙¬

  ⍥(˜∩(↘₁\(+×)Window~Dt⊂) ◡⊃θ″₁ θ″₂) ⤙⊙⊙∘

  ◡[F⟜++F˜∩×L₁L₂∩(ℂ°∠⊣)]
  ⊃(Draw~Circle Color~Red ×2√ 50_M₁_M₂
  | Draw~Line Color~Red 8 ⧈⊙∘)
)
