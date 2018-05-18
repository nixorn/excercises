> module Format where
> import Prelude hiding (Word)

Exercise 3.6
Define a function that given a maximal line width and a list of words returns a list of fitting lines so that concat . format n = id .

> type Word = String
> format :: Int -> [Word] -> [[Word]]
> format n ws = subwords ws [] [] n
>   where linelen :: [Word] -> Int
>         linelen ws = length $ unwords ws
>         subwords :: [Word] -> [Word] -> [Word] -> Int -> [[Word]]
>         subwords (w:ws) prev curr n =
>           if linelen curr > n then [prev] ++ format n (w:ws)
>             else subwords ws curr (curr ++ [w]) n
>         subwords [] prev curr n =
>           if linelen curr > n then [prev, init curr, [last curr]]
>             else [prev, curr]



Is this always possible? (As an aside, a function f with the property concat . f = id computes a partition of its input. Have you seen this property before?)
