import AOC

import Data.Map (Map)
import qualified Data.Map as Map

import Data.List

type Tile = [[Char]]

rotate :: Tile -> Tile
rotate = map reverse . transpose

vflip :: Tile -> Tile
vflip = reverse

isAffinity :: Tile -> Tile -> Bool
isAffinity t v = (not . null) $ (map head . perms) t `intersect` (map head . perms) v
    where perms x = concat $ map rotations [x, vflip x]
          rotations x = take 4 $ iterate rotate x

getMatches :: [Tile] -> [Int]
getMatches ts = map ((+(-1)) . length . m) ts
    where m t = filter (isAffinity t) ts

main = do
    inp <- readInput
    let tiles = Map.fromList $ map ((\(x:xs) -> (xs, (init . last) (words x))) . lines) ((init . splitOn "\n\n") inp)
    let ktiles = map fst (Map.toList tiles)
    let etiles = map (read . snd) (Map.toList tiles) :: [Int]
    let is = 2 `elemIndices` getMatches ktiles
    print $ product $ map (etiles !!) is
