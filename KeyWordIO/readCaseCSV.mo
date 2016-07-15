within KeyWordIO;
function readCaseCSV
  "Read header, left margin and numeric data of CSV file organized in \"case\" format"
  extends Modelica.Icons.Function;
  input String fileName "CSV file name" annotation(Dialog(saveSelector(filter="Comma separated values (*.csv)",caption="CSV data file")));
  input Integer header = 2 "Number of header rows";
  input Integer margin = 2 "Number of left margin columns";
  input String delimiter = "\t" "Delimiter of CSV file";
  input Boolean useQuotedStrings = false "Use quoted strings, if true";
  output KeyWordIO.Records.Case case(
    rowMax=KeyWordIO.getCSVRows(fileName=fileName, delimiter=delimiter),
    colMax=KeyWordIO.getCSVCols(fileName=fileName, delimiter=delimiter),
    header=header,
    margin=margin) "Case record";
algorithm
  // Read header string matrix from file
  case.headerString := KeyWordIO.readStringCSV(
    fileName=fileName,
    rowBegin=1,
    rowEnd=header,
    colBegin=1,
    colEnd=case.colMax,
    delimiter=delimiter,
    useQuotedStrings=useQuotedStrings);
  // Read margin string matrix from file
  case.marginString := KeyWordIO.readStringCSV(
    fileName=fileName,
    rowBegin=header+1,
    rowEnd=case.rowMax,
    colBegin=1,
    colEnd=margin,
    delimiter=delimiter,
    useQuotedStrings=useQuotedStrings);
  // Read numerical data from file
  case.matrix := KeyWordIO.readRealCSV(
    fileName=fileName,
    rowBegin=header+1,
    rowEnd=case.rowMax,
    colBegin=margin+1,
    colEnd=case.colMax,
    delimiter=delimiter);
end readCaseCSV;
