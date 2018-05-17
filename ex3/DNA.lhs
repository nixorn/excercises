> import Data.List

Exercise 3.3
Recall the representation of bases and DNA strands introduced in the lectures.

> data Base = A | C | G | T deriving (Eq, Ord, Show)
> type DNA = [Base]
> type Segment = [Base]

----
a) Define a function contains :: Segment -> DNA -> Bool that checks whether a specified DNA segment is contained in a DNA strand.

> contains :: Segment -> DNA -> Bool
> contains [] _ = True
> contains seg dna
>   | length seg > length dna = False
>   | seg == (take (length seg) (dna)) = True
>   | otherwise = contains seg (drop 1 dna)


Can you modify the definition so that a list of positions of occurrences is returned instead?

:TODO

> contains' :: Segment -> DNA -> [Integer]
> contains' = undefined


----
b) Define a function longestOnlyAs :: DNA -> Integer that computes (the length of) the longest segment that contains only the base A.

> longestOnlyAs :: DNA -> Integer
> longestOnlyAs dna = fromIntegral $ length $ last $ sort $ filter (\l -> head l == A) $ group dna

----
c) Define a function longestAtMostTenAs :: DNA -> Integer that computes (the length of) the longest segment that contains at most ten occurrences of the base A. (This is more challenging. Don’t spend too much time on this part.)

:TODO

> longestAtMostTenAs :: DNA -> Integer
> longestAtMostTenAs = undefined
