import System.IO

rowToList :: [Char] -> [Int]
rowToList xs = map read (words xs) :: [Int]

strToMatrix :: [Char] -> [[Int]]
strToMatrix xs = map rowToList (lines xs)

rowChecksum :: [Int] -> Int
rowChecksum xs = (maximum xs) - (minimum xs)

checksum :: [[Int]] -> Int
checksum xs = sum (map rowChecksum xs)

main = do
    input <- getContents
    print $ checksum $ strToMatrix input