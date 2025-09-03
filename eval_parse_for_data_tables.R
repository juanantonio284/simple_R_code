# This code serves to create many small data tables from a big one and, in each of those smaller 
# data tables, perform calculations. 
# Instead of writing many loops, you just write one and have eval( parse( text = name_of_dt ) ) do
# the work. 


# make a copy of the original table to avoid damage by reference
copy_DT <- data.table::copy(original_DT) 

# vector over which to iterate
# (The loop will name a DT "AAA", the next one "ABA", the next one "ABC", etc.)
codes <- c( "AAA", "ABA", "ABC", "ACA", "FMA", "FMD", "FPD", "GMD", "GND", "GNE", "GYV", "MZY",
            "TYQ", "TYR" )

# loop start ---------------------------------------------------------------------------------------
for( i in 1:length(codes) ) {
  name_of_dt <- codes[i]
  message("\t", name_of_dt) #                                (i)
    
  # create a smaller DT .................................... (ii)
  assign( 
    x = name_of_dt,  
    value = copy_DT[ codes_column == eval(name_of_dt) ] #    (iii)
  )

  # create new columns with the desired calculations ....... (iv)
  eval( parse( text = name_of_dt ) )[ #DT_start
    i = ,
    j = difference_between_col_a_and_col_b := ( units_per_year - shift(units_per_year) )
  ]#DT_end
  
} #  end loop ......................................................................................


# Bind the tables into a big one
big_DT <- rbind( AAA, ABA, ABC, ACA,  FMA, FMD, FPD, GMD, GND, GNE, GYV, MZY, TYQ, TYR )

# Set Column order and key
new_order <- c( "year", "codes_column", "V1", "V2" )
data.table::setcolorder( x = big_DT, neworder = new_order )
data.table::setkeyv( x = big_DT, cols = c("year", "codes_column") )

# (i) comment the code below the message() line to see if it runs as expected
# (ii) this will do the equivalent of 
#      AAA <- copy_DT[ codes_column == "AAA" ]
#      i.e. it will create a new, smaller, DT that just contains rows with "AAA" in codes_column
# (iii) codes_column is the name of the column in the data table which contains the codes
# (iv) this will do the equivalent of 
#      AAA[ , difference_between_col_a_and_col_b := ( units_per_year - shift(units_per_year) )
