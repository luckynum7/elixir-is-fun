module App.Router exposing (delta2url, hash2messages)

import App.Model exposing (Page(..), Model)
import App.Update exposing (Msg(..))
import Navigation exposing (Location)
import RouteUrl exposing (HistoryEntry(..), UrlChange)


delta2url : Model -> Model -> Maybe UrlChange
delta2url previous current =
    case current.activePage of
        Welcome ->
            Just <| UrlChange NewEntry "/#welcome"

        PageNotFound ->
            Just <| UrlChange NewEntry "/#404"


hash2messages : Location -> List Msg
hash2messages location =
    case location.hash of
        "" ->
            []

        "#welcome" ->
            [ SetActivePage Welcome ]

        "#404" ->
            [ SetActivePage PageNotFound ]

        _ ->
            [ SetActivePage PageNotFound ]
