within KeyWordIO.Strings;
function quoteString "Add optional quotes to string"
  input String string;
  input Boolean useQuotedString = false "Use quoted string, if true";
  output String result "Result string";
algorithm
  if useQuotedString then
    result :="\"" + string + "\"";
  else
    result :=string;
  end if;
end quoteString;
