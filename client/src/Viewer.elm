module Viewer exposing (Model, Msg, delta2url, url2messages, init, update, view, subscriptions)

import Greeting.Greetings
import Html exposing (Html, div, text, map)
import Navigation exposing (Location)
import RouteUrl exposing (UrlChange)
import RouteUrl.Builder as Builder exposing (Builder)


--MODEL


type Page
    = Greetings


type alias Model =
    { greetings : Greeting.Greetings.Model
    , currentPage : Page
    }


emptyModel : Model
emptyModel =
    { greetings = Tuple.first Greeting.Greetings.init
    , currentPage = Greetings
    }


init : ( Model, Cmd Msg )
init =
    let
        model =
            emptyModel

        effects =
            Cmd.batch
                [ Cmd.map GreetingsMsg <| Tuple.second Greeting.Greetings.init ]
    in
        ( model, effects )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- UPDATE


type Msg
    = GreetingsMsg Greeting.Greetings.Msg
    | ShowPage Page
    | NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        ShowPage page ->
            { model | currentPage = page } ! []

        GreetingsMsg submsg ->
            let
                result =
                    Greeting.Greetings.update submsg model.greetings
            in
                ( { model | greetings = Tuple.first result }
                , Cmd.map GreetingsMsg <| Tuple.second result
                )



-- VIEW


view : Model -> Html Msg
view model =
    div [] [ viewMainContent model ]


viewMainContent : Model -> Html Msg
viewMainContent model =
    let
        viewPage =
            case model.currentPage of
                Greetings ->
                    map GreetingsMsg (Greeting.Greetings.view model.greetings)
    in
        div [] [ viewPage ]



-- ROUTING


delta2url : Model -> Model -> Maybe UrlChange
delta2url previous current =
    Maybe.map Builder.toUrlChange <|
        delta2builder previous current


delta2hash : Model -> Model -> Maybe UrlChange
delta2hash previous current =
    Maybe.map Builder.toHashChange <|
        delta2builder previous current


delta2builder : Model -> Model -> Maybe Builder
delta2builder previous current =
    case current.currentPage of
        Greetings ->
            Greeting.Greetings.delta2builder previous.greetings current.greetings
                |> Maybe.map (Builder.prependToPath [ "greetings" ])


url2messages : Location -> List Msg
url2messages location =
    builder2messages (Builder.fromUrl location.href)


hash2messages : Location -> List Msg
hash2messages location =
    builder2messages (Builder.fromHash location.href)


builder2messages : Builder -> List Msg
builder2messages builder =
    case Builder.path builder of
        first :: rest ->
            let
                subBuilder =
                    Builder.replacePath rest builder
            in
                case first of
                    "greetings" ->
                        (ShowPage Greetings) :: List.map GreetingsMsg (Greeting.Greetings.builder2messages subBuilder)

                    _ ->
                        [ ShowPage Greetings ]

        _ ->
            [ ShowPage Greetings ]
