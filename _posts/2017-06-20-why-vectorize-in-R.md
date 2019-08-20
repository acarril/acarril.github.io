---
layout: post
title: "Vectorization in R: under the hood"
---

![](https://www.quizover.com/jc2012-war/ocw/mirror/col10685_1.2_complete/m21494/pic009.png)

As soon as you start to dig deeper into serious R programming, someone will surely tell you to [avoid loops like the plague](https://yihui.name/en/2010/10/on-the-gory-loops-in-r/), and that vectorizing your code is the way to go.

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

## Vectorizing, a.k.a. thinking in parallel

You may be conditioned to think that every repetitive instantly calls for a loop. That's fine from a code-efficiency perspective, because you're trying to minimize redundancy in your code, which is good. However, we can dig a little deeper and start to think if our loops carry out operations that are dependent of each other or not.

Dependent operations cannot be performed in parallel. These cases basically boil down to loops where the next iteration depends on values from the previous one. Examples include Bayesian statistic computations or some Markov Chain Monte Carlo methods.

However, there are many operations which are not inherently serial, which opens the door to parallelize them. And a neat way of parallelizing operations is to vectorize them, e.g. adding two vectors instead of performing three additions, like in our example above.
A vectorized function takes a vector as an input and outputs a vector of the same length, which eliminates the need for nested loops when dealing with two-dimensional data structures (e.g. data frames).

In this post I don't cover how to vectorize your R code. If you want a more in-depth read I recommend reading [Hadley Wickham's Advanced R chapter on functionals](http://adv-r.had.co.nz/Functionals.html) or [David Springate vectorization tricks](http://rpubs.com/daspringate/vectorisation). **Here we'll understand how does vectorizing your R code make it more efficient.**

## High-level, interpreted language

Almost every introduction to the R language mentions that **R is a high-level, interpreted language.** However, very few of them explain what the f*ck does that mean. This is basic stuff if have a computer science or engineering background, but if you don't, then here is the quick version.

The "high-level" part means that R takes care of a lot of basic (or low-level) computer tasks for us automatically. For instance, if we type

```R
x <- 2.0
```

we actually don't tell the computer that `x` stores numeric-type data, that "2.0" is a floating-point number, that it should find a space in memory to store this number and to register `x` as a pointer to that space. This seems like a chore, but in many languages you have to explicitly tell the machine all these things. Below we'll see how this can sometimes be an advantage.

This kind of simplification means we can issue instructions in a near-human level of abstraction ("high-level") and the language performs automatically a series of intermediate tasks, making reasonable assumptions, corresponding to the details of what we want done.

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

Being an interpreted language means that the computer translates our statements into binary on the fly. If R were a compiled language, this interpretation would be done in the compilation step, before the program was actually run. In compiled languages the user-written code is translated to binary at compilation: after it is written, but before it is run. Since this translation occurs for the whole program ---not line by line--- it allows the compiler to optimize the binary code in an optimal way for the computer to interpret.

## How does R relates to compiled languages?

Many R functions are actually written in a compiled language, like C, C++ or Fortran. For instance, if you inspect the code for the `stats::dnorm()` function (just typing `dnorm` in the console), you get

```R
> dnorm
function (x, mean = 0, sd = 1, log = FALSE) 
.Call(C_dnorm, x, mean, sd, log)
<bytecode: 0x7ffb50a93860>
<environment: namespace:stats>
```

We can see that R is basically passing the inputs onto a C function, `C_dnorm`. R is still interpreting the input --- for instance, figuring out the data type of `x`, as well as checking other defaults. However, the compiled code still runs faster because the "interpreting part" is done first, and then it carries out the task quickly in C (in this case) without translating ever again. 

## What has this to do with vectorization?

If you need to apply a function to all the values of a vector, you could call the function repeatedly for each of its values. However, this means R will do the small "interpreting part" for each call. On the other hand, **passing a whole vector onto the function means R will only interpret the inputs once.**

*"Hey, but there's a catch: you still need to interpret each value of the vector!"*
Actually, no, because one key aspect of a vector in R is that all its elements are of the same data type. In fact, a number in R is actually a one dimensional vector. So passing a whole vector into a function is equivalent to checking just one number, in terms of what the "interpreting part" is concerned about.

Inside C or Fortran vectors will be processed using loops or some equivalent constructs; there's just no way around it. However, since these operations now occur in the compiled code, they run much faster. **Vectorizing cuts down the amount of interpreting that R has to do, which removes overhead and speeds up operations.**

## BLASt through your tasks

Linear algebra is a core element of many computing systems; in fact, many languages are actually built around it. This means there are a lot of highly optimized programs for linear algebra. Such programs are called **basic linear algebra system**, or BLAS.

A BLAS is designed to be very efficient, making the most out of parallel processing, specific hardware setups, etc. R takes advantage of such a system by outsourcing its linear algebra operations to them, which is why it will be almost always faster to vectorize an operation and let the BLAS do the heavy lifting for you.

There are many other BLAS libraries you can try in order to optimize your operations in R if performance is critical to you. For instance, I followed [this post by Nathan VanHoudnos](http://edustatistics.org/nathanvan/2013/07/09/for-faster-r-use-openblas-instead-better-than-atlas-trivial-to-switch-to-on-ubuntu/) in order to install OpenBLAS in a Ubuntu server I use for some projects.