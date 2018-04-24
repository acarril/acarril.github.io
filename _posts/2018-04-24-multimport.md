---
layout: post
title: <code>multimport</code>&#58; automatic import and append of non-Stata data
---

It often occurs to me that I have multiple Excel or CSV files where each corresponds to a given year.
For example, something like:
```
foo2000.csv
foo2001.csv
...
foo2018.csv
```

<!--more-->

# The manual way

Assuming these files are located in the current working directory, one could easily collect all of the above filenames by using

```
local list : dir . files "*.csv", respectcase
```

The `respectcase` option is important in Windows because by default names are case-insensitive, so you would get a list with all-lowercase names.
This option is irrelevant in Linux (and OS X, I suppose).

Now we can easily import and append all these files with the following code:

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
