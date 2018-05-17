-- Exercise 3.2
-- Using the list design pattern discussed in the lectures, give recursive definitions of

allTrue :: [Bool] -> Bool
allTrue (x:xs) = if x then allTrue(xs) else False
allTrue [] = True

allFalse :: [Bool] -> Bool
allFalse (x:xs) = if x then False else allFalse(xs)
allFalse [] = True

member :: (Eq a) => a -> [a] -> Bool
member x (n:ns) = if x == n then True else member x ns
member _ [] = False


smallest :: [Int] -> Int
smallest (x:xs) = smallest' x xs
  where
    smallest' n (x:xs)
      | x <  n = smallest' x xs
      | x >= n = smallest' n xs
    smallest' n [] = n


largest :: [Int] -> Int
largest (x:xs) = largest' x xs
  where
    largest' n (x:xs)
      | x >  n = largest' x xs
      | x <= n = largest' n xs
    largest' n [] = n
