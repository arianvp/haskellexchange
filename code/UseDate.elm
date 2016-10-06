import Date
import Task
import Html.App exposing (program)
import Html.Events exposing (onClick)
import Html exposing (div, button, text)

main = program
  { init = init
  , update = update
  , view = view
  , subscriptions = \_ -> Sub.none 
  }

getDate : Cmd Msg
getDate =
  Task.perform
    (\e -> NewDate (Date.fromTime 0))
    NewDate
    Date.now

init : (Date.Date, Cmd Msg)
init = (Date.fromTime 0, getDate)

type Msg
  = NewDate Date.Date
  | GetNewDate

update msg date =
  case msg of
    NewDate date' -> (date', Cmd.none)
    GetNewDate -> (date, getDate)

view date = 
  div []
    [ button [onClick GetNewDate] [ text "new date"]
    , div [] [ text (toString date) ]
    ]
