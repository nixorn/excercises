
-- 7.1
-- Foldr fusion law from here http://myhaskelljournal.com/an-optimization-using-foldr-fusion-law/
-- If we have the following properties:
--     f is a strict function.
--     f(g x y) = h x (f y), for all x and y in the appropriate ranges
--     b = f(a).
-- Then: f . foldr g a = foldr h b.

-- a)
-- 2 * (foldr (+) 0 xs) == foldr (\a x -> a * 2 + x ) 0 xs
-- For this case  f = (2 *), g = (+), a = 0, h = (\a x -> a * 2 + x ), b = a * 2
-- so

-- ((2 *) . (foldr (+) 0)) [1,2,3] == foldr (\a x -> a * 2 + x ) 0 [1,2,3]

-- it is roughly reflection of f . foldr g a = foldr h b.

-- b)
-- same for
-- ((2 +) . (foldr max 0)) [0,-1..] == foldr (\a x -> max (2 + a) x) 0 [0,-1..]
-- f = (2 +), g = max, a = 0, h = (\a x -> max (2 + a) x), b = a + 2 = 2 on first iteration



-- 7.2
-- a) Prove the foldr -map fusion law:

map'          :: (a -> b) -> [a] -> [b]
map' f []     = []
map' f (x:xs) = [f x] ++ foldr (\y ys -> (f y):ys) [] xs

-- ((foldr (+) 0) . map (* 2)) [1,2,3] == foldr (\a b -> 2 * (a + b)) 0 [1,2,3]
