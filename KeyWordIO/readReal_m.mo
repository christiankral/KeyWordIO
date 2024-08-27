within KeyWordIO;
function readReal_m "Read the value of a Real parameter from m-file"
  extends Modelica.Icons.Function;
  import Modelica.Utilities.*;
  input String fileName "Name of file" annotation(Dialog(loadSelector(filter="m-file (*.m)",caption="Open m-file for reading")));
  input String name "Name of parameter";
  input Boolean cache = false "Read file before compiling, if true";
  output Real result "Actual value of parameter on file";
protected
  Integer iline = 1;
  String line;
  Integer index;
  Integer lenIdent;
  String message = "in file \"" + fileName + "\" on line ";
  Boolean found = false;
  Boolean endOfFile = false;
algorithm
  (line, endOfFile) :=KeyWordIO.readLine(fileName, iline, cache);
  while not found and not endOfFile loop
    if Strings.isEqual(Strings.substring(line,1,2),"//") or
       Strings.isEqual(Strings.substring(line,1,1),"%") or
       Strings.isEqual(Strings.substring(line,1,1)," ") then
      //skip comment lines (even if comment has trailing blanks before "//" or "%")
      iline := iline + 1;
    else
      index := Strings.find(line, "=", 1); //get position of "="
      if index <= 0 then //no expression
        Streams.error("Erroneous expression without =" + message + String(iline));
      else
        //strip trailing blanks of identifier part before "="
        lenIdent := Strings.find(line," ",1);
        lenIdent := if lenIdent <=0 then index else min(index, lenIdent);
        if not Strings.isEqual(Strings.substring(line, 1, lenIdent - 1), name) then
          //identifier <> name: skip line
          iline := iline + 1;
          found := false;
        else
          //identifier == name: evaluate expression
          //check for mandatory ";" after formula before optional comments
          if Strings.find(line, ";", index+1) <=0 then
            Streams.error("Expression not terminated by ;" + message + String(iline));
          else
            (result, index) := KeyWordIO.Strings.expression(line, index+1, message + String(iline));
            found := true;
          end if;
        end if;
      end if;
    end if;
    (line, endOfFile) :=KeyWordIO.readLine(fileName, iline, cache);
  end while;
  if not found then
    Streams.error("Parameter \"" + name + "\" not found in file \"" + fileName + "\"");
  end if;
  annotation(Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
result = <b>readReal_m</b>(fileName, name);
</pre></blockquote>
<h4>Description</h4>
<p>
This function demonstrates how a function can be implemented
that reads the value of a parameter from a Matlab script-file. 
The idea is to keep parameters in Modelica and in Matlab/Simulink up to date.
The function performs the following actions:
</p>
<ol>
<li> It opens file \"fileName\" and reads the lines of the file.</li>
<li> If a line starts with \"% \" or \"// \" or \" \", it is skipped.</li>
<li> If a line starts with \"name = expression\" and the \"name\" 
     in this line is identical to the second argument \"name\"
     of the function call, the expression calculator 
     is used to evaluate the expression after the \"=\" character.
     The expression has to be terminated with a \";\".
     After the \";\" a comment can follow.</li>
<li> The result of the expression evaluation is returned as
     the value of the parameter \"name\". </li>
</ol>
</html>"));
end readReal_m;
