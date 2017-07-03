module App exposing (..)

import Html exposing (Html, Attribute, span, div, text, textarea, input, p, button, label, br, program)
import Html.Attributes exposing (type_, id, style, value, size, autofocus, disabled)
import Html.Events exposing (onInput, onCheck)

import KaTeX exposing (renderWithOptions, defaultOptions)


-- MODEL


type alias Model =
  { input : String
  , isInlineRender : Bool
  }


init : ( Model, Cmd Msg )
init =
    ( Model "" False, Cmd.none )



-- MESSAGES


type Msg
    = NewInput String
    | Check Bool



-- VIEW


leftSplitView : Model -> Html Msg
leftSplitView model =
    div [ id "left-split" ]
        [ span [] [ text "Write math here" ]
        , textarea
            [ autofocus True, onInput NewInput ]
            [ text model.input ]
        ]



rightSplitView : Model -> Html Msg
rightSplitView model =
    let
        options = { defaultOptions | displayMode = not model.isInlineRender }
        output = renderWithOptions options model.input
    in
        div [ id "left-split" ]
            [ span [] [ text "Output here" ]
            , div [ style [ ( "flex-grow", "0.95" ) ] ] [ output ]
            , label []
                [ input [ type_ "checkbox", onCheck Check ] []
                , text "Inline"
                ]
            , button
                [ disabled (model.input == "")
                ] [ text "Download SVG" ]
            ]



view : Model -> Html Msg
view model =
    div [ id "split" ]
        [ leftSplitView model
        , rightSplitView model
        ]



-- UPDATE



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewInput newInput ->
            ( { model | input = newInput }, Cmd.none )
        Check ch ->
            ( { model | isInlineRender = ch }, Cmd.none )



-- SUBSCRIPTIONS



subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN



main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

