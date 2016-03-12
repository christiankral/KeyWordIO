within KeyWordIO;
function readLineWithoutCache
  "Reads a line of text from a file without cahing and returns it in a string"
  extends Modelica.Icons.Function;
  input String fileName "Name of the file that shall be read" annotation(Dialog(__Dymola_loadSelector(filter = "Text files (*.txt; *.dat)", caption = "Open file in which Real parameters are present")));
  input Integer lineNumber(min = 1) "Number of line to read";
  output String string "Line of text";
  output Boolean endOfFile
    "If true, end-of-file was reached when trying to read line";

  external "C" string = ReadLine(fileName, lineNumber, endOfFile);
  annotation(Include = "
#ifndef ReadLine_C
#define ReadLine_C
# include <stdio.h>
# include <string.h>
extern void ModelicaFormatError(const char* string,...);
extern char* ModelicaAllocateString(size_t len);
#ifndef MAXLEN
#define MAXLEN 133
#endif
const char* ReadLine(const char *fileName, int lineNumber, int* endOfFile)
{
        FILE*  fp;
        char   c, strline[MAXLEN];
        char*  line;
        int    iLine;
        size_t lineLen;
        if ((fp=fopen(fileName,\"r\")) == NULL)
        {
                ModelicaFormatError(\"ReadLine: File %s not found!\\n\",fileName);
                return \"\";
        }
        iLine=0;
        while (++iLine <= lineNumber)
        {
                c=fgetc(fp);
                lineLen=1;
                while (c != '\\n' && c != '\\r' && c != EOF)
                {
                        if (lineLen < MAXLEN)
                        {
                                strline[lineLen-1]=c;
                                c=fgetc(fp);
                                lineLen++;
                        }
                        else
                        {
                                fclose(fp);
                                ModelicaFormatError(\"ReadLine: Line %d of file %s truncated!\\n\",iLine,fileName);
                                return \"\";
                        }
                }
                if (c == EOF && iLine < lineNumber)
                {
                        fclose(fp);
                        line=ModelicaAllocateString(0);
                        *endOfFile=1;
                        return line;
                }
        }
        fclose(fp);
        strline[lineLen-1]='\0';
        line=ModelicaAllocateString(lineLen);
        strcpy(line, strline);
        *endOfFile=0;
        return line;
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
end readLineWithoutCache;
