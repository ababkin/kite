module Unit.Suggest where

import           Test.Tasty       (TestTree)
import           Test.Tasty.HUnit (testCase, (@?=))

import           Suggest

data SuggestUnitTest = SuggestUnitTest String String (Action, Cost)

suggestUnitTests :: [TestTree]
suggestUnitTests = map (\(SuggestUnitTest description keywords expectedFirstSuggestion) ->
  testCase description $ (head $ suggest keywords) @?= expectedFirstSuggestion) allTestCases
    where
      allTestCases = [
          SuggestUnitTest "simple search"
            "search"
            (Search [] [], 0)
        , SuggestUnitTest "search startups"
            "find companies"
            (Search [Startup] [], -2)
        ]
