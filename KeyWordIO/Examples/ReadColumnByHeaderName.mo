within KeyWordIO.Examples;
model ReadColumnByHeaderName "Read columns by header name"
  extends Modelica.Icons.Example;
  // parameter String csvFileName = Modelica.Utilities.Files.loadResource("modelica://KeyWordIO/Resources/tab.csv");
  parameter String csvFileName = "/work/tab.csv";
  parameter Integer row(fixed=false) "Number of rows";
  parameter Integer col(fixed=false) "Number of columns";
  parameter String header[:,:] = KeyWordIO.readStringCSV(csvFileName,1,1,4,col,"\t");
  // parameter String margin[:,:] = KeyWordIO.readStringCSV(csvFileName,3,col-2,1,2,"\t");
  parameter Real val[:,:] = KeyWordIO.readRealCSV(csvFileName,3,row-2,1,4,"\t");
initial equation
  (row,col) = KeyWordIO.Strings.sizeCSV(csvFileName);
end ReadColumnByHeaderName;
