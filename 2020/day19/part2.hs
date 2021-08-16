
import AOC

import Data.Map (Map)
import qualified Data.Map as Map

import Text.ParserCombinators.Parsec
import Text.Parsec.Expr as E

import Text.Regex.PCRE

type TNumber = Int

data TExpression = TBinary TExpression String TExpression
                 | TChar Char
                 | TNums [TNumber]
                 deriving (Eq, Show)

lexeme :: Parser a -> Parser a
lexeme p = do
    x <- p
    spaces
    return x

charExpression :: Parser TExpression
charExpression = do
    lexeme (char '"')
    e <- letter
    lexeme (char '"')
    return (TChar e)

numsExpression :: Parser TExpression
numsExpression = do
    e <- fmap read . words<$> many (noneOf "|\n")
    return (TNums e)

term :: Parser TExpression
term = charExpression <|> numsExpression

table =  [[binary "|" E.AssocLeft]]
    where binary name assoc = E.Infix (flip TBinary name <$ lexeme (string name)) assoc

expr :: Parser TExpression
expr = E.buildExpressionParser table term

tuplify2 :: [a] -> (a, a)
tuplify2 [x, y] = (x, y)

parseExpression :: String -> TExpression
parseExpression xs = case parse expr "" xs of Right z -> z

parseRules :: [String] -> Map Int TExpression
parseRules rs = getMap
    where getMap = Map.fromList (map ((\(x, y) -> (read x, parseExpression y)) . tuplify2 . splitOn ": ") rs)

eval :: Map Int TExpression -> TExpression -> String
eval rules = evalExp
    where lookupRule k = case Map.lookup k rules of Just n -> n
          parens xs = "(" ++ xs ++ ")"
          evalExp (TBinary (TNums [42]) "|" (TNums [42, 8])) = parens (evalExp (lookupRule 42)) ++ "+"
          evalExp (TBinary (TNums [42, 31]) "|" (TNums [42, 11, 31])) = parens (evalExp (lookupRule 42) ++ "(?1)?" ++ evalExp (lookupRule 31))
          evalExp (TChar x) = [x]
          evalExp (TNums xs) = concat $ map (evalExp . lookupRule) xs
          evalExp (TBinary a "|" b) = parens (evalExp a ++ "|" ++ evalExp b)
          evalExp _ = ""

dropEnd :: Int -> String -> String 
dropEnd n xs = take (length xs - n) xs

main = do
    inp <- readInput
    let [rules, strings] = map lines (splitOn "\n\n" inp)
    let rulesMap = (Map.insert 8 (parseExpression "42 | 42 8") . Map.insert 11 (parseExpression "42 31 | 42 11 31")) (parseRules rules)
    let startRule = case Map.lookup 8 rulesMap of Just n -> n
    let endRule = case Map.lookup 11 rulesMap of Just n -> n
    let r1 = "^(" ++ eval rulesMap startRule ++ ")$" -- Du début à la fin de la string, car on coupe la string après les matchs de la règle 11. Donc pour s'assurer que la fin match et le début **intégralement**
    let r2 = "(" ++ eval rulesMap endRule ++ ")$"
    let b2 = map (=~ r2) strings :: [String] -- On commence par la fin, parce que la dernière règle a besoin de symétrie et puisqu'on coupe la string, on ne veut pas couper trop le début. La règle 8 regarde si 42 match 1 ou +, donc il pourrait couper les 42 de la dernière règle.
    let b1 = map (=~ r1) (zipWith dropEnd (map length b2) strings) :: [Bool] -- On drop la fin de la string selon le match qu'on a eu avec la règle 11. 
    let b = zipWith (&&) b1 (map (not . null) b2)
    print $ length (filter id b)
