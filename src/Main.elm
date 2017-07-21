module Main exposing (..)

import Element exposing (Element, Device, area, below, button, column, el, grid, image, named, namedGrid, nav, node, row, span, spanAll, text, textLayout, when)
import Element.Attributes exposing (center, fill, height, hidden, justify, padding, percent, px, spacing, verticalCenter, width)
import Element.Events exposing (onClick, onMouseEnter, onMouseLeave)
import Html exposing (Html)
import RandomArticle exposing (firstParagraph, secondParagraph, subtitle)
import Style exposing (hover, prop, style)


(=>) =
    (,)

---- MODEL ----

type MenuItem
    = Blog
    | About
    | Contacts

type ExpandedItem = Expand MenuItem Bool


type alias Model =
    { device: Maybe Device
    , expandedMenuItem: ExpandedItem
    }


init : ( Model, Cmd Msg )
init =
    ( {device = Nothing, expandedMenuItem = Expand Blog False}, Cmd.none )



---- VIEW ----

type Styles
    = None
    | DropDown

stylesheet : Style.StyleSheet Styles variation
stylesheet =
    Style.stylesheet
        [ style None []
        ]


-- todo: css for buttons, layout for text article with image, variants, grid
view : Model -> Html Msg
view model =
    Element.layout stylesheet <|
        namedGrid None
            { columns = [fill 1, px 200]
            , rows =
                [ px 90 => [spanAll "header"]
                , fill 1 => [span 1 "content", span 1 "sidebar"]
                , px 100 => [spanAll "footer"]
                ]
            }
            []
            [ named "header" (topBar model.device model.expandedMenuItem)
            , named "content" content
            , named "footer" footer
            ]


topBar : Maybe Device -> ExpandedItem -> Element.Element Styles variation Msg
topBar device expandedMenuItem =
    row None
        [ justify, padding 20, (width << percent) 100 ]
        [ image "/logo.svg" None [(width << px) 50, (height << px) 50] (text "TODO logo")
        , node "h1" <| el None [verticalCenter] (text "Elm")
        , case device of
            Just device ->
                if device.phone || device.tablet then
                    mobileNav
                else
                    desktopNav expandedMenuItem
            Nothing -> desktopNav expandedMenuItem
        ]

mobileNav =
    el None [] (text "TODO")

desktopNav expandedMenuItem =
    nav <| row None
        [ spacing 20, verticalCenter ]
        [ el None
            [ onClick JustDebug
            , onMouseEnter (OnMenuItemExpand Blog True)
            , onMouseLeave (OnMenuItemExpand Blog False)
            ]
            (text "Blog") |> button
                |> below
                    [ column None (getSubmenuAttributes Blog expandedMenuItem)
                        [ el None [] (text "Tech")
                        , el None [] (text "Thoughs")
                        , el None [] (text "Travel")
                        ]
                    ]
        , button <| el None [onClick JustDebug] (text "About")
        , button <| el None [onClick JustDebug] (text "Contacts")
        ]

getSubmenuAttributes menuItem expandedMenuItem =
     if expandedMenuItem == Expand menuItem True then
        [center]
     else
        [center, hidden ]

content =
    textLayout None
        [padding 50, spacing 10]
        [ node "h2" <| el None [] (text "The Style Elements Library!")
        , el None [] (text firstParagraph)
        , node "h3" <| el None [] (text subtitle)
        , el None [] (text secondParagraph)
        ]

footer =
    el None
        [padding 20]
        (text "{by kubajz}")

---- UPDATE ----


type Msg
    = JustDebug
    | OnMenuItemExpand MenuItem Bool


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        JustDebug ->
            let
                _ = Debug.log "info" "We do nothing, just view."
            in
                ( model, Cmd.none )
        OnMenuItemExpand menuItem isExpanded ->
                ( {model | expandedMenuItem = Expand menuItem isExpanded}, Cmd.none )

---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
