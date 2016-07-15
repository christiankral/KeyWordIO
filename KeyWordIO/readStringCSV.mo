within KeyWordIO;
function readStringCSV "Read real matrix from CSV file"
  extends Modelica.Icons.Function;
  input String fileName "CSV file name";
  input Integer rowBegin = 1 "First row of CSV array";
  input Integer rowEnd = rowBegin "End row of CSV array";
  input Integer colBegin = 1 "First column of CSV array";
  input Integer colEnd = colBegin "End column of CSV array";
  input String delimiter = "\t" "Delimiter of CSV file";
  input Boolean useQuotedStrings = true "Use quoted strings, if true";
  output String matrix[rowEnd-rowBegin+1,colEnd-colBegin+1]
    "Matrix read from CSV file";

protected
  Integer countDelimiter = Modelica.Utilities.Strings.count(KeyWordIO.readLineWithoutCache(fileName, rowBegin),delimiter)
    "Count of delimiters in first row of CSV file";
  String line "Row to be processed";
  Boolean eof "End of file";
  Integer indx "Local index of real value";
  String val "Local string value";
  Integer indexDelimiter[countDelimiter]
    "Indexes of delimiters within line string";
  Integer colMax = KeyWordIO.getCSVCols(fileName=fileName,delimiter=delimiter) "Maximum number of rows";

algorithm
  // Check validity of indexes
  if rowBegin < 1 then
    Modelica.Utilities.Streams.error("readStringCSV: rowBegin < 1");
  end if;
  if colBegin < 1 then
    Modelica.Utilities.Streams.error("readStringCSV: colBegin < 1");
  end if;
  // Check if number of expected columns is present in CSV file
  if countDelimiter+1 < colEnd then
    Modelica.Utilities.Streams.error("readStringCSV: Number of columns of CSV file ("+String(countDelimiter+1)+") is less than colEnd ("+String(colEnd)+")");
  end if;
  eof := false;
  for row in rowBegin:rowEnd loop
    if not eof then
      (line,eof) := KeyWordIO.readLineWithoutCache(fileName, row);
      // Determine position of all delimiters
      indexDelimiter :=KeyWordIO.Strings.findAll(line, delimiter);
      indx := 1;
      for i in colBegin:colEnd loop
        if i>1 then
          indx :=indexDelimiter[i-1]+1;
        end if;
        if useQuotedStrings then
          // Read quoted string value from line ...
          (val,indx) := Modelica.Utilities.Strings.scanString(line,indx);
        else
          // Read unquoted string value directly from line using substring...
          if i==colMax then
            val := Modelica.Utilities.Strings.substring(line,indx,Modelica.Utilities.Strings.length(line));
          else
            val := Modelica.Utilities.Strings.substring(line,indx,indexDelimiter[i]-1);
            indx := indexDelimiter[i]+1;
          end if;
        end if;
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
end readStringCSV;
