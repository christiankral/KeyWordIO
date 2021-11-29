within KeyWordIO.Examples;
model ReadReal_m "Reads real parameters from m-file"
  extends Modelica.Icons.Example;
  import Modelica.Units.SI;
  parameter String inputFileName = Modelica.Utilities.Files.loadResource("modelica://KeyWordIO/Resources/m/setParameters.m");
  parameter SI.Resistance R0=KeyWordIO.readReal_m(inputFileName, "data.R0");
  parameter SI.Resistance R1=KeyWordIO.readReal_m(inputFileName, "data.R1");
  parameter SI.Resistance R2=KeyWordIO.readReal_m(inputFileName, "data.R2");
  parameter SI.AngularVelocity w0(displayUnit="rpm")=KeyWordIO.readReal_m(inputFileName, "data.w0");
  annotation (experiment(StopTime = 1, Interval = 1E-3), Documentation(info="<html>
<p>
To store parameters for usage in Modelica and in Matlab/Simulink only once;
</p>
<ul>
<li>Create a Matlab script which sets the paramaters in a struct in workspace.</li>
<li>For comments, use Matlab.style \"%\".</li>
<li>Terminate the expressions with \";\".</li>
<li>Read this m-file from Modelica.</li>
</ul>
</ul>
</html>"));
end ReadReal_m;
