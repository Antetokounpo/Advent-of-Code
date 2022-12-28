import AOC
import Control.Comonad
import Data.Char (digitToInt)

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

initU2D :: [[a]] -> Universe2D a -> Universe2D a
initU2D [] u = u
initU2D (x:xs) u = (goUp . initU2D xs . goDown . initLine x) u 
    where initLine [] uu = uu
          initLine (y:ys) uu = (goLeft . initLine ys . goRight . replace y) uu

rule :: Universe2D Int -> Int
rule u = if all (current <) neighbours then (-1) else current
    where neighbours = map (extract . ($ u)) [goUp, goDown, goLeft, goRight]
          current = extract u

crawlPoint u = if extract u == -1 then crawlPoint' 0 u else 0
    where crawlPoint' s u | extract u == 9 = 1
                          | otherwise = s + sum (map (crawlPoint' 0 . ($ u)) [goLeft, goRight, goUp, goDown])

dynamicCrawl u = if extract u == -1 then crawlPoint' 0 u else 0
    where crawlPoint' s u | extract u == 9 = 1
                          | otherwise = s + sum (map (crawlPoint' 0 . ($ u)) [goLeft, goRight, goUp, goDown])

countLows u n m = countLows' u n m 0
    where countLows' _ 0 _ s = s
          countLows' u n m s = countLows' (goDown u) (n-1) m (s + countLine u m 0)
          countLine _ 0 s = s
          countLine u n s = countLine (goRight u) (n-1) (s + extract u)

takeGrid u n m = map (takeLine m) (take n (iterate goDown u))
    where takeLine n u = map extract (take n (iterate goRight u))

main = do
    inp <- readInput
    let lavatubes = map (map digitToInt) (lines inp)
    let universe = initU2D lavatubes (pure 9) :: Universe2D Int
    let (n, m) = (length lavatubes, length (head lavatubes))
    print $ takeGrid ((extend rule) universe) n m
