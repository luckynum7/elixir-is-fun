module Greeting.Greetings exposing (..)

import Html exposing (Html, div, text)
import Http
import Json.Decode as Json
import RouteUrl.Builder exposing (Builder, builder, path, replacePath)


-- MODEL


type alias Model =
    { name : String
    , requestStatus : RequestStatus
    }


type RequestStatus
    = Use
    | Ignore


emptyModel : Model
emptyModel =
    { name = ""
    , requestStatus = Use
    }



-- UPDATE


init : ( Model, Cmd Msg )
init =
    emptyModel ! []


type Msg
    = Aloha
    | Greetings (Result Http.Error String)
    | NameFromLocation String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Aloha ->
            ( { model | requestStatus = Use }, getGreetings model.name )

        Greetings (Ok uname) ->
            case model.requestStatus of
                Use ->
                    { model | name = uname } ! []

                Ignore ->
                    model ! []

        Greetings (Err _) ->
            model ! []

        NameFromLocation url ->
            { model | name = url, requestStatus = Ignore } ! []



-- VIEW


view : Model -> Html Msg
view model =
    div [] [ text <| "Hello" ++ model.name ]



-- EFFECTS


getGreetings : String -> Cmd Msg
getGreetings name =
    Http.send Greetings <|
        Http.get
            ("http://localhost:4000/api/greeting?name=" ++ name)
        <|
            decodeName


decodeName : Json.Decoder String
decodeName =
    Json.at [ "name" ] Json.string


title : String
title =
    "Greetings"



-- Routing


delta2builder : Model -> Model -> Maybe Builder
delta2builder previous current =
    if current.name == (Tuple.first init).name then
        -- wait for the gif to arrive.
        Nothing
    else
        builder
            |> replacePath [ current.name ]
            |> Just


builder2messages : Builder -> List Msg
builder2messages builder =
    case path builder of
        -- If we have a gifUrl, then use it
        name :: rest ->
            [ NameFromLocation name ]

        -- Otherwise, do nothing
        _ ->
            []
