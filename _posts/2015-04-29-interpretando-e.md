---
layout: post
title: Derivando intuitivamente el valor de $e$
---

Cualquier ciencia que estudie el crecimiento de alguna variable debe, en algún momento, encontrarse con $e$. ¿De dónde sale? ¿Por qué tiene ese valor en particular? ¿Para qué sirve? Intentaré responder a estas preguntas de la manera más clara posible.

-----

## Una analogía

Empecemos de un lugar sencillo: el número $1$. Si lo pensamos, todos los números pueden ser considerados como una versión "a escala" del $1$. Por ejemplo, el número 5 es "5 veces 1" o, matemáticamente, $5\cdot 1$. El $0,\overline{3}$ es "un tercio de 1" o $\frac{1}{3}\cdot 1$. Por lo tanto podemos considerar al $1$ como el *número base*.

Extendamos ahora esta analogía al círculo. Gracias a Arquímides sabemos que el área $A$ de una circunferencia es

$$
	A=\pi r^2,
$$

por lo que una circunferencia de radio 1 tiene un área igual a $\pi$. Otras circunferencias también pueden ser consideradas como versiones a escala de ésta *circunferencia base*. Por ejemplo, un círculo de radio 2 tiene un área igual a $4\pi$ y es, por lo tanto, "4 veces $\pi$" o cuatro veces la circunferencia base.

Así como $1$ es la unidad base de los números y $\pi$ es la unidad base de las circunferencias, $e$ es la unidad base que comparten todos los procesos de crecimiento continuo. Es decir, todos los sistemas de crecimiento continuo son versiones escaladas de una tasa común $e$.

## Crecimiento exponencial

Entonces $e$ tiene que ver con crecimiento y, en realidad, aparece en cada situación donde hay crecimiento exponencial y continuo. Incluso en situaciones donde el crecimiento no es continuo, dicho crecimiento puede ser aproximado usando $e$.

### Tiempo discreto

Consideremos primero un sistema simple que se duplica después de una cantidad dada de tiempo. Esto significa que al finalizar un período tendremos 2 veces más, al segundo 4 veces más, al tercero 8 veces más... En forma general, el factor de crecimiento será

$$
	2^t,
$$
donde $t$ son los períodos transcurridos. Este factor de crecimiento simplemente significa que debemos duplicar la cantidad inicial $t$ veces.

Conviene pensar en <<$2$>> como un aumento del $100\%$, es decir,

$$
	(1+100\%)^t.
$$

Esto es lo mismo que la primera ecuación, pero ganamos en valor interpretativo: descompusimos la duplicación (<<2>>) en su valor original (<<1>>) más su *retorno* ($100\%$).

Ahora podríamos pensar en tasas de retorno distintas del $100\%$ y, por tanto, generalizar nuestro factor de crecimiento a:

$$
	(1+\text{retorno})^t.
$$

### Tiempo continuo

El problema con el factor de crecimiento anterior es que asume que no existe crecimiento entre un período y otro. En algunos casos este supuesto es válido y se ajusta mejor a la realidad.

Sin embargo, el dinero claramente no sigue este patrón de crecimiento discreto. Si pensamos en nuestra fórmula de crecimiento como un interés compuesto, entonces estaríamos equivocados asumiendo que durante un año completo la cantidad de dinero no aumenta y luego al cabo de dicho año éste se duplica instantáneamente.

Vamos de a poco. Si comenzamos con un dólar y el retorno es $100\%$ entonces claramente al cabo de un año tendremos $2$ dólares, es decir, habremos ganado $1$ dólar. Sin embargo, a la mitad del año ése dólar inicial ya había generado un retorno del $50\%$, es decir, ya había generado $50$ centavos. Y esos $50$ centavos deberían también haber generado un retorno en el segundo semestre, es decir, generar otros $25$ centavos.

De esta forma, el factor de crecimiento para dos períodos de medio año es

$$
	\left(1+\frac{100\%}{2}\right)^2=2.25.
$$

Notar que este crecimiento compuesto es mayor que el caso anterior. Si descomponemos este crecimiento de $2.25$ tenemos que

- Hay <span class="tex2jax_ignore">$1</span> que corresponde al dólar inicial. Llamémoslo $A$.
- Hay <span class="tex2jax_ignore">$1</span> que corresponde al retorno de $A$. Llamémoslo $B$.
- Hay 25$\cent$ que corresponden al retorno de $B$. Llamémoslo $C$.

-----

¿Por qué detenernos en dos períodos? Claramente podemos considerar tres períodos cuatrimestrales, cada uno con un retorno de $33,\overline{3}\%$. En este caso la fórmula sería

$$
	\left(1+\frac{100\%}{3}\right)^3 \approx 2.37.
$$

¿Cómo ocurrió esto? En el mes 4 $A$ genera un retorno de $33,\overline{3}\%$, es decir, 33 centavos que llamamos $B$. En el mes 8 $A$ genera otros 33 centavos que se agregan a $B$. Sin embargo, antes de esto $B$ a su vez ya había generado un retorno de $33,\overline{3}\%$, es decir, 11 centavos ($33,\overline{3}\% \cdot 33 centavos)$. A estos 11 centavos les llamaremos $C$.

Afírmate, porque aquí se complica. En el mes 12 $A$ vuelve a generar 33c
