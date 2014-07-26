module Unit.Cost (matchPatternsUnitTests) where

import           Test.Tasty       (TestTree)
import           Test.Tasty.HUnit (testCase, (@?=))

import           Suggest

data MatchPatternsUnitTest = MatchPatternsUnitTest String String [Pattern] Cost

matchPatternsUnitTests :: [TestTree]
matchPatternsUnitTests = map (\(MatchPatternsUnitTest description keywords patterns expectedCost) ->
  testCase description $ costPatterns keywords patterns @?= expectedCost) allTestCases
    where
      allTestCases = [
          MatchPatternsUnitTest "simple full match"
            "search"
            ["search", "find"]
            0
        , MatchPatternsUnitTest "search startups"
            "search startups"
            ["search", "find"]
            0
        , MatchPatternsUnitTest "1 typo"
            "serch"
            ["search", "find"]
            1
        , MatchPatternsUnitTest "swap characters"
            "saerch"
            ["search", "find"]
            2
        , MatchPatternsUnitTest "match both patterns with typo in one"
            "search fnid"
            ["search", "find"]
            0
        ]

        -- add double worded patterns cases
