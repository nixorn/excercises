a) Evaluate (by hand, using the format above) the expression insertionSort (7 : (9 : (2 : [ ])))

Answer:
insertSort (7 : (9 : (2 : [ ]))) => {definition of insertSort and x == 7, xs == [9,2]} =>
insert 7 (insertSort (9 : (2 : []))) => {definition of insertSort and x == 9, xs == [2]} =>
insert 7 (insert 9 (insertSort (2 : [])))) => {definition of insertSort and x == 2, xs == []} =>
insert 7 (insert 9 (insert 2 (insertSort [])))) => {definition of insertSort and [] == []}
insert 7 (insert 9 (insert 2 []))) => {definition of insert and a == 2, [] == []}
insert 7 (insert 9 (2 : [])) => {definition of insert and 9 > 2 } =>
insert 7 (2 : (insert 9 [])) => {definition of insert and a == 9, [] == []} =>
insert 7 (2 : (9 : [])) => {definition of insert and 7 > 2 } =>
2 (insert 7 (9 : [])) => {definition of insert and 7 <= 9 } =>
2 : (7 : (9 : []))

Code below is for debug and mind-mapping. Not the answer, you can delete it.

> insertionSort :: [Integer ] -> [Integer]
> insertionSort [] = []
> insertionSort (x : xs) = insert x (insertionSort xs)

> insert :: Integer -> [Integer ] -> [Integer ]
> insert a [] = a : []
> insert a (b : xs)
>  | a <= b = a : b : xs
>  | a > b = b : insert a xs

b) The function twice applies its first argument twice to its second argument.

> twice f a = f (f a)

Is there any rhyme or rhythm? Can you identify any pattern?

Answer:
https://oeis.org/A014221

How I got answer:
i replaced
twice ("|" ++ ) ""
with
twice (1 + ) 0

so
twice (1 + ) 0                   == 2     == 2 ^ 1
twice twice (1 + ) 0             == 4     == 2 ^ 2
twice twice twice (1 + ) 0       == 16    == 2 ^ 4
twice twice twice twice (1 + ) 0 == 65536 == 2 ^ 16

After i just google sequence 2 4 16 65536
