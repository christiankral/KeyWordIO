within KeyWordIO;
function readLine
  "Reads a line of text from a file without cahing and returns it in a string"
  extends Modelica.Icons.Function;
  input String fileName "Name of the file that shall be read" annotation(Dialog(__Dymola_loadSelector(filter = "Text files (*.txt; *.dat)", caption = "Open file in which Real parameters are present")));
  input Integer lineNumber(min = 1) "Number of line to read";
input Boolean cache = false "Read file before compiling, if true";
  output String string "Line of text";
  output Boolean endOfFile
    "If true, end-of-file was reached when trying to read line";
algorithm
  if not cache then
    (string, endOfFile) := KeyWordIO.readLineWithoutCache(fileName, lineNumber);
  else
    (string, endOfFile) := Modelica.Utilities.Streams.readLine(fileName, lineNumber);
  end if;

  annotation (
 Documentation(info = "<html>
<h4>Syntax</h4>
<blockquote><pre>
(string, endOfFile) = <b>readLine</b>(fileName, lineNumber)
</pre></blockquote>
<h4>Description</h4>
<p>
Function <b>readLine</b>(..) opens the given file, reads enough of the 
content to get the requested line, and returns the line as a string. 
Lines are separated by LF or CR-LF; the returned string does not 
contain the line separator.
</p>
<p>
If lineNumber > countLines(fileName), an empty string is returned
and endOfFile=true. Otherwise endOfFile=false.
</p>
</html>"));
end readLine;
