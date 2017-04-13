---
layout: post
title:  "Manipulating locals via macro lists"
categories: stata
published: true
---

Defining and using locals in Stata is extremely useful, but sometimes we need to go beyond just storing and reusing some values. In this post I explain advanced manipulation of locals via [`macro lists`](http://www.stata.com/manuals13/pmacrolists.pdf), which allow us to get the number of elements in a local, handle duplicate elements, sort (and shuffle) elements and perform other logical operations.

1. [Duplicate elements](#duplicate-elements)
2. [Add and remove elements](#add-and-remove-elements)
3. [Unions and intersections](#unions-and-intersections)
4. [Sorting and shuffling](#sorting-and-shuffling)

# Duplicate elements

We may have a local with duplicate elements stored within. For example,

```stata
. local fib 0 1 1 2 3
```

We can easily **remove duplicated elements from the local** using

```
. local fib_nodups : list uniq fib
. display "`fib_nodups'"
0 1 2 3
```

We could also **extract duplicated elements from the local** using

```
. local fib_dups : list dups fib
. display "`fib_dups'"
1
```

Note that `dups` extracts *all* surplus elements, so if we have had three 1s in `fib`, then `fib_dups` would have had two.

# Add and remove elements

**Adding elements to a local** is as easy as "appending" one after the other. For example, lets define the contents of two local macros, `vars` and `coefs`, as follows:

```
. local vars x y z
. local coefs a b c
```

We can very easily join the contents of both locals into a third one using:

```
. local vars_coefs `vars' `coefs'
. display "`vars_coefs'"
x y z a b c
```

Now, to **remove elements from a local** we need to define a new one with the elements to be removed and then "substract" it from the original one.

For example, suppose we want to update the contents of `vars` by eliminating the element `y`. This can be done by defining a new local (e.g. `not`) with the elements to be removed and then "substracting" it from `vars`:

```
. local not y
. local vars : list vars - not
. di "`vars'"
x z
```

Cool! No need to [tokenize](http://www.stata.com/manuals13/ptokenize.pdf).

# Unions and intersections

A slightly different way of adding the elements is taking the **union of two locals**, which is just the set of all *distinct* elements in both locals.

For example, if we have local macros `A` and `B` defined as follows, we can append all the elements of `B` not contained in `A` with the `|` ("pipe") sign:

```
. local A house tree car
. local B computer car bike
. local all_things : list A | B
. display "`all_things'"
house tree car computer bike
```

Notice how the element `car` was not appended, because it was already in `A`. This is how unions differ from simply [adding the elements of one local to the other](#add-and-remove-elements).

We can also get the **intersection of two locals**, which corresponds to elements that belong to *both*. Using local macros `A` and `B` defined above, we can get their intersection in the following way:

```
. local common_things : list A & B
. display "`common_things'"
car
```

# Sorting and shuffling

Sometimes we will want to **sort the elements inside a local macro**, which can be done as follows:

```
. local names  tao galois ramunajan neumann
. local names : list sort names
. display "`names'"
galois neumann ramunajan tao
```

And as a bonus, I had a hard time figuring out how to **randomly shuffle the elements of a macro**, which turns out can be easily done using a bit of [Mata](https://www.stata.com/manuals13/m.pdf):

```
. local nums 1 2 3 4 5
. mata : st_local("random_nums", invtokens(jumble(tokens(st_local("nums"))')'))
. display "`random_nums'"
2 1 3 5 4
```
