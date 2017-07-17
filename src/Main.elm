module Main exposing (..)

import Element exposing (button, el, image, row, text)
import Element.Attributes exposing (height, justify, padding, percent, px, spacing, verticalCenter, width)
import Element.Events exposing (onClick)
import Html exposing (Html)
import Style exposing (style)



---- MODEL ----


type alias Model =
    {}


init : ( Model, Cmd Msg )
init =
    ( {}, Cmd.none )



---- VIEW ----

type Styles
    = None

stylesheet : Style.StyleSheet Styles variation
stylesheet =
    Style.stylesheet
        [ style None []
        ]


-- todo: css for buttons, layout for text article with image, variants, grid
view : Model -> Html Msg
view model =
    Element.root stylesheet <|
        row None
            [ justify, padding 20, (width << percent) 100 ]
            [ image "/logo.svg" None [(width << px) 50, (height << px) 50] (text "TODO logo")
            , row None
                [ spacing 20, verticalCenter ]
                [ button <| el None [onClick JustDebug] (text "Blog")
                , button <| el None [onClick JustDebug] (text "About")
                , button <| el None [onClick JustDebug] (text "Contacts")
                ]
            ]


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
