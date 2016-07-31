within KeyWordIO;
function readCaseNumbers "Read number of cases from CSV file"
  extends Modelica.Icons.Function;

  input String fileName "CSV file name";
  input Integer header = 2 "Number of header rows";
  input String delimiter = "\t" "Delimiter of CSV file";
  input Boolean cache = false "Read file before compiling, if true";
  output Integer cases "Number of cases";

protected
  Integer col "Number of columns";
  Integer row "Number of rows";

algorithm
  (row,col) :=KeyWordIO.readCSVSize(
    fileName=fileName,
    delimiter=delimiter,
    cache=cache);
  cases := row - header;
end readCaseNumbers;
