import AOC

fibo :: Num a => [a] -> [a]
fibo ns = ((ns !! 6) + (ns !! 8)):ns

finalNumber :: Num a => Int -> [a]
finalNumber d = iterate fibo (replicate 9 1) !! d

main = do
    inp <- readInput
    let init = map read (splitOn "," inp) :: [Int]
    print $ sum (map (head . finalNumber . (256-)) init)
