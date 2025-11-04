# Experimental!
I ~ "gh: Marcos-cat/iris"

DrawCursor ← (
  # Gray if the mouse is up, Green if down
  ⨬([0.5 0.5 0.5]|Green) I~Mouse!(Down Left_Right)
  # Draw sectors with a radius of 30, starting at the top, and half a circle
  I~Draw~Circle!°⊸Angle ⊟⊸¯ 1/2 ⊙30
)

DrawTrail ← I~Draw~Line Red 5 ⧈⊙∘

I~Open 640_480 "Iris mouse example"
I~Window!°FPS 60 # Set the FPS with °FPS

[] # trail path

I~Loop!(
  I~Draw~Background "#87CEEB" # Skyblue
  # Add mouse position to the trail
  ⬚0↙20 ⊂I~Mouse~Pos
  ⊸⊃(DrawTrail|DrawCursor⊢)
)
