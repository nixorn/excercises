> module BinaryTree
> where

> data Tree elem = Empty | Node (Tree elem) elem (Tree elem)
>   deriving (Show)

> instance Functor Tree where
>   fmap _f Empty         =  Empty
>   fmap f  (Node l a r)  =  Node (fmap f l) (f a) (fmap f r)

--------------------------------------------------------------------------------
4.1 a)

> abcdfg :: Tree Char
> abcdfg = Node (Node Empty 'a' (Node Empty 'b' Empty)) 'c' (Node (Node Empty 'd' Empty ) 'f' (Node Empty 'g' Empty))

--------------------------------------------------------------------------------
4.1 b) Submit a scan/photo of your solution, or draw the solution using TikZ.
:TODO
> ex1  ::  Tree Integer
> ex1  =   Node Empty 4711 (Node Empty 0815 (Node Empty 42 Empty))
> ex2  ::  Tree String
> ex2  =   Node (Node (Node Empty "Frits" Empty) "Peter" Empty) "Ralf" Empty
> ex3  ::  Tree Char
> ex3  =   Node (Node Empty 'a' Empty) 'k' (Node Empty 'z' Empty)

--------------------------------------------------------------------------------
4.1 c)

> size :: Tree elem -> Int
> size Empty = 0
> size (Node l _ r) = 1 + size l + size r

--------------------------------------------------------------------------------
4.1 d)

> minHeight :: Tree elem -> Int
> minHeight Empty = 0
> minHeight (Node l _ r) = 1 + min (minHeight l) (minHeight r)

> maxHeight :: Tree elem -> Int
> maxHeight Empty = 0
> maxHeight (Node l _ r) = 1 + max (maxHeight l) (maxHeight r)


--------------------------------------------------------------------------------
4.1 e)

:TODO
size t >= maxHeight t >= minHeight t


--------------------------------------------------------------------------------
4.1 f)

> member :: (Eq elem) => elem -> Tree elem -> Bool
> member _ Empty = False
> member el (Node l a r)
>   | el == a = True
>   | otherwise = member el l || member el r

--------------------------------------------------------------------------------
4.2 a)

preorder, inorder, postorder :: Tree elem -> [elem]

in linear time!

--------------------------------------------------------------------------------
4.2 b)

layout :: (Show elem) => Tree elem -> String

--------------------------------------------------------------------------------
4.2 c) [Optional]


--------------------------------------------------------------------------------
4.3 a)

build :: [elem] -> Tree elem

--------------------------------------------------------------------------------
4.3 b)

balanced :: [elem] -> Tree elem

--------------------------------------------------------------------------------
4.3 c)

create :: Int -> Tree ()

If, why, and how is that possible?
