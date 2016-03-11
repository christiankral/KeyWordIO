within KeyWordIO;
function writeRealVariables "Write multiple real variables to file"
  input String fileName "Name of file" annotation(Dialog(__Dymola_loadSelector(filter = "Text files (*.txt; *.dat)", caption = "Open file in which Real parameters are present")));
  input String name[:] "Name of variable";
  input Real data[:] "Actual value of variable";
  input Boolean append = false "Append data to file";
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
    Modelica.Utilities.Streams.print(name[k] + " = " + String(data[k]), fileName);
  end for;
end writeRealVariables;
