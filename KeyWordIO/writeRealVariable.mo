within KeyWordIO;
function writeRealVariable "Writing real variable to file"
  extends Modelica.Icons.Function;
  input String fileName "Name of file" annotation(Dialog(saveSelector(filter="Text file (*.txt;*.dat)",caption="Text data file")));
  input String name "Name of parameter";
  input Real data "Actual value of parameter";
  input Boolean append = false "Append data to file";
protected
  Integer significantDigits = 15 "Number of significant Digits";
algorithm
  if not append then
    Modelica.Utilities.Files.removeFile(fileName);
  end if;
  Modelica.Utilities.Streams.print(name + " = " + String(data,significantDigits=significantDigits), fileName);
end writeRealVariable;
