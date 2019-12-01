import System.IO

strToList :: [Char] -> [Int]
strToList xs = map read (lines xs) :: [Int]

calcFuel :: Int -> Int
calcFuel x
    | y <= 0 = 0
    | otherwise = y + calcFuel y
        where y = x `div` 3 - 2

sumFuel :: [Int] -> Int
sumFuel xs = sum $ map calcFuel xs

main = do
    input <- getContents
    print $ sumFuel $ strToList input