within KeyWordIO;
function readRowsCSV "Read number of rows from CSV file"
  extends Modelica.Icons.Function;

  input String fileName "CSV file name";
  input String delimiter = "\t" "Delimiter of CSV file";
  input Boolean cache = false "Read file before compiling, if true";
  output Integer row "Number of rows";

protected
  Integer col "Number of columns";

algorithm
    (row,col) :=KeyWordIO.readSizeCSV(
      fileName=fileName,
      delimiter=delimiter,
      cache=cache);
end readRowsCSV;
