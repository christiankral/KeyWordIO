within KeyWordIO;
function readColsCSV "Read number of columns from CSV file"
  extends Modelica.Icons.Function;

  input String fileName "CSV file name" annotation(Dialog(loadSelector(filter="Comma separated values (*.csv)",caption="CSV data file")));
  input String delimiter = "\t" "Delimiter of CSV file";
  input Boolean cache = false "Read file before compiling, if true";
  output Integer col "Number of columns";

protected
  Integer row "Number of rows";

algorithm
    (row,col) :=KeyWordIO.readSizeCSV(
    fileName=fileName,
    delimiter=delimiter,
    cache=cache);
end readColsCSV;
