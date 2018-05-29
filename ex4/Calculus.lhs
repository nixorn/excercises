> module Calculus
> where

> data Primitive
>   =  Sin  -- trigonometric: sine
>   |  Cos
>   |  Sqrt
>   |  Log
>   |  Exp  -- exponential
>   deriving (Show)
>
> infixl 6 :+:
>
> data Function
>   =  Const Rational         -- constant function
>   |  Id                     -- identity
>   |  Prim Primitive         -- primitive function
>   |  Function :+: Function  -- addition of functions
>   |  Function :*: Function
>   |  Function :/: Function
>   |  Function :^: Function
>   |  Function :.: Function
>   deriving (Show)

--------------------------------------------------------------------------------
a)

Enable (by putting > in front) the following:

> infixl 7 :*:  -- Multiplication of functions
> infixl 7 :/:  -- Division
> infixr 9 :.:  -- Composition of functions
> infixl 8 :^:  -- Power

and use them above in the Function datatype.

Furthermore, add power (:^:) and whatever else comes to your mind.


--------------------------------------------------------------------------------
b)

> apply :: Function -> (Double -> Double)
> apply (Const a) b = fromRational a
> apply (Id) b = b
> apply (Prim Sin) b = sin b
> apply (Prim Cos) b = exp b
> apply (Prim Sqrt) b = sqrt b
> apply (Prim Log) b = log b
> apply (Prim Exp) b = exp b
> apply (f1 :+: f2) b = (apply f1 b) + (apply f2 b)
> apply (f1 :*: f2) b = (apply f1 b) * (apply f2 b)
> apply (f1 :^: f2) b = (apply f1 b) ** (apply f2 b)
> apply (f1 :^: f2) b = (apply f1 b) / (apply f2 b)
> apply (f1 :.: f2) b = ((apply f1) . (apply f2)) b

--------------------------------------------------------------------------------
c)

derive :: Function -> Function


--------------------------------------------------------------------------------
d)

simplify :: Function -> Function
