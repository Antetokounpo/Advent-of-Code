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

main = do
    input <- getContents
    let program = replace 2 2 (replace 1 12 (strToList input))
    print $ interpretProgram program 0 !! 0
