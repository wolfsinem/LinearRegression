module Library where

import Datatypes

sumL :: [(Float,Float)] -> ((Float,Float) -> Float) -> Float
sumL [] l = 0
sumL (x:xs) l = l(x) + sumL xs l

-- | vind de Y in een lineare formule waarvan de x al bekend is 
findY :: [(Float,Float)] -> Float -> Float
findY [] x = 0
findY ls x = (find_alpha ls) + ((find_beta ls) * x)

-- | vind de X in een lineare formule waarvan de y al bekend is
findX :: [(Float,Float)] -> Float -> Float
findX [] y = 0
findX ls y = (y - find_alpha ls) / find_beta ls

-- | vind de alpha (intercept) in een lineare formule
find_alpha :: [(Float,Float)] -> Float
find_alpha [] = 0
find_alpha ls = (((sumL ls get_y) * (sumL ls get_x_sq)) - ((sumL ls get_x) * (sumL ls get_xy))) / divisor ls

-- | vind de beta (slope) in een lineare formule
find_beta :: [(Float,Float)] -> Float
find_beta [] = 0
find_beta ls = ((fromIntegral(length ls) * (sumL ls get_xy)) - ((sumL ls get_x) * (sumL ls get_y))) / divisor ls

divisor :: [(Float,Float)] -> Float
divisor ls = fromIntegral(length ls) * (sumL ls get_x_sq) - (sumL ls get_x)^2

-- | return y (in de example set weten we al de y waarde)
get_y :: (Float,Float) -> Float
get_y (x,y) = y

-- | return x (in de example set weten we al de x waarde)
get_x :: (Float,Float) -> Float
get_x (x,y) = x

-- | return x kwadraat
get_x_sq :: (Float,Float) -> Float
get_x_sq (x,y) = x^2

-- | return product xy  
get_xy :: (Float,Float) -> Float
get_xy (x,y) = x*y

-- findY [(1,4),(4,2),(5,10)] 5 (x=5)