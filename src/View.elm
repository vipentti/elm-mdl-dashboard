module View exposing (view)

import Html exposing (Html, text, div, span, form)
import Html.Attributes exposing (href, src)
import Model exposing (Model)
import Msg exposing (Msg(..))
import Material.Layout as Layout
import Material.Snackbar as Snackbar
import Material.Icon as Icon
import Material.Color as Color
import Material.Menu as Menu
import Material.Dialog as Dialog
import Material.Button as Button
import Material.Options as Options exposing (css, cs, when)
import Route exposing (Route(..))
import View.Home
import View.Users
import Charts
import Material.Scheme


styles : String
styles =
    """
   .demo-options .mdl-checkbox__box-outline {
      border-color: rgba(255, 255, 255, 0.89);
    }

   .mdl-layout__drawer {
      border: none !important;
   }

   .mdl-layout__drawer .mdl-navigation__link:hover {
      background-color: #00BCD4 !important;
      color: #37474F !important;
    }
   """


view : Model -> Html Msg
view model =
    Material.Scheme.top <|
        Layout.render Mdl
                model.mdl
                [ Layout.fixedHeader
                , Layout.fixedDrawer
                , Options.css "display" "flex !important"
                , Options.css "flex-direction" "row"
                , Options.css "align-items" "center"
                ]
                { header = [ viewHeader model ]
                , drawer = [ drawerHeader model, viewDrawer model ]
                , tabs = ( [], [] )
                , main =
                    [ viewBody model
                    , Snackbar.view model.snackbar |> Html.map Snackbar
                    , viewSource model
                    , helpDialog model
                    ] ++ Charts.createDefinitions
                }


viewHeader : Model -> Html Msg
viewHeader model =
    Layout.row
        [ Color.background <| Color.color Color.Grey Color.S100
        , Color.text <| Color.color Color.Grey Color.S900
        ]
        [ Layout.title [] [ text "elm-mdl Dashboard Example" ]
        , Layout.spacer
        , Layout.navigation []
            []
        ]


viewSource : Model -> Html Msg
viewSource model =
    Button.render Mdl
        [ 5, 6, 6, 7 ]
        model.mdl
        [ css "position" "fixed"
        , css "display" "block"
        , css "left" "100"
        , css "bottom" "0"
        , css "margin-left" "80px"
        , css "margin-bottom" "40px"
        , css "z-index" "900"
        , Color.text Color.white
        , Button.ripple
        , Button.colored
        , Button.raised
        , Options.onClick (ViewSourceClick "https://github.com/vipentti/elm-mdl-dashboard")
        ]
        [ text "View Source" ]


type alias MenuItem =
    { text : String
    , iconName : String
    , route : Maybe Route
    }


menuItems : List MenuItem
menuItems =
    [ { text = "Dashboard", iconName = "dashboard", route = Just Home }
    , { text = "Users", iconName = "group", route = Just Users }
    , { text = "Last Activity", iconName = "alarm", route = Nothing }
    , { text = "Reports", iconName = "list", route = Nothing }
    , { text = "Organizations", iconName = "store", route = Nothing }
    , { text = "Project", iconName = "view_list", route = Nothing }
    ]


viewDrawerMenuItem : Model -> MenuItem -> Html Msg
viewDrawerMenuItem model menuItem =
    let
        isCurrentLocation =
            case model.history of
                currentLocation :: _ ->
                    currentLocation == menuItem.route

                _ ->
                    False

        onClickCmd =
            case ( isCurrentLocation, menuItem.route ) of
                ( False, Just route ) ->
                    route |> Route.urlFor |> NewUrl |> Options.onClick

                _ ->
                    Options.nop
    in
        Layout.link
            [ onClickCmd
            , when isCurrentLocation (Color.background <| Color.color Color.BlueGrey Color.S600)
            , Options.css "color" "rgba(255, 255, 255, 0.56)"
            , Options.css "font-weight" "500"
            ]
            [ Icon.view menuItem.iconName
                [ Color.text <| Color.color Color.BlueGrey Color.S500
                , Options.css "margin-right" "32px"
                ]
            , text menuItem.text
            ]


viewDrawer : Model -> Html Msg
viewDrawer model =
    Layout.navigation
        [ Color.background <| Color.color Color.BlueGrey Color.S800
        , Color.text <| Color.color Color.BlueGrey Color.S50
        , Options.css "flex-grow" "1"
        ]
    <|
        (List.map (viewDrawerMenuItem model) menuItems)
            ++ [ Layout.spacer
               , Layout.link
                    [ Dialog.openOn "click"
                    ]
                    [ Icon.view "help"
                        [ Color.text <| Color.color Color.BlueGrey Color.S500
                        ]
                    ]
               ]


drawerHeader : Model -> Html Msg
drawerHeader model =
    Options.styled Html.header
        [ css "display" "flex"
        , css "box-sizing" "border-box"
        , css "justify-content" "flex-end"
        , css "padding" "16px"
        , css "height" "151px"
        , css "flex-direction" "column"
        , cs "demo-header"
        , Color.background <| Color.color Color.BlueGrey Color.S900
        , Color.text <| Color.color Color.BlueGrey Color.S50
        ]
        [ Options.styled Html.img
            [ Options.attribute <| src "images/elm.png"
            , css "width" "48px"
            , css "height" "48px"
            , css "border-radius" "24px"
            ]
            []
        , Options.styled Html.div
            [ css "display" "flex"
            , css "flex-direction" "row"
            , css "align-items" "center"
            , css "width" "100%"
            , css "position" "relative"
            ]
            [ Html.span [] [ text model.selectedMail ]
            , Layout.spacer
            , Menu.render Mdl
                [ 1, 2, 3, 4 ]
                model.mdl
                [ Menu.ripple
                , Menu.bottomRight
                , Menu.icon "arrow_drop_down"
                ]
                [ Menu.item
                    [ Menu.onSelect (SelectMail "elm.mdl@example.0") ]
                    [ text "elm.mdl@example.0" ]
                , Menu.item
                    [ Menu.onSelect (SelectMail "elm.mdl@example.1") ]
                    [ text "elm.mdl@example.1" ]
                , Menu.item
                    [ Menu.onSelect (SelectMail "elm.mdl@example.2") ]
                    [ text "elm.mdl@example.2" ]
                , Menu.item
                    [ Menu.onSelect (SelectMail "elm.mdl@example.3") ]
                    [ text "elm.mdl@example.3" ]
                ]
            ]
        ]


viewBody : Model -> Html Msg
viewBody model =
    case model.history |> List.head |> Maybe.withDefault Nothing of
        Just (Route.Home) ->
            View.Home.view model

        Just (Route.Users) ->
            View.Users.view model

        Nothing ->
            text "404"


helpDialog : Model -> Html Msg
helpDialog model =
    Dialog.view
        []
        [ Dialog.title [] [ text "About" ]
        , Dialog.content []
            [ Html.p []
                [ text "elm-mdl is awesome." ]
            , Html.p []
                [ text "it really is." ]
            ]
        , Dialog.actions []
            [ Options.styled Html.span
                [ Dialog.closeOn "click" ]
                [ Button.render Mdl
                    [ 5, 1, 6 ]
                    model.mdl
                    [ Button.ripple
                    ]
                    [ text "Close" ]
                ]
            ]
        ]
