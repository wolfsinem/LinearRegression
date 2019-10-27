-- ghci /Users/wolfsinem/Documents/declarativeProgramming/haskellProject/linRegTest.hs
-- cabal install --lib

{-# LANGUAGE OverloadedStrings, RecordWildCards, FunctionalDependencies, FlexibleInstances, FlexibleContexts, BangPatterns  #-}

module Main where

import qualified Data.ByteString.Lazy as BL
import qualified Data.Vector as V
import Data.Csv
import Control.Applicative
import Filesystem.Path.CurrentOS as Path

{-
Alle benodigde stappen voor een goed functionerende lineaire model om zo met behulp van lineaire
regressie de aandelenprijzen van cryptomunten te voorspellen. 

y = ax + b
a is een coefficient van x 
b is de constante (snijpunt met y as) 

- gemiddelde en variantie berekenen 
    bereken het gemiddelde van de lijst, trek van elke x in de lijst het gemiddelde er van af, neem voor elke x 
    de kwadraat, neem hier de som van, deel de som met lengte van de lijst - 1. (sigma(Xi -X)/(N-1))
- covariantie 
    hoeveel twee variabelen met elkaar zijn verbonden.
    c = sigma(xi - xgemiddelde) * (yi - ygemiddelde) / n - 1 
- coefficient 
-}

-- filePathToString :: FilePath -> String
filePathToString = Path.encodeString

-- |Alle variabelen die relevant zijn in de berekeningen voor het linaire model
data Coin = Coin { date   :: String -- wat is het verschil met !String 
                 , symbol :: String
                 , open :: Float } 
                 -- , close :: Float 
                 
data LinearModel = LinearModel { coefs :: V.Vector Double
                               , lmIntercept :: Bool 
                               , lmStandardize :: Bool
                               , lmMean ::  V.Vector Double
                               , lmStd ::  V.Vector Double }
                               deriving (Show)

-- |Gemiddelde,variantie.. 

-- |encode/decode data types, we nemen hier de kolommen die in mijn BTC.csv file staan
instance FromNamedRecord Coin where
    parseNamedRecord r = Coin <$> r .: "Date" <*> r .: "Symbol" <*> r .: "Open" -- <*> r .: "Close"

main :: IO ()
main = do
    csvData <- BL.readFile $ filePathToString "BTC.csv"
    case decodeByName csvData of
        Left err -> putStrLn err
        Right (_, v) -> V.forM_ v $ \ d ->
            putStrLn $ "Date: " ++ show (date d) ++ " Coin " ++ show (symbol d) ++ " open " ++ show (open d) -- ++ " close " ++ show (close d)