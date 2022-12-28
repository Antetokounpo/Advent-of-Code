
import AOC

findWeakness :: [Int] -> Int
findWeakness xs = if x <= 2*(minimum ys) || x >= 2*(maximum ys) then x else findWeakness (drop 1 xs)
                    where ys = take 25 xs
                          x  = xs !! 25

findCombination :: [Int] -> Int -> Int -> Int
findCombination [] _ _ = 0
findCombination xs y n = if sum ys == y then (maximum ys) + (minimum ys) else findCombination (drop 1 xs) y n
                            where ys = take n xs

bruteForce :: [Int] -> Int -> Int
bruteForce xs y = maximum (map (findCombination xs y) [2..(length xs)])

main = do
    inp <- readInput
    let numbers = map read (lines inp) :: [Int]
    let weakNumber = findWeakness numbers
    print $ bruteForce numbers weakNumber
