import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Html.App exposing (program)
import Time exposing (Time)
import Json.Decode exposing (..)
import Http 
import Task

main = program { init = init , update = update , view = view , subscriptions = \_ -> Sub.none }

type alias Quote = String
type alias Model = 
 { qot : Quote
 }

quoteDecoder =
  at ["value", "joke"] string

getQuote  : Cmd Msg
getQuote  =
  let url = "http://api.icndb.com/jokes/random"
  in Task.perform Fail GotNewQuote (Http.get quoteDecoder url)

init = ({qot = "yo i am a joke"} , Cmd.none)

type Msg 
  = GetNewQuote
  | GotNewQuote Quote
  | Fail Http.Error

update msg mdl =
  case msg of
    GetNewQuote ->
      (mdl, getQuote)
    GotNewQuote quote ->
      ({ mdl | qot = quote }, Cmd.none)
    Fail error ->
      (mdl, Cmd.none)


view : Model -> Html Msg
view model =
  div []
    [ blockquote [style [("background-color", "#AAA")]]
      [ text model.qot
      ]
    , button [onClick GetNewQuote] [ text "hey" ]
    ]
