import AOC

import Data.List

main = do
    inp <- readInput
    let adpaters = map (read) (lines inp) :: [Int]
    let sortedAdapters = sort adpaters
    let diffs =  map (\x -> (sortedAdapters !! (x+1)) - (sortedAdapters !! x)) [0..(length sortedAdapters - 2)]
    print $ (length (filter (==1) diffs)+1) * (length (filter (==3) diffs)+1)
