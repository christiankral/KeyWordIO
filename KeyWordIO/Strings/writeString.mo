within KeyWordIO.Strings;
function writeString "Add optional quotes to string"
  input String string;
  input Boolean useQuotedString = false "Use quoted string, if true";
  output String result "Result string";
algorithm
  if useQuotedString then
    result :="\"" + string + "\"";
  else
    result :=string;
  end if;
end writeString;
