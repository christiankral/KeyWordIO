within KeyWordIO.Strings;
function sizeCSV "Determine size of CSV file"
  extends Modelica.Icons.Function;
  input String fileName "CSV file name";
  input String delimiter = "\t" "Delimiter of CSV file";
  input Boolean cache = false "Read file before compiling, if true";
  output Integer row "Number of rows of CSV file";
  output Integer col "Number of columns of CSV file";

protected
  Integer countDelimiter=Modelica.Utilities.Strings.count(
      KeyWordIO.readLine(fileName, 1, cache), delimiter)
    "Count of delimiters in first row of CSV file";
  String line "Row to be processed";
  Boolean eof "End of file";

algorithm
  // Number of rows equals number of delimiters + 1
  col:=countDelimiter+1;
  // Start column counting with 0
  row:=0;
  // Initialize eof with false since it will be overwritten after reading the file
  eof := false;
  while not eof loop
    row:=row+1;
    // Determine eof after reading next line
    (line,eof) :=KeyWordIO.readLine(fileName, row, cache);
    // If the actual number of delimtiers is not equal number of delimiters of
    // the first line, then trigger end of reading
    if Modelica.Utilities.Strings.count(KeyWordIO.readLine(fileName, row, cache),
        delimiter) + 1 <> col then
      // Trigger exit of while loop
      eof:=true;
      // Reduce numnber of rows by 1 to determine correct number of
      // equal delimiter rows
      row:=row-1;
    end if;
  end while;
end sizeCSV;
