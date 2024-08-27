within KeyWordIO;
function readRealCSV "Read real matrix from CSV file"
  extends Modelica.Icons.Function;
  input String fileName "CSV file name" annotation(Dialog(loadSelector(filter="Comma separated values (*.csv)",caption="CSV data file")));
  input Integer rowBegin = 1 "First row of CSV array";
  input Integer rowEnd = rowBegin "End row of CSV array";
  input Integer colBegin = 1 "First column of CSV array";
  input Integer colEnd = colBegin "End column of CSV array";
  input String delimiter = "\t" "Delimiter of CSV file";
  input Boolean cache = false "Read file before compiling, if true";
  output Real matrix[rowEnd-rowBegin+1,colEnd-colBegin+1]
    "Matrix read from CSV file";

protected
  Integer countDelimiter=Modelica.Utilities.Strings.count(KeyWordIO.readLine(
      fileName, rowBegin, cache), delimiter)
    "Count of delimiters in first row of CSV file";
  String line "Row to be processed";
  Boolean eof "End of file";
  Integer indx "Local index of real value";
  Real val "Local real value";
  Integer indexDelimiter[countDelimiter]
    "Indexes of delimiters within line string";

algorithm
  // Check validity of indexes
  if rowBegin < 1 then
    Modelica.Utilities.Streams.error("readRealCSV: rowBegin < 1");
  end if;
  if colBegin < 1 then
    Modelica.Utilities.Streams.error("readRealCSV: colBegin < 1");
  end if;
  // Check if number of expected columns is present in CSV file
  if countDelimiter+1 < colEnd then
    Modelica.Utilities.Streams.error("readRealCSV: Number of columns of CSV file ("+String(countDelimiter+1)+") is less than colEnd ("+String(colEnd)+")");
  end if;
  eof := false;
  for row in rowBegin:rowEnd loop
    if not eof then
      (line,eof) :=KeyWordIO.readLine(fileName, row, cache);
      // Determine position of all delimiters
      indexDelimiter :=KeyWordIO.Strings.findAll(line, delimiter);
      indx := 1;
      for i in colBegin:colEnd loop
        if i>1 then
          indx :=indexDelimiter[i-1]+1;
        end if;
        // Read real value from line ...
        (val,indx) := Modelica.Utilities.Strings.scanReal(line,indx);
        // ... and store it in the result matrix
        matrix[row-rowBegin+1,i-colBegin+1] := val;
      end for;

    end if;
  end for;

  annotation (Documentation(info="<html>
<p>This functions reads an array from a CSV file and returns a matrix of equal size. The array size of the CSV file is specified by the integers</p>
<ul>
<li><code>rowBegin</span></code> and <code>rowEnd</span></code>,</li>
<li><code>colBegin</span></code> and <code>colEnd</span></code>.</li>
</ul>
<p><br>File format</p>
<ul>
<li>Recommended delimiters are </li>
<ul><li>\"\\t\" tab</li>
    <li>\" \"  space</li>
    <li>\",\"  comma</li></ul>
<li>The decimal separator must be .</li>
</ul>
</html>"));
end readRealCSV;
