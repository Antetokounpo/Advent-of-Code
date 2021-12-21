import AOC
import Data.List

lineify :: [[[Int]]] -> [[Int]]
lineify = concatMap lineify'
    where lineify' [[x1, y1], [x2, y2]]
            | x1 == x2 = map (([x1]++) .  pure) (range y1 y2)
            | y1 == y2 = map (:[y1]) (range x1 x2)
          range a b = if a < b then [a..b] else [b..a] 

main :: IO ()
main = do
    inp <- readInput
    let lines' = map (map (map read . splitOn ",") . splitOn " -> ") (lines inp) :: [[[Int]]]
    let horizontalVerticalLines = filter (\[[x1, y1], [x2, y2]] -> (x1 == x2) || (y1 == y2)) lines'
    let points = lineify horizontalVerticalLines
    print $ length (filter (/=1) ((map length . group . sort) points))
