import System.Environment

slide :: Int -> Int -> [String] -> Int
slide x y grid = if grid !! y !! (x `mod` (length . head $ grid)) == '#' then 1 else 0

slope :: [String] -> Int -> Int
slope grid n = slide (n*3) (n*1) grid

main = do
    (filename:_) <- getArgs
    inp <- readFile filename
    let grid = lines inp
    let s = sum $ map (slope grid) [0..(length grid)-1] 
    print s
     
