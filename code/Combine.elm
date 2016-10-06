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
