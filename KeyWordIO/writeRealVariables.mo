within KeyWordIO;
function writeRealVariables "Write multiple real variables to file"
  extends Modelica.Icons.Function;
  input String fileName "Name of file" annotation(Dialog(saveSelector(filter="Text file (*.txt;*.dat)",caption="Text data file")));
  input String name[:] "Name of variable";
  input Real data[:] "Actual value of variable";
  input Boolean append = false "Append data to file";
  input Integer significantDigits = 6 "Number of significant digits";
algorithm
  // Check sizes of name and data
  if size(name, 1) <> size(data, 1) then
    assert(false, "writeReadParameters: Lengths of name and data have to be equal");
  end if;
  // Write data to file
  if not append then
    Modelica.Utilities.Files.removeFile(fileName);
  end if;
  for k in 1:size(name, 1) loop
    Modelica.Utilities.Streams.print(name[k] + " = " + String(data[k],significantDigits=significantDigits), fileName);
  end for;
end writeRealVariables;
