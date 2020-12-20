import System.Environment

slide :: Int -> Int -> [String] -> Int
slide x y grid = if grid !! y !! (x `mod` (length . head $ grid)) == '#' then 1 else 0

slope :: [String] -> Int -> Int -> Int -> Int
slope grid i j n = slide (n*i) (n*j) grid

sumTrees :: [String] -> Int -> Int -> Int
sumTrees grid i j = sum $ map (slope grid i j) [0..(length grid) `div` j - 1]

main = do
    (filename:_) <- getArgs
    inp <- readFile filename
    let grid = lines inp
    let p = product $ map (uncurry $ sumTrees grid) [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
    print p
     

