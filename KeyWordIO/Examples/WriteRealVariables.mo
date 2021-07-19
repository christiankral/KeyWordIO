within KeyWordIO.Examples;
model WriteRealVariables "Write real variable to file"
  extends Modelica.Icons.Example;
  parameter Real offset = 0 "Offset";
  parameter Real height = 1 "Height";
  parameter Modelica.Units.SI.Time startTime=0.5 "Starting time of step";
  parameter String outputFileName = Modelica.Utilities.Files.loadResource("modelica://KeyWordIO/../output.txt");
  discrete Real y_start "Start value of step.y";
  discrete Real y_end(start=0) "End value of step.y right after switching";
  Modelica.Blocks.Sources.Step step(offset=offset,height=height,startTime=startTime)
    annotation (Placement(transformation(extent={{-8,-8},{12,12}})));
algorithm
  // Start value of step.y
  when initial() then
    y_start := step.y;
  end when;
  // End value of step.y right after switching
  when time>=startTime then
    y_end := step.y;
  end when;
  when terminal() then
    KeyWordIO.writeRealVariables(outputFileName,{"y_start","y_end"},{y_start,y_end},append=false);
  end when;
  annotation (experiment(StopTime = 1, Interval = 1E-3));
end WriteRealVariables;
