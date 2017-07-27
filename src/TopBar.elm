module TopBar exposing (..)

import Element
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onClick)
import Stylesheets exposing (Styles(..), stylesheet)
import MessageTypes exposing (Msg(..))

topBarDesktop : Element.Element Styles variation Msg
topBarDesktop =
    row TopBar
        [ justify, padding 20, (width << percent) 100 ]
        [ image "/logo.svg" None [(width << px) 50, (height << px) 50] (text "TODO logo")
        , node "h1" <| el None [verticalCenter] (text "Elm")
        , desktopNav
        ]

desktopNav =
    nav <| row None
        [ spacing 20, verticalCenter ]
        [ el MenuButton
            [ onClick JustDebug
            , paddingXY 15 5
            , class "dropdown-switch"
            ]
            (text "Blog") |> button
                |> below
                    [ column MenuDropdown [center, class "dropdown-menu"]
                        [ el MenuDropdownItem [paddingXY 15 5] (text "Tech")
                        , el MenuDropdownItem [paddingXY 15 5] (text "Thoughs")
                        , el MenuDropdownItem [paddingXY 15 5] (text "Travel")
                        ]
                    ]
        , el MenuButton
            [ onClick JustDebug
            , paddingXY 15 5
            ]
            (text "About") |> button
        , el MenuButton
            [ onClick JustDebug
            , paddingXY 15 5
            ]
            (text "Contacts") |> button
        ]

mobileNav =
    el None [] (text "TODO")
