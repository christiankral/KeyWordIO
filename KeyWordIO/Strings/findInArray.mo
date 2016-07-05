within KeyWordIO.Strings;
function findInArray "Find string in string array"
  extends Modelica.Icons.Function;
  input String string[:] "String array";
  input String searchString "Search string";
  input Integer startIndex = 1 "Start index to search within string";
  output Integer index "Array index of string found in array (0=not found)";
protected
  Boolean found "Indicator of found string";
  Integer k "Counter";
algorithm
  // Initialize index, indicator and counter
  index := 0;
  found := false;
  k := 0;
  while found==false and k<size(string,1) loop
    k := k + 1;
    if string[k]==searchString then
      // If string is found then exit while loop
      index := k;
      found := true;
    end if;
  end while;

end findInArray;
