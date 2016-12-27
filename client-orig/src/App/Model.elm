module App.Model exposing (Page(..), Model, emptyModel)

import Pages.Profile.Model exposing (Model, emptyModel)


type Page
    = Welcome
    | Profile
    | PageNotFound


type alias Model =
    { activePage : Page
    , pageProfile : Pages.Profile.Model.Model
    }


emptyModel : Model
emptyModel =
    { activePage = Welcome
    , pageProfile = Pages.Profile.Model.emptyModel
    }
