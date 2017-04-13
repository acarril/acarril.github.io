---
layout: post
title:  "Looping over values of a variable"
categories: stata
---

When creating loops, it is common to loop over all unique values of a variable. Usually we set these values explicitely, but there are more streamlined ways to automatically loop over existing values. This makes your code less error prone and more adaptable.

For example, let's say you have a dataset with a `year` variable that spans years 2007-2013:

```stata
. tab year

       Year |      Freq.     Percent        Cum.
------------+-----------------------------------
       2007 |     73,949       13.18       13.18
       2008 |     75,315       13.43       26.61
       2009 |     75,398       13.44       40.05
       2010 |     69,152       12.33       52.38
       2011 |     75,665       13.49       65.87
       2012 |     93,167       16.61       82.48
       2013 |     98,288       17.52      100.00
------------+-----------------------------------
      Total |    560,934      100.00
```

The most direct way of looping through all values of `year` is to define a loop like

```stata
forvalues y = 2007/2013 {
  ...
}
```

However this is not very efficient, as one would have to manually change all these loops if we dropped a year or added an aditional one. It would be far better to just extract the unique values contained in `year`, whatever those are.

There is a way to do exactly that, using the [`levelsof`](http://www.stata.com/help.cgi?levelsof) command. It can be used just like `tabulate` above, to display the values of a variable:

```stata
. levelsof year
2007 2008 2009 2010 2011 2012 2013
```

However, *`levelsof` can store values of a variable in a local macro*. We can then use that macro to construct our loop in various ways. For example,

```stata
. levelsof year, local(year_values)
. foreach y of numlist `year_values' {
  ...
}
```

[continues]
