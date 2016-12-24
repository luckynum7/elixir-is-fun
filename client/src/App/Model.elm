module App.Model exposing (Page(..), Model, emptyModel)


type Page
    = Welcome
    | PageNotFound


type alias Model =
    { activePage : Page
    }


emptyModel : Model
emptyModel =
    { activePage = Welcome
    }
