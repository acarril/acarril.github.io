---
layout: post
title: "Vectorization in R: under the hood"
draft: true
---

![](https://www.quizover.com/jc2012-war/ocw/mirror/col10685_1.2_complete/m21494/pic009.png)

As soon as you start to dig deeper into serious R programming, someone will surely tell you to avoid loops like the plague, and that vectorizing your code is the way to go.

Basically you're asked to blindly believe that 

$$
\begin{bmatrix}
0 \\
1 \\
2 \\
\end{bmatrix}
+
\begin{bmatrix}
3 \\
4 \\
5 \\
\end{bmatrix}
=
\begin{bmatrix}
3 \\
5 \\
7 \\
\end{bmatrix}
$$

is better/faster than

$$
\begin{align}
0 + 3 &= 3 \\
1 + 4 &= 5 \\
2 + 5 &= 7
\end{align}
$$.

This doesn't make a whole lot of sense. I mean, in both cases we're performing the three same sums, so why should using vectors be more efficient? In this post we'll dive into the inner workings of R to understand why.

<!--more-->

# High-level, interpreted language

Almost every introduction to the R language mentions that **R is a high-level, interpreted language.** However, very few of them explain what the f*ck does that mean. This is basic stuff if have a computer science or engineering background, but if you don't, then here is the quick version.

The "high-level" part means that R takes care of a lot of basic (or low-level) computer tasks for us automatically. For instance, if we type

```R
x <- 2.0
```

we actually don't tell the computer that `x` stores numeric-type data, that "2.0" is a floating-point number, that it should find a space in memory to store this number and to register `x` as a pointer to that space. This seems like a chore, but in many languages you have to explicitly tell the machine all these things. Below we'll see how this can sometimes be an advantage.

This means we can issue instructions in a near-human level of abstraction ("high-level") and the language performs a series of intermediate tasks, making reasonable assumptions, corresponding to the details of what we want done.

Moreover, R performs all these intermediate tasks on the fly, as you type them in the console (or source them from a script). This means that running a command in R takes a tiny bit longer than in some other lower-level languages, like C. Take the following command as an example:

```R
5L + 3.14
```

Internally, this computation goes down a little something like this:

> What is this statement?
> A sum between two thingies
> So what's the first thing?
> An integer
> And the second thing?
> A floating-point number
> Cool. So what should I do to add up these two different thingies?
> Just convert the integer to a floating-point number and use your routine to add up two floating-points.
> \* Converts integer to floating-point number \*
> \* Adds up tow floating-point numbers \*
> \* Finds place in memory to store result \*

