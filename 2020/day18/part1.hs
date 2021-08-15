import AOC
import Data.Char
import Text.ParserCombinators.Parsec
import qualified Text.Parsec.Expr as E

type TNumber = Int

data TExpression = TBinary TExpression String TExpression
                 | TParens TExpression
                 | TNum TNumber
                 deriving (Eq, Show)

numberExpression :: Parser TExpression
numberExpression = do
    e <- lexeme $ fmap read (many digit)
    return (TNum e)

parensExpression :: Parser TExpression
parensExpression = do
    lexeme (char '(')
    e <- expr
    lexeme (char ')')
    return e

expr :: Parser TExpression
expr = E.buildExpressionParser table term

term :: Parser TExpression
term = parensExpression <|> numberExpression

table = [[binary "+" E.AssocLeft, binary "*" E.AssocLeft]]
    where binary name assoc = E.Infix (flip TBinary name <$ lexeme (string name)) assoc

lexeme :: Parser a -> Parser a
lexeme p = do
    x <- p
    spaces
    return x

eval :: TExpression -> TNumber
eval (TNum x) = x
eval (TParens e) = eval e
eval (TBinary a "+" b) = (eval a) + (eval b)
eval (TBinary a "*" b) = (eval a) * (eval b)

main = do
    inp <- readInput
    let homeworks = fmap sum (sequence (map (fmap eval . parse expr "") (lines inp)))
    print $ case homeworks of Right x -> show x
