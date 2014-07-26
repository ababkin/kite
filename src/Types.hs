module Types where

import           Data.List (intercalate)

data SearchTarget = Startup | InvestorGroup deriving (Show, Eq)
data Industry = Biomedical
  | Automotive
  | HighTech
  | Ecology
  deriving (Show, Eq)

data DealTarget = DealStartup String | DealInvestorGroup String deriving Eq

instance Show DealTarget where
  show (DealStartup s) = "startup " ++ s
  show (DealInvestorGroup s) = "investor group " ++ s

data Action = Search{
      _targets    :: [SearchTarget]
    , _industries :: [Industry]
    }
  | Dashboard
  | DealReview{
      _dealTarget :: DealTarget
    }
  | DealRoom{
      _dealTarget :: DealTarget
    }
  deriving Eq


type Pattern = String
type Cost = Int
newtype ActionWithCost = ActionWithCost {unAWC :: (Action,Cost)} deriving Eq

instance Ord ActionWithCost where
  ActionWithCost (_, c) `compare` ActionWithCost (_, d) = c `compare` d

instance Show Action where
  show (Search [] industries) = case industries of
    []  -> s
    _   -> s ++ " in " ++ (intercalate ", " $ map show industries)
    where
      s = "Search for startups or investor groups"

  show (Search searchTargets industries) = case industries of
    []  -> s searchTargets
    _   -> (s searchTargets) ++ " in " ++ (intercalate ", " $ map show industries)
    where
      s searchTargets = "Search for " ++ (intercalate " or " $ map show searchTargets)

  show Dashboard = "My dashboard"
  show (DealReview target) = "Review deal with " ++ show target
  show (DealRoom target) = "My deal with " ++ show target

