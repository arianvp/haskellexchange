








class: center, middle


# Building Single Page Applications in Elm 
## Arian Van Putten
### Haskell Exchange 2016
#### @ProgrammerDude / https://arianvp.me / https://github.com/arianvp


---

---
# Current state of web development
* JavaScript
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
# Syntax deep dive
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
# Hello world! 

.pull-left-lg[
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
]
.pull-right-sm[

<iframe class="executed" src="code/Simple.elm.html"></iframe>
]

<br />

```bash
$ npm -g install elm
$ elm-make Hello.elm && firefox index.html
```
---
# The Elm Architecture

* `Model : *` 
* `model : Model`  the initial state
* `Msg : *`  the type of events that can be fired by our application
* `update : Msg -> Model -> Model` The event handler that updates the state
* `view : Model -> Html Msg` renders our state to screen
---
# Basic Example - Counter

.pull-left-lg[
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
.pull-right-sm[

<iframe class="executed" src="code/CounterBasic.elm.html"></iframe>
]

---
# Basic Example - Counter

.pull-left-lg[
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
.pull-right-sm[

1. `view` can attach event handlers to DOM elements
2. Those generate events of type `Msg`
3. `update` gets called with `Msg` to decrement or increment counter
4. `view` gets called to render counter. 

```elm
onClick : Msg -> Attribute Msg
```
]

---
# Basic Example - Counter
.pull-left-lg[
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
.pull-right-sm[
* When `view` gets called. potentially new handlers will be registered and old handlers deregistered
<iframe class="executed" src="code/NewCounter.elm.html"></iframe>
]

---
# beginnerProgram
.pull-left-lg[
```elm
beginnerProgram
  : { model : model
    , view : model -> Html msg
    , update : msg -> model -> model
  } -> Program Never  
```
]
.pull-right-sm[
1. `view` can attach event handlers to DOM elements
2. Those generate events of type `msg`
3. `update` gets called with `msg` to decrement or increment counter
4. `view` gets called to render counter. 
5.  When `view` gets called. potentially new handlers will be registered and old handlers deregistered

]


---
# How does this work?
* Isn't rerendering on every state change expensive?

--
* No: `Html Msg` is a _virtual document_.
* Is diffed against the previous virtual document
* Diff is a minimal set of instructions to update the actual dom

.pull-left[
```elm
div [ class "yo"]
  [ h1 [onClick Greet] [ text "there" ]]

```
]
.pull-right[
```elm
  div [ class "abc" ]
    [ h1 [onClick Bye] [ text "stuff" ]]
```
]

<br />
```javascript
div$1.setClass("abc");
h1$1.innerHTML = "stuff";
h1.eventHandlers.deregister("onclick", Greet_onclickhandler);
h1.eventHandlers.register("onclick", Bye_onclickhandler);
```

* This is an implementation detail. We don't care
* We just return the entire document, and elm figures out how to update the
actual dom efficiently

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
```elm
Html.App.map : (submsg -> msg) -> Html submsg -> Html msg
```
* given a way to turn `submsg` into `msg` .
* Will modify all event handlers to emit `msg` instead of `submsg`
* This is the functor instance of Html! (If elm had typeclasses)
* 
---

# Composing Components

.pull-left-lg[
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
.pull-right-sm[

<iframe class="executed" src="code/Combine.elm.html"></iframe>
]

---


# And now?
* We can now make simple applications in elm..
* But how do we do useful stuff?
* We want to do HTTP requests
* Get the current time
* ... etc
*


---

# Cmds
```elm
type Cmd msg
```
* A command tells Elm " Hey I want to do stuff!"
* "Hey, I want to perform an HTTP Request"
* "Hey, what is the current datE?"
* "Hey, I want a random number"

```elm
map : (a -> msg) -> Cmd a -> Cmd msg
none : Cmd msg
```

---
# Cmds


* We extend our _program_ such that `update` can
create commands next to updating the state.

```elm
init : (Model, Cmd Msg)
update : Msg -> Model -> (Model, Cmd Msg)

program
    :  { init : (model, Cmd msg)
       , update : msg -> model -> (model, Cmd msg)
       , subscriptions : model -> Sub msg
       , view : model -> Html msg }
    -> Program Never
```
* A command then is executed asynchronously, and will call
  `update` as the callback with the `msg` that `Cmd` produced
---
# Cmds
.pull-left-lg[
```elm
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
   
```
]
.pull-right-sm[

<iframe class="executed" src="code/RandomEx.elm.html"></iframe>
]


---
# HTTP
## Tasks
* A task is a Cmd that can potentially fail

```elm
perform : (x -> msg) -> (a -> msg) -> Task x a -> Cmd msg
--         ^             ^
--         |             |
--        if fail       if success

```

```elm
HTTP.get : Json.Decoder value -> String -> Task Error value
```

---
# Lets build a Quote of the Day app

`http://api.icndb.com/jokes/random`
```json
{ 
  "type": "success",
  "value": {
    "id": 138,
    "joke": "Chuck Norris can slam a revolving door.",
    "categories": [] 
  }
}
```

```elm
qotDecoder : Json.Decoder String
qotDecoder = Json.at ["value", "joke"]
```

---
# Lets build a Quote of the Day app

```elm

type alias Quote = String
type alias Model = 
 { qot : Quote }


type Msg 
  = GetNewQuote
  | GotNewQuote Quote
  | Fail Http.Error

getQuote : Cmd Msg
getQuote =
  let url = "http://api.icndb.com/jokes/random"
  in Task.perform Fail GotNewQuote (Http.get quoteDecoder url)

```
---
# Lets build a Quote of the Day app

.pull-left-lg[
```elm
init : (Model, Cmd Msg)
init = ({qot=""}, getQuote)

update : Msg -> Model -> (Model, Cmd Msg)
update msg mdl =
  case msg of
    GetNewQuote -> (mdl, getQuote)
    GotNewQuote qot' -> ({ mdl | qot = qot' }, Cmd.none)
    Fail error -> ({ mdl | qot = ''}, Cmd.none)

    
view : Model -> Html Msg
view model =
  div []
    [ blockquote [style [("background-color", "#AAA")]]
      [ text model.qot
      ]
    , button [onClick GetNewQuote] [ text "hey" ]
    ]
```
]
.pull-right-sm[
<iframe class="executed" src="code/QotLol.elm.html"></iframe>
]

---
# Subscriptions
* A way to subscribe to a stream of `Msg`s
* Mouse movements
* Websockets
* Time


---
# Subscriptions
```elm
type Sub msg

map : (a -> msg) -> Sub a -> Sub msg
batch : List (sub msg) -> Sub msg
none : Sub msg
none = batch []

```
---

# A clock
```elm

Time.every : Time -> (Time -> msg) -> Sub msg
Date.fromTime : Time -> Date

type Msg = Tick Date

update msg model =
  case msg of
    Tick newDate -> (newDate, Cmd.none)

subscriptions : Sub Msg
subscriptions = Time.every Time.second (\x -> Tick (Date.fromTime x))
```
---
# A clock

.pull-left-lg[
```elm
makeHand inunit time max size =
  let angle = (degrees (toFloat (inunit time) * (360.0 / max))) - degrees 90.0
      handX = toString (50 + size * cos angle)
      handY = toString (50 + size * sin angle)
  in (handX, handY)

view : Model -> Html Msg
view time =
  let (handXS, handYS) = makeHand second time 60 42
      (handXM, handYM) = makeHand minute time 60 38
      (handXH, handYH) = makeHand hour time 12 30
  in Svg.svg [ viewBox "0 0 100 100", width "300px" ]
      [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] []
      , line [ x1 "50", y1 "50", x2 handXH, y2 handYH, stroke "#023963" ] []
      , line [ x1 "50", y1 "50", x2 handXM, y2 handYM, stroke "#023963" ] []
      , line [ x1 "50", y1 "50", x2 handXS, y2 handYS, stroke "#FFF"
             , strokeWidth "0.5" ] []
      ]
```
]

.pull-right-sm[
<iframe class="executed" src="code/Clock.elm.html"></iframe>
]


---

# What I miss in Elm

* No Functor, Monad, Applicative . No typelcasses at all!
* Means I can't  genenarlise patterns like `Task.andThen` and `Html.App.map`
* This stuff is scary for beginners. But makes advanced users productive
* I advice looking at PureScript .  Does have typeclasses
* http://www.alexmingoia.com/purescript-pux/ 

---
