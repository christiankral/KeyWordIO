within KeyWordIO.Examples;
model ReadRealCSV "Read real matrix from CSV file"
  extends Modelica.Icons.Example;
  parameter Integer rowBegin = 3 "Begin row of CSV file";
  parameter Integer rowEnd = 5 "End row of CSV file";
  parameter Boolean cache=false "Read file before compiling, if true";
  parameter String csvTabFileName = Modelica.Utilities.Files.loadResource("modelica://KeyWordIO/Resources/csv/tab.csv");
  parameter Modelica.Units.SI.Voltage va[:,1]=KeyWordIO.readRealCSV(
      csvTabFileName,
      rowBegin,
      rowEnd,
      1,
      1,
      delimiter="\t",
      cache=cache);
  parameter String csvCommaFileName = Modelica.Utilities.Files.loadResource("modelica://KeyWordIO/Resources/csv/comma.csv");
  parameter Modelica.Units.SI.Current ia[:,1]=KeyWordIO.readRealCSV(
      csvCommaFileName,
      rowBegin,
      rowEnd,
      2,
      2,
      delimiter=",",
      cache=cache);
  parameter String csvSpaceFileName = Modelica.Utilities.Files.loadResource("modelica://KeyWordIO/Resources/csv/space.csv");
  parameter Modelica.Units.NonSI.AngularVelocity_rpm n[:,1]=
      KeyWordIO.readRealCSV(
      csvSpaceFileName,
      rowBegin,
      rowEnd,
      3,
      3,
      delimiter=" ",
      cache=cache);
  parameter String csvSpace2FileName = Modelica.Utilities.Files.loadResource("modelica://KeyWordIO/Resources/csv/space2.csv");
  parameter Modelica.Units.SI.Torque tau[:,1]=KeyWordIO.readRealCSV(
      csvSpace2FileName,
      rowBegin,
      rowEnd,
      4,
      4,
      delimiter="  ",
      cache=cache);
  annotation (experiment(StopTime = 1, Interval = 1E-3));
end ReadRealCSV;
