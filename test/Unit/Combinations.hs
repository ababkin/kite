module Unit.Combinations (suggestCombinationsUnitTests) where

import           Test.Tasty       (TestTree)
import           Test.Tasty.HUnit (testCase, (@?=))

import           Suggest

data SuggestCombinationUnitTest a = SuggestCombinationUnitTest String [(a, Cost)] [([a], Cost)]

suggestCombinationsUnitTests :: [TestTree]
suggestCombinationsUnitTests = map (\(SuggestCombinationUnitTest description input expectedOutput) ->
  testCase description $ suggestCombinations input @?= expectedOutput) allTestCases
    where
      allTestCases = [
          SuggestCombinationUnitTest "simple search"
            [("a", 2), ("b", 3), ("c", 4)]
            [
                ([],0)
              , (["a"],-3)
              , (["b"],-2)
              , (["b","a"],-5)
              , (["c"],-1)
              , (["c","a"],-4)
              , (["c","b"],-3)
              , (["c","b","a"],-6)
              , (["a","b"],-5)
              , (["c","a","b"],-6)
              , (["b","c"],-3)
              , (["a","c"],-4)
              , (["a","b","c"],-6)
              , (["a","c","b"],-6)
              , (["b","a","c"],-6)
              , (["b","c","a"],-6)
            ]
        ]
