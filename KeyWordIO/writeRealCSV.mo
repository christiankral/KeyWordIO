within KeyWordIO;
function writeRealCSV "Writing real matrix to CSV file"
  extends Modelica.Icons.Function;
  input String fileName = "Name of file" annotation(Dialog(saveSelector(filter="Comma separated values (*.csv)",caption="CSV data file")));
  input String delimiter = "\t" "Delimiter";
  input Real matrix[:,:] "Actual matrix to be written to CSV file";
  input String[:,:] header = fill("",0,size(matrix,2))
    "Header lines to be written to CSV file";
  input Integer significantDigits = 6 "Number of significant digits";
protected
  String line "Line string";
algorithm
  if size(matrix,2)<>size(header,2) then
    Modelica.Utilities.Streams.error("writeRealCSV: number of columns of matrix ("+String(size(matrix,1))+") and header ("+String(size(header,1))+") do not match");
  end if;
  Modelica.Utilities.Files.removeFile(fileName);
  // Write headers to file
  for col in 1:size(header,1) loop
    line := header[col, 1];
    for row in 2:size(header,2) loop
      line :=line + delimiter + header[col, row];
    end for;
    Modelica.Utilities.Streams.print(line,fileName);
  end for;

  // Write matrix to file
  for col in 1:size(matrix,1) loop
    line :=String(matrix[col, 1]);
    for row in 2:size(matrix,2) loop
      line :=line + delimiter + String(matrix[col, row],significantDigits=significantDigits);
    end for;
    Modelica.Utilities.Streams.print(line,fileName);
  end for;

  annotation (Documentation(info="<html>
<p>This functions writes an array to a CSV file including header. If the header is not specified explicitely, the header is not written
to the CSV file. Each row of the header string is written to the CSV file. However, the number of columns of <code>matrix</code> and <code>header</code> have to match.</p>

<p><br>File format</p>
<ul>
<li>Recommended delimiters are </li>
<ul><li>\"\\t\" tab</li>
    <li>\" \"  space</li>
    <li>\",\"  comma</li></ul>
<li>The decimal separator is represented by .</li>
</ul>
</html>"));
end writeRealCSV;
