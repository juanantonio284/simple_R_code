# USING EXPRESSION PARSING TO RUN COMMANDS IN A LOOP

# Much of the code below is related to a particular example which doesn't really matter; what's
# relevant is the usage of the following functions
# * "expression"
# * "deparse"
# * "gsub" (gsub is a common R function which you should learn separately but I point it out because
#    in this script there is a nice example of its usage)
# * "eval"
# * "parse"

# set reading parameters ---------------------------------------------------------------------------
years <- c(1950, 1960, 1970, 1980, 1990, 2000, 2010, 2020)

country_prefix <- c( "arg", "bol", "bra", "chi", "col", "cri", "cub", "ecu", "sal", "gua",
                     "hai", "hon", "mex", "nic", "pan", "par", "per", "dr", "uru" ) #, "ven"


# LOOP 1 START ----
# simple extraction --------------------------------------------------------------------------------
for( i in 1:length( country_prefix ) ) {
  
  message( "\t", "COUNTRY: ", country_prefix[i] )
  message( "\t", "\t", "Reading tables from pdf file" )
  
  # something happens here
   
  message("\t", "\t", "\t", "\t", "finished first read")
  
  # from this point, a better example is needed. Read manual for eval parse
  # LOOP 2 START ----
  for( j in 1:length( get(page_number_vector) ) ) { 
    
    table_name <- paste0( country_prefix[i], "_", years[j] )
    
    message( "\t", "\t", "\t", "Converting table on page ", 
             get(page_number_vector)[j], " to data.table: ", table_name )
    
    # in this part the code is written but NOT evaluated yet .......................................
    expr <- expression(
      {
        dummy_table_name <- as.data.table( first_read_table_list[j] )
      }
    )#expression
    
expr <- deparse( expr ) # creates a character vector that contains everything written above
  expr <- gsub( pattern = '(dummy_table_name)', replacement = table_name,  x = expr ) # insert actual table name
  eval( eval( parse( text = expr ) ) ) # here the expression is actually evaluated
      
  }#loop 2 end
  
}#loop 1 end
