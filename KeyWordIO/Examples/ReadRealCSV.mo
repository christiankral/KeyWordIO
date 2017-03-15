within KeyWordIO.Examples;
model ReadRealCSV "Read real matrix from CSV file"
  extends Modelica.Icons.Example;
  parameter Integer colBegin = 3 "Begin column of CSV file";
  parameter Integer colEnd = 5 "End column of CSV file";
  parameter Boolean cache=false "Read file before compiling, if true";
  parameter String csvTabFileName = Modelica.Utilities.Files.loadResource("modelica://KeyWordIO/Resources/csv/tab.csv");
  parameter Modelica.SIunits.Voltage va[:,1] = KeyWordIO.readRealCSV(csvTabFileName,colBegin,colEnd,1,1,delimiter="\t",cache=cache);
  parameter String csvCommaFileName = Modelica.Utilities.Files.loadResource("modelica://KeyWordIO/Resources/csv/comma.csv");
  parameter Modelica.SIunits.Current ia[:,1] = KeyWordIO.readRealCSV(csvCommaFileName,colBegin,colEnd,2,2,delimiter=",",cache=cache);
  parameter String csvSpaceFileName = Modelica.Utilities.Files.loadResource("modelica://KeyWordIO/Resources/csv/space.csv");
  parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm n[:,1] = KeyWordIO.readRealCSV(csvSpaceFileName,colBegin,colEnd,3,3,delimiter=" ",cache=cache);
  parameter String csvSpace2FileName = Modelica.Utilities.Files.loadResource("modelica://KeyWordIO/Resources/csv/space2.csv");
  parameter Modelica.SIunits.Torque tau[:,1] = KeyWordIO.readRealCSV(csvSpace2FileName,colBegin,colEnd,4,4,delimiter="  ",cache=cache);
  annotation (experiment(StopTime = 1, Interval = 1E-3));
end ReadRealCSV;
