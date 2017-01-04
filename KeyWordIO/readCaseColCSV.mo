within KeyWordIO;
function readCaseColCSV "Read column of case CSV file by header name"
  extends Modelica.Icons.Function;
  input String fileName "CSV file name" annotation(Dialog(saveSelector(filter="Comma separated values (*.csv)",caption="CSV data file")));
  input Integer header = 2 "Number of header rows";
  input Integer margin = 2 "Number of left margin columns";
  input String delimiter = "\t" "Delimiter of CSV file";
  input Boolean useQuotedStrings = false "Use quoted strings, if true";
  input Boolean cache = false "Read file before compiling, if true";
  input String name "Name of header string be searched";
  input Integer headerRow = 1 "Header row index for searching name";
  output Real val[readRowsCSV(fileName=fileName,delimiter=delimiter,cache=cache)-header]
    "Real vector extracted from data matrix";

protected
  Integer colMax =  readColsCSV(fileName=fileName,delimiter=delimiter,cache=cache);
  Integer rowMax =  readRowsCSV(fileName=fileName,delimiter=delimiter,cache=cache);
  String headerString[:,:] = KeyWordIO.readStringCSV(
      fileName=fileName,
      rowBegin=1,
      rowEnd=header,
      colBegin=1,
      colEnd=colMax,
      delimiter=delimiter,
      useQuotedStrings=useQuotedStrings,
      cache=cache);
  Real matrix[:,:] = KeyWordIO.readRealCSV(
      fileName=fileName,
      rowBegin=header+1,
      rowEnd=rowMax,
      colBegin=margin+1,
      colEnd=colMax,
      delimiter=delimiter,
      cache=cache);
  Integer index = 0 "Index found of name in header";
  Boolean success =  false "Success of searching name in header";
algorithm
  // ### Also change "margin+" in "getCaseCol"
  for col in margin+1:colMax loop
    if Modelica.Utilities.Strings.isEqual(headerString[headerRow,col],name) then
      index := col-margin;
      success := true;
      break;
    end if;
  end for;
  assert(success,"getCaseCol: String "+name+" not found in case.headerString[headerRow,:]");
  val := matrix[:,index];
end readCaseColCSV;
