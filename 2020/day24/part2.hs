import AOC
import Data.List
import Control.Monad
import Control.Comonad
import Control.DeepSeq
import Text.Regex.Posix ( (=~), AllTextMatches(getAllTextMatches) )

data Universe a = Universe [a] a [a] deriving (Show)

left :: Universe a -> Universe a
left (Universe (l:ls) x rs) = Universe ls l (x:rs)

right :: Universe a -> Universe a
right (Universe ls x (r:rs)) = Universe (x:ls) r rs

instance Functor Universe where
    fmap f (Universe ls x rs) = Universe (fmap f ls) (f x) (fmap f rs)

instance Applicative Universe where
    pure c = Universe cs c cs where cs = repeat c
    (Universe lfs f rfs) <*> (Universe ls x rs) = Universe (zipWith ($) lfs ls) (f x) (zipWith ($) rfs rs)

instance Comonad Universe where
    extract (Universe ls x rs) = x
    duplicate u = Universe (tail (iterate left u)) u (tail (iterate right u))

newtype Universe2D a = Universe2D {getUniverse2D :: Universe (Universe a)} deriving (Show)

instance Functor Universe2D where
    fmap f = Universe2D . (fmap . fmap) f . getUniverse2D

instance Applicative Universe2D where
    pure = Universe2D . duplicate . upure
                where upure = pure :: a -> Universe a
    fs <*> u = Universe2D (Universe (zipWith (<*>) lfs ls) (f <*> x) (zipWith (<*>) rfs rs))
                where (Universe lfs f rfs) = getUniverse2D fs
                      (Universe ls x rs)   = getUniverse2D u

instance Comonad Universe2D where
    extract = (extract . extract) . getUniverse2D
    duplicate = fmap Universe2D . Universe2D . duplicate2D . duplicate2D . getUniverse2D
                where duplicate2D u = Universe (tail (iterate (fmap left) u)) u (tail (iterate (fmap right) u))


goLeft :: Universe2D a -> Universe2D a
goLeft = Universe2D . left . getUniverse2D

goRight :: Universe2D a -> Universe2D a
goRight = Universe2D . right . getUniverse2D

goUp :: Universe2D a -> Universe2D a
goUp = Universe2D . fmap right . getUniverse2D

goDown :: Universe2D a -> Universe2D a
goDown = Universe2D . fmap left . getUniverse2D

moveTo :: Int -> Int -> Universe2D a -> Universe2D a
moveTo i j u = let [a, b] = map abs [i, j] in iterate fy (iterate fx u !! a) !! b
                                            where fx = if i < 0 then goLeft else goRight
                                                  fy = if j > 0 then goDown else goUp

replace :: a -> Universe2D a -> Universe2D a
replace e u = Universe2D (Universe uls (Universe ls e rs) urs)
            where Universe uls (Universe ls x rs) urs = getUniverse2D u

rule :: Universe2D Bool -> Bool 
rule u 
    | current && (c == 0 || c > 2) = False
    | not current && c == 2 = True
    | otherwise = current
        where current = extract u
              neighbours = map (extract . (\(i, j) -> moveTo i j u) . moveTile (0, 0)) ["e", "se", "sw", "w", "nw", "ne"]
              c = length $ filter id neighbours

universeToList :: Int -> Universe a -> [a]
universeToList n (Universe ls x rs) = reverse (take n ls) ++ [x] ++ take n rs

countActive u c = length (filter id (concatMap (universeToList c) (universeToList c uu)))
                where uu = getUniverse2D u

moveTile :: (Num a1, Num a2) => (a1, a2) -> [Char] -> (a1, a2)
moveTile (i, j) "e" = (i+1, j)
moveTile (i, j) "se" = (i, j+1)
moveTile (i, j) "sw" = (i-1, j+1)
moveTile (i, j) "w" = (i-1, j)
moveTile (i, j) "nw" = (i, j-1)
moveTile (i, j) "ne" = (i+1, j-1)

runCycles u 0 = u
runCycles u n = runCycles (extend rule u) (n-1)

main = do
    inp <- readInput
    let tiles = lines inp
    let pat = "e|se|sw|w|nw|ne"
    let r = map (getAllTextMatches . (=~ pat)) tiles :: [[String]]
    let m = map (foldl moveTile (0,0)) r
    let counts = map (length . (`elemIndices` m)) m
    let switches = map fst (filter ((/=0) . (`mod` 2) . snd) (zip m counts))
    let u = pure False :: Universe2D Bool
    let uinit = foldl (\uni (i, j) -> moveTo (-i) (-j) (replace True (moveTo i j uni))) u switches
    let ufinal = runCycles uinit 100
    print $ countActive ufinal 120
