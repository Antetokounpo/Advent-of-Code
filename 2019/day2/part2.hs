import System.IO
import Data.Char

replace :: Int -> a -> [a] -> [a]
replace i y xs = x ++ y : ys
    where (x,_:ys) = splitAt i xs

commaToSpace :: [Char] -> [Char]
commaToSpace [] = ""
commaToSpace (x:xs) = if isNumber $ x then ([x] ++ commaToSpace xs) else (" " ++ commaToSpace xs)

strToList :: [Char] -> [Int]
strToList xs = map read (words $ commaToSpace xs) :: [Int]

interpretProgram :: [Int] -> Int -> [Int]
interpretProgram xs x
    | o == 1 = interpretProgram (replace (xs !! (x+3)) ((xs !! (xs !! (x+1))) + (xs !! (xs !! (x+2)))) xs) (x+4)
    | o == 2 = interpretProgram (replace (xs !! (x+3)) ((xs !! (xs !! (x+1))) * (xs !! (xs !! (x+2)))) xs) (x+4)
    | o == 99 = xs
    | otherwise = error "Invalid opcode"
        where o = xs !! x

getOutput :: Int -> Int -> [Int] -> Int
getOutput n v p = interpretProgram (replace 2 v (replace 1 n p)) 0 !! 0

bruteForce :: [Int] -> Int -> Int -> Int
bruteForce p n v
    | o == 19690720 = 100*n+v
    | v == 99 = bruteForce p (n+1) 0
    | otherwise = bruteForce p n (v+1)
        where o = getOutput n v p

main = do
    input <- getContents
    print $ bruteForce (strToList input) 0 0