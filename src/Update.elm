module Update exposing (update)

import Model exposing (Model)
import Msg exposing (Msg(..))
import Types exposing (User)
import Material
import Material.Snackbar as Snackbar
import Navigation
import Route exposing (Route)
import Dict
import Ports
import Task


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Mdl msg_ ->
            Material.update Mdl msg_ model

        Snackbar msg_ ->
            let
                ( snackbar, snackCmd ) =
                    Snackbar.update msg_ model.snackbar
            in
                { model | snackbar = snackbar } ! [ Cmd.map Snackbar snackCmd ]

        NavigateTo location ->
            location
                |> Route.locFor
                |> urlUpdate model

        NewUrl url ->
            model ! [ Navigation.newUrl url ]

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

        ViewSourceClick url ->
            model ! [ Ports.windowOpen url ]


urlUpdate : Model -> Maybe Route -> ( Model, Cmd Msg )
urlUpdate model route =
    let
        newModel =
            { model | history = route :: model.history }
    in
        case route of
            Just (Route.Users) ->
                -- Pretend we did an API call and it got us some new users
                newModel ! [ fetchUsers newModel ]

            _ ->
                newModel ! []


fetchUsers : Model -> Cmd Msg
fetchUsers newModel =
    Task.perform
        (always <| GotUsers (mockUser :: newModel.users))
        (Task.succeed ())


mockUser : User
mockUser =
    { name = "Jumpy McFiddlepants" }
