import AOC


elems :: (Foldable t, Eq a) => [a] -> t a -> Bool
elems tochk ob = foldl (&&) True (map ($ ob) (map elem tochk))

isPassportValid :: [String] -> Int
isPassportValid pp = fromEnum $ elems ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"] (map (take 3) pp)

main = do
    inp <- readInput
    let entries = map (concat . map words . lines) (splitOn "\n\n" inp)
    print $ sum (map isPassportValid entries)

