import AOC

import Data.List
import Data.Maybe

data Bag = Bag { name :: String,
                 number :: Int,
                 children :: [Bag]
} | EmptyBag deriving Show

constructBag' :: [String] -> [[String]] -> String -> Bag
constructBag' p c "" = EmptyBag
constructBag' p c k = Bag {name = j, number = i, children = (map (constructBag' p c) (c !! n))}
                        where xs = words k
                              i  = read (head xs) :: Int
                              j  = intercalate " " (tail xs)
                              n = fromJust $ elemIndex j p

constructBag :: [String] -> [[String]] -> String -> Bag
constructBag p c k = Bag {name = k, number = 1, children = (map (constructBag' p c) (c !! n))}
                        where n = fromJust $ elemIndex k p

countBags :: Bag -> Int
countBags Bag {name = _, number = n, children = []} = n
countBags b = number b * (sum (map countBags (children b)) + 1)


main = do
    inp <- readInput
    let rules = map (splitOn " bags contain ") (lines inp)
    let children =  map ((map ((intercalate " ") . init . words)) . (filter (/="no other bags")) . (splitOn ", ") . (filter (/='.') . (!! 1))) rules
    let parents = map (!! 0) rules
    let shinyBag = constructBag parents children "shiny gold"
    print $ countBags shinyBag - 1
