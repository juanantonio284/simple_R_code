# SAVE ---------------------------------------------------------------------------------------------
# path definition ..........................................
data_dir <- "~/Downloads/"
date_dir <- format(Sys.time(), "%d-%b-%Y_time_%H-%M") # date of directory creation
save_dir <- paste0(data_dir, "1_raw_", date_dir, "/")

if ( !dir.exists(save_dir) ) { # create save_dir if it does not exist
  dir.create(save_dir, recursive = TRUE)
}

# CHOOSE AN OPTION BELOW, DELETE THE ONES YOU DON'T USE AND THE "Option 123: " COMMENTS
# Option 1: type in the names of objects directly ---------------------------
# Save selected objects ....................................
message( paste0( rep( "-", 100 ), collapse = "" ) )
message( "\t", "Saving objects to RData/rds file" )

save( object_1, # just type in the names of objects directly
      file = paste0( save_dir,
                     "test",
                     ".RData" ) # .rds for one object, .RData for many
)
# list.files(save_dir)


# Option 2: make a vector with selected objects -----------------------------
# select objects to save ...................................
# Stringer
dput( ls() ) # run and copy/paste the output text in line below
object_string <- # "c( "object_1", "object_2" )
  
  # Save selected objects ....................................
  message( paste0( rep( '-', 100 ), collapse = '' ) )
message( "\t", "Saving objects to RData file" )

save( list = object_string , # list argument requires character string "c(
      file = paste0( save_dir,
                     "INSERT_FILE_NAME",
                     ".RData" ) # .rds for one object, .RData for many
)
# list.files(save_dir)


# Option 3: using a loop to save many .rds files ---------------------------
# .rds loop saver ...................................
object_string <-  c("", "", "")

message( "\t", "Saving objects to many .rds files" )
for( i in 1:length(object_string) ) { # i <- 1
  
  # create names ..................................................
  save_name <- object_string[i]
  message( "\t", "\t", save_name )
  
  save( list =  object_string[i],
        file = paste0( data_dir,
                       save_name,
                       ".rds" ) # .rds for one object, .Rdata for many
  )
  
}# for loop end
# list.files(data_dir)
