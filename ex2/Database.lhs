> type Person  =  (Name, Age, FavouriteCourse)
>
> type Name             =  String
> type Age              =  Integer
> type FavouriteCourse  =  String
>
> frits, peter, ralf :: Person
> frits  =  ("Frits",  33,  "Algorithms and Data Structures")
> peter  =  ("Peter",  57,  "Imperative Programming")
> ralf   =  ("Ralf",   33,  "Functional Programming")
>
> students  ::  [Person]
> students  =   [frits, peter, ralf]

a) Invent some additional entries and add them to the list of students.

> eloise = ("Eloise",  20,  "Functional Programming")
> victor = ("Victor",  29,  "Imperative Programming")
> students1 = students ++ [eloise, victor]

--------------------------------------------------------------------------------
b) The function age defined below extracts the age from a person, e.g. age ralf = 33. (In case you wonder why some variables have a leading underscore see Hint 1.)

> age :: Person -> Age
> age (_n, a, _c) = a

Define functions name and favouriteCourse

> name :: Person -> Name
> name (n, _a, _c) = n

> favouriteCourse :: Person -> FavouriteCourse
> favouriteCourse (_n, _a, c) = c


--------------------------------------------------------------------------------
c) Define a function showPerson :: Person → String that returns a string representation of a person.

> showPerson :: Person -> String
> showPerson (n, a, c) = n ++ " " ++ show a ++ " " ++ c

--------------------------------------------------------------------------------
d) Define a function twins :: Person → Person → Bool that checks whether two persons are twins. (For lack of data, we agree that two persons are twins if they are of the same age.)

> twins :: Person -> Person -> Bool
> twins p1 p2 = age p1 == age p2

--------------------------------------------------------------------------------

e) Define a function increaseAge :: Person -> Person which increases the age of a given person by one, e.g.

> increaseAge :: Person -> Person
> increaseAge (n, a, c) = (n, a + 1, c)

--------------------------------------------------------------------------------
f) Create expressions to solve the following tasks:
(i) increment the age of all students by two;
(ii) promote all of the students (attach "Dr. " to their name);
(iii) find all students named Frits;
(iv) find all students whose favourite course is Functional Programming;
(v) find all students who are in their twenties, i.e. who are between 20 and 30 years
old;
(vi) find all students whose favourite course is Functional Programming and who are
in their twenties;
(vii) find all students whose favourite course is Imperative Programming or who are
in their twenties.

> increaseAgeN ::  Integer -> Person -> Person
> increaseAgeN n (name, a, c) = (name, a + n, c)
> older = map (increaseAgeN 2) students1

> namePrefix :: String -> Person -> Person
> namePrefix pref (n, a, c) = (pref ++ n, a, c)
> promoted = map (namePrefix "Dr. ") students1

> haveName :: String -> Person -> Bool
> haveName nn (n, _, _) = n == nn
> fritss   = filter (haveName "Frits") students1

> favCource :: String -> Person -> Bool
> favCource cc (_, _, c) = c == cc
> fp       = filter (favCource "Functional Programming") students1

> isInTwenties (n, a, c) = a >= 20 && a < 30
> twenties = filter isInTwenties students1

> fp20     = filter isInTwenties $ filter ( favCource "Functional Programming") students1
> ip20     = filter isInTwenties $ filter ( favCource "Imperative Programming") students1
