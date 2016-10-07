import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Html.App exposing (program)
import Time exposing (Time)
import Json.Decode exposing (..)
import Http 
import Task

main = program
  { init = init
  , update = update
  , view = view
  , subscriptions = subscriptions
  }

type alias Quote = String

type alias Model = 
 { qot : Quote
 }

quoteDecoder =
  at ["value", "joke"] string

decodeQuote = decodeString quoteDecoder

getQuote  : Cmd Msg
getQuote  =
  let url = "http://api.icndb.com/jokes/random"
  in Task.perform Fail GotNewQuote (Http.get quoteDecoder url)

init = ({qot = ""} , Cmd.none)

type Msg 
  = GetNewQuote
  | GotNewQuote Quote
  | Fail Http.Error

update : Msg -> Model -> (Model, Cmd Msg)
update msg mdl =
  case msg of
    GetNewQuote ->
      (mdl, getQuote)
    GotNewQuote quote ->
      ({ mdl | qot = quote }, Cmd.none)
    Fail error ->
      (mdl, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every (3*Time.second) (\_ -> GetNewQuote)

view : Model -> Html Msg
view model =
  div []
    [ blockquote [style [("background-color", "#AAA")]]
      [ text model.qot
      ]
    , button [onClick GetNewQuote] [ text "hey" ]
    ]
