a) How many total functions are there that take one Boolean as an input and return one Boolean? Or put differently, how many functions are there of type Bool -> Bool ? Define all of them. Think of sensible names.

Answer: Two functions.

> not' :: Bool -> Bool
> not' True = False
> not' False = True

> same :: Bool -> Bool
> same a = a

-----------------------------

b) How many total functions are there that take two Booleans as an input and return one Boolean? Or put differently, how many functions are there of type (Bool , Bool ) -> Bool ?

Answer: So we have 4 inputs:
[(True, False)
,(False, True)
,(False, False)
,(True, True)]

And for each input we have 2 possibly outputs per function - True or False.

For example

var1 (True, False)  = False
var1 (False, True)  = False
var1 (False, False) = False
var1 (True, True)   = False

var2 (True, False)  = True
var2 (False, True)  = False
var2 (False, False) = False
var2 (True, True)   = False

var3 (True, False)  = False
var3 (False, True)  = True
var3 (False, False) = False
var3 (True, True)   = False

... and so on. So if True is 1 and False is 0 we can imagine each function (input -> output) as 4-digit binary number.

[0000, 0001, 0010, ... , 1111]. 1111 is binary representation of decimal 15. So, with zero, there are 16 total functions that take two Booleans as an input and return one Boolean.
----------

Define at least four. Try to vary the definitional style by using different features of Haskell, e.g. predefined operators such as || and &&, conditional expressions (if . . then . . else . .), guards, and pattern matching.

Pattern matching:

> f1 :: (Bool, Bool) -> Bool
> f1 _ = False

Predefined ||:

> f2 (a, b) = a || b

Predefined &&:

> f3 (a, b) = a && b

Conditional expressions:

> f4 (a, b) = if a then b else a

Guards:

> f5 (a, b)
>   | a || b == True = True
>   | otherwise = False


c) What about functions of type Bool -> Bool -> Bool ?

Answer: the same as about functions (Bool, Bool) -> Bool. There is 2 functions in Prelude wich have Bool -> Bool -> Bool signature. There is (&&) and (||) functions. Boolean "and" and "or", the basic boolean functions.
