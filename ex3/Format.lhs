> module Format where
> import Prelude hiding (Word)

Exercise 3.6
Define a function that given a maximal line width and a list of words returns a list of fitting lines so that concat . format n = id .

> format :: Int -> [String] -> [[String]]
> format n ws = subwords ws [] [] n
>   where linelen :: [String] -> Int
>         linelen ws = length $ unwords ws
>         subwords :: [String] -> [String] -> [String] -> Int -> [[String]]
>         subwords (w:ws) prev curr n =
>           if linelen curr > n then [prev] ++ format n ((last curr):w:ws)
>             else subwords ws curr (curr ++ [w]) n
>         subwords [] prev curr n =
>           if linelen curr > n then [init curr, [last curr]]
>             else [curr]


Is this always possible?
Answer: At least it is impossible when length of some word bigger than maximal line length.

:TODO 
(As an aside, a function f with the property concat . f = id computes a partition of its input. Have you seen this property before?)
