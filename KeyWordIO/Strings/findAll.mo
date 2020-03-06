within KeyWordIO.Strings;
function findAll "Find all indexes of 'subString' within 'string'"
  extends Modelica.Icons.Function;
  import Modelica.Utilities.Strings.find;
  import Modelica.Utilities.Strings.count;

  input String string "String that is analyzed";
  input String searchString "String that is searched for in string";
  input Boolean caseSensitive=true
    "= false, if lower and upper case are ignored for the search";
  output Integer index[count(string,searchString,1,caseSensitive)]
    "Index of the beginning of the first occurrence of 'searchString' within 'string', or zero if not present";
protected
  Integer countAll = count(string,searchString,1,caseSensitive)
    "Number of all occurrences of 'searchString' within 'string'";
  Integer iStart = 1 "Local index to start serch from";

algorithm
  for i in 1:countAll loop
    index[i] := find(string,searchString,iStart,caseSensitive);
    iStart := index[i] + 1;
  end for;
end findAll;
