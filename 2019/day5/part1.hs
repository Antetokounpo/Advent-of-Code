import System.IO
import Data.Char

replace :: Int -> a -> [a] -> [a]
replace n y (x:xs)
    | n == 0 = y:xs
    | otherwise = x:replace (n-1) y xs

commaToSpace :: [Char] -> [Char]
commaToSpace [] = ""
commaToSpace (x:xs) = if x /= ',' then ([x] ++ commaToSpace xs) else (" " ++ commaToSpace xs)

strToList :: [Char] -> [Int]
strToList xs = map read (words $ commaToSpace xs) :: [Int]

interpretProgram :: [Int] -> Int -> [Int]
interpretProgram xs x
    | o == 1 = interpretProgram (replace p3 (p1 + p2) xs) (x+4)
    | o == 2 = interpretProgram (replace p3 (p1 * p2) xs) (x+4)
    | o == 3 = interpretProgram (replace (xs !! (x+1)) 1 xs) (x+2)
    | o == 4 = interpretProgram (xs++[p1]) (x+2)
    | o == 99 = xs
    | otherwise = error ("Invalid opcode " ++ (show o) ++ " at " ++ show x)
        where o = (xs !! x) `mod` 100
              p1 = if (xs !! x) `div` 100 `mod` 10 == 0 then xs !! (xs !! (x+1)) else xs !! (x+1)
              p2 = if (xs !! x) `div` 1000 == 0 then xs !! (xs !! (x+2)) else xs !! (x+2)
              p3 = xs !! (x+3)

main = do
    input <- getContents
    let program = strToList input
    print $ last $ interpretProgram program 0  
