{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TupleSections     #-}

module Main where

import           Control.Applicative           ((<$>))
import           Control.Lens                  ((^.))
import           Control.Monad.IO.Class        (liftIO)
import qualified Data.ByteString.Char8         as BS
import qualified Data.Map                      as M
import           Data.Maybe                    (maybeToList)
import           Data.Monoid                   (mconcat)
import qualified Data.Text.Lazy                as T

import           Network.Wai                   (Request (..))
import           Network.Wai.Middleware.Static (addBase, noDots, staticPolicy,
                                                (>->))
import           Web.Scotty                    (get, json, middleware, request,
                                                scotty)

actions = [
    (["dashboard", "control panel", "home"],  "/dashboard")
  , (["search", "find"],                      "/search")
  , (["rate deal", "review"],                 "/rate-a-deal")
  ]

expandActions = concat . map (\(keywords, action) -> (map (,action) keywords))

suggest :: String -> [String]
suggest phrase = maybeToList $ M.lookup phrase $ M.fromList $ expandActions actions

main = scotty 5000 $ do
  middleware $ staticPolicy (noDots >-> addBase "frontend")
  get "/suggest_actions" $ do
    req <- request
    liftIO $ putStrLn $ show $ queryString req
    let ("phrase", Just phrase):_ = queryString req
    json $ T.pack <$> (suggest $ BS.unpack phrase)

    {- post "/relay" $ do -}
    {- post "/:word" $ do -}
        {- beam <- param "word" -}
        {- relayUrl <- body -}
        {- r <- liftIO $ W.get $ BS.unpack relayUrl -}
        {- text $ T.pack . BS.unpack $ r ^. W.responseBody -}

