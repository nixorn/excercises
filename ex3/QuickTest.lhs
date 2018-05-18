> import Data.List hiding (permutations)

> type Probes a = [a]
> type Property a = a -> Bool

> infixr 1 -->, ==>
> (-->) :: Probes a -> Property b -> Property (a -> b)
> (==>) :: Probes a -> (a -> Property b) -> Property (a -> b)
> probes --> prop = \f -> and [prop (f x ) | x <- probes ]
> probes ==> prop = \f -> and [prop x (f x ) | x <- probes ]


Exercise 3.5
a) Define the predicate that checks whether a list is ordered i.e. the sequence of elements is non-decreasing.

> ordered :: (Ord a) => Property [a]
> ordered a = a == sort a

b) Apply the list design pattern to define the generator that produces the list of all permutations of its input list.

> insertEverywhere :: a -> [a] -> [[a]]
> insertEverywhere x [] = [[x]]
> insertEverywhere x (y:ys) = (x:y:ys) : map (y:) (insertEverywhere x ys)

> permutations :: [a] -> Probes [a]
> permutations = foldr (concatMap . insertEverywhere) [[]]

(How many permutations of a list of length n are there?)
Answer: https://oeis.org/A000142
n!
so for array with 6 elems we have 6! = (1*2*3*4*5*6) = 720 permutations.

c) Use the combinators to define a testing procedure for the function of Exercise 3.3.

:TODO

> trustedRuns = undefined
>
> runs_test :: (Ord a) => Probes [a] -> Property [[a]]
> runs_test probes = probes ==> \inp res -> trustedRuns inp == res


:TODO
d) Harry Hacker has translated a function that calculates the integer square root from C to Haskell. It is not immediately obvious that this definition is correct. Define a testing procedure to exercise the program.

> isqrt :: Integer -> Integer
> isqrt n = loop 0 3 1
>   where loop i k s
>              | s <= n = loop (i + 1) (k + 2) (s + k )
>               | otherwise = i

-- > isIntegerSqrt :: Property (Integer -> Integer )

e) Define a combinator that takes probes for type a, probes for type b, and generates probes for type (a, b) by combining the input data in all possible ways e.g.

-- > infixr 4 <+>
-- > (<+>) :: Probes a -> Probes b -> Probes (a, b)
-- > (<+>) :: Probes a -> Probes b -> Probes (a, b)

:TODO
If as contains m elements, and bs contains n elements, then as perm_x bs contains ...

