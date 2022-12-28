import AOC

import Data.Char
import Text.Read

elems :: (Foldable t, Eq a) => [a] -> t a -> Bool
elems tochk ob = foldl (&&) True (map ($ ob) (map elem tochk))

isPassportValid :: [String] -> Bool
isPassportValid pp = elems ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"] (map (take 3) pp)

isPassportValid' :: [String] -> Int
isPassportValid' pp = fromEnum $ foldl (&&) True (map isFieldValid pp)

isYearValid :: String -> Int -> Int -> Bool
isYearValid y min max = case (readMaybe y :: Maybe Int) of
                                Nothing -> False
                                Just x -> (x >= min) && (x <= max)

isByrValid :: String -> Bool
isByrValid byr = isYearValid byr 1920 2002

isIyrValid :: String -> Bool
isIyrValid iyr = isYearValid iyr 2010 2020

isEyrValid :: String -> Bool
isEyrValid eyr = isYearValid eyr 2020 2030

isHgtValid :: String -> Bool
isHgtValid hgt
    | u == "mc" && (h >= 150) && (h <= 193) = True
    | u == "ni" && (h >= 59) && (h <= 76) = True
    | otherwise = False
    where u = take 2 (reverse hgt)
          h = case readMaybe (takeWhile isDigit hgt) :: Maybe Int of
                    Nothing -> 0
                    Just x -> x

isHclValid :: String -> Bool
isHclValid hcl = x == '#' && all isHexDigit xs && all (not . isUpper) xs
                    where (x:xs) = hcl

isEclValid :: String -> Bool
isEclValid ecl = elem ecl ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

isPidValid :: String -> Bool
isPidValid pid = (length pid == 9) && (all isDigit pid)

isFieldValid :: String -> Bool
isFieldValid xs = case i of "byr" -> isByrValid j
                            "iyr" -> isIyrValid j
                            "eyr" -> isEyrValid j
                            "hgt" -> isHgtValid j
                            "hcl" -> isHclValid j
                            "ecl" -> isEclValid j
                            "pid" -> isPidValid j
                            "cid" -> True
                        where i = take 3 xs
                              j = drop 4 xs

main = do
    inp <- readInput
    let entries = map (concat . map words . lines) (splitOn "\n\n" inp)
    print $ sum (map isPassportValid' (filter isPassportValid entries))

