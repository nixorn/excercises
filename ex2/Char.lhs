> module Char
> where
> import Data.Char

--------------------------------------------------------------------------------
a) Define an equality test for strings that disregards case:

> equal :: String -> String -> Bool
> equal a b = map toLower a == map toLower b

--------------------------------------------------------------------------------
b) Define predicates that test whether a string consists solely of digits or white space.

> isNumeral  :: String -> Bool
> isNumeral str = and $ map isDigit str

> isBlank :: String -> Bool
> isBlank str = and $ map isSpace str

--------------------------------------------------------------------------------
c) Implement the Caesar cipher

> shift :: Int -> Char -> Char
> shift n c
>   | n == 0 = c
>   | not (isAlpha c) = c
>   | n > 0  = incrementShift n c
>   | n < 0  = decrementShift n c
>  where incrementShift :: Int -> Char -> Char
>        incrementShift n 'Z' = shift (n - 1) 'A'
>        incrementShift n c   = shift (n - 1) (succ c)
>        decrementShift n 'A' = shift (n + 1) 'Z'
>        decrementShift n c   = shift (n + 1) (pred c)

> msg :: String
> msg = "MHILY LZA ZBHL XBPZXBL MVYABUHL HWWPBZ JSHBKPBZ "
>    ++ "JHLJBZ KPJABT HYJHUBT LZA ULBAYVU"

Answer:
*Char Data.Char DC> map (shift 19) msg
"FABER EST SUAE QUISQUE FORTUNAE APPIUS CLAUDIUS CAECUS DICTUM ARCANUM EST NEUTRON"
