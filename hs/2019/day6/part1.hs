import System.IO
import Data.List
import Data.Tuple
import Data.Maybe
import qualified Data.Map as Map

strToList :: [Char] -> [([Char], [Char])]
strToList xs = map swap (map (splitAt 3) (map (delete ')') (lines xs)))

countOrbits :: Map.Map [Char] [Char] -> [Char] -> Int
countOrbits xs x = if x == "COM" then 1 else 1 + countOrbits xs (fromMaybe "COM" (Map.lookup x xs))

main = do
    input <- getContents
    let orbits = strToList input
    let orbitsMap = Map.fromList orbits
    print $ sum $ map (countOrbits orbitsMap) (map snd orbits)