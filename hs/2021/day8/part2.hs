import AOC
import Data.List
import qualified Data.Map as Map

data Segment = A | B | C | D | E | F | G deriving (Eq, Ord, Show)

count :: Eq a => a -> [a] -> Int
count x xs = length $ filter (==x) xs

countOutputs :: (Eq a, Num a) => [[a]] -> Int
countOutputs xs = sum $ map count [2, 4, 3, 7] <*> xs

translateSignal :: [Segment] -> String
translateSignal [A, B, C, E, F, G] = "0"
translateSignal [C, F] = "1"
translateSignal [A, C, D, E, G] = "2"
translateSignal [A, C, D, F, G] = "3"
translateSignal [B, C, D, F] = "4"
translateSignal [A, B, D, F, G] = "5"
translateSignal [A, B, D, E, F, G] = "6"
translateSignal [A, C, F] = "7"
translateSignal [A, B, C, D, E, F, G] = "8"
translateSignal [A, B, C, D, F, G] = "9"
translateSignal xs = error (show xs)

containsAll :: (Foldable t1, Foldable t2, Eq a) => t1 a -> t2 a -> Bool
containsAll ys xs = all (`elem` xs) ys

mapSymbols :: [[Char]] -> Map.Map [Char] Segment
mapSymbols xs = Map.fromList [(a, A), (b, B), (c, C), (d, D), (e, E), (f, F), (g, G)]
    where ys = Map.fromList [("7", head $ filter ((==3) . length) xs),
                             ("1", head $ filter ((==2) . length) xs),
                             ("4", head $ filter ((==4) . length) xs),
                             ("8", head $ filter ((==7) . length) xs)]
          a = Map.findWithDefault "" "7" ys \\ Map.findWithDefault "" "1" ys
          e = "abcdefg" \\ head (filter (\x -> containsAll (Map.findWithDefault "" "4" ys) x && length x == 6) xs)
          c = "abcdefg" \\ head (filter (\x -> isInfixOf e x && length x == 6 && not (containsAll (Map.findWithDefault "" "7" ys) x)) xs)
          f = Map.findWithDefault "" "1" ys \\ c
          b = "abcdefg" \\ (head (filter (\x -> isInfixOf c x && not (isInfixOf f x) && length x == 5) xs) ++ f)
          g = head (filter (\x -> isInfixOf e x && isInfixOf c x && length x == 6) xs) \\ concat [a, e, c, f, b]
          d = "abcdefg" \\ concat [a, e, c, f, b, g]

decodeSignal :: Ord a => Map.Map [a] Segment -> [a] -> [Segment]
decodeSignal d xs = map (\x -> Map.findWithDefault A [x] d) xs

main = do
    inp <- readInput
    let signals = map (map words . splitOn "|") (lines inp)
    let decoded = map (mapSymbols . concat) signals
    let outputs = map last signals
    let outputsNumbers = map (read . concat . \(s, dict) -> map (translateSignal . sort . decodeSignal dict) s) (zip outputs decoded) :: [Int]
    print $ sum outputsNumbers
