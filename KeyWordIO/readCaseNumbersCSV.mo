within KeyWordIO;
function readCaseNumbersCSV "Read number of cases from CSV file"
  extends Modelica.Icons.Function;

  input String fileName "CSV file name" annotation(Dialog(loadSelector(filter="Comma separated values (*.csv)",caption="CSV data file")));
  input Integer header = 2 "Number of header rows";
  input String delimiter = "\t" "Delimiter of CSV file";
  input Boolean cache = false "Read file before compiling, if true";
  output Integer cases "Number of cases";

protected
  Integer col "Number of columns";
  Integer row "Number of rows";

algorithm
  (row,col) :=KeyWordIO.readSizeCSV(
    fileName=fileName,
    delimiter=delimiter,
    cache=cache);
  cases := row - header;
end readCaseNumbersCSV;
