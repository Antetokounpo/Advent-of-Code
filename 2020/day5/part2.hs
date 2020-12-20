import AOC

import Data.List

getRow' :: String -> [Int] -> Int
getRow' _ [y] = y
getRow' (x:xs) ys = if x == 'B' then getRow' xs (drop s ys) else getRow' xs (take s ys)
                        where s = length ys `div` 2

getRow :: String -> Int
getRow xs = getRow' xs [0..127]

getCol' :: String -> [Int] -> Int
getCol' _ [y] = y
getCol' (x:xs) ys = if x == 'R' then getCol' xs (drop s ys) else getCol' xs (take s ys)
                        where s = length ys `div` 2
getCol :: String -> Int
getCol xs = getCol' xs [0..7]

getId :: String -> Int
getId xs = ((getRow r) * 8) + (getCol c)
            where r = (takeWhile (flip elem ['F', 'B'])) xs
                  c = (dropWhile (flip elem ['F', 'B'])) xs

main = do
    inp <- readInput
    let ids = (map getId (lines inp))
    print $ head ([(minimum ids)..(maximum ids)] \\ ids)

