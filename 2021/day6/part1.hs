import AOC

oneday = concatMap ((\x -> if x == -1 then [6, 8] else [x]) . (+(-1)))

main = do
    inp <- readInput
    let init = map read (splitOn "," inp) :: [Int]
    print $ length (iterate oneday init !! 80)