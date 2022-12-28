import AOC
import Data.List
import Text.Regex.Posix

moveTile :: (Num a1, Num a2) => (a1, a2) -> [Char] -> (a1, a2)
moveTile (i, j) "e" = (i+1, j)
moveTile (i, j) "se" = (i, j+1)
moveTile (i, j) "sw" = (i-1, j+1)
moveTile (i, j) "w" = (i-1, j)
moveTile (i, j) "nw" = (i, j-1)
moveTile (i, j) "ne" = (i+1, j-1)

main = do
    inp <- readInput
    let tiles = lines inp
    let pat = "e|se|sw|w|nw|ne"
    let r = map (getAllTextMatches . (=~ pat)) tiles :: [[String]]
    let m = map (foldl moveTile (0,0)) r
    let counts = map (length . (`elemIndices` m)) m
    print $ length (filter (==1) counts)
