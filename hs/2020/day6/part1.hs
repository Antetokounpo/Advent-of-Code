import AOC

import Data.List

main = do
    inp <- readInput
    print $ sum (map (length . filter (/='\n') . nub) (splitOn "\n\n" inp))

