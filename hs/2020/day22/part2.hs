import AOC

playGame :: [Int] -> [Int] -> [([Int], [Int])] -> ([Int], [Int])
playGame d [] _ = (d, [])
playGame [] d _ = ([], d)
playGame (c1:d1) (c2:d2) stack 
    | (c1:d1, c2:d2) `elem` stack = (c1:d1, [])
    | length d1 >= c1 && length d2 >= c2 = let (_, dd2) = recursiveCombat (c1:d1) (c2:d2) in whoWins (null dd2)
    | otherwise = whoWins (c1 > c2) 
        where recursiveCombat (c1':d1') (c2':d2') = playGame (take c1' d1') (take c2' d2') []
              player1Wins = playGame (d1 ++ [c1, c2]) d2 ((c1:d1, c2:d2):stack)
              player2Wins = playGame d1 (d2 ++ [c2, c1]) ((c1:d1, c2:d2):stack)
              whoWins predicate = if predicate then player1Wins else player2Wins


main = do
    inp <- readInput
    let [d1, d2] = map (map read . tail . lines) (splitOn "\n\n" inp) :: [[Int]]
    let endDecks = playGame d1 d2 []
    let endDeck = reverse $ uncurry (++) endDecks
    print $ sum (map (\x -> (endDeck !! x)*(x+1)) [0..(length endDeck - 1)])
