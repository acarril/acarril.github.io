---
layout: post
title: "Under the hood of vectorization in R"
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
is better than
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

Almost every introduction to the R language mentions that R is a high-level, interpreted language. However, very few of them explain what the f*ck does that mean.

Well, the "high-level" part means that R takes care of a lot of basic (or low-level) computer tasks for us automatically. For instance, if we type

```R
x <- 2.0
```

we actually don't tell the computer that `x` stores numeric-type data, that "2.0" is a floating-point number, that it should find a space in memory to store this number and to register `x` as a pointer to that space. This seems like a chore, but in many languages you have to explicitely tell the machine all these things. Below we'll see how this can sometimes be an advantage.

This means we can issue instructions in a near-human level of abstraction ("high-level") and the language 
