import AOC
import Data.List

lineify :: [[[Int]]] -> [[Int]]
lineify = concatMap lineify'
    where lineify' [[x1, y1], [x2, y2]]
            | x1 == x2 = map (([x1]++) .  pure) (range y1 y2)
            | y1 == y2 = map (:[y1]) (range x1 x2)
            | otherwise = map (\(x, y) -> [x, y]) (zip (range x1 x2) (range y1 y2))
          range a b = if a < b then [a..b] else [a, (a-1)..b] 

main :: IO ()
main = do
    inp <- readInput
    let lines' = map (map (map read . splitOn ",") . splitOn " -> ") (lines inp) :: [[[Int]]]
    let points = lineify lines'
    print $ length (filter (/=1) ((map length . group . sort) points))
