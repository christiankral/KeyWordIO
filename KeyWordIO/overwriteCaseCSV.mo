within KeyWordIO;
function overwriteCaseCSV
  "Overwrite numeric data of CSV file organized in \"case\" format"
  extends Modelica.Icons.Function;
  input String fileName = "Name of file" annotation(Dialog(saveSelector(filter="Comma separated values (*.csv)",caption="CSV data file")));
  input Integer header = 2 "Number of header rows";
  input Integer margin = 2 "Number of left margin columns";
  input String delimiter = "\t" "Delimiter of CSV file";
  input Boolean useQuotedStrings = false "Use quoted strings, if true";
  input Boolean cache = false "Read file before compiling, if true";
  input String name "Name to be identified in header";
  input Integer headerRow = 1 "Header row index for searching key";
  input Real val[KeyWordIO.readCaseNumbers(
    fileName=fileName,
    header=header,
    delimiter="\t",
    cache=cache)]
    "Real vector to be overwritten at column where header matches name";
  input Integer significantDigits = 6 "Number of significant digits";

protected
  Records.Case case = KeyWordIO.readCaseCSV(
    fileName=fileName,
    header=header,
    margin=margin,
    delimiter=delimiter,
    useQuotedStrings=useQuotedStrings) "Case";
  Integer index = 0 "Index found of name in header";
  Boolean success =  false "Success of searching name in header";

algorithm
  // ### For testing sizes
  // Modelica.Utilities.Streams.print("size(val,1)="+String(size(val,1)));
  // Modelica.Utilities.Streams.print("size(case.matrix,1)="+String(size(case.matrix,1)));
  Modelica.Utilities.Files.removeFile(fileName);

 for col in 1:case.colMax loop
    if Modelica.Utilities.Strings.isEqual(case.headerString[headerRow,col],name) then
      index := col-margin;
      success := true;
      break;
    end if;
  end for;
  assert(success,"getCaseCol: String "+name+" not found in case.headerString[headerRow,:]");
  case.matrix[:,index] := val;
  KeyWordIO.writeCaseCSV(fileName=fileName,case=case,delimiter=delimiter,useQuotedStrings=useQuotedStrings,significantDigits=significantDigits);
end overwriteCaseCSV;
