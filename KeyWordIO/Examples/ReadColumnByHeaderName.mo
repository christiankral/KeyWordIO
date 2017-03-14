within KeyWordIO.Examples;
model ReadColumnByHeaderName "Read columns by header name"
  extends Modelica.Icons.Example;
  parameter String csvFileName = Modelica.Utilities.Files.loadResource("modelica://KeyWordIO/Resources/tab.csv");
  parameter Integer row(fixed=false) "Number of rows" annotation(Evaluate=true);
  parameter Integer col(fixed=false) "Number of columns" annotation(Evaluate=true);
  parameter Boolean cache = false "Read file before compiling, if true";
  constant Integer colConst = 4;
  constant Integer rowConst = 72;
  // The following code shall work with row and col but it is not working.
  // Therefore row is replaced by rowConst and col is replaced by colCOnst.
  parameter String header[:,:] = KeyWordIO.readStringCSV(csvFileName,1,1,2,colConst,delimiter="\t",cache=cache,useQuotedStrings=true);
  parameter Real val[:,:] = KeyWordIO.readRealCSV(csvFileName,3,rowConst,1,colConst,delimiter="\t",cache=cache);
initial equation
  (row,col) = KeyWordIO.readSizeCSV(csvFileName,cache=true);
end ReadColumnByHeaderName;
