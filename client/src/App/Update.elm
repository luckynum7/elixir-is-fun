module App.Update exposing (init, Msg(..), update, subscriptions)

import App.Model exposing (Page(..), Model, emptyModel)


init : ( Model, Cmd Msg )
init =
    emptyModel ! []



-- UPDATE


type Msg
    = SetActivePage Page


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetActivePage page ->
            { model | activePage = page } ! []



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
