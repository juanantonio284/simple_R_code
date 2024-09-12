# Code to explore data.table objects
# (see below for links to download sample data)

# 1 Basics -----------------------------------------------------------------------------------------

# See the structure of the table
cstr(tables)
# cstr is a custom function to get the "clean" structure of the table 
# (change to str if you don't have cstr)

# get a vector like c( "column_1", "column_2", ... ) with the column names
dput( names(tables) )

# make a smaller table with only one row
x <-tables[1, ]

# make a smaller table with filtering conditions and only 10 rows
x <- tables[ LocID == 32 & Time == 1950, ][1:10, ]


# 2 Select columns ---------------------------------------------------------------------------------
# Select columns to make a smaller, easier to read, table

# (i) put all the column names in the vector ...............
columns_wanted <- dput( names(tables) ) 

# line above does the same as this
columns_wanted <- c(
  "SortOrder", "LocID", "Notes", "ISO3_code", "ISO2_code", "SDMX_code",  "LocTypeID", "LocTypeName",
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
smaller_table <- tables[ , columns_wanted, with = FALSE ] # preferred method "with = FALSE"

# Other methods ............................................
# smaller_table <- tables[ , ..columns_wanted ] # '..' if using vector and NOT using "with = FALSE"

# smaller_table <- tables[ , list(LocID, Location) ] # list the columns directly
                                                     # also takes'.()' shortcut instead of 'list()'


# Sample Data ---------------------------------------------------------------------------------
# dataset used here
# https://population.un.org/wpp/Download/Files/1_Indicator%20(Standard)/CSV_FILES/WPP2024_Life_Table_Abridged_Medium_1950-2023.csv.gz

# from this page
# https://population.un.org/wpp/Download/Standard/CSV/
