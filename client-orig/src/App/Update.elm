module App.Update exposing (init, Msg(..), update, subscriptions)

import App.Model exposing (Page(..), Model, emptyModel)
import Pages.Profile.Update exposing (Msg(..))


-- UPDATE


type Msg
    = PageProfile Pages.Profile.Update.Msg
    | SetActivePage Page


init : ( Model, Cmd Msg )
init =
    emptyModel ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PageProfile subMsg ->
            let
                ( updatedProfileModel, profileCmd ) =
                    Pages.Profile.Update.update subMsg model.pageProfile
            in
                ( { model | pageProfile = updatedProfileModel }
                , Cmd.map PageProfile profileCmd
                )

        SetActivePage page ->
            { model | activePage = page } ! []



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
