within KeyWordIO;
function getCSVSize
  "Determined number of rows and columns of CSV file"
  extends Modelica.Icons.Function;

  input String fileName "CSV file name";
  input String delimiter = "\t" "Delimiter of CSV file";
  output Integer row "Number of rows";
  output Integer col "Number of columns";

protected
  Integer countDelimiter1 "Count of delimiters in first row of CSV file";
  Integer countDelimiter "Count of delimiters in remaining rows of CSV file";
  String line "Row to be processed";
  Boolean eof "End of file";

algorithm
    row := 1;
    // Read first line of file
    (line,eof) := KeyWordIO.readLineWithoutCache(fileName, 1);
    // Determine number of delimiters of first line
    countDelimiter1 := Modelica.Utilities.Strings.count(line, delimiter);
    while not eof and not Modelica.Utilities.Strings.isEmpty(line) loop
      row := row +1;
      // Read next line of file
      (line,eof) := KeyWordIO.readLineWithoutCache(fileName, row);
      // Determine number of delimiters of next line
      countDelimiter := Modelica.Utilities.Strings.count(line, delimiter);
      // Cause assert, if number of delimiters is different to first line
      assert(countDelimiter==countDelimiter1 or countDelimiter1==1 or Modelica.Utilities.Strings.isEmpty(line) or eof,"getCSVSize: row "+String(row)+" has a different number of columns than the previous rows");
    end while;
    // eof or empty(line) went one index to far, thus
    row := row-1;
    col := countDelimiter1+1;
end getCSVSize;
