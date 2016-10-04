







class: center, middle


# Building Single Page Applications in Elm 
## Arian Van Putten
### Haskell Exchange 2016


---

---
# Current state of web development
*  Lots of tools
* Lots of frameworks
* Transpilers, compatibility layers, package managers
* https://hackernoon.com/how-it-feels-to-learn-javascript-in-2016
* Overall pretty messy

---
# What is Elm?
## At first
* An experimental language to explore Functional Reactive Programming
* Strong types
* Aimed at beginners

---
# What is Elm
## Now
* No FRP anymore, focusses on _The Elm Architecture_
* Easy way to build interactive web apps
* Similar to Facebook React + Redux
* Actualy, redux is a port of _The Elm Architecture_ to JavasScript
* A powerhorse
* Still beginner friendly
---

# Why Elm
.pull-left[
* JavaScript and its ecosystem is pretty scary these days (https://hackernoon.com/how-it-feels-to-learn-javascript-in-2016-d3a717dd577f#.nju4zrbov)
* I like types
* I like functional style
* Great error messages
]
.pull-right[
```
The argument for `getFullName` is causing a
mismatch.
21| getFullName
22|>  {
23|>    firstName = "Arian",
24|>    lastName = "van Putten",
25|>    hairColor = "ginger",
26|>  }

Function `getFullName` is expexting argument
to be:
    
    { ..., phoenNumber : ... }

But it is:
    { ..., phoneNumber : ... }

Hint: I compared the record fields and found som
potential typos.
  phoenNumber <-> phoneNumber
```
]
---

---
# Syntax deep dive

.pull-left[
```elm
add : Int -> Int -> Int
add x y = x + y
```
]
.pull-right[
```haskell
add :: Int -> Int -> Int
add x y = x + y
```
]
<br />
.pull-left[
```elm
type Maybe a 
  = Just a
  | Nothing

maybe : (a -> b) -> b -> Maybe a -> b
maybe f x m =
  case m of
    Just y -> f y
    Nothing -> x
```
]
.pull-right[
```haskell
data Maybe a
  = Just a
  | Nothing

maybe :: (a -> b) -> b -> Maybe a -> b
maybe f x (Just y) = y
maybe f x _= x
```
]
<br />
.pull-left[
```elm
giveGreeting : String -> String
giveGreeting name =
  let
    greet = name ++ ", Shalom!"
  in
    greet ++ greet
```
]
.pull-right[
```haskell
giveGreetingTwice :: String -> String
giveGreetingTwice name = greet ++ greet
  where greet = name ++ ", Shalom!"
```
]
---
.pull-left[
```elm
type alias Count = Int
type alias User =
 { name : String, phone : String
type alias Pet = { name : String }
```
]
.pull-right[
```haskell
type Count = Int
data User = User
  { name :: String, phone :: Phone}
data Pet  = Pet  { petName :: String }
```
]
---
# Syntax deep dive
## Records
* Extensible records with scoped labels

.pull-left[
```elm
type alias User =
 { name : String
 , phone : String }
type alias Pet = { name : String }

greet : { named | name : String} -> String
greet x = "Hello " ++ x.name ++ "!" 

user = { name = "Arian", phone = "2384294" }
cat = { name = "Robbedoes" }
-- greet user => "Hello Arian!"
-- greet cat  => "Hello Robbedoes!"
```
]
.pull-right[
```elm
user1 = { user | phone = "23935" }
```
]
---
# The Elm Architecture

```elm
```elm
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


```
<iframe class="executed" src="code/Simple.elm.html"></iframe>
```
---
# The Elm Architecture 
```elm
type alias Model = { name : String }
init = { name = "Arian" } 

view : Model -> Html Msg
view model =
  h1 []
    [ text model.name ]

update :  Msg -> Model -> Model

```
---
# Basic Example - Counter

.pull-left[
```elm
import Html exposing (div, button, text, Html)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)
main =
  beginnerProgram 
    { model = 0, view = view, update = update }

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
```
]
.pull-right[

<iframe class="executed" src="code/CounterBasic.elm.html"></iframe>
]

---
# Basic Example - Counter

.pull-left[
```elm
import Html exposing (div, button, text, Html)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)
main =
  beginnerProgram 
    { model = 0, view = view, update = update }

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
```
]
.pull-right[

1. `view` can attach event handlers to DOM elements
2. Those generate events of type `Msg`
3. `update` gets called with `Msg` to decrement or increment counter
4. `view` gets called to render counter. 
]

---
# Basic Example - Counter
.pull-left[
```elm
view : Int -> Html Msg
view model =
  let
    clickHandler =
      if model <= 0
        then []
        else [ onClick Decrement ]
  in
    div []
      [ button clickHandler [ text "-" ]
      , div [] [ text (toString model) ]
      , button [onClick Increment ] [ text "+" ]
      ]
```
]
.pull-right[
* When `view` gets called. potentially new handlers will be registered and old handlers deregistered
<iframe class="executed" src="code/NewCounter.elm.html"></iframe>
]

---
# beginnerProgram
.pull-left[
```elm
beginnerProgram
  : { model : model
    , view : model -> Html msg
    , update : msg -> model -> model
  } -> Program Never  
```
]
.pull-right[
1. `view` can attach event handlers to DOM elements
2. Those generate events of type `msg`
3. `update` gets called with `msg` to decrement or increment counter
4. `view` gets called to render counter. 
5.  When `view` gets called. potentially new handlers will be registered and old handlers deregistered
]
---

# Composing Components
```elm
Html.App.map : (submsg -> msg) -> Html submsg -> Html msg
```
* given a way to turn `submsg` into `msg` .
* Will modify all event handlers to emit `msg` instead of `submsg`
* This is the functor instance of Html! (If elm had typeclasses)
* 
---

# Composing Components

```elm
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
```
---

# Composing Components

.pull-left[
```elm
import Html exposing (span, Html)
import Html.App exposing (map, beginnerProgram)
import Counter as Ctr 
main = beginnerProgram
  { model=model, view=view, update=update}

type alias Model =
  { c1 : Ctr.Model , c2 : Ctr.Model }

model = { c1 = Ctr.model , c2 = Ctr.model }

view model =
  span []
   [ map C1 (Ctr.view model.c1)
   , map C2 (Ctr.view model.c2)
   ]

type Msg = C1 Ctr.Msg | C2 Ctr.Msg

update msg model =
  case msg of
    C1 m1 ->
      { model | c1 = Ctr.update m1 model.c1 }
    C2 m2 ->
      { model | c2 = Ctr.update m2 model.c2 }
```
]
.pull-right[

<iframe class="executed" src="code/Combine.elm.html"></iframe>
]

---

# Tasks
## Or - how do I actually make something useful in an FP language?
* Can be sequenced and combined. 

---
# Subscriptions


---

# What I miss in Elm

* No Functor, Monad, Applicative . No typelcasses at all!
* Means I can't  genenarlise patterns like `Task.andThen` and `Html.App.map`
* This stuff is scary for beginners. But makes advanced users productive
* I advice looking at PureScript .  Does have typeclasses
* http://www.alexmingoia.com/purescript-pux/ 

---
# Yo  there
```elm
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
```