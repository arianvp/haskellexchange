type alias Model =
  { qotd : String
  }


type Msg
  = NewQuote

init : (Model, Cmd Msg)
init =
  ({ qotd = "To be or Not to be"}, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NewQuote ->
      (model, Cmd.none)


qotUrl = "http://quotes.res/qod.json"
