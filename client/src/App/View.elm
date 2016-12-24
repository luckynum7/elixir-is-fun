module App.View exposing (view)

import App.Model exposing (Page(..), Model)
import App.Update exposing (Msg(..))
import Html exposing (Html, div)
import Pages.PageNotFound.View
import Pages.Welcome.View


view : Model -> Html Msg
view model =
    div [] [ viewMainContent model ]


viewMainContent : Model -> Html Msg
viewMainContent model =
    case model.activePage of
        Welcome ->
            Pages.Welcome.View.view

        PageNotFound ->
            Pages.PageNotFound.View.view
