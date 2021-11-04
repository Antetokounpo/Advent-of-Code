import AOC

playGame :: Ord a => [a] -> [a] -> [a]
playGame d [] = d
playGame [] d = d
playGame (c1:d1) (c2:d2) = if c1 > c2 then playGame (d1 ++ [c1, c2]) d2 else playGame d1 (d2 ++ [c2, c1])

main = do
    inp <- readInput
    let [d1, d2] = map (map read . tail . lines) (splitOn "\n\n" inp) :: [[Int]]
    let endDeck = reverse $ playGame d1 d2
    print $ sum (map (\x -> (endDeck !! x)*(x+1)) [0..(length endDeck - 1)])