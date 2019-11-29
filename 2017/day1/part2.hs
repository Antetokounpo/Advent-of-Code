import System.IO
import Data.Char

strToList :: [Char] -> [Int]
strToList x = map digitToInt $ filter isNumber x

matchSum :: [Int] -> Int -> Int
matchSum (x:xs) i
    | length xs == i-1 = 0
    | otherwise = 
        let n = if x == xs !! (i-1) then x else 0
        in n + matchSum xs i

main = do
    input <- getContents
    let list = strToList input
    let halfLength = length list `div` 2
    print $ matchSum (take (length list + halfLength) (cycle list)) halfLength