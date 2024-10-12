library(data.table)
library(tabulapdf)

# setting parameters -------------------------------------------------------------------------------
path_to_pdf_file <- ".../simple_R_code/extract_table_sample_file.pdf"
pages_aux <- 1

# simple extraction --------------------------------------------------------------------------------
test <- tabulapdf::extract_tables( file = path_to_pdf_file,  pages = pages_aux )
DT <- as.data.table(test)


# extraction with selected areas -------------------------------------------------------------------

male_coordinates <- list(
  c(
    top = 144.289818866979, 
    left = 59.42367688713, 
    bottom = 388.402782862069, 
    right = 531.31490840179
  )
)

# coordinates like the ones above can be obtained with:
# coordinates <- locate_areas(
#   file = path_to_pdf_file, pages = pages_aux,
#   resolution = 60L,
#   widget = c("shiny", "native", "reduced"), copy = FALSE
# )
# to get many sets of coordinates for different areas of the page, add something like pages = c(1,1)
# In this example, 1 is the page number (repeat the page number for however many areas you have)

test <- tabulapdf::extract_tables( 
  file = path_to_pdf_file,  
  pages = pages_aux, 
  guess = FALSE,
  area = male_coordinates
)


# find information about pdf file ------------------------------------------------------------------

# extract_metadata() .............................
# Extract metadata from a file
# Usage: extract_metadata(file, password = NULL, copy = FALSE)
extract_metadata( file = path_to_pdf_file )

# get_page_dims() ................................
# returns a list of two-element numeric vectors specifying the width and height of each page.
# usage: get_page_dims(file, doc, pages = NULL, password = NULL, copy = FALSE)
get_page_dims( file = path_to_pdf_file, pages = pages_aux )

# get_n_pages() ..................................
# returns number of pages of a pdf document (the "page length")
# usage: get_n_pages(file, doc, password = NULL, copy = FALSE)
get_n_pages( file = path_to_pdf_file )

# locate_areas() .................................
# Interactively identify areas and extract
locate_areas( 
  file = path_to_pdf_file, pages = pages_aux,
  resolution = 60L, 
  widget = c("shiny", "native", "reduced"), copy = FALSE 
)


# further reading ----------------------------------------------------------------------------------

# https://www.r-bloggers.com/2024/04/tabulapdf-extract-tables-from-pdf-documents/
# https://cran.r-project.org/web/packages/tabulapdf/vignettes/tabulapdf.html
