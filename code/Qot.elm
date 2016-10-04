import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)
import Html.App exposing (program)
import Time exposing (Time)
import Json.Decode exposing (..)
import Http 
import Task
import Debug

type alias Quote = String

type alias Model = 
 { qot : Quote
 }

quoteDecoder =
  at ["value", "joke"] string

decodeQuote = decodeString quoteDecoder

getQuote  : Cmd Msg
getQuote  =
  let

    url = "http://api.icndb.com/jokes/random"
  in
      Task.perform Fail GotNewQuote (Http.get quoteDecoder url)


init = ({qot =  "yo i am a joke"}
       , Cmd.none)

main = program
  { init = init
  , update = update
  , view = view
  , subscriptions = subscriptions
  }

type Msg 
  = GetNewQuote
  | GotNewQuote Quote
  | Fail Http.Error

update msg mdl =
  case msg of
    GetNewQuote ->
      Debug.log "get new quote" (mdl, getQuote)

    GotNewQuote quote ->
      Debug.log "got new quote" ({ mdl | qot = quote }, Cmd.none)
    Fail error ->
      (mdl, Cmd.none)


subscriptions model =
  Time.every (3*Time.second) (\_ -> GetNewQuote)

view model =
  div []
    [ blockquote [style [("background-color", "#AAA")]]
      [ text model.qot
      ]
    , button [onClick GetNewQuote] [ text "hey" ]
    ]
