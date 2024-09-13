# Code to explore data.table objects
# (see below for links to download sample data)

library(data.table)

# Basics -------------------------------------------------------------------------------------------

# See the structure of the table
cstr(WPP_lt_1950_2023)
# cstr is a custom function to get the "clean" structure of the table 
# (change to str if you don't have cstr)

# get a vector like c( "column_1", "column_2", ... ) with the column names
dput( names(WPP_lt_1950_2023) )

# make a smaller table with only one row
x <-WPP_lt_1950_2023[1, ]

# make a smaller table with filtering conditions and only 10 rows
x <- WPP_lt_1950_2023[ LocID == 32 & Time == 1950, ][1:10, ]


# Further ------------------------------------------------------------------------------------------

# 1. select unique values from the location id column and the country code column
country_codes <- unique( 
  WPP_lt_1950_2023[ , list(LocID, ISO3_code, Location) ] 
)

# 2. keep only rows where ISO3_code column is not blank
country_codes <- country_codes[ ISO3_code != "", ]
# This is because only countries are needed for this example and, upon inspection, you see that many
# codes do not correspond to a country but rather a region (e.g. Europe and Northern America).

# 3. sort alphabetical
data.table::setorder(country_codes, ISO3_code) 

View(country_codes)


# Select columns -----------------------------------------------------------------------------------
# Select columns to make a smaller, easier to read, table

# (i) put all the column names in the vector ...............
columns_wanted <- dput( names(WPP_lt_1950_2023) ) 

# line above does the same as this
columns_wanted <- c(
  "SortOrder", "LocID", "Notes", "ISO3_code", "ISO2_code", "SDMX_code", "LocTypeID", "LocTypeName",
  "ParentID", "Location", "VarID", "Variant", "Time", "MidPeriod", "SexID", "Sex", "AgeGrp", 
  "AgeGrpStart", "AgeGrpSpan", "mx", "qx", "px", "lx", "dx", "Lx", "Sx", "Tx", "ex", "ax"
)

# (ii) manually select the columns you want to keep ........
columns_wanted <- c(
  "LocID", "ISO3_code", "Location", 
  "VarID", "Variant", 
  "Time", "MidPeriod", 
  "SexID", "Sex", 
  "AgeGrpStart", "AgeGrpSpan", 
  "mx", "qx", "px", "lx", "dx", "Lx", "Sx", "Tx", "ex", "ax"
)

# (iii) subset .............................................
smaller_table <- WPP_lt_1950_2023[ , columns_wanted, with = FALSE ] # preferred method "with = FALSE"


# Other methods
# smaller_table <- WPP_lt_1950_2023[ , ..columns_wanted ] # use '..' syntax if using vector and NOT 
                                                          # using "with = FALSE"

# smaller_table <- WPP_lt_1950_2023[ , list(LocID, Location) ] # list the columns directly
                                                               # also takes'.()' shortcut
                                                               # instead of 'list()'

# (iv) you could also delete columns you don't want
# WPP_lt_1950_2023[ , c( "SortOrder", "LocID", "Notes" ) := NULL ] # note vector and "" syntax


# Sample Data ......................................................................................

# direct link to download dataset 
# https://population.un.org/wpp/Download/Files/1_Indicator%20(Standard)/CSV_FILES/WPP2024_Life_Table_Abridged_Medium_1950-2023.csv.gz

# home page
# https://population.un.org/wpp/Download/Standard/CSV/
