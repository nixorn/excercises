
firstPart = "This old man, he played "
secPart   = ",\nHe played knick-knack "
thirdPart = ";\nWith a knick- knack paddywhack,\nGive the dog a bone,\nThis old man came rolling home."

values = [("one", "on my thumb")
         ,("two", "on my shoe")
         ,("three", "on my knee")
         ,("four", "on my door")
         ,("five", "on my hive")
         ,("six", "on my sticks")
         ,("seven", "up in heaven")
         ,("eight", "on my gate")
         ,("nine", "on my spine")
         ,("ten", "once again")]

constructPoem (x, y) = firstPart ++ x ++ secPart ++ y ++ thirdPart ++ "\n\n"

thisOldMan = concat $ map constructPoem values
