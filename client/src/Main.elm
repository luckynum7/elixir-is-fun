module Main exposing (..)

import RouteUrl exposing (RouteUrlProgram)
import Viewer exposing (Model, Msg)


main : RouteUrlProgram Never Model Msg
main =
    RouteUrl.program
        { delta2url = Viewer.delta2url
        , location2messages = Viewer.url2messages
        , init = Viewer.init
        , update = Viewer.update
        , view = Viewer.view
        , subscriptions = Viewer.subscriptions
        }
