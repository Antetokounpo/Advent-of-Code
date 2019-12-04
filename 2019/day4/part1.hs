import System.IO

adjacentDigitCheck :: [Char] -> Bool
adjacentDigitCheck [x] = False
adjacentDigitCheck (x:xs) = if x == head xs then True else adjacentDigitCheck xs

neverDeacreaseCheck :: [Char] -> Bool
neverDeacreaseCheck [x] = True
neverDeacreaseCheck (x:xs) = if show x > show (head xs) then False else neverDeacreaseCheck xs

testPass :: [Char] -> Bool
testPass xs = (adjacentDigitCheck xs && neverDeacreaseCheck xs)

main = do
    let input = [197487, 673251]
    print $ length $ filter (testPass) (map show [(head input)..(last input)])

    