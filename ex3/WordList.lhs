> module WordList where
> import Prelude hiding (Word)
> import Data.List
> import Data.Char


-------------------
Exercise 3.1
Write a non-recursive program that computes the word list of a given text, ordered by frequency of occurrence.

> lorem = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."
> type Word = String
> worldList :: String -> [(Word, Int)]
> worldList s = map (\l -> (head l, length l)) $ sortOn length . group . sort . words $ filter (/= '.') $ map toLower s


:TODO https://www.geeksforgeeks.org/stability-in-sorting-algorithms/
As an aside, sort and sortOn implement stable sorting algorithms. Why is this a welcome feature for this particular application?

Because sorting ends for one list traverse?

:TODO What means "shown"? Printed to output? It sounds like IO monad using, I guess to early for that.
Can you format the output so that one entry is shown per line?

> pprint :: [a] -> IO ()
> pprint = undefined

