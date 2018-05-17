> import Data.List

Exercise 3.3
A run is a non-empty, non-decreasing sequence of elements. Use the list design pattern to define a function.
:TODO bad function. It could be better.

> runs' :: (Ord a) => [[a]] -> [a] -> [a] -> [[a]]
> runs' acc run (y:x:xs)
>   | y <= x = runs' acc (run ++ [y]) (x:xs)
>   | y >  x = runs' (acc ++ [run ++ [y]]) [] (x:xs)
> runs' acc [] [x]  = acc ++ [[x]]
> runs' acc run [x] = if last run < x
>                     then acc ++ [run ++ [x]]
>                     else acc ++ [run] ++ [[x]]
> runs' acc run [] = acc ++ [run]


> runs :: (Ord a) => [a] -> [[a]]
> runs  = runs' [] []




