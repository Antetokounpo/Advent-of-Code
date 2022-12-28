import AOC
import qualified Data.Map as Map
import Data.List

openings :: [Char]
openings = ['(', '[', '{', '<']

closings :: [Char]
closings = [')', ']', '}', '>']

closingToOpeningMap :: Map.Map Char Char
closingToOpeningMap = Map.fromList (zip closings openings)

openingToClosingMap :: Map.Map Char Char
openingToClosingMap  = Map.fromList (zip openings closings)

count :: Eq a => a -> [a] -> Int
count c = length . filter (==c)

autocomplete :: [Char] -> String
autocomplete s = autocomplete' s []
    where autocomplete' (x:xs) stack
            | x `elem` openings = autocomplete' xs (x:stack)
            | x `elem` closings = if closingToOpeningMap Map.! x == head stack then autocomplete' xs (tail stack) else "" -- else is corrupted
          autocomplete' [] stack = map (openingToClosingMap Map.!) stack

getPointClosing :: Char -> Int
getPointClosing x = case x `elemIndex` closings of Just n -> n+1

countPoints :: [Char] -> Int
countPoints = countPoints' 0 
  where countPoints' c (x:xs) = countPoints' (c*5 + getPointClosing x) xs 
        countPoints' c [] = c


main :: IO ()
main = do
    inp <- readInput
    let chunks = lines inp
    let scores = sort (filter (/=0) (map (countPoints . autocomplete) chunks))
    print $ scores !! (length scores `div` 2)
