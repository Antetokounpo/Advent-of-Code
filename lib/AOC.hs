module AOC
( splitOn,
  readInput,
  replaceInList,
  replaceInMatrix
) where

import Data.List ( isPrefixOf )
import System.Environment

splitOn' :: Eq a => [a] -> [a] -> [a] -> [[a]]
splitOn' c [] cstr = [cstr]
splitOn' c str cstr = if isPrefixOf c w then (cstr ++ m) : (splitOn' c (drop (length c) w) []) else splitOn' c (tail str) (cstr ++ [head str])
                        where f = head c
                              w = dropWhile (/= f) str
                              m = takeWhile (/= f) str

splitOn :: Eq a => [a] -> [a] -> [[a]]
splitOn c str = splitOn' c str []

replaceInList :: [a] -> Int -> a -> [a]
replaceInList xs i y = x ++ y:ys
      where (x,_:ys) = splitAt i xs

replaceInMatrix :: [[a]] -> Int -> Int -> a -> [[a]]
replaceInMatrix xs i j y = replaceInList xs i (replaceInList (xs !! i) j y)

readInput :: IO String
readInput = do
        (filename:_) <- getArgs
        x <- readFile filename
        return x
