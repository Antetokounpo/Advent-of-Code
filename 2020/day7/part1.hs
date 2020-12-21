import AOC

import Data.List

getEveryContainer :: [String] -> [[String]] -> String -> [String]
getEveryContainer p c "" = []
getEveryContainer p c k = (concat (map (getEveryContainer p c) n)) ++ n
                            where n = map (p !!) (filter ((elem k) . (c !!)) [0..(length p - 1)])


main = do
    inp <- readInput
    let rules = map (splitOn " bags contain ") (lines inp)
    let children =  map ((map ((intercalate " ") . (drop 1) . init . words)) . (filter (/="no other bags")) . (splitOn ", ") . (filter (/='.') . (!! 1))) rules
    let parents = map (!! 0) rules
    print $ (length . nub) (getEveryContainer parents children "shiny gold")
