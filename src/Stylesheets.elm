module Stylesheets exposing (stylesheet, Styles(..))

import Color exposing (rgba)
import Style exposing (hover, prop, style)
import Style.Color as Color
import Style.Border as Border
import Style.Font as Font
import Style.Scale as Scale

scaled =
    Scale.modular 16 1.2

type Styles
    = None
    | Root
    | TopBar
    | MenuButton
    | MenuDropdown
    | MenuDropdownItem
    | EventStyle
    | EventTitle

stylesheet : Style.StyleSheet Styles variation
stylesheet =
    Style.stylesheet
        [ style None []
        , style Root
            [ Font.typeface ["courier"]
            , Font.size (scaled 1)
            ]
        , style TopBar
            [ Color.background (rgba 230 230 230 0.5)
            ]
        , style MenuButton
            [ Color.background Color.white
            , Color.border (rgba 0 160 160 0.7)
            , Color.text (rgba 0 160 160 0.7)
            , Border.all 1
            , Border.rounded 3
            , Style.cursor "pointer"
            ]
        , style MenuDropdown
            [ Color.background (rgba 255 255 255 0.7)
            , Color.border (rgba 0 160 160 0.7)
            , Border.all 1
            , Border.rounded 3
            , Style.cursor "pointer"
            , prop "z-index" "1"
            ]
        , style MenuDropdownItem
            [ hover
                [ Color.background (rgba 0 160 160 0.7)
                , Color.text Color.white
                ]
            ]
        , style EventStyle
            [ Border.all 1
            , Color.border (rgba 0 200 200 0.5)
            , Font.size (scaled -1)
            ]
        , style EventTitle
            [ Color.background (rgba 0 200 200 0.1)
            , Font.bold
            ]
        ]
