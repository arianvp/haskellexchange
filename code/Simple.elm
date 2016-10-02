import Html exposing (..)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)

const a b = b
main =
  beginnerProgram
    { model = {}, view = view, update = const }

view a = h1 [] [text "hello world"]


