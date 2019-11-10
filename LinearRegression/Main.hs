{-# LANGUAGE OverloadedStrings#-}

module Main where

import qualified Data.ByteString.Lazy as BL
import qualified Data.Vector as V
import Data.Csv
import Filesystem.Path.CurrentOS as Path

import Library
import Datatypes

instance FromNamedRecord Coin where
      parseNamedRecord r = Coin <$> r .: "Date" <*> r .: "Open"

main :: IO ()
main = do  
      csvData <- BL.readFile $ Path.encodeString "BTCnew.csv"
      case decodeByName csvData of
            Left err -> putStrLn err
            Right (_, v) -> V.forM_ v $ \ d ->
                putStrLn $ show (date d) ++ " " ++ show (open d)

            --     let trainingset = 
            --       TrainingSet [Example (1,8304.96), Example (2,8321.52), Example (3,8381.72) ]
            --                   [Example (date d, open d)]
