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

  input Real val[KeyWordIO.readCaseNumbersCSV(
    fileName=fileName,
    header=header,
    delimiter="\t",
    cache=cache)] "Real vector to be overwritten at column where header matches name";

  // input Real val[35] "Real vector to be overwritten at column where header matches name";
/*
  input Real val[KeyWordIO.readColsCSV(fileName=fileName,delimiter=delimiter,cache=cache)-header]
    "Real vector to be overwritten at column where header matches name";
    */
  input Integer significantDigits = 6 "Number of significant digits";

protected
  Integer row "Number of data rows";
  Integer col "Number of data columns";

  String headerString[header,KeyWordIO.readColsCSV(fileName=fileName,delimiter=delimiter,cache=cache)] "Header string";
  String marginString[KeyWordIO.readRowsCSV(fileName=fileName,delimiter=delimiter,cache=cache)-header,margin] "Margin string";
  Real matrix[KeyWordIO.readRowsCSV(fileName=fileName,delimiter=delimiter,cache=cache)-header,
              KeyWordIO.readColsCSV(fileName=fileName,delimiter=delimiter,cache=cache)-margin] "Numeric data";
  Integer index = 0 "Index found of name in header";
  Boolean success =  false "Success of searching name in header";

algorithm
  // Determine rows and columns of entire CSV file
  (row,col) := KeyWordIO.readSizeCSV(
    fileName=fileName,
    delimiter=delimiter,
    cache=cache);
  headerString :=KeyWordIO.readStringCSV(
    fileName=fileName,
    colBegin=1,
    colEnd=col,
    rowBegin=1,
    rowEnd=header,
    delimiter=delimiter,
    useQuotedStrings=useQuotedStrings,
    cache=cache);
  marginString :=KeyWordIO.readStringCSV(
    fileName=fileName,
    colBegin=1,
    colEnd=margin,
    rowBegin=header+1,
    rowEnd=row,
    delimiter=delimiter,
    useQuotedStrings=useQuotedStrings,
    cache=cache);
  matrix := readRealCSV(fileName=fileName,
    colBegin=margin+1,
    colEnd=col,
    rowBegin=header+1,
    rowEnd=row,
    delimiter=delimiter,
    cache=cache);
  // Remove file, as it is going to be overwritten
  Modelica.Utilities.Files.removeFile(fileName);

  for c in 1:col loop
    if Modelica.Utilities.Strings.isEqual(headerString[headerRow,c],name) then
      index := c-margin;
      success := true;
      break;
    end if;
  end for;
  assert(success,"getCaseCol: String "+name+" not found in case.headerString[headerRow,:]");

  // Write header back to CSV file
  for r in 1:header loop
    for c in 1:col-1 loop
      writeString(fileName, headerString[r, c] + "\t");
    end for;
    // Write last column of header back to file
    writeLine(fileName, headerString[r, col]);
  end for;
  for r in 1:row-header loop
    // Write margin back to CSV file
    for c in 1:margin loop
      writeString(fileName, marginString[r, c] + "\t");
    end for;
    // Write data matrix back to CSV file
    for c in 1:col-margin-1 loop
      if c<>index then
        writeString(fileName, String(matrix[r, c], significantDigits=significantDigits) + "\t");
      else
        writeString(fileName, String(val[r], significantDigits=significantDigits) + "\t");
      end if;
    end for;
    // Write last column of data matrix back to file
    if col-margin<>index then
      writeLine(fileName, String(matrix[r, col - margin], significantDigits=significantDigits));
    else
      writeLine(fileName, String(val[r], significantDigits=significantDigits));
    end if;

  end for;
end overwriteCaseCSV;
