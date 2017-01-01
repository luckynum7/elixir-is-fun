module Greeting.Greetings exposing (Model, model, init, Msg(..), update, view, title, delta2builder, builder2messages)

import Html exposing (Html, div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Http
import Json.Decode as Json
import Material
import Material.Button as Button
import Material.Options as Options
import Material.Scheme
import RouteUrl.Builder exposing (Builder, builder, path, replacePath)


-- MODEL


type alias Model =
    { name : String
    , requestStatus : RequestStatus
    , mdl : Material.Model
    }


type RequestStatus
    = Use
    | Ignore


model : Model
model =
    { name = ""
    , requestStatus = Use
    , mdl = Material.model
    }



-- UPDATE


init : ( Model, Cmd Msg )
init =
    ( model
    , getGreetings model.name
    )


type Msg
    = Aloha
    | Greetings (Result Http.Error String)
    | NameFromLocation String
    | Mdl (Material.Msg Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Aloha ->
            ( { model | requestStatus = Use }, getGreetings "Hoffmann" )

        Greetings (Ok uname) ->
            case model.requestStatus of
                Use ->
                    { model | name = uname } ! []

                Ignore ->
                    model ! []

        Greetings (Err _) ->
            { model | name = "<Error>" } ! []

        NameFromLocation url ->
            { model | name = url, requestStatus = Ignore } ! []

        Mdl msg_ ->
            Material.update Mdl msg_ model



-- VIEW


type alias Mdl =
    Material.Model


view : Model -> Html Msg
view model =
    div [ style [ ( "padding", "2rem" ) ] ]
        [ div []
            [ text <| "Hello " ++ model.name ]
        , div
            []
            -- [ a [ onClick Aloha ] [ text "Aloha!" ] ]
            [ Button.render Mdl
                [ 0 ]
                model.mdl
                [ Options.onClick Aloha ]
                [ text "Aloha!" ]
            ]
        ]
        |> Material.Scheme.top



-- EFFECTS


getGreetings : String -> Cmd Msg
getGreetings name =
    Http.send Greetings <|
        Http.get
            ("http://127.0.0.1:4000/api/greeting?name=" ++ name)
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
