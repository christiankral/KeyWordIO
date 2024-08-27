within KeyWordIO;
function writeLine "Low level write of line including to file"
  extends Modelica.Icons.Function;
  input String fileName "Name of the file that shall be read" annotation(Dialog(saveSelector(filter = "Text files (*.txt; *.dat)", caption = "Open file in which Real parameters are present")));
  input String line "Line of text";
  output Integer status "Status";
  external "C" status = WriteLineLn(fileName, line);
  annotation(Include = "
#ifndef WriteLineLn_C
#define WriteLineLn_C
# include <stdio.h>
# include <string.h>
extern void ModelicaFormatError(const char* string,...);
extern char* ModelicaAllocateString(size_t len);
const int* WriteLineLn(const char *fileName, const char *line)
{
        FILE*  fp;
        
        if ((fp=fopen(fileName,\"a\")) == NULL)
        {
           ModelicaFormatError(\"WriteLineLn: File %s not found or accessible.\\n\",fileName);
           return 1;
        }
        if ( fputs(line,fp) < 0 ) 
        {
           ModelicaFormatError(\"WriteLineLn: String could not be written to file %s.\\n\",fileName);
           fclose(fp);
           return 2;
        }
        
        if ( fputs(\"\\n\",fp) < 0 ) 
        {
        ModelicaFormatError(\"WriteLineLn: Newline could not be written to file %s.\\n\",fileName);
           fclose(fp);
           return 3;
        }
        
        fclose(fp);
        return 0;
}
#endif
",
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

end writeLine;
