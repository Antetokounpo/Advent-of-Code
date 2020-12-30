import AOC
import Data.List
import qualified Data.Map as Map

turn :: Int -> Int -> Map.Map Int Int -> Int
turn c x hs = if c == (30000000-1) then x else case Map.lookup x hs of
                                                              Just n  -> turn (c+1) (c-n) (Map.insert x c hs)
                                                              Nothing -> turn (c+1) 0 (Map.insert x c hs)

main = do
    let inp = [0,1,4,13,15,12,16]
    let hashmap = Map.fromList (zip (init inp) [0..(length inp - 2)])
    print $ turn (length inp - 1) (last inp) hashmap
