module Datatypes where

data Coin = Coin { date :: Int 
                 , open :: Float } 

-- data Coefficients =
--   Coefficients (Float, Float)
--   deriving (Show) 

-- | Example staat voor elke x en y paar (date,open)
data Example =
  Example (Int, Float)

-- | Alle examples komen hier in de lijst (dus eigenlijk alle paren in de CSV-file) zodat op basis hiervan een lineaire functie opgesteld kan worden
data TrainingSet =
  TrainingSet [Example]