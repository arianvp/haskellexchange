










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
* Model
* Update
* View

---

# Basic Example

.pull-left[
```elm
import Html exposing (div, button, text)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)

main =
  beginnerProgram 
    { model = 0, view = view, update = update }

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

---
```elm
import Html exposing (..)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)

const a b = b
main =
  beginnerProgram
    { model = {}, view = view, update = const }

view a = h1 [] [text "hello world"]


```
<iframe class="executed" src="code/Simple.elm.html"></iframe>


---

# Yo  there
```elm
import Html exposing (div, button, text)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)

main =
  beginnerProgram 
    { model = 0, view = view, update = update }

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