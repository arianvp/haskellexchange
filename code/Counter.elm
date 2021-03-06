module Counter  exposing (..)
import Html exposing (div, button, text, Html)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)

type alias Model = Int
model = 0

view : Int -> Html Msg
view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (toString model) ]
    , button [ onClick Increment ] [ text "+" ]
    ]

type Msg = Increment | Decrement

update : Msg -> Int -> Int
update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1
