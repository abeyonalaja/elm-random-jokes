module Main exposing (..)

import Html exposing (..)
import Html.Events exposing(..)
import Html.Attributes exposing (src)
import Http
import Json.Decode exposing (..)


---- MODEL ----


type alias Model =
    String


initModel : Model
initModel =
    "Finding a Joke...."


randomJoke : Cmd Msg
randomJoke =
    let
        url =
            "http://api.icndb.com/jokes/random"

        request =
            -- Http.getString url
            http.get url (at ["value", "joke"] string)

        cmd =
            Http.send Joke request
    in
        cmd


init : ( Model, Cmd Msg )
init =
    ( initModel, randomJoke )



---- UPDATE ----


type Msg
    = Joke (Result Http.Error String)
    | NewJoke


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Joke (Ok joke) ->
            ( joke, Cmd.none )

        Joke (Err err) ->
            ( (toString err), Cmd.none )

        NewJoke ->
            ( "Getting a new Joke ...", randomJoke )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , div [] [ text "Your Elm App is working!" ]
        , div [] [ text model ]
        , br [] []
        , button [ onClick NewJoke ] [ text "Get A new Joke" ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
