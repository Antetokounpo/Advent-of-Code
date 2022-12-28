import AOC

findWeakness :: [Int] -> Int
findWeakness xs = if x <= 2*(minimum ys) || x >= 2*(maximum ys) then x else findWeakness (drop 1 xs)
                    where ys = take 25 xs
                          x  = xs !! 25

main = do
    inp <- readInput
    let numbers = map read (lines inp) :: [Int]
    print $ findWeakness numbers
