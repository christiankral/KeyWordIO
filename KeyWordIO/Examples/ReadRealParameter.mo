within KeyWordIO.Examples;
model ReadRealParameter "Reads real parameters from file"
  extends Modelica.Icons.Example;
  parameter String inputFileName = Modelica.Utilities.Files.loadResource("modelica://KeyWordIO/Resources/txt/input.txt");
  parameter Modelica.SIunits.Resistance R0 = KeyWordIO.readRealParameter(inputFileName,"R0");
  parameter Modelica.SIunits.Resistance R1 = KeyWordIO.readRealParameter(inputFileName,"R1");
  parameter Modelica.SIunits.Resistance R2 = KeyWordIO.readRealParameter(inputFileName,"R2");
  annotation (experiment(StopTime = 1, Interval = 1E-3));
end ReadRealParameter;
