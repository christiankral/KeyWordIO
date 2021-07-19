within KeyWordIO;
function writeString "Low level write of string to file"
  extends Modelica.Icons.Function;
  input String fileName "Name of the file that shall be read" annotation(Dialog(__Dymola_loadSelector(filter = "Text files (*.txt; *.dat)", caption = "Open file in which Real parameters are present")));
  input String line "Line of text";
  output Integer status "Status";
  external "C" status = WriteLine(fileName, line)
  annotation(Include = "
#ifndef WriteLine_C
#define WriteLine_C
# include <stdio.h>
# include <string.h>
extern void ModelicaFormatError(const char* string,...);
extern char* ModelicaAllocateString(size_t len);
const int* WriteLine(const char *fileName, const char *line)
{
        FILE*  fp;
        
        if ((fp=fopen(fileName,\"a\")) == NULL)
        {
           ModelicaFormatError(\"WriteLine: File %s not found or accessible.\\n\",fileName);
           fclose(fp);
           return 1;
        }
        if ( fputs(line,fp) < 0 ) 
        {
           ModelicaFormatError(\"WriteLine: String could not be written to file %s.\\n\",fileName);
           fclose(fp);
           return 2;
        }
        fclose(fp);
        
        return 0;
}
#endif
");
  annotation(Documentation(info = "<html>
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
end writeString;
