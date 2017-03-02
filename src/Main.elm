module Main exposing (..)

import Navigation
import View
import Update
import Model exposing (Model)
import Msg exposing (Msg(..))
import Material
import Subscriptions


main : Program Never Model Msg
main =
    Navigation.program NavigateTo
        { init = Model.init
        , update = Update.update
        , view = View.view
        , subscriptions = Subscriptions.subscriptions
        }
