module Model exposing (Model, init)

import Msg exposing (Msg(Mdl))
import Material
import Material.Snackbar as Snackbar
import Route
import Types exposing (User)
import Dict exposing (Dict)


type alias Model =
  { mdl : Material.Model
  , snackbar : Snackbar.Model (Maybe Msg)
  , route : Route.Model
  , users : List User
  , toggles : Dict (List Int) Bool
  , selectedMail : String
  }


initialModel : Maybe Route.Location -> Model
initialModel location =
  { mdl = Material.model
  , snackbar = Snackbar.model
  , route = Route.init location
  , users = mockUsers
  , toggles = Dict.empty
  , selectedMail = "elm.mdl@example.0"
  }


init : Maybe Route.Location -> ( Model, Cmd Msg )
init location =
  (initialModel location) ! [ Material.init Mdl ]


mockUsers : List User
mockUsers =
  [
  ]
