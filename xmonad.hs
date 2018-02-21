import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig(additionalKeys, additionalKeysP)
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.SpawnOnce
import XMonad.Config.Desktop
import XMonad.Config.Gnome
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import System.IO
import Graphics.X11.ExtraTypes.XF86
import Data.Default

main = do
  xmproc <- spawnPipe "xmobar /home/patrick/.xmobarrc"
  -- xmproc <- spawnPipe "/home/patrick/.config/polybar/launch.sh"
  -- xmproc <- spawnPipe "tint2"
  -- nm <- spawnPipe "nm-applet"
  -- autostart <- spawnOnce "bash $HOME/.xmonad/autostart.sh"

  xmonad $ desktopConfig
    { modMask = myModMask
    , terminal = "termite"
    , borderWidth = 1 
    , layoutHook = avoidStruts $ layoutHook def
    , handleEventHook    = handleEventHook def <+> docksEventHook
    , manageHook = manageHook def <+> manageDocks <+> myManageHook
    , startupHook = do 
                setWMName "LG3D"
                docksStartupHook
    -- , startupHook = do
              -- spawnOnce "bash /home/patrick/.xmonad/autostart.sh"
              -- spawnOnce "echo $HOME > /home/patrick/test.txt"
    , logHook = dynamicLogWithPP xmobarPP
      { ppOutput = hPutStrLn xmproc
      , ppTitle = xmobarColor "green" "" . shorten 50
      }
    } `additionalKeysP` myKeys

myModMask = mod4Mask -- Use Super instead of Alt

myManageHook = composeAll
  [ isDialog     --> doCenterFloat
  , isFullscreen --> doFullFloat
  ]

myKeys =  [ ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +1.5%")
          , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@  -1.5%")
          , ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")    

          , ("<XF86AudioPlay>", spawn "playerctl play-pause")    
          , ("<XF86AudioPrev>", spawn "playerctl previous")    
          , ("<XF86AudioNext>", spawn "playerctl next")    
          
          , ("<XF86MonBrightnessUp>", spawn "lux -a 5%")    
          , ("<XF86MonBrightnessDown>", spawn "lux -s 5%")    

          , ("M-S-l", spawn "i3lock -c 000000")
          ]
