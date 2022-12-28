import System.IO
import Data.Char

strToList :: [Char] -> [Int]
strToList x = map digitToInt $ filter isNumber x

matchSum :: [Int] -> Int
matchSum [x] = 0
matchSum (x:xs) =
    let n = if x == head xs then x else 0
    in n + matchSum xs

main = do
    input <- getContents
    let list = strToList input
    print $ matchSum $ take (length list + 1) (cycle list)