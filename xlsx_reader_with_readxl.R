# packages and paths should be loaded in dedicated scripts
# library(readxl)
# library(data.table)
# read_dir <- paste0( data_dir, "name_of_specific_folder_with_data" )
# write_dir <- read_dir # change?

# DATASET READER
message( paste0( rep( '-', 100 ), collapse = '' ) )
message( "\t", "Reading raw data" )


# read xlsx ----------------------------------------------------------------------------------------
message( "\t", "\t", file_name )

first_read_tibble <-  readxl::read_xlsx( path = full_path_to_file,
                                         sheet = 1,
                                         col_names = TRUE
)

# readxl outputs a tibble, so you might want to convert to data.table
DT <-  as.data.table(first_read_tibble)


# save ---------------------------------------------------------------------------------------------
message( "\t", "Saving" )
message( "\t", "\t", object_name, ".rds" )

# for a single object ............................
save( INSERT_OBJECT_NAME_HERE_DIRECTLY_WITH_NO_QUOTATION_MARKS, 
      file = paste0( write_dir,
                     object_name,
                     ".rds" ) 
)

# for many objects ...............................
# save( first object, second object, # put the object names in directly, without quotation marks
#       file = paste0( write_dir,
#                      "INSERT NAME FOR THE RDATA FILE HERE (BETWEEN QUOTATION MARKS)",
#                      ".RData" ) 
# )

message( "\t", "Finished" )
