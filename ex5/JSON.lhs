> import Data.List
> data JValue =   String String
>               | Number Integer
>               | Object [(String, JValue)]
>               | Array [JValue]
>               | Boolean Bool
>               | Null
>  deriving (Eq, Show)


> format :: JValue -> String
> format Null = "null"
> format (String a) = a
> format (Number a) = show a
> format (Boolean True) = "true"
> format (Boolean False) = "false"
> format (Array []) = "[]"
> format (Array a) = '[' : (intercalate ", " $ map format a) ++ "]"
> format (Object []) = "{}"
> format (Object a) = '{' : (intercalate ", " $ map (\(n,v) -> n ++ ":" ++ format v) a) ++ "}"

