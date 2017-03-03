module Charts exposing (..)

import Html
import Svg
import Svg.Attributes as Attr


pieChart : String -> String -> Html.Html msg
pieChart color class =
    Svg.svg
        [ Attr.fill "currentColor"
        , Attr.width "200px"
        , Attr.height "200px"
        , Attr.viewBox "0 0 1 1"
        , Attr.class "demo-chart"
        , Attr.style ("color: " ++ color ++ ";")
        , Attr.class class
        ]
        [ Svg.use
            [ Attr.xlinkHref "#piechart"
            , Attr.mask "url(#piemask)"
            ]
            []
        , Svg.text_
            [ Attr.x "0.5"
            , Attr.y "0.5"
            , Attr.fontFamily "Roboto"
            , Attr.fontSize "0.3"
            , Attr.fill "#888"
            , Attr.textAnchor "middle"
            , Attr.dy "0.1"
            ]
            [ Svg.text "82"
            , Svg.tspan
                [ Attr.fontSize "0.2"
                , Attr.dy "-0.07"
                ]
                [ Svg.text "%" ]
            ]
        ]


graph : String -> Html.Html msg
graph color =
    Svg.svg
        [ Attr.fill "currentColor"
        , Attr.viewBox "0 0 500 250"
        , Attr.class "demo-graph"
        , Attr.style ("color: " ++ color ++ ";")
        ]
        [ Svg.use
            [ Attr.xlinkHref "#chart"
            ]
            []
        ]


createDefinitions : List (Html.Html msg)
createDefinitions =
    -- Pie chart
    [ Svg.svg
        [ Attr.style "position: fixed; left: -1000px; height: -1000px"
        , Attr.version "1.1"
        ]
        [ Svg.defs []
            [ Svg.mask
                [ Attr.id "piemask"
                , Attr.maskContentUnits "objectBoundingBox"
                ]
                [ Svg.circle
                    [ Attr.cx "0.5"
                    , Attr.cy "0.5"
                    , Attr.r "0.49"
                    , Attr.fill "white"
                    ]
                    []
                , Svg.circle
                    [ Attr.cx "0.5"
                    , Attr.cy "0.5"
                    , Attr.r "0.40"
                    , Attr.fill "black"
                    ]
                    []
                ]
            , Svg.g [ Attr.id "piechart" ]
                [ Svg.circle
                    [ Attr.cx "0.5"
                    , Attr.cy "0.5"
                    , Attr.r "0.5"
                    ]
                    []
                , Svg.path
                    [ Attr.d "M 0.5 0.5 0.5 0 A 0.5 0.5 0 0 1 0.95 0.28 z"
                    , Attr.fill "rgba(255, 255, 255, 0.75)"
                    , Attr.stroke "none"
                    ]
                    []
                ]
            ]
        ]
      -- Graphs
    , Svg.svg
        [ Attr.style "position: fixed; left: -1000px; height: -1000px"
        , Attr.viewBox "0 0 500 250"
        ]
        [ chartDefinition
        ]
    ]


chartDefinition : Svg.Svg msg
chartDefinition =
    let
        line y1 x2 y2 =
            Svg.line
                [ Attr.fill "#888888"
                , Attr.stroke "#888888"
                , Attr.strokeMiterlimit "10"
                , Attr.x1 "0"
                , Attr.y1 <| y1
                , Attr.x2 <| x2
                , Attr.y2 <| y2
                ]
                []

        text number tform =
            Svg.text_
                [ Attr.fontFamily "Roboto"
                , Attr.fontSize "9"
                , Attr.fill "#888888"
                , Attr.transform tform
                ]
                [ Svg.text number ]
    in
        Svg.defs []
            [ Svg.g [ Attr.id "chart" ]
                [ Svg.g [ Attr.id "Gridlines" ]
                    [ line "27.3" "468.3" "27.3"
                    , line "66.7" "468.3" "66.7"
                    , line "105.3" "468.3" "105.3"
                    , line "144.7" "468.3" "144.7"
                    , line "184.3" "468.3" "184.3"
                    ]
                , Svg.g [ Attr.id "Numbers" ]
                    [ text "500" "matrix(1 0 0 1 485 29.3333)"
                    , text "400" "matrix(1 0 0 1 485 69)"
                    , text "300" "matrix(1 0 0 1 485 109.3333)"
                    , text "200" "matrix(1 0 0 1 485 149)"
                    , text "100" "matrix(1 0 0 1 485 188.3333)"
                    , text "1" "matrix(1 0 0 1 0 249.0003)"
                    , text "2" "matrix(1 0 0 1 78 249.0003)"
                    , text "3" "matrix(1 0 0 1 154.6667 249.0003)"
                    , text "4" "matrix(1 0 0 1 232.1667 249.0003)"
                    , text "5" "matrix(1 0 0 1 309 249.0003)"
                    , text "6" "matrix(1 0 0 1 386.6667 249.0003)"
                    , text "7" "matrix(1 0 0 1 464.3333 249.0003)"
                    ]
                , Svg.g [ Attr.id "Layer_5" ]
                    [ Svg.polygon
                        [ Attr.strokeMiterlimit "10"
                        , Attr.opacity "0.36"
                        , Attr.points "0,223.3 48,138.5 154.7,169 211,88.5 294.5,80.5 380,165.2 437,75.5 469.5,223.3"
                        ]
                        []
                    ]
                , Svg.g [ Attr.id "Layer_4" ]
                    [ Svg.polygon
                        [ Attr.strokeMiterlimit "10"
                        , Attr.points "469.3,222.7 1,222.7 48.7,166.7 155.7,188.3 212,132.7 296.7,128 380.7,184.3 436.7,125"
                        ]
                        []
                    ]
                ]
            ]
