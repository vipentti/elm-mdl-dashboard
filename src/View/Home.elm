module View.Home exposing (view)

import Model exposing (Model)
import Msg exposing (Msg(..))
import Html exposing (Html, text, div, span)
import Material.Grid as Grid exposing (grid, size, cell, Device(..))
import Material.Elevation as Elevation
import Material.Card as Card
import Material.Color as Color
import Material.Button as Button
import Material.Button as Button
import Material.Toggles as Toggles
import Material.Options as Options exposing (when, css)
import String
import Charts
import Dict


toClass : List (Options.Property () a) -> String
toClass options =
    -- let
    --     summary =
    --         Options.collect ()
    --             options
    -- in
    --     summary.classes
    []
        |> String.join " "


view : Model -> Html Msg
view model =
    let
        pieClass =
            toClass
                [ size All 4
                , size Desktop 3
                ]
    in
        grid [ Options.css "max-width" "1080px" ]
            [ cell
                [ size All 12
                , Elevation.e2
                , Options.css "align-items" "center"
                , Options.cs "mdl-grid"
                ]
                [ Charts.pieChart "#ACEC00" pieClass
                , Charts.pieChart "#00BBD6" pieClass
                , Charts.pieChart "#BA65C9" pieClass
                , Charts.pieChart "#EF3C79" pieClass
                ]
            , cell
                [ size All 8
                , Elevation.e2
                , Options.css "padding" "16px 32px"
                , Options.css "display" "flex"
                , Options.css "flex-direction" "column"
                , Options.css "align-items" "stretch"
                ]
                [ Charts.graph "#00b9d8"
                , Charts.graph "#d9006e"
                ]
            , cell
                [ size All 4
                , size Tablet 8
                ]
                [ grid [ Grid.noSpacing ]
                    [ cell
                        [ size All 4
                        , size Tablet 4
                        , size Desktop 12
                        ]
                        [ updatesCard model
                        , Options.div
                            [ size All 1
                            , css "height" "32px"
                            ]
                            []
                        , optionsCard model
                        ]
                    ]
                ]
            ]


white : Options.Property a b
white =
    Color.text Color.white


updatesCard : Model -> Html Msg
updatesCard model =
    Card.view
        [ Elevation.e2
        , css "width" "100%"
        ]
        [ Card.title
            [ css "background" "url('images/pomegranate.jpg') center / cover"
            , css "min-height" "200px"
            , css "padding" "0"
              -- Clear default padding to encompass scrim
            , Color.background <| Color.color Color.Teal Color.S300
            ]
            [ Card.head
                [ white
                , Options.scrim 0.75
                , css "padding" "16px"
                  -- Restore default padding inside scrim
                , css "width" "100%"
                ]
                [ text "Grenadine" ]
            ]
        , Card.text []
            [ text "Non-alcoholic syrup used for both its tart and sweet flavour as well as its deep red color." ]
        , Card.actions
            [ Card.border ]
            [ Button.render Mdl
                [ 1, 0 ]
                model.mdl
                [ Button.ripple, Button.accent ]
                [ text "Ingredients" ]
            ]
        ]


optionsCard : Model -> Html Msg
optionsCard model =
    let
        option title index =
            Options.styled Html.li
                [ css "margin" "4px 0" ]
                [ Toggles.checkbox Mdl
                    index
                    model.mdl
                    [ Toggles.ripple
                    , Toggles.value (Maybe.withDefault False (Dict.get index model.toggles))
                    , Options.onToggle (Toggle index)
                    ]
                    [ text title ]
                ]
    in
        Card.view
            [ css "width" "100%"
            , Color.background (Color.color Color.Pink Color.S500)
            , Options.cs "demo-options"
            ]
            [ Card.text [ white ]
                [ Options.styled Html.h3
                    [ css "font-size" "1em"
                    , css "margin" "0"
                    ]
                    [ text "Options"
                    ]
                , Options.styled Html.ul
                    [ css "list-style-type" "none"
                    , css "margin" "0"
                    , css "padding" "0"
                    ]
                    [ option "Clicks per object" [ 0 ]
                    , option "Views per object" [ 1 ]
                    , option "Objects selected" [ 2 ]
                    , option "Objects viewed" [ 3 ]
                    ]
                ]
            , Card.actions
                [ Card.border ]
                [ Button.render Mdl
                    [ 1, 1 ]
                    model.mdl
                    [ Button.ripple, white ]
                    [ text "Awesome" ]
                ]
            ]
