import AOC
import Data.Char
import Data.List

modulo a b = ((mod a b) + b) `mod` b

moveCups :: [Int] -> [Int]
moveCups (p:c1:c2:c3:cups) = take (index + 1) cups ++ [c1,c2,c3] ++ drop (index + 1) cups ++ [p]
    where labels = map ((`modulo` 10) . (p-)) [1..9]
          index = (head . head) $ filter (not . null) (map (`elemIndices` cups) labels)


main = do
    let inp = map digitToInt "315679824" :: [Int]
    let finalCups = iterate moveCups inp !! 100
    let index = head $ 1 `elemIndices` finalCups
    let (ys, x:xs) = splitAt index finalCups
    putStrLn $ map intToDigit (xs ++ ys)