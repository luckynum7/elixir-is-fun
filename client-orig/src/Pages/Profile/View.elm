module Pages.Profile.View exposing (view)

import Html exposing (div, text, Html)
import Pages.Profile.Model exposing (Model)
import Pages.Profile.Update exposing (Msg(..))


-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ text <| "Hello" ++ model.name ]
