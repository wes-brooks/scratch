# ---
# variables:
#   station_id:
#     ColumnName: "cimis_station_id"
#     Category: "source"
#     Description: "CIMIS station ID number"
#     Format: "integer"
#     Notes: "source: CIMIS"
#   station_name:
#     ColumnName: "cimis_station_name"
#     Category: "new"
#     Description: "CIMIS station name used by researchers"
#     Format: "numeric"
#     Notes: "source: CIMIS"
#   elevation:
#     ColumnName: "cimis_elevation_ft"
#     Category: "new"
#     Description: "elevation of the CIMIS station"
#     Format: "numeric"
#     Notes: "source: CIMIS"
# ---

#GOAL: This is a template script to write file-level metadata for data that is a part of a larger UC Davis DataLab project. It is based on the USGS' "Metadata in plain language" website: https://geology.usgs.gov/tools/metadata/tools/doc/ctc/ This template purposefully leaves out project-level metadata that is covered in the project's scoping documument or other documentation.  It is recommended that you use this code at the end of a cleaning script to facilitate writing the metadata and to keep the cleaning script and metadata in one place.

#AUTHOR: Michele Tobias - mmtobias@ucdavis.edu
#DATE: 2021-04-16


# Setup -------------------------------------------------------------------
#   Load Libraries
library("gdata") #makes a fixed-width data dictionary table in the metadata


# Write the Data & Metadata -----------------------------------------------

#   Create Data Dictionary 

#   For each column you make, write a metadata line to the metadata variable.
#"ColumnName" = the column name in the finished dataset
#"Category" = what is the source of this data? "source" = from another, citable source; "derivative" = created by summarizing or analyzing another source of data; "new" = created by the researcher
#"Description" = a short text description of the data
#"Format" = the data type (numeric, integer, text, etc.)
#"Notes" = any comments that don't fit elsewhere

#   create a blank datatframe sized for the number metadata columns
data.dictionary<-data.frame(matrix(ncol = 5, nrow = 0))

#   create your own dataframe with one row for each column in your dataset with the metadata columns described above.

#   example data dictionary:
data.dictionary<-rbind(
  data.dictionary,
  c("cimis_station_id", "source", "CIMIS station ID number", "integer", "source: CIMIS"),
  c("cimis_station_name", "new", "CIMIS station name used by researchers", "text", NA),
  c("cimis_elevation_ft", "source", "elevation of the CIMIS station", "numeric", "source: CIMIS; units: feet")
)

names(data.dictionary)<-c("ColumnName", "Category",	"Description",	"Format",	"Notes")



# Create the Metadata

#   write the file

#   open the file connection
metadata.con<-file(description="datasetName_METADATA.txt", open="a")

#   writes the metadata to the file at the top
writeLines(
  text=c(
    #   fill in the information inside the paste statement
  paste(
    "Date Metadata was Generated:", Sys.time()),
    "",
    "1. What does the dataset describe?",
    "Dataset Title: [example: Sample Locations]",
    "Dataset File Name: [example: sample_locations.csv]",
    "Dataset Description: ",
    "Time Period: ",
    "Data Format: [table, image, map, spatial vector data, etc.]",
    "File Format: [.csv, .shp, .tiff, etc.]",
    "Geographic Feature Format: (optional) [raster, points, lines, polygons, TIN, point cloud, etc.]",
    "Coordinate Reference System: (optional) [EPSG, Proj string, or text description]",
    "",
    "2. Who produced the dataset?",
      "Original Data Authors: ",
    "Data Processors: (optional)",
    "Other Contributors: (optional)",
    "Input Dataset: ",
    "Cleaning Script: ",
    "Corresponding Author or Contributor: ", 
    "Corresponding Author or Contributor Contact information: [email or phone]",
    "",
    "3. Who wrote the metadata?",
    "Metadata Author: [name]",
    "Metadata Author Contact Information: [email or phone]",
    "",
    "4. Data Dictionary",
    ""
    ),
  con=metadata.con
)

#   write the data dictionary next as a fixed-width table for ease of reading in the text document
write.fwf(data.dictionary, file=metadata.con)

#   close the file connection - the file only writes once the connection is closed
close(metadata.con)
