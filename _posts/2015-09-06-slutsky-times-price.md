---
layout: post
title: Slutsky matrix times price vector
---
From microeconomic theory we know that 
$$ S(p, w) \cdot p = 0,$$ 
where $S$ is the Slutsky matrix and $p$ is the price vector.

Why?

It is a general mathematical result that the Hessian matrix of a multivariate function is homogeneous of degree one.

We know that the **expenditure function** $E$  is homogeneous of degree one in prices. Intuitively, if all prices change in the same proportion relative prices stay constant. And if relative prices stay unchanged, the minimum-cost compensated bundle for a given utility level also stays unchanged. That is, budget shares remain constant. So we have that the *expenditure* (expressed by $E$)  needed to achieve the same utility level as before rises equally with prices, and so we have homogeneity of degree one.

By duality, the Hicksian demand vector is the gradient of the expenditure function on prices,
$$H= \frac{d E}{d p}.$$
Intuitively, $H$ gives the minimum-cost demanded quantities. Due to the homogeneity of degree one of the expenditure function, the inner product of the Hicksian demand vector times the price vector equals the expenditure function:
$$H\cdot p=E.$$
This is because we are just multiplying the (minimum-cost) demanded quantities by their unit price and then summing up, which is total expenditure.

Combining these two results we have that 
$$\frac{d (H\cdot p)}{dp}=H \\
H + \frac{d H}{dp}\cdot p = H.$$
So it follows that when $H=0$,
$$\frac{dH}{dp}\cdot p = 0.$$

We know that the Jacobian matrix of the Hicksian demand is the Hessian matrix of the expenditure function, that is, 
$$\frac{dH}{dp}=\frac{d^2E}{dp^2}=S(p,w).$$

So combining these las two results gives us that 
$$S(p, w) \cdot p = 0.$$

This means that compensated demanded quantities are not affected by changes in price if relative prices remain constant.


