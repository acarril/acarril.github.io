---
layout: page
title: Resources
permalink: /resources
order: 2
---

This page is a repository of resources of various types, collected in one place. These include [software](#software) bits I've written (mostly Stata) and miscellaneous [documents](#documents) (mostly in spanish).


### Software

Although I also like to code in R and Python, I believe my only worthy collaborations to the world are Stata and LaTeX programs. All Stata programs can be installed directly within Stata using `ssc install <program>`.

- [**rddsga**](https://gitlab.com/acarril/rddsga/wikis/home) -- Subgroup analysis with propensity score weighting in RDD settings ([Github](https://github.com/acarril/rddsga))
- [**psestimate**]({{site.baseurl}}/posts/psestimate) -- Estimate the propensity score proposed by [Imbens and Rubin (2015)](http://www.cambridge.org/zw/academic/subjects/statistics-probability/statistical-theory-and-methods/causal-inference-statistics-social-and-biomedical-sciences-introduction) ([SSC](https://ideas.repec.org/c/boc/bocode/s458179.html), [Github](https://github.com/acarril/psestimate))
- [**randtreat**]({{site.baseurl}}/posts/randtreat) -- Random treatment assignment with unequal treatment fractions and dealing with misfits ([SSC](https://ideas.repec.org/c/boc/bocode/s458106.html), [Github](https://github.com/acarril/randtreat)). I also discuss misfits in greater detail in my [SJ paper](http://www.stata-journal.com/article.html?article=st0490) (see the [research section](/research) for additional info).
- [**texresults**]({{site.baseurl}}/posts/export-results-latex) -- Create external file of LaTeX macros with results ([SSC](https://ideas.repec.org/c/boc/bocode/s458334.html), [Github](https://github.com/acarril/texresults))
- [**lcmm / gcdm**]({{site.baseurl}}/posts/GCD-LCM) -- Compute least common multiple and greatest common divisor
- **nrow** -- Rename variables as their *n*-th row values ([SSC](https://ideas.repec.org/c/boc/bocode/s458116.html), [Github](https://github.com/acarril/nrow))
- **jpaltheme** -- LaTeX Beamer theme that complies with [J-PAL](https://www.povertyactionlab.org/)'s branding guidelines ([Github](https://github.com/acarril/jpaltheme))

### Documents

Almost all of these documents are unfinished and may contain errors. Use with caution.

- [**Poder estadístico en diseños experimentales**](https://www.dropbox.com/s/s4wvhsi59zqw34c/poder_optimal_design.pdf?dl=0) -- Ejercicios sencillos de cálculos de poder en [Optimal Design](http://hlmsoft.net/od/) (pauta disponible [aquí](https://www.dropbox.com/s/q5l73pjng99fjyz/poder_optimal_design%20-%20pauta.pdf?dl=0))
- [**Resumen De Gregorio**](https://www.dropbox.com/s/o5cj07jpdq0em54/DeGregorioResumen.pdf?dl=0) -- Resumen del libro [Macroeconomía: Teoría y Políticas](http://www.degregorio.cl/pdf/Macroeconomia.pdf), de [José De Gregorio (2007)](http://www.econ.uchile.cl/jdegregorio)
- [**Apunte Finanzas Públicas**](https://www.dropbox.com/s/574qx72wji32tgq/Apuntes%20finanzas%20publicas.pdf?dl=0) -- Apuntes del curso de Finanzas Públicas de [Claudia Martínez](http://economia.uc.cl/profesor/claudia-martinez-a/)
- [**Manual de LaTeX**](https://www.dropbox.com/s/hcz69dj5rrusi9g/manual_latex.pdf?dl=0) -- Breve guía práctica para escribir en [LaTeX](http://tex.stackexchange.com/a/94910/45978)
- [**Análisis de Datos en R**](https://www.dropbox.com/s/at5qtihss4vsme5/ADR.pdf?dl=0) -- Borrador en progreso de un libro que estoy escribiendo para manejo y análisis de datos en [R](https://www.r-project.org/).

### Lectures

A collection of lectures I've given, mainly with [J-PAL LAC](https://www.povertyactionlab.org/LAC) (hence, in spanish).

- **Introducción a Stata** - Secuencia de clases de introducción a Stata. [01](https://www.dropbox.com/s/d253yz7yyfmkhyi/stata_class01.pdf?dl=0) - [02](https://www.dropbox.com/s/5pybvikiiufizgp/stata_class02.pdf?dl=0) - [03](https://www.dropbox.com/s/4pigjntd5zytyeb/stata_class03_vMax.pdf?dl=0) - [04](https://www.dropbox.com/s/jst8u56f46di85c/stata_class04_vMax.pdf?dl=0) - [05](https://www.dropbox.com/s/fef1fmfb2lw3x8t/stata_class05.pdf?dl=0) - [06](https://www.dropbox.com/s/xpod8h8si0cthn1/stata_class06.pdf?dl=0) -[07](https://www.dropbox.com/s/xj8yqxbc4aihgpk/stata_class07_vMax.pdf?dl=0) - [08](https://www.dropbox.com/s/tda1rtwcq0dw43a/stata_class08_vMax.pdf?dl=0)
- [**Efectos estandarizados y Poder estadístico**](https://www.dropbox.com/s/pf4rse155g2yc2f/class_statistical_power.pdf?dl=0) -- Entender intuitivamente la necesidad de estandarizar efectos y cómo hacerlo. Entender intuitiva y gráficamente qué es el poder estadístico, cómo se relaciona con errores tipo I y II y qué elementos de un diseño lo afectan. Aplicaciones en Stata.
- [**Mecánica de aleatorización I**](https://www.dropbox.com/s/aedge51xocm79iv/clase12_slides.pdf?dl=0) -- Pasos para una aleatorización simple y replicable en Stata. Aplicación de estos pasos en diseños de lotería simple, rotación, *phase-in* y aleatorización en la burbuja. [Datos](https://www.dropbox.com/s/juo24v3si088e5x/aerdat5.dta?dl=0) y do-file.
- **Mecánica de aleatorización II** -- slides, datos, do-file
