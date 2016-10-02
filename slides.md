class: center, middle


# Building Single Page Applications in Elm 
## Arian Van Putten
### Haskell Exchange 2016

---
# What is Elm?

* A language for building web apps
* Functional
* Similar in syntax to haskell



---

# The Elm Architecture
.pull-left[
* Model
* Update
* View
]

---

# Basic Example
.pull-left[
```elm
module Counter exposing (main)
import Html exposing (div, button, text)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)

--| main
main =
  beginnerProgram { model = 0, view = view, update = update }


view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (toString model) ]
    , button [ onClick Increment ] [ text "+" ]
    ]


type Msg = Increment | Decrement


update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1
```
]
.pull-right[
<iframe class="executed" src="code/Counter.elm.html"></iframe>
]
