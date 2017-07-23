module Main exposing (..)

import Color exposing (rgba)
import Element exposing (Device, Element, area, below, button, column, el, grid, image, named, namedGrid, nav, node, onRight, row, span, spanAll, text, textLayout, when, wrappedColumn)
import Element.Attributes exposing (alignRight, center, class, fill, height, hidden, justify, padding, paddingXY, percent, px, spacing, verticalCenter, width)
import Element.Events exposing (on, onClick, onMouseOut, onMouseOver)
import Html exposing (Html)
import List exposing (map)
import RandomArticle exposing (firstParagraph, secondParagraph, subtitle)
import Style exposing (hover, prop, style)
import Style.Color as Color
import Style.Border as Border
import Style.Font as Font
import Style.Scale as Scale

(=>) =
    (,)

---- MODEL ----

type alias Model =
    { device: Maybe Device
    }

type alias Event =
    { title: String
    , image: String
    , date: String
    }

init : ( Model, Cmd Msg )
init =
    ( {device = Nothing}, Cmd.none )


---- VIEW ----

scaled =
    Scale.modular 16 1.2

type Styles
    = None
    | RootStyle
    | TopBarStyle
    | MenuButtonStyle
    | MenuDropdownStyle
    | MenuDropdownItem
    | EventStyle
    | EventTitleStyle

stylesheet : Style.StyleSheet Styles variation
stylesheet =
    Style.stylesheet
        [ style None []
        , style RootStyle
            [ Font.typeface ["courier"]
            , Font.size (scaled 1)
            ]
        , style TopBarStyle
            [ Color.background (rgba 230 230 230 0.5)
            ]
        , style MenuButtonStyle
            [ Color.background Color.white
            , Color.border (rgba 0 160 160 0.7)
            , Color.text (rgba 0 160 160 0.7)
            , Border.all 1
            , Border.rounded 3
            , Style.cursor "pointer"
            ]
        , style MenuDropdownStyle
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
        , style EventTitleStyle
            [ Color.background (rgba 0 200 200 0.1)
            , Font.bold
            ]
        ]

-- TODO responsiveness, styles for buttons & text
view : Model -> Html Msg
view model =
    Element.layout stylesheet <|
        namedGrid RootStyle
            { columns = [fill 1, px 250]
            , rows =
                [ px 90 => [spanAll "header"]
                , fill 1 => [span 1 "content", span 1 "sidebar"]
                , px 100 => [spanAll "footer"]
                ]
            }
            []
            [ named "header" (topBar model.device)
            , named "content" content
            , named "sidebar" sidebar
            , named "footer" footer
            ]

topBar : Maybe Device -> Element.Element Styles variation Msg
topBar device =
    row TopBarStyle
        [ justify, padding 20, (width << percent) 100 ]
        [ image "/logo.svg" None [(width << px) 50, (height << px) 50] (text "TODO logo")
        , node "h1" <| el None [verticalCenter] (text "Elm")
        , case device of
            Just device ->
                if device.phone || device.tablet then
                    mobileNav
                else
                    desktopNav
            Nothing -> desktopNav
        ]

mobileNav =
    el None [] (text "TODO")

desktopNav =
    nav <| row None
        [ spacing 20, verticalCenter ]
        [ el MenuButtonStyle
            [ onClick JustDebug
            , paddingXY 15 5
            , class "dropdown-switch"
            ]
            (text "Blog") |> button
                |> below
                    [ column MenuDropdownStyle [center, class "dropdown-menu"]
                        [ el MenuDropdownItem [paddingXY 15 5] (text "Tech")
                        , el MenuDropdownItem [paddingXY 15 5] (text "Thoughs")
                        , el MenuDropdownItem [paddingXY 15 5] (text "Travel")
                        ]
                    ]
        , el MenuButtonStyle
            [ onClick JustDebug
            , paddingXY 15 5
            ]
            (text "About") |> button
        , el MenuButtonStyle
            [ onClick JustDebug
            , paddingXY 15 5
            ]
            (text "Contacts") |> button
        ]

content =
    textLayout None
        [paddingXY 30 50, spacing 10]
        [ node "h2" <| el None [] (text "The Style Elements Library!")
        , el None [] (text firstParagraph)
        , node "h3" <| el None [] (text subtitle)
        , el None [] (text secondParagraph)
        ]

sidebar =
    column None
        [ padding 20, spacing 10 ]
        (map
            renderEvent
            [ { title = "Workshop | Arduino"
              , image = "http://bit.ly/2unYcY9"
              , date = "26. 7. 2017 18:00"
              }
            ,
              { title = "Future Port Prague 2017"
              , image = "http://bit.ly/2uOfmPg"
              , date = "7. 9. 2017 9:00 - 22:00"
              }
            ])

renderEvent : Event -> Element Styles variation msg
renderEvent event =
    column EventStyle
        []
        [ el EventTitleStyle [paddingXY 10 5] (text event.title)
        , image event.image None [(width << percent) 100] (text event.title)
        , row None
            [justify, verticalCenter, (width << percent) 100]
            [ el None [paddingXY 10 5] (text event.date)
            , el None [] (text "Sign up") |> button
            ]
        ]

footer =
    el None
        [padding 20]
        (text "{by kubajz}")

---- UPDATE ----


type Msg
    = JustDebug


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        JustDebug ->
            let
                _ = Debug.log "info" "We do nothing, just view."
            in
                ( model, Cmd.none )

---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
