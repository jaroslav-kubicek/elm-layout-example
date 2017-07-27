module Main exposing (..)

import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events exposing (on, onClick, onMouseOut, onMouseOver)
import Html exposing (Html)
import List exposing (map)
import Window
import RandomArticle exposing (firstParagraph, secondParagraph, subtitle)
import Stylesheets exposing (Styles(..), stylesheet)
import MessageTypes exposing (Msg(..))
import TopBar exposing (..)

(=>) : a -> b -> ( a, b )
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

-- TODO responsiveness
view : Model -> Html Msg
view model =
    Element.layout stylesheet <|
        namedGrid Root
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
    case device of
                Just device ->
                    if device.phone || device.tablet then
                        mobileNav
                    else
                        topBarDesktop
                Nothing -> topBarDesktop

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
        (List.map
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
        [ el EventTitle [paddingXY 10 5] (text event.title)
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

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        JustDebug ->
            let
                _ = Debug.log "info" "We do nothing, just view."
            in
                ( model, Cmd.none )
        Resize size ->
            let
                device = classifyDevice size
            in
                ( { model | device = Just device }, Cmd.none)


---- SUBSCRIPTIONS

subscriptions model =
    Window.resizes Resize

---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
