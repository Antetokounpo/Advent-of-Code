import System.IO
import Data.Char
import Data.List

replace :: Int -> a -> [a] -> [a]
replace n y (x:xs)
    | n == 0 = y:xs
    | otherwise = x:replace (n-1) y xs

commaToSpace :: [Char] -> [Char]
commaToSpace [] = ""
commaToSpace (x:xs) = if x /= ',' then ([x] ++ commaToSpace xs) else (" " ++ commaToSpace xs)

strToList :: [Char] -> [Int]
strToList xs = map read (words $ commaToSpace xs) :: [Int]

interpretProgram :: [Int] -> Int -> [Int] -> [Int]
interpretProgram xs x inp
    | o == 1 = interpretProgram (replace p3 (p1 + p2) xs) (x+4) inp
    | o == 2 = interpretProgram (replace p3 (p1 * p2) xs) (x+4) inp
    | o == 3 = interpretProgram (replace (xs !! (x+1)) (head inp) xs) (x+2) (tail inp)
    | o == 4 = interpretProgram (xs++[p1]) (x+2) inp
    | o == 5 = interpretProgram xs (if p1 /= 0 then p2 else x+3) inp
    | o == 6 = interpretProgram xs (if p1 == 0 then p2 else x+3) inp
    | o == 7 = interpretProgram (if p1 < p2 then replace p3 1 xs else replace p3 0 xs) (x+4) inp
    | o == 8 = interpretProgram (if p1 == p2 then replace p3 1 xs else replace p3 0 xs) (x+4) inp
    | o == 99 = xs
    | otherwise = error ("Invalid opcode " ++ (show o) ++ " at " ++ show x)
        where o = (xs !! x) `mod` 100
              p1 = if (xs !! x) `div` 100 `mod` 10 == 0 then xs !! (xs !! (x+1)) else xs !! (x+1)
              p2 = if (xs !! x) `div` 1000 == 0 then xs !! (xs !! (x+2)) else xs !! (x+2)
              p3 = xs !! (x+3)

testCombination :: [Int] -> [Int] -> Int -> Int
testCombination program [x] v = last $ interpretProgram program 0 [x, v]
testCombination program combination v = last $ interpretProgram program 0 [last combination, (testCombination program (init combination) v)]

main = do
    input <- getContents
    let program = strToList input
    print $ maximum $ map ((flip $ testCombination program) 0) (permutations [0..4])
