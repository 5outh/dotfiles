import XMonad
import XMonad.Layout.ThreeColumns
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Hooks.ManageDocks (avoidStruts)

main = xmonad def
  { terminal = "kitty"
  , layoutHook = myLayoutHook
  }

myLayoutHook = avoidStruts . smartBorders $ Tall 1 (3/100) (1/2) ||| ThreeCol 1 (3/100) (1/3)
