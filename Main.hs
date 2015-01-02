{-# LANGUAGE OverloadedStrings #-}
module Main where

import Control.Monad.IO.Class
import System.Process
import Web.Scotty

htmlFile :: FilePath -> ActionM ()
htmlFile f = do
  setHeader "Content-Type" "text/html; charset=utf-8"
  file f

jsFile :: FilePath -> ActionM ()
jsFile f = do
  setHeader "Content-Type" "text/javascript; charset=utf-8"
  file f

left :: ActionM ()
left = do
  liftIO $ callProcess "xdotool" ["key", "--clearmodifier", "Left"]
  redirect "/"

right :: ActionM ()
right = do
  liftIO $ callProcess "xdotool" ["key", "--clearmodifier", "Right"]
  redirect "/"

main :: IO ()
main = scotty 8080 $ do
  get "/" $ htmlFile "index.html"
  get "/jquery.js" $ jsFile "jquery.js"
  get "/jquery.form.js" $ jsFile "jquery.form.js"
  post "/key/left" left
  post "/key/right" right
