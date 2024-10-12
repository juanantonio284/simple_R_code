# This gives an example of how to read a table from a pdf using the "tabulapdf" package and

# * fix misreads (i.e. data that shouldn't be there or should be somewhere else) caused by tabulapdf
#   being confused by the table's layout (when the pdf doesn't have tables in a perfect grid).
# * fix values (i.e. data that has been correctly read but is not yet useful because, having been 
#   read as a character string, it contains extraneous information). For example the number 1000 
#   might be read as "1 000b", which includes a blank space and a reference to note "b" in the text.
# * perform common wrangling tasks such as change column names and order, convert data types, etc.

# find the sample file in this github at ".../simple_R_code/extract_table_sample_file.pdf"

library(data.table)
library(tabulapdf)
library(stringr)


# set reading parameters ---------------------------------------------------------------------------
path_to_pdf_file <- ".../simple_R_code/extract_table_sample_file.pdf"
pages_aux <- 1


# simple extraction --------------------------------------------------------------------------------
arg_1950 <- tabulapdf::extract_tables( file = path_to_pdf_file,  pages = pages_aux ) # list object
arg_1950 <- as.data.table(arg_1950)


# fix misreads -------------------------------------------------------------------------------------
# delete blank columns ...........................
arg_1950[ , 6 := NULL ] 

# separate joined columns ........................
# This shows that the 5th column, which has been named "...5",  is actually the 5th and 6th columns
# joined together. Need to separate them.
# arg_1950[ , "...5"]

# extract the values and put into separate columns
arg_1950[ , l_x := stringr::str_sub(string = ...5 , end = -7L) ] # (i)
arg_1950[ , d_xn := stringr::str_sub(string = ...5 , start = -6L) ] # (ii)

# (i): Take the first digits up to the 7th from the end.
#      This should include a value up to 6 figures, e.g. 100 000, including that space in the middle
#      and a space at the end.
# (ii): Take the last 6 digits from any given value in the column and put them in a separate column
#       The values are in between the last 3 and last 5 digits, asking for 6 should cover everything
#       including one blank space before the value.


# column names -------------------------------------------------------------------------------------
# dput( names(arg_1950) )
old_names <-  c( "Edad.Age", "...2", "...3", "...4", "...5", 
                 "...7", "...8", "...9", "...10", "l_x", "d_xn" )
new_names <- c( "x", "n", "m_xn", "q_xn", "misread",
                "L_xn", "p_x_x+5", "T_x", "e_x", "l_x", "d_xn" )
setnames( arg_1950, old = old_names, new = new_names )

# column order ...................................
new_order <- c( "x", "n", "m_xn", "q_xn", "l_x", 
                "d_xn", "L_xn", "p_x_x+5", "T_x", "e_x", "misread" )
setcolorder( x = arg_1950, neworder = new_order )


# fix values ---------------------------------------------------------------------------------------
# remove blank spaces ............................
arg_1950[ , l_x := stringr::str_replace_all( string = l_x, pattern = " ", replacement = "" ) ]
arg_1950[ , d_xn := stringr::str_replace_all( string = d_xn, pattern = " ", replacement = "" ) ]
arg_1950[ , L_xn := stringr::str_replace_all( string = L_xn, pattern = " ", replacement = "" ) ]
arg_1950[ , `p_x_x+5` := str_replace_all( string = `p_x_x+5` , pattern = " ", replacement = "" ) ]
arg_1950[ , T_x := stringr::str_replace_all( string = T_x , pattern = " ", replacement = "" ) ]
arg_1950[ , e_x := stringr::str_replace_all( string = e_x, pattern = " ", replacement = "" ) ]

# remove letters like "b" and "c" from column p_x_x+5
arg_1950[ , `p_x_x+5` := str_replace( string = `p_x_x+5` , pattern = "[a-z]$", replacement = "" ) ]


# add info -----------------------------------------------------------------------------------------
arg_1950[ , country := "ARG" ]
arg_1950[ , year := 1950 ]
arg_1950[ 1:24, sex := "M" ] # Male
arg_1950[ 25:47, sex := "F" ] # Female


# cleaning -----------------------------------------------------------------------------------------
arg_1950[ , misread := NULL]
arg_1950 <- arg_1950[ c(3:24, 26:47), ] # delete unnecessary rows

new_order <- c( "country", "year", "sex",
                "x", "n", "m_xn", "q_xn", "l_x",
                "d_xn", "L_xn", "p_x_x+5",  "T_x", "e_x" )
setcolorder( x = arg_1950, neworder = new_order )


# type conversion to numeric -----------------------------------------------------------------------
# remove rows 1 and 2, seeing as they are characters and they will mess with the conversion to number
arg_1950[ , x := as.numeric(x)]
arg_1950[ , n := as.numeric(n)]
arg_1950[ , m_xn := as.numeric(m_xn)]
arg_1950[ , q_xn := as.numeric(q_xn)]
arg_1950[ , l_x := as.numeric(l_x)]
arg_1950[ , d_xn := as.numeric(d_xn)]
arg_1950[ , L_xn := as.numeric(L_xn)]
arg_1950[ , `p_x_x+5` := as.numeric(`p_x_x+5`)]
arg_1950[ , T_x := as.numeric(T_x)]
arg_1950[ , e_x := as.numeric(e_x)]


# save_to_csv --------------------------------------------------------------------------------------
file_name <- paste0( "~/Downloads/life_tables_temp_sep_11/", "arg_1950.csv" )
data.table::fwrite( x = arg_1950, file = file_name )
