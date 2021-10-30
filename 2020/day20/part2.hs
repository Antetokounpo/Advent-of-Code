import AOC

import Data.Map (Map)
import qualified Data.Map as Map

import Data.List

import System.IO
import Debug.Trace

type Tile = [[Char]]

rotate :: Tile -> Tile
rotate = map reverse . transpose

vflip :: Tile -> Tile
vflip = reverse

perms x = concat $ map rotations [x, vflip x]
    where rotations x = take 4 $ iterate rotate x

isAffinity :: Tile -> Tile -> Bool
isAffinity t v = (not . null) $ (map head . perms) t `intersect` (map head . perms) v

getBottom :: Tile -> [Char]
getBottom t = last t

getTop :: Tile -> [Char]
getTop t = head t

getRight :: Tile -> [Char]
getRight t = map last t

getLeft :: Tile -> [Char]
getLeft t = map head t

isAffinityLeft :: Tile -> Tile -> Bool
isAffinityLeft t1 t2 = getLeft t1 == getRight t2

isAffinityRight :: Tile -> Tile -> Bool
isAffinityRight t1 t2 = isAffinityLeft t2 t1


isAffinityBottom :: Tile -> Tile -> Bool
isAffinityBottom t1 t2 = getBottom t1 == getTop t2

isAffinityTop :: Tile -> Tile -> Bool
isAffinityTop t1 t2 = isAffinityBottom t2 t1

buildInitCorner corner r d = [correctOrientation, rPerms !! head (getRight correctOrientation `elemIndices` leftSides), dPerms !! head (getBottom correctOrientation `elemIndices` topSides)]
    where rPerms = perms r
          dPerms = perms d
          cornerPerms = perms corner
          rightSides = map getRight cornerPerms
          bottomSides = map getBottom cornerPerms
          leftSides = map getLeft rPerms
          topSides = map getTop dPerms
          right = filter (`elem` leftSides) rightSides
          bottom = filter (`elem` topSides) bottomSides
          cornerOrientations = concat $ map (`elemIndices` rightSides) right ++ map (`elemIndices` bottomSides) bottom
          correctOrientation = cornerPerms !! head (cornerOrientations \\ nub cornerOrientations)

getMatches :: [Tile] -> [Int]
getMatches ts = map ((+(-1)) . length . m) ts
    where m t = filter (isAffinity t) ts

neighbours :: [[Tile]] -> Int -> Int -> [Tile]
neighbours ts i j = [l, r, u, d]
    where l = if j == 0 then [] else ts !! i !! (j-1)
          r = if j == 11 then [] else ts !! i !! (j+1)
          u = if i == 0 then [] else ts !! (i-1) !! j
          d = if i == 11 then [] else ts !! (i+1) !! j

getPossibleChoices :: [Tile] -> [[Tile]] -> Int -> Int -> [Tile]
getPossibleChoices ts im i j = filter (`notElem` concatMap perms [l, r, u, d]) (concat $ filter (not . null) (map correctOrientationChoicesUnique ts))
    where [l, r, u, d] = neighbours im i j
          correctOrientationsChoices t =  map (\(s, f) -> filter (f s) (perms t)) (filter (not . null . fst) (zip [l, r, u, d] [isAffinityRight, isAffinityLeft, isAffinityBottom, isAffinityTop]))
          correctOrientationChoicesUnique t = if null (correctOrientationsChoices t) then [] else (foldl1 intersect . correctOrientationsChoices) t
          isEmptyInside xs = [] `elem` xs

buildImage :: Tile -> [Tile] -> [[Tile]]
buildImage corner ts = iterate constructImage initImage !! 141
        where [r, d] = filter (isAffinity corner) ts -- Les 2 tiles qui ont une affinité avec le coin
              [cornerOrientation, right, down] = buildInitCorner corner r d
              initImage = [[cornerOrientation, right] ++ replicate 10 [], down : replicate 11 []] ++ replicate 10 (replicate 12 [])
              emptyCells im = filter (\[i, j] -> null (im !! i !! j)) (sequence [[0..11], [0..11]])
              fillImage im tiles = head $ filter (not . null) (map (\[i, j] -> let ks = getPossibleChoices tiles im i j in if length ks == 1 then replaceInMatrix im i j (head ks) else []) (emptyCells im))
              constructImage im = fillImage im ts

cutCorners :: Tile -> Tile
cutCorners = cut . map cut
    where cut = take 8 . drop 1



writeTileMap tilemap = do
    let linesMap = map (unlines . map unwords . transpose . filter (not . null)) tilemap
    writeFile "tile.txt" (unlines linesMap)

isDragon :: Tile -> Int -> Int -> Bool
isDragon t i j = all (\(ii, jj) -> t !! (ii+i) !! (jj+j) == '#') [(0, 0), (1, 1), (1, 4), (0, 5), (0, 6), (1, 7), (1, 10), (0, 11), (0, 12), (1, 13), (1, 16), (0, 17), (0, 18), (-1, 18), (0, 19)]

countDragons :: Tile -> Int 
countDragons t = length $ filter id (concatMap (\i -> map (isDragon t i) [0..76]) [1..94])


main = do
    inp <- readInput
    let tiles = Map.fromList $ map ((\(x:xs) -> (xs, (init . last) (words x))) . lines) ((init . splitOn "\n\n") inp)
    let ktiles = map fst (Map.toList tiles)
    let etiles = map (read . snd) (Map.toList tiles) :: [Int]
    let cornerIndex = filter ((==2) . (getMatches ktiles !!)) [0..(length ktiles - 1)] !! 0
    let corner = ktiles !! cornerIndex
    let image = buildImage corner (ktiles \\ [corner])
    let cutImage = map (map cutCorners) image
    let imageMatrix = concat $ map (map (intercalate "") .  transpose) cutImage
    let correctOrientation = head $ filter ((/= 0) . countDragons) (perms imageMatrix)
    print $ length (filter (=='#') (concat correctOrientation)) - (countDragons correctOrientation)*15

