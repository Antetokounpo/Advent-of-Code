import System.IO
import Data.List

getNumber :: [Char] -> Int
getNumber xs = read (tail xs) :: Int

getPos :: [(Int, Int)] -> [Char] -> [(Int, Int)]
getPos pos [] = pos
getPos pos path
    | head path == 'R' = getPos (pos ++ [(x + i, y) | i <- [1..d]]) r
    | head path == 'L' = getPos (pos ++ [(x - i, y) | i <- [1..d]]) r
    | head path == 'U' = getPos (pos ++ [(x, y + i) | i <- [1..d]]) r
    | head path == 'D' = getPos (pos ++ [(x, y - i) | i <- [1..d]]) r
    | otherwise = error "Invalid direction"
        where x = fst (last pos)
              y = snd (last pos)
              d = (getNumber (takeWhile (/=',') path))
              r = if ',' `elem` path then (tail (dropWhile (/=',') path)) else []

distance :: (Int, Int) -> Int
distance (x, y) = abs(x) + abs(y)

main = do
    input <- getContents
    let wires = map (getPos [(0, 0)]) (lines input)
    let intersections = filter (`elem` (head wires)) (last wires)
    print $ intersections
    print $ head $ sort $ map distance (tail intersections)