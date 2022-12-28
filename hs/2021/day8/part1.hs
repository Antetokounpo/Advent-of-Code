import AOC

count :: Eq a => a -> [a] -> Int
count x xs = length $ filter (==x) xs

countOutputs :: (Eq a, Num a) => [[a]] -> Int
countOutputs xs = sum $ map count [2, 4, 3, 7] <*> xs

main = do
    inp <- readInput
    let signals = map (map words . splitOn "|") (lines inp)
    print $ countOutputs (map (map length . last) signals)
