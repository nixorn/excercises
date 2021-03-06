> module BinaryTree
> where
>
> import Data.List

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

> trv :: Tree elem -> [elem]
> trv Empty = []
> trv (Node Empty a Empty) = [a]
> trv (Node Empty a r)     = a : trv r


> preorder :: Tree elem -> [elem]
> preorder Empty = []
> preorder n = (trv $ repack n Empty)
>   -- repack tree to all lefts elements will Empty, so we have only one direction from root -> to right
>   where repack Empty                Empty = Empty
>         repack Empty                r'    = repack r' Empty
>         repack (Node Empty a Empty) Empty = Node Empty a Empty
>         repack (Node Empty a Empty) r'    = Node Empty a r'
>         repack (Node l a r)         Empty = Node Empty a $ repack l r
>         repack (Node l a r)         r'    = Node Empty a $ repack l (repack r r')

> inorder :: Tree elem -> [elem]
> inorder Empty = []
> inorder n = (trv $ repack n Empty)
>   where repack Empty Empty = Empty
>         repack Empty r' = repack r' Empty
>         repack n@(Node Empty a Empty) Empty = n
>         repack (Node Empty a r)     Empty   = Node Empty a $ repack r  Empty
>         repack (Node Empty a Empty) r'      = Node Empty a $ repack r' Empty
>         repack (Node Empty a r) r'          = Node Empty a $ repack r $ repack r' Empty
>         repack (Node l a r) r'              = repack (repack l $ Node Empty a $ repack r $ repack r' Empty) Empty

:TODO error here

> postorder :: Tree elem -> [elem]
> postorder Empty = []
> postorder n = (trv $ repack n Empty)
>   where repack Empty Empty = Empty
>         repack Empty r'    = repack r' Empty
>         repack n@(Node Empty a Empty) Empty = n
>         repack (Node Empty a r)       Empty = repack r $ Node Empty a Empty
>         repack (Node Empty a r)       r'    = repack r $ Node Empty a $ repack r' Empty
>         repack (Node l a Empty)       Empty = repack l $ Node Empty a Empty
>         repack (Node l a r)           Empty = repack l $ repack r $ Node Empty a Empty
>         repack (Node l a r)           r'    = repack l $ repack r $ Node Empty a $ repack r' Empty



> preorder' :: Tree elem -> [elem]
> preorder' Empty = []
> preorder' (Node l a r) = a : (preorder' l ++ preorder' r)


> inorder' :: Tree elem -> [elem]
> inorder' Empty = []
> inorder' (Node l a r) = inorder' l ++ (a : inorder' r)

> postorder' :: Tree elem -> [elem]
> postorder' Empty = []
> postorder' (Node l a r) = postorder' l ++ postorder' r ++ [a]


in linear time!

--------------------------------------------------------------------------------
4.2 b)

> lbl Empty = []
> lbl (Node _ x _ ) = x

> levels lvl Empty = [(lvl, [])]
> levels lvl (Node l x r) = filter (not . null . snd) $ [(lvl, [x])] ++ levels (lvl + 1) l  ++ levels (lvl + 1) r
>
> concatLevels lvls@((lvl, val):_) = [intercalate (replicate (lvl*2) ' ') $ map snd $ filter (\x -> fst x == lvl) lvls] ++ concatLevels (filter (\x -> fst x /= lvl) lvls)
> concatLevels [] = []


layout :: (Show elem) => Tree elem -> String
layout tr = levels tr
  where repack Empty = " "
        repack (Node l a r) = ( "\n" ++ show a ++ "\n") ++ repack l ++ repack r

--------------------------------------------------------------------------------
4.2 c) [Optional]

:TODO

--------------------------------------------------------------------------------
4.3 a)

:TODO wrong structure of answer. Order is correct

> build :: [elem] -> Tree elem
> build xs = case sublists xs of
>                ([], y:[]) -> Node Empty y Empty
>                (xs, y:ys) -> Node (build xs) y (build ys)
>                ([], [])   -> Empty
>   where
>     n = length xs
>     half = div n 2
>     sublists xs = (take half xs, drop half xs)


--------------------------------------------------------------------------------
4.3 b)

> balanced :: [elem] -> Tree elem
> balanced xs = case sublists xs of
>              (x:xs, ys) -> Node (balanced xs) x (balanced ys)
>              ([], [])   -> Empty
>              ([], y:[]) -> Node Empty y Empty
>   where
>     n = length xs
>     half = div n 2
>     sublists xs = (take half xs, drop half xs)


--------------------------------------------------------------------------------
4.3 c)

create :: Int -> Tree ()

If, why, and how is that possible?
