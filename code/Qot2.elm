import Json.Decode exposing (..)

qotUrl = "https://api.forismatic.com/api/1.0/?method=getQuote&format=json&lang=en"

type alias Quote =
  { text : String
  , author : String
  }

quoteDecoder =
  object2 Quote
    ("quoteText" := string)
    ("quoteAuthor" := string)

decodeQuote = decodeString quoteDecoder


