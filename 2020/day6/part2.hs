import AOC

import Data.List

main = do
    inp <- readInput
    print $ sum (map (length . (foldl intersect ['a'..'z']) . lines) (splitOn "\n\n" inp))

