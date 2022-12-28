import AOC

import Data.List
import Data.Maybe

getIds :: String -> [Int]
getIds ids = map read (((filter (/="x")) . (splitOn ",")) ids) :: [Int]

getProduct :: Int -> [Int] -> Int
getProduct t ids = m * i
                        where ml   = map (\x -> x - (t `mod` x)) ids
                              m    = minimum ml
                              i    = ids !! (((fromMaybe 0) . (elemIndex m)) ml)

main = do
    inp <- readInput
    let [time, lids] = lines inp
    let t = read time :: Int
    let ids = getIds lids
    print $ getProduct t ids

