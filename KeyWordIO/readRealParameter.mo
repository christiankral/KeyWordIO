within KeyWordIO;
function readRealParameter "Read the value of a Real parameter from file"
  extends Modelica.Icons.Function;
  import Modelica.Utilities.*;
  import KeyWordIO;
  input String fileName "Name of file" annotation(Dialog(__Dymola_loadSelector(filter = "Text files (*.txt; *.dat)", caption = "Open file in which Real parameters are present")));
  input String name "Name of parameter";
  input Boolean cache = false "Read file with/without caching";
  output Real result "Actual value of parameter on file";
protected
  String line;
  String identifier;
  String delimiter;
  Integer nextIndex;
  Integer iline = 1;
  Types.TokenValue token;
  String message = "in file \"" + fileName + "\" on line ";
  String message2;
  Boolean found = false;
  Boolean endOfFile = false;
algorithm
  if not cache then
    (line, endOfFile) := readLineWithoutCache(fileName, iline);
  else
    (line, endOfFile) := Streams.readLine(fileName, iline);
  end if;
  while not found and not endOfFile loop
    (token, nextIndex) := Strings.scanToken(line);
    if token.tokenType == Types.TokenType.NoToken then
      iline := iline + 1;
    elseif token.tokenType == Types.TokenType.IdentifierToken then
      if token.string == name then
        message2 := message + String(iline);
        (delimiter, nextIndex) := Strings.scanDelimiter(line, nextIndex, {"="}, message2);
        (result, nextIndex) :=KeyWordIO.Strings.expression(
          line,
          nextIndex,
          message2);
        (delimiter, nextIndex) := Strings.scanDelimiter(line, nextIndex, {";", ""}, message2);
        Strings.scanNoToken(line, nextIndex, message2);
        found := true;
      else
        iline := iline + 1;
      end if;
    else
      Strings.syntaxError(line, nextIndex, "Expected identifier " + message + String(iline));
    end if;
    if not cache then
      (line, endOfFile) := readLineWithoutCache(fileName, iline);
    else
      (line, endOfFile) := Streams.readLine(fileName, iline);
    end if;
  end while;
  // skip line
  // name found, get value of "name = value;"
  // wrong name, skip line
  // wrong token
  // read next line
  /*
                                                      if not cache then
                                                        Streams.close(fileName);
                                                      end if;
                                                    */
  if not found then
    Streams.error("Parameter \"" + name + "\" not found in file \"" + fileName + "\"");
  end if;
  annotation(Documentation(info = "<html>
<h4>Syntax</h4>
<blockquote><pre>
result = <b>readRealParameter</b>(fileName, name);
</pre></blockquote>
<h4>Description</h4>
<p>
This function demonstrates how a function can be implemented
that reads the value of a parameter from file. The function
performs the following actions:
</p>
<ol>
<li> It opens file \"fileName\" and reads the lines of the file.</li>
<li> In every line, Modelica line comments (\"// ... end-of-line\")
     are skipped </li>
<li> If a line consists of \"name = expression\" and the \"name\"
     in this line is identical to the second argument \"name\"
     of the function call, the expression calculator Examples.expression
     is used to evaluate the expression after the \"=\" character.
     The expression can optionally be terminated with a \";\".</li>
<li> The result of the expression evaluation is returned as
     the value of the parameter \"name\". </li>
</ol>
<h4>Example</h4>
<p>
On file \"test.txt\" the following lines might be present:
</p>
<blockquote><pre>
// Motor data
J        = 2.3     // inertia
w_rel0   = 1.5*2;  // relative angular velocity
phi_rel0 = pi/3
</pre></blockquote>
<p>
The function returns the value \"3.0\" when called as:
</p>
<blockquote><pre>
readRealParameter(\"test.txt\", \"w_rel0\")
</pre></blockquote>
</html>"));
end readRealParameter;
