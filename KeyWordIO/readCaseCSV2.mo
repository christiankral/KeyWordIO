within KeyWordIO;
function readCaseCSV2
  "Read header, left margin and numeric data of CSV file organized in \"case\" format"
  extends Modelica.Icons.Function;
  input String fileName "CSV file name";
  input Integer header = 2 "Number of header rows";
  input Integer margin = 2 "Number of left margin columns";
  input String delimiter = "\t" "Delimiter of CSV file";
  input Boolean useQuotedStrings = true "Use quoted strings, if true";
  output String headerString[header,KeyWordIO.getCSVCols(fileName=fileName,delimiter=delimiter)] "Header string matrix read from CSV file";
  output String marginString[KeyWordIO.getCSVRows(fileName=fileName,delimiter=delimiter)-header,margin] "Margin string matrix read from CSV file";
  output Real matrix[KeyWordIO.getCSVRows(fileName=fileName,delimiter=delimiter)-header,KeyWordIO.getCSVCols(fileName=fileName,delimiter=delimiter)-margin] "Numercal data matrix read from CSV file";
protected
  Integer rowMax = KeyWordIO.getCSVRows(fileName=fileName, delimiter=delimiter) "Maximum number of rows";
  Integer colMax = KeyWordIO.getCSVCols(fileName=fileName, delimiter=delimiter) "Maximum number of columns";
algorithm
  // Read header string matrix from file
  headerString := KeyWordIO.readStringCSV(
    fileName=fileName,
    rowBegin=1,
    rowEnd=header,
    colBegin=1,
    colEnd=colMax,
    delimiter=delimiter,
    useQuotedStrings=useQuotedStrings);
  // Read margin string matrix from file
  marginString := KeyWordIO.readStringCSV(
    fileName=fileName,
    rowBegin=header+1,
    rowEnd=rowMax,
    colBegin=1,
    colEnd=margin,
    delimiter=delimiter,
    useQuotedStrings=useQuotedStrings);
  // Read numerical data from file
  matrix := KeyWordIO.readRealCSV(
    fileName=fileName,
    rowBegin=header+1,
    rowEnd=rowMax,
    colBegin=margin+1,
    colEnd=colMax,
    delimiter=delimiter);
end readCaseCSV2;
