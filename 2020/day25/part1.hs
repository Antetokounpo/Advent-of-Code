import AOC
import Data.List


numberTransform sub v = (sub*v) `mod` 20201227

main = do
    inp <- readInput
    let [cardpub, doorpub] = map read (lines inp) :: [Int]
    let loopsizes = iterate (numberTransform 7) 1
    let cardloopsize = head $ elemIndices cardpub loopsizes
    let doorloopsize = head $ elemIndices doorpub loopsizes
    print $ iterate (numberTransform cardpub) 1 !! doorloopsize
