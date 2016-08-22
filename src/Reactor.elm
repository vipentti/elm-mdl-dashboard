module Main exposing (..)

import Navigation
import View
import Update
import Model exposing (Model)
import Types exposing (User)
import Route
import Msg exposing (Msg(..))
import Task
import Material
import Html
import Html.Attributes as Html
import Material.Color as Color
import Material.Scheme


main : Program Never
main =
  Navigation.program (Navigation.makeParser Route.locFor)
    { init = Model.init
    , update = Update.update
    , urlUpdate = urlUpdate
    , view =
      \model ->
        Html.div []
          [ Material.Scheme.topWithScheme Color.Cyan Color.LightBlue (Html.div [] [])
          , View.view model


          , Html.node "script"
              [ Html.attribute "src" "https://cdn.polyfill.io/v2/polyfill.js?features=Event.focusin" ]
              []

          , Html.node "script"
              [ Html.attribute "src" "https://cdnjs.cloudflare.com/ajax/libs/dialog-polyfill/0.4.4/dialog-polyfill.min.js" ]
              []

          , Html.node "link"
              [ Html.attribute "href" "https://cdnjs.cloudflare.com/ajax/libs/dialog-polyfill/0.4.4/dialog-polyfill.min.css"
              , Html.attribute "rel" "stylesheet"
              , Html.attribute "type" "text/css"
              ]
              []
          ]

    , subscriptions = subscriptions
    }


subscriptions : Model -> Sub Msg
subscriptions model =
  Material.subscriptions Mdl model


urlUpdate : Maybe Route.Location -> Model -> ( Model, Cmd Msg )
urlUpdate route model =
  let
    newModel =
      { model | route = route }
  in
    case route of
      Just (Route.Users) ->
        -- Pretend we did an API call and it got us some new users
        newModel ! [ fetchUsers newModel ]

      _ ->
        newModel ! []


mockUser : User
mockUser =
  { name = "Jumpy McFiddlepants" }


fetchUsers : Model -> Cmd Msg
fetchUsers newModel =
  Task.perform
    (always <| GotUsers (mockUser :: newModel.users))
    (always <| GotUsers (mockUser :: newModel.users))
    (Task.succeed ())
