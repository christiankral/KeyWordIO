within KeyWordIO;
function getCSVCols "Determined number of columns of CSV file"
  extends Modelica.Icons.Function;

  input String fileName "CSV file name";
  input String delimiter = "\t" "Delimiter of CSV file";
  input Boolean cache = false "Read file before compiling, if true";
  output Integer col "Number of columns";

protected
  Integer row "Number of rows";

algorithm
    (row,col) :=KeyWordIO.getCSVSize(fileName=fileName, delimiter=delimiter, cache=cache);
end getCSVCols;
