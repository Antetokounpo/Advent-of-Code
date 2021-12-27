import AOC
import Data.List

summation :: Integer -> Integer
summation n = (n+1) * n `div` 2

computeFuel :: [Integer] -> Integer -> Integer
computeFuel xs x = sum (map (summation . abs . (x-)) xs)

main = do
    inp <- readInput
    let pos = map read (splitOn "," inp) :: [Integer]
    print $ minimum (map (computeFuel pos) [(minimum pos)..(maximum pos)])
