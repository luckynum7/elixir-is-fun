module Main exposing (..)

import App.Model exposing (Model)
import App.Router exposing (delta2url, hash2messages)
import App.Update exposing (init, Msg, update, subscriptions)
import App.View exposing (view)
import RouteUrl exposing (RouteUrlProgram)


main : RouteUrlProgram Never Model Msg
main =
    RouteUrl.program
        { delta2url = delta2url
        , location2messages = hash2messages
        , init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
