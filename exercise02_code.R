# Quizzes
# 1 --> a
# 2 --> d
# 3 --> d
# 4 --> b

# Tutorial
# Section 00 - Getting ready
library(data.table)
library(magrittr)

# Section 01 - Reading and cleaning up data
# 1
users_dt <- fread(file.path("C:","Users","usertest","Documents","Data Analysis","Lectures","extdata","extdata","BX-Users.csv"))
ratings_dt <- fread(file.path("C:","Users","usertest","Documents","Data Analysis","Lectures","extdata","extdata","BX-Book-Ratings.csv"))
books_dt <- fread(file.path("C:","Users","usertest","Documents","Data Analysis","Lectures","extdata","extdata","BX-Books.csv"))

# 2
class(users_dt)
class(ratings_dt)
class(books_dt)

# 3
str(users_dt)
sapply(users_dt, class)

users_dt[, Age := as.numeric(Age)]
sapply(users_dt, class)

# 4 
summary(books_dt)

# 5
ratings_dt

# 6
colnames(users_dt) <- gsub("-","_",colnames(users_dt))
colnames(books_dt) <- gsub("-","_",colnames(books_dt))
colnames(ratings_dt) <- gsub("-","_",colnames(ratings_dt))

#7
books_dt[, Image_URL_S := NULL]
books_dt[, Image_URL_M := NULL]
books_dt[, Image_URL_L := NULL]
#or books_dt[, c("Image_URL_S", "Image_URL_M", "Image_URL_L"):=NULL]

books_dt

#8
books_dt_2 <- books_dt[Year_Of_Publication %in% 1900:2019]
books_dt_2

# Section 02 - Data Exploration
# 1
books_dt[,uniqueN(Book_Author)]

# 2 
books_dt[Year_Of_Publication >= 2000L & Year_Of_Publication <= 2010L,uniqueN(Book_Author), by = Year_Of_Publication]

# 3
users_dt[is.na(Age),.N]

# 4
max(ratings_dt$Book_Rating)

# 5
ratings_dt[Book_Rating > 0,.N, by=Book_Rating][N == max(N)]
 
# 6
ratings_dt[Book_Rating == max(Book_Rating, na.rm = TRUE),"ISBN"] %>% head(n=5)

# 7
ratings_dt[order(-Book_Rating)]

# Section 03 - Manipulating data tables
# 1
ratings_dt[,High_Rating := ifelse(Book_Rating > 7,1,0)]

# 2
ratings_dt[, .N, by = High_Rating]
ratings_dt[, sum(High_Rating)/.N] # relative

# 3
user_raiters <- ratings_dt[,User_ID]

users_dt[!(User_ID %in% user_raiters)]

# 4
users_dt[User_ID %in% user_raiters & !is.na(Age),.N, by = Age][N == max(N)]

# 5
ratings_dt[,.N, by = User_ID][, mean(N)]

# 6
ratings_dt[order(Year_Of_Publication, -Book_Rating), .(Book_Title, Year_Of_Publication, Book_Rating)] %>% head(1)

# 7
ratings_dt[,Rating_Count := .N, by = Book_Title]
ratings_dt[Rating_Count == max(Rating_Count), max(Year_Of_Publication)]

# 8
ratings_dt[, Max_Book_Ranking := max(Book_Rating), by = ISBN]
ratings_dt

# 9
authors <- c("Agatha Christie", "William Shakespeare", "Stephen King",
             "Ann M. Martin", "Carolyn Keene", "Francine Pascal",
             "Isaac Asimov", "Nora Roberts", "Barbara Cartland", "Charles Dickens")
sub_rating <- ratings_dt[Book_Author %in% authors]

# 10
sub_rating[,Number := .N, by = Book_Author]
sub_rating[,Max := max(Book_Rating), by = Book_Author]
sub_rating[,Average := mean(Book_Rating), by = Book_Author]
sub_rating[,c("Book_Author","Max","Average")] %>% unique()

# Section 04 - Working with Excel formats
# 1
library(readxl)
summer_olympic <- read_excel(file.path("C:","Users","usertest","Documents","Data Analysis","Lectures","extdata","extdata","summer_olympic_medals.xlsx"))
summer_olympic <- as.data.table(summer_olympic)
 
# 2
summer_olympic[, unique(Gender)]
summer_olympic[, unique(Event_gender)]
summer_olympic[Gender == "Men" & !Event_gender %in% c("M","X")]

# 3
summer_olympic[, .N, by = NOC]