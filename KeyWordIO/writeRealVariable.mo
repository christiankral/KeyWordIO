within KeyWordIO;
function writeRealVariable "Writing real variable to file"
  input String fileName "Name of file" annotation(Dialog(__Dymola_loadSelector(filter = "Text files (*.txt; *.dat)", caption = "Open file in which Real parameters are present")));
  input String name "Name of parameter";
  input Real data "Actual value of parameter";
  input Boolean append = false "Append data to file";
algorithm
  if not append then
    Modelica.Utilities.Files.removeFile(fileName);
  end if;
  Modelica.Utilities.Streams.print(name + " = " + String(data), fileName);
end writeRealVariable;
