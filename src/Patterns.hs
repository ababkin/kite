module Patterns where

import           Types

data ActionPattern = SearchPattern [String]
  | DashboardPattern [String]
  | DealRoomPattern [String]
  | DealReviewPattern [String]

actionPatterns = [
    SearchPattern     ["search", "find"]
  , DashboardPattern  ["dashboard", "control panel", "home"]
  , DealRoomPattern   ["deals", "deal room"]
  , DealReviewPattern ["rate", "review", "deal"]
  ]

searchTargetPatterns = [
    (Startup,       ["startup", "startups", "company", "companies"])
  , (InvestorGroup, ["investor", "investment", "group", "angels", "fund", "funding", "fundraise", "raise"])
  ]

industryPatterns = [
    (Biomedical,  ["biomedical", "medicine"])
  , (Automotive,  ["auto", "automotive", "cars"])
  , (HighTech,    ["hightech", "high tech", "computer", "embedded", "electronics"])
  , (Ecology,     ["ecology", "clean", "environment"])
  ]


