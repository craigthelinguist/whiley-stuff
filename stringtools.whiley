import whiley.lang.System

import char from whiley.lang.ASCII
import string from whiley.lang.ASCII
import whiley.lang.ASCII

/**
   Return the input string with all upper-case letters replaced by
   lower-case letters.
      s : string to operate upon.

   Examples
      lower("WhIlEY") -> "whiley"
**/
function lower (string s) -> (string r):
   char[] result = [0;|s|]
   int i = 0
   while i < |s|:
      if ASCII.isLetter(s[i]) && ASCII.isUpperCase(s[i]):
         result[i] = s[i] + 32
      else:
         result[i] = s[i]
      i = i + 1
   return result

/**
   Return the input string with all lower-case letters replaced by
   upper-case letters.
      s : string to operate upon.

   Examples
      upper("WhIlEY") -> "WHILEY"
**/
function upper (string s) -> (string r):
   char[] result = [0;|s|]
   int i = 0
   while i < |s|:
      char ch = s[i]
      if ASCII.isLetter(s[i]) && ASCII.isLowerCase(s[i]):
         result[i] = s[i] - 32
      else:
         result[i] = s[i]
      i = i + 1
   return result

/**
   Return the string obtained by concatenating an array of strings
   together, separated by a specified symbol.
      strings : array of strings to be joined together.
      separator : the char which should separate each string.

   Requires
      - Length of input should be positive.

   Examples
      join(["Here ", "is%an" "example"], "|") -> "Here |is%an|example"
**/
function join (string[] strings, char separator) -> (string)
   requires |strings| > 0:

   // Count number of characters that will be in the output string.
   int numChars = 0
   int k = 0
   while k < |strings|:
      numChars = numChars + |strings[k]|
      k = k + 1
   numChars = numChars + separator * (|strings| - 1)

   // Construct the new string.
   string result = [0;numChars]
   int rIndex = 0
   k = 0
   while k < |strings|:

      // Append next substring.
      string str = strings[k]
      int i = 0
      while i < |str|:
         result[rIndex] = str[i]
         rIndex = rIndex + 1
         i = i + 1
     
      // Increment indices; append separator.   
      if k != |strings| - 1:
         result[rIndex] = separator
      rIndex = rIndex + 1
      k = k + 1

   return result

/**
   Return the string obtained by dividing a string into an array of
   strings. The strings in the array are those delimited in the input
   by a specified separator character.
   
   Examples
      split("good work bro", " ") -> ["good", "work", "bro"]
**/
function split (string str, char separator) -> (string[]):
   
   // Count number of times the separator occurs.
   int numSeps = 0
   int k = 0
   while k < |str|:
      if str[k] == separator:
         numSeps = numSeps + 1
      k = k + 1

   // This is where the results will be stored.
   // k indexes the input string; rIndex the output array.
   string[] result = [ [0;0]; numSeps + 1]
   int rIndex = 0
   k = 0

   while k < |str|:

      // Figure out how long  next substring is.
      int substrLen = 0
      while k + substrLen < |str| && str[k + substrLen] != separator:
         substrLen = substrLen + 1

      // Copy substring into new char array. Put into output.
      char[] substr = [0;substrLen]
      int i = 0
      while i < substrLen:
         substr[i] = str[k + i]
         i = i + 1

      // Append separator. Increment indices.
      if rIndex != |result|:
         result[rIndex] = substr
      rIndex = rIndex + 1
      k = k + substrLen + 1 // +1 for the separator

   return result

