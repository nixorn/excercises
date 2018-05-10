The datatype Shape defined below captures simple geometric shapes: circles, squares, and rectangles.

> data Shape = Circle Double | Square Double | Rectangle Double Double deriving (Show)

> showShape :: Shape -> String
> showShape (Circle r ) = "circle of radius " ++ show r
> showShape (Square l )= "square of length " ++ show l
> showShape (Rectangle w h) = "rectangle of width " ++ show w ++ " and height " ++ show h

Use the same definitional scheme to implement the functions

> area :: Shape -> Double
> area (Circle r) = pi * r ^ 2
> area (Square l) = l ^ 2
> area (Rectangle w h) = w * h

> perimeter :: Shape -> Double
> perimeter (Circle r) = pi * r * 2
> perimeter (Square l) = l * 4
> perimeter (Rectangle w h) = (w + h) *2

> center :: Shape -> (Double, Double)
> center (Circle r) = (r, r)
> center (Square l) = (l/2, l/2)
> center (Rectangle w h) = (w/2, h/2)

> boundingBox :: Shape -> (Double, Double)
> boundingBox (Circle r) = (r*2, r*2)
> boundingBox (Square l) = (l, l)
> boundingBox (Rectangle w h) = (w, h)


