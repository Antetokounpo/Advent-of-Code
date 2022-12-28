import System.IO

rowToList :: [Char] -> [Int]
rowToList xs = map read (words xs) :: [Int]

strToMatrix :: [Char] -> [[Int]]
strToMatrix xs = map rowToList (lines xs)

rowChecksum :: [Int] -> Int
rowChecksum (x:xs) = if null e then rowChecksum xs else (max (head e) x) `div` (min (head e) x)
    where e = filter (predicate x) xs
          predicate x y = y `mod` x == 0 || x `mod` y == 0

checksum :: [[Int]] -> Int
checksum xs = sum (map rowChecksum xs)

main = do
    input <- getContents
    print $ checksum $ strToMatrix input