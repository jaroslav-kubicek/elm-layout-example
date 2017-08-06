module TopBar exposing (topBarMobile, topBarDesktop)

import Element
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (onClick)
import Stylesheets exposing (Styles(..), stylesheet)
import MessageTypes exposing (Msg(..))

type alias MenuItem =
    { label: String
    , subItems: List String
    }

menuItems : List MenuItem
menuItems =
    [ { label = "Blog"
      , subItems =
            [ "Tech"
            , "Thoughs"
            , "Travel"
            ]
      }
    , { label = "About", subItems = [] }
    , { label = "Contacts", subItems = [] }
    ]

getSubMenuItem subMenuItem =
    el MenuDropdownItem [paddingXY 15 5] (text subMenuItem)

getMenuItem menuItem =
    let
        subMenuFn = if (List.length menuItem.subItems) == 0 then
                        \a -> a
                    else
                        \menuElement ->
                            below
                            [ column MenuDropdown
                                [center, class "dropdown-menu"]
                                (List.map getSubMenuItem menuItem.subItems)
                            ]
                            menuElement
    in
        el MenuButton
            [ onClick JustDebug
            , paddingXY 15 5
            , class "dropdown-switch"
            ]
            (text menuItem.label)
                |> button |> subMenuFn

topBarDesktop : Element.Element Styles variation Msg
topBarDesktop =
    row TopBar
        [ justify, padding 20, verticalCenter]
        [ logo
        , node "h1" <| el None [] (text "Elm")
        , desktopNav
        ]

desktopNav : Element.Element Styles variation Msg
desktopNav =
    nav <| row None
        [ spacing 20, verticalCenter ]
        (List.map getMenuItem menuItems)

topBarMobile =
    row TopBar
        [ justify, verticalCenter, paddingXY 10 5 ]
        [ row None
            [spacing 10, verticalCenter]
            [ logo
            , node "h1" <| el None [] (text "Elm")
            ]
        , mobileNav
        ]

mobileNav : Element.Element Styles variation Msg
mobileNav =
    el None [] (text "TODO")

logo =
    image "/logo.svg" None [(width << px) 50, (height << px) 50] empty
