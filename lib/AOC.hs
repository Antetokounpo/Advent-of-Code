module AOC
( splitOn,
  readInput
) where

import Data.List
import System.Environment

splitOn' :: Eq a => [a] -> [a] -> [a] -> [[a]]
splitOn' c [] cstr = [cstr]
splitOn' c str cstr = if isPrefixOf c w then (cstr ++ m) : (splitOn' c (drop (length c) w) []) else splitOn' c (tail str) (cstr ++ [head str])
                        where f = head c
                              w = dropWhile (/= f) str
                              m = takeWhile (/= f) str

splitOn :: Eq a => [a] -> [a] -> [[a]]
splitOn c str = splitOn' c str []

{-
splitOn :: Eq a => [a] -> [a] -> [[a]]
splitOn c [] = []
splitOn c str = if isPrefixOf c w then m : (splitOn c (drop (length c) w)) else (k : k') : rstr'
                   where f = head c
                         w = dropWhile (/= f) str
                         m = takeWhile (/= f) str
                         (k:rstr) = str
                         (k':rstr') = splitOn c rstr
-}


readInput :: IO String
readInput = do
        (filename:_) <- getArgs
        x <- readFile filename
        return x
