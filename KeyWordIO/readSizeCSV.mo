within KeyWordIO;
function readSizeCSV "Determined number of rows and columns of CSV file"
  extends Modelica.Icons.Function;

  input String fileName "CSV file name";
  input String delimiter = "\t" "Delimiter of CSV file";
  input Boolean cache = false "Read file before compiling, if true";
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
    (line,eof) :=KeyWordIO.readLine(fileName, 1, cache);
    // Determine number of delimiters of first line
    countDelimiter1 := Modelica.Utilities.Strings.count(line, delimiter);
    while not eof and not Modelica.Utilities.Strings.isEmpty(line) loop
      row := row +1;
      // Read next line of file
      (line,eof) :=KeyWordIO.readLine(fileName, row, cache);
      // Determine number of delimiters of next line
      countDelimiter := Modelica.Utilities.Strings.count(line, delimiter);
      // Cause assert, if number of delimiters is different to first line
      assert(countDelimiter==countDelimiter1 or countDelimiter1==1 or Modelica.Utilities.Strings.isEmpty(line) or eof,"getSizeCSV: row "+String(row)+" has a different number of columns than the previous rows");
    end while;
    // If cache = true then read number of lines using countLines instead
    if cache==true then
       row := Modelica.Utilities.Streams.countLines(fileName=fileName);
    else
       row := row-1;
    end if;
    // eof or empty(line) went one index to far, thus
    col := countDelimiter1+1;

end readSizeCSV;
