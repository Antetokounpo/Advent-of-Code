import System.IO
import Data.List
import Data.Tuple
import Data.Maybe
import qualified Data.Map as Map

strToList :: [Char] -> [([Char], [Char])]
strToList xs = map swap (map (splitAt 3) (map (delete ')') (lines xs)))

getOrbits :: Map.Map [Char] [Char] -> [Char] -> [[Char]]
getOrbits xs x = if x == "COM" then ["COM"] else [x] ++ getOrbits xs (fromMaybe "COM" (Map.lookup x xs))

main = do
    input <- getContents
    let orbits = strToList input
    let orbitsMap = Map.fromList orbits
    print $ (length $ (getOrbits orbitsMap "YOU") \\ (getOrbits orbitsMap "SAN")) + (length $ (getOrbits orbitsMap "SAN") \\ (getOrbits orbitsMap "YOU")) - 2