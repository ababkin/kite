{-# LANGUAGE FlexibleContexts  #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE LambdaCase        #-}
{-# LANGUAGE TupleSections     #-}

module Suggest (
    suggest
  , Cost
  , Pattern
  , Action(..)
  , SearchTarget(..)
  , Industry(..)
  , costPatterns
  , suggestCombinations
)where

import           Data.Char         (isSpace)
import           Data.List         (nub, sort, take)
import           Data.List         (permutations, subsequences)
import qualified Data.Map          as M
import           Data.Maybe        (maybeToList)
import           Data.Monoid       (mconcat)
import           Text.EditDistance

import           Patterns
import           Types


suggest :: String -> [(Action, Cost)]
suggest = take 5 . sortActionsByCost . suggestActions
  where
    sortActionsByCost :: [(Action, Cost)] -> [(Action, Cost)]
    sortActionsByCost = map unAWC . sort . map ActionWithCost

suggestActions :: String -> [(Action, Cost)]
suggestActions keywordsExp =
  concat $ map suggestAction actionPatterns
  where
    suggestAction = (\case
      SearchPattern ps ->
        [ (Search searchTargets industries, (costPatterns keywordsExp ps + searchTargetCost + industryTargetsCost))
          | (searchTargets, searchTargetCost) <- (suggestCombinations $ suggestSearchTargets keywordsExp)
          , (industries, industryTargetsCost) <- (suggestCombinations $ suggestIndustries keywordsExp)
        ]
      DashboardPattern ps ->
        [(Dashboard, costPatterns keywordsExp ps)]
      DealRoomPattern ps ->
        [(DealRoom $ DealStartup "unknown", costPatterns keywordsExp ps)]
      DealReviewPattern ps ->
        [(DealReview $ DealStartup "unknown", costPatterns keywordsExp ps)]
      _ -> [])


suggestCombinations :: Eq a => [(a, Cost)] -> [([a], Cost)]
suggestCombinations = (map $ foldl (\(acci, accc) (i, c) -> (i:acci, accc + c - patternMatchCredit)) ([], 0) ) . nub . concat . map subsequences . permutations
  where
    patternMatchCredit = 2

suggestIndustries :: String -> [(Industry, Cost)]
suggestIndustries keywordsExp =
  map (\(i, ps) -> (i, costPatterns keywordsExp ps)) industryPatterns

{- suggestSearchTargets :: String -> Maybe SearchTarget -}
suggestSearchTargets :: String -> [(SearchTarget, Cost)]
suggestSearchTargets keywordsExp =
  map (\(st, ps) -> (st, costPatterns keywordsExp ps)) searchTargetPatterns


costPatterns :: String -> [Pattern] -> Cost
costPatterns keywordsExp = minimum . map (cost keywordsExp)
  where
    cost :: String -> Pattern -> Cost
    cost keywordsExp =
        foldr (+) 0 . map (\pw -> minimum [ levenshteinDistance defaultEditCosts t pw | t <- (words keywordsExp) ]) . words


