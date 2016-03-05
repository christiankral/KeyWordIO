within KeyWordIO;
function expression
  "Expression interpreter that returns with the position after the expression (expression may consist of +,-,*,/,^,(),sin(), cos(), tan(), sqrt(), asin(), acos(), atan(), exp(), log(), pi"
  import Modelica.Utilities.Types;
  import Modelica.Utilities.Strings;
  import Modelica.Math;
  import Modelica.Constants;
  input String string "Expression that is evaluated";
  input Integer startIndex = 1
    "Start scanning of expression at character startIndex";
  input String message = ""
    "Message used in error message if scan is not successful";
  output Real result "Value of expression";
  output Integer nextIndex "Index after the scanned expression";
protected
  function term "Evaluate term of an expression"
    extends Modelica.Icons.Function;
    input String string;
    input Integer startIndex;
    input String message = "";
    output Real result;
    output Integer nextIndex;
  protected
    Real result2;
    Boolean scanning = true;
    String opString;
  algorithm
    // scan for "primary * primary" or "primary / primary"
    (result, nextIndex) := primary(string, startIndex, message);
    while scanning loop
      (opString, nextIndex) := Strings.scanDelimiter(string, nextIndex, {"*", "/", "^", ""}, message);
      if opString == "" then
        scanning := false;
      else
        (result2, nextIndex) := primary(string, nextIndex, message);
        result := if opString == "*" then result * result2 else if opString == "/" then result / result2 else result ^ result2;
      end if;
    end while;
  end term;

  function primary "Evaluate primary of an expression"
    extends Modelica.Icons.Function;
    input String string;
    input Integer startIndex;
    input String message = "";
    output Real result;
    output Integer nextIndex;
  protected
    Types.TokenValue token;
    Real result2;
    String delimiter;
    String functionName;
    Real pi = Constants.pi;
  algorithm
    (token, nextIndex) := Strings.scanToken(string, startIndex, unsigned=  true);
    if token.tokenType == Types.TokenType.DelimiterToken and token.string == "(" then
      (result, nextIndex) := expression(string, nextIndex, message);
      (delimiter, nextIndex) := Strings.scanDelimiter(string, nextIndex, {")"}, message);
    elseif token.tokenType == Types.TokenType.RealToken then
      result := token.real;
    elseif token.tokenType == Types.TokenType.IntegerToken then
      result := token.integer;
    elseif token.tokenType == Types.TokenType.IdentifierToken then
      if token.string == "pi" then
        result := pi;
      else
        functionName := token.string;
        (delimiter, nextIndex) := Strings.scanDelimiter(string, nextIndex, {"("}, message);
        (result, nextIndex) := expression(string, nextIndex, message);
        (delimiter, nextIndex) := Strings.scanDelimiter(string, nextIndex, {")"}, message);
        if functionName == "sin" then
          result := Math.sin(result);
        elseif functionName == "cos" then
          result := Math.cos(result);
        elseif functionName == "tan" then
          result := Math.tan(result);
        elseif functionName == "sqrt" then
          if result < 0.0 then
            Strings.syntaxError(string, startIndex, "Argument of call \"sqrt(" + String(result) + ")\" is negative.\n" + "Imaginary numbers are not supported by the calculator.\n" + message);
          end if;
          result := sqrt(result);
        elseif functionName == "asin" then
          result := Math.asin(result);
        elseif functionName == "acos" then
          result := Math.acos(result);
        elseif functionName == "atan" then
          result := Math.atan(result);
        elseif functionName == "exp" then
          result := Math.exp(result);
        elseif functionName == "log" then
          if result <= 0.0 then
            Strings.syntaxError(string, startIndex, "Argument of call \"log(" + String(result) + ")\" is negative.\n" + message);
          end if;
          result := log(result);
        else
          Strings.syntaxError(string, startIndex, "Function \"" + functionName + "\" is unknown (not supported)\n" + message);
        end if;
      end if;
    else
      Strings.syntaxError(string, startIndex, "Invalid primary of expression.\n" + message);
    end if;
  end primary;

  Real result2;
  String signOfNumber;
  Boolean scanning = true;
  String opString;
algorithm
  // scan for optional leading "+" or "-" sign
  (signOfNumber, nextIndex) := Strings.scanDelimiter(string, startIndex, {"+", "-", ""}, message);
  // scan for "term + term" or "term - term"
  (result, nextIndex) := term(string, nextIndex, message);
  if signOfNumber == "-" then
    result := -result;
  end if;
  while scanning loop
    (opString, nextIndex) := Strings.scanDelimiter(string, nextIndex, {"+", "-", ""}, message);
    if opString == "" then
      scanning := false;
    else
      (result2, nextIndex) := term(string, nextIndex, message);
      result := if opString == "+" then result + result2 else result - result2;
    end if;
  end while;
  annotation(Documentation(info = "<html>
<h4>Syntax</h4>
<blockquote><pre>
             result = <b>expression</b>(string);
(result, nextIndex) = <b>expression</b>(string, startIndex=1, message=\"\");
</pre></blockquote>
<h4>Description</h4>
<p>
This function is nearly the same as Examples.<b>calculator</b>.
The essential difference is that function \"expression\" might be
used in other parsing operations: After the expression is
parsed and evaluated, the function returns with the value
of the expression as well as the position of the character
directly after the expression.
</p>
<p>
This function demonstrates how a simple expression calculator
can be implemented in form of a recursive decent parser
using basically the Strings.scanToken(..) and scanDelimiters(..)
function. There are 2 local functions (term, primary) that
implement the corresponding part of the grammar.
</p>
<p>
The following operations are supported (pi=3.14.. is a predefined constant):
</p>
<pre>
   +, -
   *, /, ^
   (expression)
   sin(expression)
   cos(expression)
   tan(expression)
   sqrt(expression)
   asin(expression)
   acos(expression)
   atan(expression)
   exp(expression)
   log(expression)
   pi
</pre>
<p>
The optional argument \"startIndex\" defines at which position
scanning of the expression starts.
</p>
<p>
In case of error,
the optional argument \"message\" is appended to the error
message, in order to give additional information where
the error occured.
</p>
<p>
This function parses the following grammaer
</p>
<pre>
  expression: [ add_op ] term { add_op term }
  add_op    : \"+\" | \"-\"
  term      : primary { mul_op primary }
  mul_op    : \"*\" | \"/\" | \"^\"
  primary   : UNSIGNED_NUMBER
              | pi
              | ( expression )
              | functionName( expression )
  function  :   sin
              | cos
              | tan
              | sqrt
              | asin
              | acos
              | atan
              | exp
              | log
</pre>
<p>
Note, in Examples.readRealParameter it is shown, how the expression
function can be used as part of another scan operation.
</p>
<h4>Example</h4>
<blockquote><pre>
  expression(\"2+3*(4-1)\");  // returns 11
  expression(\"sin(pi/6)\");  // returns 0.5
</pre></blockquote>
</html>"));
end expression;
