defmodule Elmspark.IntegrationTest do
  alias ElmSpark.Code
  alias ElmSpark.Evaluation
  alias ElmSpark.Feature
  alias ElmSpark.Operator
  alias ElmSpark.Project
  alias ElmSpark.Requirement
  alias ElmSpark.Tool

  describe "integration" do
    test "works" do
      project = %Project{
        id: 1,
        summary: "Clckd"
      }

      feature = %Feature{
        id: 2,
        project_id: 1,
        summary: "Can be clicked"
      }

      requirement_1 = %Requirement{
        id: 31,
        acceptance_criteria: "When the button is clicked the button turns red.",
        feature_id: 2,
        summary: "Button Color"
      }

      requirement_2 = %Requirement{
        id: 32,
        acceptance_criteria:
          "When the button is clicked the screen starts flashing blue every 3 seconds.",
        feature_id: 2,
        summary: "Background Color"
      }

      tool_1 = %Tool{
        id: 41,
        kind: :elm_compiler
      }

      tool_2 = %Tool{
        id: 42,
        kind: :elm_program_test
      }

      operator = %Operator{
        id: 5,
        kind: :llm
      }

      station = %Station{
        id: 6,
        available_tools: [tool_1.id, tool_2.id],
        operators: [operator.id]
      }

      data = %{
        project: project,
        features: [feature],
        requirements: [requirement_1, requirement_2],
        tools: [tool],
        stations: [station],
        operators: [operator],
        evaluations: []
      }

      {:ok, result} = data
        |> Evaluate.step()

      expected_test = %Evaluation{
        expected_result: """
        """,
        id: 9,
        requirement_id: requirement_1.id,
        test_case: """module ClckdTest exposing (all)

import ProgramTest exposing (ProgramTest, clickButton, expectViewHas, fillIn, update)
import Test exposing (..)
import Test.Html.Selector exposing (text)
import Clckd as Main

all : Test
all =
    describe "Clckd works"
        [ test "When the button is clicked the button turns red." <|
            \() ->
                start
                    |> clickButton "MyButton"
                    |> expectViewHas
                        [ text "You must enter a valid postal code"
                        ]
        ]

        
        """,
        }

      assert result.evaluations == [^expected_test]
    end
  end
end
