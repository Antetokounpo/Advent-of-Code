import AOC
import Data.List

computeFuel xs x = sum (map (abs . (x-)) xs)

main = do
    inp <- readInput
    let pos = map read (splitOn "," inp) :: [Int]
    print $ minimum (map (computeFuel pos) [(minimum pos)..(maximum pos)])
