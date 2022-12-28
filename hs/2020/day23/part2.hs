import AOC
import Data.Char
import Data.List
import Data.Maybe
import Data.Vector (Vector)
import qualified Data.Vector as Vector

cupNumber :: Int
cupNumber = 1000000

modulo :: Integral a => a -> a -> a
modulo a b = ((mod a b) + b) `mod` b

moveCups :: Vector Int -> Vector Int
moveCups cups = Vector.concat [xs, Vector.fromList threegroup, ys, Vector.fromList [p]]
    where p = Vector.head cups
          c1 = cups Vector.! 1
          c2 = cups Vector.! 2
          c3 = cups Vector.! 3
          threegroup = [c1, c2, c3]
          cups' = Vector.drop 4 cups
          labels = map ((`modulo` (cupNumber + 1)) . (p-)) [1..cupNumber]
          index = case head (filter (not . null) (map (`Vector.elemIndex` cups') labels)) of Just n -> n
          (xs, ys) = Vector.splitAt (index + 1) cups'

main = do
    let inp = map digitToInt "315679824" :: [Int]
    let cups = inp ++ [10..cupNumber]
    let finalCups = iterate moveCups (Vector.fromList cups) !! 1000
    let index = Vector.head $ 1 `Vector.elemIndices` finalCups
    let a = finalCups Vector.! ((index+1) `mod` cupNumber)
    let b = finalCups Vector.! ((index+2) `mod` cupNumber)
    print a
    print b
