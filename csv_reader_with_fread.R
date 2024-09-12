# This reader uses the data.table package's fread instruction which reads faster (maybe), and
# automatically converts to data.table format.

library(data.table)

message( paste0( rep( "-", 100 ), collapse = "" ) )
message( "\t", "Reading" )
data_dir <- "~/Downloads/"
read_dir <- paste0( data_dir, "name_of_specific_folder_with_data" )

# 1 CSV using fread  -------------------------------------------------------------------------------
object_name <- "name_of_file_without_extension" # .... (i)
file_name <- paste0(object_name, ".csv") 
full_file_path <- paste0( read_dir, file_name )

message( "\t", "\t", "Reading: ", file_name )

assign( 
  x = object_name, # .... (ii)
  value = data.table::fread(full_file_path) 
)





# (i) hopefully your file names are nice (short, clear, no weird characters) and it makes sense to
#     use them as the names of the objects inside your R environment.
#     For example, if the name of the file is "gdp_2010.csv" it would make sense to re-use it as the 
#     name of the table "gdp_2010". 
#
#     If the name of the file is something like "gdp_unitd ArAb EMIrates_as of 11 22-2010.csv"
#     you may want to change it ... But, if you don't want to change it for reproducibility reasons,
#     then change the assignment line (ii).
