module Pages.Profile.Update exposing (init, Msg(..), update)

import Http
import Json.Decode as Decode
import Pages.Profile.Model exposing (Model, emptyModel)


-- UPDATE


type Msg
    = Greeting (Result Http.Error String)


init : ( Model, Cmd Msg )
init =
    ( emptyModel, getGreetings )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Greeting (Ok uname) ->
            { model | name = uname } ! []

        Greeting (Err _) ->
            model ! []



-- HTTP


getGreetings : Cmd Msg
getGreetings =
    let
        url =
            "http://localhost:4000/api/greeting?name=Hoffmann"
    in
        Http.send Greeting (Http.get url decodeName)


decodeName : Decode.Decoder String
decodeName =
    Decode.at [ "name" ] Decode.string
