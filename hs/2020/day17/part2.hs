
import AOC
import Control.Comonad
import Data.List
import Control.Monad


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

newtype Universe4D a = Universe4D {getUniverse4D :: Universe (Universe (Universe (Universe a)))} deriving (Show)

instance Functor Universe4D where
    fmap f = Universe4D . (fmap . fmap . fmap . fmap) f . getUniverse4D

instance Comonad Universe4D where
    extract = (extract . extract . extract . extract) . getUniverse4D
    duplicate = fmap Universe4D . Universe4D . duplicate4D . duplicate4D . duplicate4D . duplicate4D . getUniverse4D
        where duplicate4D u = Universe (tail (iterate ((fmap . fmap . fmap) left) u)) u (tail (iterate ((fmap . fmap . fmap) right) u))

goLeft :: Universe4D a -> Universe4D a
goLeft = Universe4D . left . getUniverse4D

goRight :: Universe4D a -> Universe4D a
goRight = Universe4D . right . getUniverse4D

goUp :: Universe4D a -> Universe4D a
goUp = Universe4D . fmap right . getUniverse4D

goDown :: Universe4D a -> Universe4D a
goDown = Universe4D . fmap left . getUniverse4D

goFront :: Universe4D a -> Universe4D a
goFront = Universe4D . (fmap . fmap) right . getUniverse4D

goBack :: Universe4D a -> Universe4D a
goBack = Universe4D . (fmap . fmap) left . getUniverse4D

goHigher :: Universe4D a -> Universe4D a
goHigher = Universe4D . (fmap . fmap . fmap) right . getUniverse4D

goLower :: Universe4D a -> Universe4D a
goLower = Universe4D . (fmap . fmap . fmap) left . getUniverse4D

rule :: Universe4D Bool -> Bool
rule u = if current then (c == 3) || (c == 4) else c == 3
    where c = (length . filter id) neighbours
          neighbours = map (extract . ($ u) . foldl (.) id) (mapM (id:) [[goLeft, goRight], [goUp, goDown], [goFront, goBack], [goHigher, goLower]])
          current = extract u
                       
replace :: a -> Universe4D a -> Universe4D a
replace e u = Universe4D (Universe uuuls (Universe uuls (Universe uls (Universe ls e rs) urs) uurs) uuurs)
            where Universe uuuls (Universe uuls (Universe uls (Universe ls _ rs) urs) uurs) uuurs = getUniverse4D u

initU4D :: Universe4D Bool -> [String] -> Universe4D Bool
initU4D u [] = u
initU4D u (l:ls) = goUp (initU4D (goDown (initLine u l)) ls)
                where initLine uu [] = uu
                      initLine uu (ll:lls) = goLeft (initLine (goRight (replace (ll == '#') uu)) lls)

conwayCycles :: Universe4D Bool -> Int -> Universe4D Bool
conwayCycles u 0 = u
conwayCycles u n = conwayCycles (extend rule u) (n-1)

moveTo :: Int -> Int -> Int -> Int -> Universe4D a -> Universe4D a
moveTo i j k l u = let [a, b, c, d] = map abs [i, j, k, l] in iterate fw (iterate fz (iterate fy (iterate fx u !! a) !! b) !! c) !! d
                                            where fx = if i < 0 then goLeft else goRight
                                                  fy = if j > 0 then goDown else goUp 
                                                  fz = if k > 0 then goBack else goFront
                                                  fw = if l > 0 then goLower else goHigher

countActive :: Universe4D Bool -> Int -> Int
--countActive u c = sum (map (fromEnum . extract . (\[i, j, k, l] -> moveTo i j k l u)) coords)
--                where coords = sequence (replicate 4 [(-c)..c])

universeToList :: Int -> Universe a -> [a]
universeToList n (Universe ls x rs) = reverse (take n ls) ++ [x] ++ take n rs

countActive u c = length (filter id (concatMap (universeToList c) (concatMap (universeToList c) (concatMap (universeToList c) (universeToList c uu)))))
                where coords = replicateM 4 [(-c)..c]
                      uu = getUniverse4D u
main = do
    inp <- readInput
    let ls = lines inp
    let u = pure False :: Universe Bool
    let u3 = (Universe4D . duplicate . duplicate . duplicate) u
    let uu3 = initU4D u3 ls
    print $ countActive (conwayCycles uu3 6) 20

