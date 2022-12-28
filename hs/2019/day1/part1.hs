import System.IO

strToList :: [Char] -> [Int]
strToList xs = map read (lines xs) :: [Int]

calcFuel :: Int -> Int
calcFuel x = x `div` 3 - 2

sumFuel :: [Int] -> Int
sumFuel xs = sum $ map calcFuel xs

main = do
    input <- getContents
    print $ sumFuel $ strToList input