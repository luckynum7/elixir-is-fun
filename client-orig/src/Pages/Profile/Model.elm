module Pages.Profile.Model exposing (Model, emptyModel)

-- MODEL


type alias Model =
    { name : String }


emptyModel : Model
emptyModel =
    { name = "" }
