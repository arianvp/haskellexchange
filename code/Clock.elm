import Html exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Date exposing (..)
import Html.App exposing (program)
import Task
import Debug
import Time 

main =
  program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

type alias Model = Date
init : (Model, Cmd Msg)
init =
  (fromTime 0, Task.perform (\_ -> Tick (fromTime 0)) (Tick) now)

type Msg
  = Tick Date

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick newDate ->
      (newDate, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions m =
  Time.every Time.second (\x -> Tick (fromTime x))

offset (x,y) = (x+50, y+50)

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
