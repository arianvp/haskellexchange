






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

maybe : (a -> b) -> b -> Maybe a -> b
maybe f x (Just y) = y
maybe f x _= x
```
]
<br />
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
type alias Model = { name : String }
init = { name = "Arian" } 

view : Model -> Html Msg
view model =
  h1 []
    [ text model.name ]

update :  Msg -> Model -> Model

```
---

# Tasks
* Can be sequenced and combined. 

---
# Subscriptions


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