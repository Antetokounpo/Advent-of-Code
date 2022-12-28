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

newtype Universe3D a = Universe3D {getUniverse3D :: Universe (Universe (Universe a))} deriving (Show)

instance Functor Universe3D where
    fmap f = Universe3D . (fmap . fmap . fmap) f . getUniverse3D

instance Comonad Universe3D where
    extract = (extract . extract . extract) . getUniverse3D
    duplicate = fmap Universe3D . Universe3D . duplicate3D . duplicate3D . duplicate3D . getUniverse3D
        where duplicate3D u = Universe (tail (iterate ((fmap . fmap) left) u)) u (tail (iterate ((fmap . fmap) right) u))

goLeft :: Universe3D a -> Universe3D a
goLeft = Universe3D . left . getUniverse3D

goRight :: Universe3D a -> Universe3D a
goRight = Universe3D . right . getUniverse3D

goUp :: Universe3D a -> Universe3D a
goUp = Universe3D . fmap right . getUniverse3D

goDown :: Universe3D a -> Universe3D a
goDown = Universe3D . fmap left . getUniverse3D

goFront :: Universe3D a -> Universe3D a
goFront = Universe3D . (fmap . fmap) right . getUniverse3D

goBack :: Universe3D a -> Universe3D a
goBack = Universe3D . (fmap . fmap) left . getUniverse3D

rule :: Universe3D Bool -> Bool
rule u = if current then (c == 3) || (c == 4) else c == 3
    where c = (length . filter id) neighbours
          neighbours = map (extract . ($ u) . foldl (.) id) (mapM (id:) [[goLeft, goRight], [goUp, goDown], [goFront, goBack]])
          current = extract u
                       
replace :: a -> Universe3D a -> Universe3D a
replace e u = Universe3D (Universe uuls (Universe uls (Universe ls e rs) urs) uurs)
            where Universe uuls (Universe uls (Universe ls _ rs) urs) uurs = getUniverse3D u

initU3D :: Universe3D Bool -> [String] -> Universe3D Bool
initU3D u [] = u
initU3D u (l:ls) = goUp (initU3D (goDown (initLine u l)) ls)
                where initLine uu [] = uu
                      initLine uu (ll:lls) = goLeft (initLine (goRight (replace (ll == '#') uu)) lls)

conwayCycles :: Universe3D Bool -> Int -> Universe3D Bool
conwayCycles u 0 = u
conwayCycles u n = conwayCycles (extend rule u) (n-1)

moveTo :: Int -> Int -> Int -> Universe3D a -> Universe3D a
moveTo i j k u = let [a, b, c] = map abs [i, j, k] in iterate fz (iterate fy (iterate fx u !! a) !! b) !! c
                                            where fx = if i < 0 then goLeft else goRight
                                                  fy = if j > 0 then goDown else goUp 
                                                  fz = if k > 0 then goBack else goFront

universeToList :: Int -> Universe a -> [a]
universeToList n (Universe ls x rs) = reverse (take n ls) ++ [x] ++ take n rs

countActive :: Universe3D Bool -> Int -> Int
--countActive u c = sum (map (fromEnum . extract . (\[i, j, k] -> moveTo i j k u)) coords)
--                where coords = sequence (replicate 3 [(-c)..c])

countActive u c = length (filter id (concatMap (universeToList c) (concatMap (universeToList c) (universeToList c uu))))
                where coords = replicateM 3 [(-c)..c]
                      uu = getUniverse3D u

main = do
    inp <- readInput
    let ls = lines inp
    let u = pure False :: Universe Bool
    let u3 = (Universe3D . duplicate . duplicate) u
    let uu3 = initU3D u3 ls
    print $ countActive (conwayCycles uu3 6) 40

