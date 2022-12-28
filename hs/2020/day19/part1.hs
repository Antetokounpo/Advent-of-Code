import AOC

import Data.Map (Map)
import qualified Data.Map as Map

import Text.ParserCombinators.Parsec
import Text.Parsec.Expr as E

import Text.Regex.Posix

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

parseRules :: [String] -> Map Int TExpression
parseRules rs = getMap
    where getMap = Map.fromList (map ((\(x, y) -> (read x, case parse expr "" y of Right z -> z)) . tuplify2 . splitOn ": ") rs)

eval :: Map Int TExpression -> TExpression -> String
eval rules = evalExp 
    where lookupRule k = case Map.lookup k rules of Just n -> n
          parens xs = "(" ++ xs ++ ")"
          evalExp (TChar x) = [x]
          evalExp (TNums xs) = concat $ map (evalExp . lookupRule) xs
          evalExp (TBinary a "|" b) = parens (evalExp a ++ "|" ++ evalExp b)

main = do
    inp <- readInput
    let [rules, strings] = map lines (splitOn "\n\n" inp)
    let rulesMap = parseRules rules
    let initRule = case Map.lookup 0 rulesMap of Just n -> n
    let r = "^" ++ eval rulesMap initRule ++ "$"
    let b = map (=~ r) strings :: [Bool]
    print $ length (filter id b)
