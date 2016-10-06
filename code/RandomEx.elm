import Random exposing (int, generate)
import Html.App exposing (program)
import Html exposing (..)
import Html.Events exposing (..)

main = program { init = init, view = view, update = update, subscriptions = \_ -> Sub.none}

random : Cmd Msg
random = generate GotNewRandom (int 0 10)

init : (Int, Cmd Msg)
init = (0, random)

type Msg
  = NewRandom
  | GotNewRandom Int

update msg x =
  case msg of
    NewRandom -> (x, random)
    GotNewRandom x' -> (x', Cmd.none)

view x = 
  div [] [button [onClick NewRandom] [text "newrandom"]
         ,text (toString x) ]
   
