import AOC
import Data.List

count :: Eq a => a -> [a] -> Int
count x = length . filter (==x)

findFields :: [[Bool]] -> [(Int, Int)] -> [(Int, Int)]
findFields [] c = c
findFields t c = case elemIndex 1 ((map (count True)) (transpose t)) of 
    Just n -> case elemIndex True ((transpose t) !! n) of 
        Just k -> findFields ((take k t) ++ [[False | x <- [1..(length (head t))]]] ++ (drop (k+1) t)) ((k, n):c)
    Nothing -> c

main = do
    inp <- readInput
    let [ranges, yourTicket, nearbyTickets] = splitOn "\n\n" inp
    let range = map (nub . concat) (map (\x -> let y = (reverse . words) x in map ((\k -> [(k !! 0)..(k !! 1)]) . (map read) . (splitOn "-")) [y !! 0, y !! 2]) (lines ranges)) :: [[Int]]
    let urange = (nub . concat) range
    let tickets = ((map (map read)) . (map (splitOn ",")) . lines . (drop 16)) nearbyTickets :: [[Int]]
    let filteredTickets = filter (all (flip elem urange)) tickets
    let myTicket = map read (((splitOn ",") . (drop 13)) yourTicket) :: [Int]
    let t = map (\y -> (map (\x -> all (flip elem (range !! y)) ((transpose filteredTickets) !! x))) [0..(length range - 1)]) [0..(length range - 1)]
    let a = findFields t []
    print $ product (map (myTicket !!) (map snd (take 6 (sort a))))
