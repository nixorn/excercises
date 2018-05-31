> data Tree elem = Empty | Node (Tree elem) elem (Tree elem)
>   deriving (Show)
> instance Functor Tree where
>   fmap _f Empty         =  Empty
>   fmap f  (Node l a r)  =  Node (fmap f l) (f a) (fmap f r)



> registry :: Tree String
> registry = Node (Node (Node Empty "Frits" Empty) "Peter" Empty) "Ralf" Empty

a)

> member :: (Ord elem) => elem -> Tree elem -> Bool
> member _    Empty = False
> member elem (Node l x r)
>   | elem == x = True
>   | elem >  x = member elem r
>   | otherwise = member elem l

What’s the difference to Exercise 4.1f?

Not need to traverse most of subtrees.

b)

> insert :: (Ord elem) => elem -> Tree elem -> Tree elem
> insert elem Empty = Node Empty elem Empty
> insert elem (Node l x r)
>   | elem == x = Node l x r
>   | x > elem  = Node (insert elem l) x r
>   | x < elem  = Node l x $ insert elem r

c)

> delete :: (Ord elem) => elem -> Tree elem -> Tree elem
> delete _ Empty = Empty
> delete elem (Node l x r)
>   | elem == x = deleteRoot (Node l x r)
>   | elem < x  = Node (delete elem l) x r
>   | elem > x  = Node l x (delete elem r)
>   where deleteRoot (Node Empty x r) = r
>         deleteRoot (Node l x Empty) = l
>         deleteRoot (Node l x r) = (Node l lv r)
>         lv = left r
>         left (Node Empty x _) = x
>         left (Node l _ _) = left l

d)

TODO:

