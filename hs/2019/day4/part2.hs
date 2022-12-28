import System.IO
import Data.List

adjacentDigitCheck :: [Char] -> Bool
adjacentDigitCheck xs = 2 `elem` (map length (group xs)) 

neverDeacreaseCheck :: [Char] -> Bool
neverDeacreaseCheck [x] = True
neverDeacreaseCheck (x:xs) = if show x > show (head xs) then False else neverDeacreaseCheck xs

testPass :: [Char] -> Bool
testPass xs = (adjacentDigitCheck xs && neverDeacreaseCheck xs)

main = do
    let input = [197487, 673251]
    print $ length $ filter (testPass) (map show [(head input)..(last input)])

    