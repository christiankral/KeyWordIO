within KeyWordIO.Examples;
model WriteRealVariable "Write real variable to file"
  extends Modelica.Icons.Example;
  parameter Real offset = 0 "Offset";
  parameter Real height = 1 "Height";
  parameter Modelica.SIunits.Time startTime = 0.5 "Starting time of step";
  parameter String outputFileName = Modelica.Utilities.Files.loadResource("modelica://KeyWordIO/../output.txt");
  Modelica.Blocks.Sources.Step step(offset=offset,height=height,startTime=startTime)
    annotation (Placement(transformation(extent={{-8,-8},{12,12}})));
equation
  // Start value of step.y
  when initial() then
    KeyWordIO.writeRealVariable(outputFileName,"y_start",step.y,append=false);
  end when;
  // End value of step.y right after switching
  when time>startTime then
    KeyWordIO.writeRealVariable(outputFileName,"y_end",step.y,append=true);
  end when;
  annotation (experiment(StopTime = 1, Interval = 1E-3));
end WriteRealVariable;
