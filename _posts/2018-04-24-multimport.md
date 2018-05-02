---
layout: post
title: <code>multimport</code>&#58; automatic import and append of non-Stata data
---

It often occurs to me that I have multiple Excel or CSV files where each corresponds to a given year.
Something like
```
foo2000.csv
foo2001.csv
...
foo2017.csv
```

It is fairly straightforward to create a loop to import and append all these files, but there are several little things that can be made to make the code more succint and generalizable.

<!--more-->

# The manual way

Suppose all these files are located in a subdirectory (relative to your current working directory) called `foos`. Instead of manually setting the list type for the loop (ie. `forvalues i = 2000/2017 {`), we could easily collect all the filenames with

```
local list : dir "foos/" files "*.csv", respectcase
```

This method has the advantage of being more flexible (what if you finally get `foo2018.csv`?), and it also works if filenames are not indexed nicely (ie. they don't contain numbers that form a sequence).
The `respectcase` option is important in Windows because by default names are case-insensitive, so you would get a list with all-lowercase names.
This option is irrelevant in Linux (and OS X, I suppose).

Now we can easily import and append all files with the following code:

```
tempfile data
save `data', emptyok
foreach f of local files {
  // Import
  import delimited "`f'"
  // Append
  append using `data'
  save `data', replace
}
```

Generally this code works fine, but it relies on having matching column names across files.
It also depends on having no mismatch of string/numeric columns, which (for me) is a common issue.
When time or efficiency is not a big issue, I opt to import everything as string, do the append, and then destring all variables:

```
tempfile data
save `data', emptyok
foreach f of local files {
  // Import
  import delimited "`f'", stringcols(_all)
  // Append
  append using `data'
  save `data', replace
}
destring, replace
```

# The `multimport` command

Being tired of carrying out this small operation time and time again, I created a small program to do it for me. It can be installed with

```
ssc install multimport
```

It does exactly what it name implies: it imports and appends multiple non-Stata files at once.
For instance, the same result as above can be achieved with

```
multimport delimited, dir("foos/") import(stringcols(_all))
```

The program will automatically list all CSV files in `foos/`, and after a user prompt it will import and append them.
It is also easy to specify specific files, or exclude certain ones.
There is an Excel version as well, which is called out with `multimport excel ...`.
The help file provides more options and examples.

# Further improvements

The contribution of this program is fairly modest, as it performs a function that can be easily replicated with a few lines of code (like I showed above).
It's just nice (at least for me) to be able to execute it as a one-liner.

However, if I can find the time it would be cool to implement the following additions:

1. Ability to import from multiple sources.
2. Better handling of string/numeric mismatches, so it is carried out out automatically and just for the conflicting columns.
3. Add some kind of column name string matching, so datasets with slightly different column names would still be matched.

Other suggestions are welcome.
