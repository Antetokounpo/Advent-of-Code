import AOC
import Data.List

main = do
    inp <- readInput
    let [ranges, yourTicket, nearbyTickets] = splitOn "\n\n" inp
    let range = (nub . concat . concat) (map (\x -> let y = (reverse . words) x in map ((\k -> [(k !! 0)..(k !! 1)]) . (map read) . (splitOn "-")) [y !! 0, y !! 2]) (lines ranges)) :: [Int]
    let tickets = ((map read) . concat . (map (splitOn ",")) . lines . (drop 16)) nearbyTickets :: [Int]
    print $ sum (filter (not . ((flip elem) range)) tickets)
