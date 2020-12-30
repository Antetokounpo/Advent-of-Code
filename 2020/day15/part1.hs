import AOC
import Data.List

turn :: [Int] -> Int
turn (x:xs) = if length xs == 2019 then x else case elemIndex x xs of
                                                              Just n  -> turn ((n+1):x:xs)
                                                              Nothing -> turn (0:x:xs)

main = do
    let inp = [0,1,4,13,15,12,16]
    print $ turn (reverse inp)
