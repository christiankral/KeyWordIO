within KeyWordIO;
function readRealCSV "Read real matrix from CSV file"
  input String fileName "CSV file name";
  input Integer rowBegin = 1 "First row of CSV array";
  input Integer rowEnd = rowBegin "End row of CSV array";
  input Integer colBegin = 1 "First column of CSV array";
  input Integer colEnd = colBegin "End column of CSV array";
  output Real matrix[rowEnd-rowBegin+1,colEnd-colBegin+1]
    "Matrix read from CSV file";

protected
  String line "Row to be processed";
  Boolean eof "End of file";
  Integer indx "Local index of real value";
  Real val "Local real value";
algorithm
  eof := false;
  for row in rowBegin:rowEnd loop
    if not eof then
      (line,eof) :=KeyWordIO.readLineWithoutCache(fileName, row);
      indx :=1;
      for i in 1:colEnd loop
        (val,indx) := Modelica.Utilities.Strings.scanReal(line,indx);
        indx := indx + 1;
        if i>=colBegin then
          matrix[row-rowBegin+1,i-colBegin+1] := val;
        end if;
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
<li>Allowed delimiters are </li>
<ul><li>\"\\t\" tab</li>
    <li>\" \"  space</li>
    <li>\",\"  comma</li></ul>
<li>The decimal separator must be .</li>
</ul>
</html>"));
end readRealCSV;
