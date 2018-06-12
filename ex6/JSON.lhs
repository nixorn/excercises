> module JSON
> where
> import Prelude hiding ((>>), (>>=), fail, return)
> import Data.Char (isHexDigit, chr)
> import Numeric (readHex)
> import Data.List (intersperse)

--------------------------------------------------------------------------------
Please use this JSON data type, even if you had another (better / more complex)
solution on the last exercise sheet:

> data JValue
>  = JString String
>  | JNumber Integer
>  | JObject [(String, JValue)]
>  | JArray [JValue]
>  | JTrue
>  | JFalse
>  | JNull
>  deriving (Eq, Show)


Data type for Tokens (generated by lexer):

> data Token
>   = Sep     Char    -- Any of the characters , : [ ] { }
>   | Atom    String  -- true false null
>   | String  String  -- Strings, without surrounding quotes
>   | Number  Integer
>   deriving (Eq, Show)


--------------------------------------------------------------------------------
Parser type. In the lecture, we had: type Parser a = String -> [(a, String)]
That type fixes the input to be a String, i.e. a list of Characters.
We now use a generalized type:

> type Parser input output = [input] -> [(output, [input])]

The input type is now parametric. For parsing Strings, use: Parser Char a
That is exactly the same type as in the lecture, i.e. [Char] -> [(a, [Char])]

Here are the parser combinators from the lecture, all slightly adjusted for the
generalized Parser type:

> return :: output -> Parser input output
> return x = \inp -> [(x, inp)]

> (>>=) :: Parser input a -> (a -> Parser input b) -> Parser input b
> p >>= q = \inp -> [res | (a, inp') <- p inp, res <- q a inp']

> fail :: Parser input output
> fail = \_ -> []

> (.|) ::  Parser input output -> Parser input output -> Parser input output
> p .| q = \inp -> p inp ++ q inp

> char :: (Eq input) => input -> Parser input input
> char c = \inp -> case inp of
>                    []       -> []
>                    a : inp' -> if c == a then [(a, inp')] else []

> skip :: Parser input ()
> skip = return ()

> (>>) :: Parser input a -> Parser input b -> Parser input b
> p >> q = p >>= \_ -> q

> alt :: [Parser input output] -> Parser input output
> alt = foldr (.|) fail

> many :: Parser input output -> Parser input [output]
> many p = many1 p .| return []

> many1 :: Parser input output -> Parser input [output]
> many1 p = p >>= \a -> many p >>= \as -> return (a : as)

> parse :: Parser input output -> ([input] -> [output])
> parse p inp = [a | (a, []) <- p inp]


Modified choice combinator. p >| q parses p if possible, and only if p fails it
falls back to q.

> (>|) ::  Parser input output -> Parser input output -> Parser input output
> p >| q = \inp -> case p inp of
>   []  -> q inp -- p failed, fall back to q
>   res -> res   -- p succeeded, use its result and ignore q


Greedy is an alternative of many that greedily parses the input until the given
parser fails, only then it skips.

> greedy :: Parser input output -> Parser input [output]
> greedy p = greedy1 p >| return []

> greedy1 :: Parser input output -> Parser input [output]
> greedy1 p = p >>= \a -> greedy p >>= \as -> return (a : as)


Chaining two parsers (i.e. lexer and parser) as described on the exercise sheet:

> chain :: Parser i [tok] -> Parser tok o -> Parser i o
> chain lex parse inp = [(parsed, []) | (lexed,  []) <- lex inp,
>                                       (parsed, []) <- parse lexed]


--------------------------------------------------------------------------------
This is a lexer for JSON.

> lexJSON :: Parser Char [Token]
> lexJSON = (lexWhitespace -- skip whitespaces
>            >> alt [lexSep, lexAtom, lexString, lexNumber] -- lex single token
>            >>= \t i -> [(t : ts, i') | (ts, i') <- lexJSON i] -- lex rest
>           ) >| (skip >> return [])

> lexWhitespace :: Parser Char String
> lexWhitespace = greedy $ alt [char c | c <- " \r\n\t"]

> lexSep :: Parser Char Token
> lexSep = alt [char c | c <- ",:[]{}"] >>= \c -> return (Sep c)

> lexAtom :: Parser Char Token
> lexAtom = (seq "true"  >> return (Atom "true"))
>        .| (seq "false" >> return (Atom "false"))
>        .| (seq "null"  >> return (Atom "null"))
>   where seq s = foldr1 (>>) [char c | c <- s]

> lexString :: Parser Char Token
> lexString = char '"' >> content >>= \s -> return (String s)
>   where content, escape, unicode :: Parser Char String
>         content ""         = []        -- fail, string did not end
>         content ('"'  : s) = [("", s)] -- success
>         content ('\\' : s) = escape s  -- start escape char
>         content (c    : s) = [(c : a, t) | (a, t) <- content s] -- normal char
>         escape (c    : s)
>           | c `elem` "\"\\/" = [(c : a, t) | (a, t) <- content s]
>         escape ('b' : s) = [('\b' : a, t) | (a, t) <- content s]
>         escape ('f' : s) = [('\f' : a, t) | (a, t) <- content s]
>         escape ('n' : s) = [('\n' : a, t) | (a, t) <- content s]
>         escape ('r' : s) = [('\r' : a, t) | (a, t) <- content s]
>         escape ('t' : s) = [('\t' : a, t) | (a, t) <- content s]
>         escape ('u' : s) = unicode s
>         escape _          = [] -- fail, illegal escape character
>         unicode (c1:c2:c3:c4:s)
>           | isHexDigit c1 && isHexDigit c2 && isHexDigit c3 && isHexDigit c4
>               = let [(n, _)] = readHex [c1, c2, c3, c4]
>                 in  [((chr n) : a, t) | (a, t) <- content s]
>         unicode _          = [] -- fail, illegal unicode escape character

> lexNumber :: Parser Char Token
> lexNumber = (char '-' >> digits >>= \n -> return (Number (-(read n))))
>          .| (digits >>= \n -> return (Number (read n)))
>   where digits = greedy1 $ alt [char c | c <- ['0' .. '9']]


--------------------------------------------------------------------------------
The Formatter type described on the exercise sheet:

> type Formatter a = a -> String

Trusted formatter for JSON:

> format :: Formatter JValue
> format (JString s) = formatString s
> format (JNumber x) = show x
> format (JObject a) = "{" ++ (concat $ intersperse ", " $ map f a) ++ "}"
>   where f (k, v)   = (formatString k) ++ ": " ++ (format v)
> format (JArray a)  = "[" ++ (concat $ intersperse ", " $ map format a) ++ "]"
> format JTrue       = "true"
> format JFalse      = "false"
> format JNull       = "null"
>
> formatString s = '"' : helper s where
>   helper []         =  "\""
>   helper (c:xs)     = (helper2 c) ++ helper xs
>   helper2 '\"'      = "\\\""
>   helper2 '\\'      = "\\"
>   helper2 '/'       = "/"
>   helper2 '\b'      = "\\b"
>   helper2 '\f'      = "\\f"
>   helper2 '\n'      = "\\n"
>   helper2 '\r'      = "\\r"
>   helper2 '\t'      = "\\t"
>   helper2 c         = [c]


--------------------------------------------------------------------------------
Here are some probes for testing:

> jsonProbes :: [JValue]
> jsonProbes = [JTrue, JFalse, JNull, JObject [], JArray [],
>               JArray [JTrue, JFalse, JObject [("foo", JString "bar"), ("baz", JNumber 42)]],
>               JObject [("xyz", JNumber (-123))],
>               JObject [("0", JArray [JNull]), ("test", JTrue)]
>               ]


--------------------------------------------------------------------------------
6.3 a)

Since we work now on lists of Tokens, you can use the char parser to parse a
single token. The following alias might help to clarify:

> tok :: Token -> Parser Token Token
> tok = char

If you want to match an Atom token, use: tok (Atom "true")
For matching String and Number tokens, use these helpers:

> string :: Parser Token String
> string ((String s) : t) = [(s, t)]
> string _ = []

> number :: Parser Token Integer
> number ((Number n) : t) = [(n, t)]
> number _ = []

> jstring :: Parser Token JValue
> jstring ((String s) : t) = [(JString s, t)]
> jstring _ = []

> jnumber :: Parser Token JValue
> jnumber ((Number n) : t) = [(JNumber n, t)]
> jnumber _ = []

> jatom :: Parser Token JValue
> jatom ((Atom "true") : t) = [(JTrue, t)]
> jatom ((Atom "false") : t) = [(JFalse, t)]
> jatom ((Atom "null") : t) = [(JNull, t)]
> jatom _ = []

jkvs = do
    label <- string
    value <- (jobj
              >| jarray
              >| jatom
              >| jnumber
              >| jstring)
    return $ (label, value)

jobj = do
  tok '{'
  kvs <- jkvs
  tok '}'
  return $ JObject kvs

jarray = do
    tok "["
    array <- jobj
             >| jarray
             >| jatom
             >| jnumber
             >| jnumber
             >| tok ","
    tok "]"
    return $ JArray array


kv :: Parser Token (String, JValue)
kv obj = do
  (key, rest)   <- string obj
  (_, rest)     <- colon rest
  (value, rest) <- parseJSON rest
  return ((key, value), rest)

Now implement the parser:

> parseJSON :: Parser Token JValue
> parseJSON = undefined

parseJSON ((String s):rest) = (JString s, rest) : parseJSON rest
parseJSON ((Number n):rest) = (JNumber n, rest) : parseJSON rest
parseJSON ((Atom "true"):rest) = (JTrue, rest) : parseJSON rest
parseJSON ((Atom "false"):rest) = (JFalse, rest) : parseJSON rest
parseJSON ((Sep '['):lst) = repackList $ (many parseJSON) lst
parseJSON ((Sep ']'):rest) = parseJSON rest

parseJSON ((Sep '{'):object) = many kv $ object

parseJSON ((Sep '}'):rest) = parseJSON rest
parseJSON ((Sep ','):xs) = parseJSON xs
parseJSON ((Sep ':'):xs) = parseJSON xs
parseJSON _ = []



--------------------------------------------------------------------------------
6.3 b)

> check :: Formatter a -> Parser Char a -> String -> Bool
> check f p val = (f $ head $ parse p val) == val

--------------------------------------------------------------------------------
6.4 a)

> class JSON a where
>   toJSON   :: a -> JValue
>   fromJSON :: JValue -> Maybe a


> instance JSON Integer where
>   fromJSON (JNumber i) = Just i
>   fromJSON _ = Nothing
>   toJSON i = JNumber i


> instance JSON Bool where
>   fromJSON JTrue = Just True
>   fromJSON JFalse = Just False
>   fromJSON _ = Nothing
>   toJSON True = JTrue
>   toJSON False = JFalse

--------------------------------------------------------------------------------
6.4 b)

instance (JSON a) => JSON [a] where
...
