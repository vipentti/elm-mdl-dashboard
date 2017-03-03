module Main exposing (..)

import Navigation
import View
import Update
import Model exposing (Model)
import Msg exposing (Msg(..))
import Subscriptions
import Html
import Html.Attributes as Html
import Material.Color as Color
import Material.Scheme


main : Program Never Model Msg
main =
    Navigation.program NavigateTo
        { init = Model.init
        , update = Update.update
        , view =
            \model ->
                Html.div []
                    [ Material.Scheme.topWithScheme Color.Cyan Color.LightBlue (Html.div [] [])
                    , View.view model
                    , Html.node "script" [ Html.attribute "src" "https://cdn.polyfill.io/v2/polyfill.js?features=Event.focusin" ] []
                    , Html.node "script" [ Html.attribute "src" "https://cdnjs.cloudflare.com/ajax/libs/dialog-polyfill/0.4.4/dialog-polyfill.min.js" ] []
                    , Html.node "link"
                        [ Html.attribute "href" "https://cdnjs.cloudflare.com/ajax/libs/dialog-polyfill/0.4.4/dialog-polyfill.min.css"
                        , Html.attribute "rel" "stylesheet"
                        , Html.attribute "type" "text/css"
                        ]
                        []
                    ]
        , subscriptions = Subscriptions.subscriptions
        }
