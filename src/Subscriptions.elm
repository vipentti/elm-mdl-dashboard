module Subscriptions exposing (subscriptions)

import Material
import Model exposing (Model)
import Msg exposing (Msg(..))


subscriptions : Model -> Sub Msg
subscriptions model =
    Material.subscriptions Mdl model
