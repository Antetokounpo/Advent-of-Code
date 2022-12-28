import AOC

import Data.List
import Data.Maybe

getIds :: String -> [Int]
getIds ids = map read (((map (\x -> if x =="x" then "1" else x)) . (splitOn ",")) ids) :: [Int]


euclid :: Int -> Int -> [Int]
euclid a b = eucl a 1 0 b 0 1
                where eucl r u v 0 u' v' = [r, u, v]
                      eucl r u v r' u' v' = eucl r' u' v' (r - r `div` r' * r') (u - r `div` r' * u') (v - r `div` r' * v')

chineseTheorem :: [Int] -> [Int] -> Int
chineseTheorem a n = sum [(a !! x) * (e !! x) | x <- [0..(length n - 1)]]
                    where m = product n
                          n' = map (m `div`) n
                          e = [(n' !! x) * (euclid (n !! x) (n' !! x) !! 2) | x <- [0..(length n' - 1)]]


main = do
    inp <- readInput
    let [time, lids] = lines inp
    let t = read time :: Int
    let ids = getIds lids
    let n = product ids
    print $ chineseTheorem (0:[(ids !! x)-x | x <- [1..(length ids -1)]]) ids `mod` n

