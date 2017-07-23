module Main exposing (..)

import Element exposing (Device, Element, area, below, button, column, el, grid, image, named, namedGrid, nav, node, onRight, row, span, spanAll, text, textLayout, when, wrappedColumn)
import Element.Attributes exposing (alignRight, center, class, fill, height, hidden, justify, padding, percent, px, spacing, verticalCenter, width)
import Element.Events exposing (on, onClick, onMouseOut, onMouseOver)
import Html exposing (Html)
import RandomArticle exposing (firstParagraph, secondParagraph, subtitle)
import Style exposing (hover, prop, style)

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

type Styles
    = None
    | DropDown

stylesheet : Style.StyleSheet Styles variation
stylesheet =
    Style.stylesheet
        [ style None []
        ]

-- TODO responsiveness, styles for buttons & text
view : Model -> Html Msg
view model =
    Element.layout stylesheet <|
        namedGrid None
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
    row None
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
        [ el None
            [ onClick JustDebug
            , class "dropdown-switch"
            ]
            (text "Blog") |> button
                |> below
                    [ column None [center, class "dropdown-menu"]
                        [ el None [] (text "Tech")
                        , el None [] (text "Thoughs")
                        , el None [] (text "Travel")
                        ]
                    ]
        , button <| el None [onClick JustDebug] (text "About")
        , button <| el None [onClick JustDebug] (text "Contacts")
        ]

content =
    textLayout None
        [padding 50, spacing 10]
        [ node "h2" <| el None [] (text "The Style Elements Library!")
        , el None [] (text firstParagraph)
        , node "h3" <| el None [] (text subtitle)
        , el None [] (text secondParagraph)
        ]

sidebar =
    column None
        [ padding 10, spacing 10 ]
        [ renderEvent
            { title = "Workshop | Project: Arduino"
            , image = "http://bit.ly/2unYcY9"
            , date = "26. 7. 2017 18:00"
            }
        , renderEvent
            { title = "Future Port Prague 2017"
            , image = "http://bit.ly/2uOfmPg"
            , date = "7. 9. 2017 9:00 - 22:00"
            }
        ]

renderEvent : Event -> Element Styles variation msg
renderEvent event =
    column None
        []
        [ el None [] (text event.title)
        , image event.image None [(width << percent) 100] (text event.title)
        , row None
            [justify, verticalCenter, (width << percent) 100]
            [ el None [] (text event.date)
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
