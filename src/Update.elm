module Update exposing (update)

import Model exposing (Model)
import Msg exposing (Msg(..))
import Material
import Material.Snackbar as Snackbar
import Navigation
import Route
import Dict


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Mdl msg' ->
      Material.update msg' model

    Snackbar msg' ->
      let
        ( snackbar, snackCmd ) =
          Snackbar.update msg' model.snackbar
      in
        { model | snackbar = snackbar } ! [ Cmd.map Snackbar snackCmd ]

    NavigateTo maybeLocation ->
      case maybeLocation of
        Nothing ->
          model ! []

        Just location ->
          model ! [ Navigation.newUrl (Route.urlFor location) ]

    GotUsers users ->
      { model | users = users } ! []

    SelectMail mail ->
      { model | selectedMail = mail } ! []

    Toggle index ->
      let
        toggles =
          case (Dict.get index model.toggles) of
            Just v ->
              Dict.insert index (not v) model.toggles

            Nothing ->
              Dict.insert index True model.toggles
      in
        { model | toggles = toggles } ! []
