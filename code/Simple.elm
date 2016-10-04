import Html exposing (..)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)

const a b = b
main =
  beginnerProgram
    { model = {}, view = view, update = \x y -> y }

view a =
  div []
    [ h1 [] [text "hello world"]
    , p [] [text "Some text"]
    ]


