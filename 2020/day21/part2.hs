import AOC
import qualified Data.Map as Map
import Data.List

buildDict :: [[[Char]]] -> Map.Map String [[String]]
buildDict list = buildDict' list Map.empty
    where buildDict' [] c = c
          buildDict' ([ingredients, allergens]:xs) currentDict = buildDict' xs (newDict currentDict (splitOn ", " allergens) (words ingredients))
          updateDict m v k = if Map.member k m then Map.adjust (v:) k m else Map.insert k [v] m
          newDict m [] _ = m
          newDict m (k:ks) v = newDict (updateDict m v k) ks v

count :: (Eq a) => [a] -> a -> Int
count xs y = length $ filter (==y) xs

buildAllergensDict :: Map.Map String [String] -> Map.Map String String
buildAllergensDict d = buildDict' (Map.toList d) Map.empty
    where buildDict' [] current = current
          buildDict' dd current = let (k, v) = soloElem (Map.fromList dd) in buildDict' (Map.toList (Map.filter (not . null) (Map.map (\\ v) (Map.fromList dd)))) (Map.insert k (head v) current)
          soloElem dd = head (Map.toList (Map.filter (\x -> length x == 1) dd))


main = do
    inp <- readInput 
    let foods = map (splitOn " (contains " . init) (lines inp)
    let foodsDict = buildDict foods
    let ingredients = concatMap (words . head) foods
    let allergensDict = (Map.map (foldl1 intersect) foodsDict)
    let ingredientsWithAllergens = nub $ concat (Map.elems (Map.map (foldl1 intersect) foodsDict))
    let noAllergensIngredients = nub ingredients \\ ingredientsWithAllergens
    putStrLn $ intercalate "," (map snd ((Map.toAscList  . buildAllergensDict) allergensDict))
