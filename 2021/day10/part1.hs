import AOC
import qualified Data.Map as Map

openings :: [Char]
openings = ['(', '{', '[', '<']

closings :: [Char]
closings = [')', '}', ']', '>']

closingToOpeningMap :: Map.Map Char Char
closingToOpeningMap = Map.fromList (zip closings openings)


count :: Eq a => a -> [a] -> Int
count c = length . filter (==c)

isCorrupted :: [Char] -> Char
isCorrupted s = isCorrupted' s []
    where isCorrupted' (x:xs) stack
            | x `elem` openings = isCorrupted' xs (x:stack)
            | x `elem` closings = if closingToOpeningMap Map.! x == (head stack) then isCorrupted' xs (tail stack) else x
          isCorrupted' [] _ = 'x'

countPoints :: Num a => Char -> a
countPoints ')' = 3
countPoints ']' = 57
countPoints '}' = 1197
countPoints '>' = 25137
countPoints 'x' = 0

main :: IO ()
main = do
    inp <- readInput
    let chunks = lines inp
    print $ sum (map (countPoints . isCorrupted) chunks)
