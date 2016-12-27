module App.View exposing (view)

import App.Model exposing (Page(..), Model)
import App.Update exposing (Msg(..))
import Html exposing (Html, div, a, text)
import Html.Events exposing (onClick)
import Pages.PageNotFound.View
import Pages.Welcome.View


view : Model -> Html Msg
view model =
    div []
        [ viewHeader model
        , viewMainContent model
        , viewFooterContent model
        ]


viewHeader : Model -> Html Msg
viewHeader model =
    div []
        [ a [ onClick <| SetActivePage Welcome ] [ text "welcome" ]
        , text "|"
        , a [ onClick <| SetActivePage PageNotFound ] [ text "404" ]
        ]


viewMainContent : Model -> Html Msg
viewMainContent model =
    case model.activePage of
        Welcome ->
            Pages.Welcome.View.view

        PageNotFound ->
            Pages.PageNotFound.View.view


viewFooterContent : Model -> Html Msg
viewFooterContent model =
    div [] []
