within KeyWordIO;
function writeCaseCSV
  "Write header, left margin and numeric data of CSV file organized in \"case\" format"
  extends Modelica.Icons.Function;
  input String fileName = "Name of file" annotation(Dialog(saveSelector(filter="Comma separated values (*.csv)",caption="CSV data file")));
  input Records.Case case "Case";
  input String delimiter = "\t" "Delimiter of CSV file";
  input Boolean useQuotedStrings = false "Use quoted strings, if true";

protected
  String line "Line string";
  Integer significantDigits = 15 "Number of significant Digits";
  Integer rowHeaderMax = size(case.headerString,1) "Number of rows of header";
  Integer colHeaderMax = size(case.headerString,2)
    "Number of columns of header";
  Integer colMarginMax = size(case.marginString,2)
    "Number of columns of margin";
  Integer colMatrixMax = size(case.matrix,2) "Number of columns of matrix";
  Integer rowMatrixMax = size(case.matrix,1) "Number of rows of matrix";

algorithm
  // Remove file before writing
  Modelica.Utilities.Files.removeFile(fileName);
  // Write header lines
  for row in 1:rowHeaderMax loop
    // Treat first column separately due delimiter
    line := Strings.writeString(case.headerString[row, 1],useQuotedStrings);
      for col in 2:colHeaderMax loop
        line :=line + delimiter + Strings.writeString(case.headerString[row,col],useQuotedStrings);
      end for;
      // Write header line to file
      Modelica.Utilities.Streams.print(line,fileName);
  end for;
  // Margin lines
  for row in 1:rowMatrixMax loop
    if colMarginMax>0 then
      // Margin first column
      line :=Strings.writeString(case.marginString[row, 1], useQuotedStrings);
      for col in 2:colMarginMax loop
        // Remaining margin columns
        line :=line + delimiter + Strings.writeString(case.marginString[row,col],useQuotedStrings);
      end for;
      // WMatrix first column
      line := line + delimiter + String(case.matrix[row,1],significantDigits=significantDigits);
    else
      // Matrix first column
      line := String(case.matrix[row,1],significantDigits=significantDigits);
    end if;
    for col in 2:colMatrixMax loop
      // Remaining matrix columns
      line := line + delimiter + String(case.matrix[row,col],significantDigits=significantDigits);
    end for;
    Modelica.Utilities.Streams.print(line,fileName);
  end for;

end writeCaseCSV;
