---
usemathjax: true
permalink: /blp
layout: page
---
# Random Coefficients BLP

This is my take on replicating Berry, Levinsohn and Pakes (1995), focusing on the empirical implementation in Julia more than on the derivation of key results.

## Data

The `cars` data 

### GMM review

The GMM estimate is given by

$$
g_n(\beta) = \frac{1}{n} \sum_{i=1}^n z_i(y_i - x'_i\beta)
$$

Let $$Q(\beta) = g_n(\beta)' \mathbf{W} g_n(\beta)$$.
Then the estimated $\beta$ is given by
$$
\hat\beta = \arg \min Q(\beta).
$$

...

Expanding the objective function $Q(\beta)$, we can write it as
$$
Q(\beta) = y' Z W Z' y - \beta' X' Z W Z' y - y'Z W Z' X \beta + \beta' X' Z W Z' X \beta
$$
By equating the derivate of this function to zero, we have that
$$
\begin{aligned}
\frac{\partial Q(\beta)}{\partial \beta} &= 0 \\
2 X' Z W' Z' X \hat\beta - 2 X' Z W Z' y &= 0 \\
\implies \hat\beta &= (X' Z W' Z' X)^{-1} X' Z W Z' y.
\end{aligned}
$$

The choice of $W$, the weighting matrix, is key.
In general, the weighting matrix of the GMM estimator is $(\Phi(M))^{-1}$.
Under homoscedasticity (i.e. assuming independently distributed disturbances), the GMM estimator and the 2SLS estimators are equivalent, and the weighting matrix is $(Z'Z)^{-1}$.


```julia
# https://mark-ponder.com/tutorials/static-discrete-choice-models/random-coefficients-blp/
using CSV, DataFrames, DataFramesMeta
using GLM

cd("/Users/alvaro/Repos/BLP")
cars = DataFrame(CSV.File("blp_1995_data.csv"))
```




<table class="data-frame"><thead><tr><th></th><th>prodvec</th><th>modelvec</th><th>newmodv</th><th>model_year</th><th>id</th><th>firmid</th><th>market</th><th>hpwt</th><th>space</th></tr><tr><th></th><th>String</th><th>String</th><th>String</th><th>Int64</th><th>Int64</th><th>Int64</th><th>Int64</th><th>Float64</th><th>Float64</th></tr></thead><tbody><p>2,217 rows × 20 columns (omitted printing of 11 columns)</p><tr><th>1</th><td>AMGREM</td><td>AMGREM</td><td>AMGREM71</td><td>71</td><td>129</td><td>15</td><td>1</td><td>0.528997</td><td>1.1502</td></tr><tr><th>2</th><td>AMHORN</td><td>AMHORN</td><td>AMHORN71</td><td>71</td><td>130</td><td>15</td><td>1</td><td>0.494324</td><td>1.278</td></tr><tr><th>3</th><td>AMJAVL</td><td>AMJAVL</td><td>AMJAVL71</td><td>71</td><td>132</td><td>15</td><td>1</td><td>0.467613</td><td>1.4592</td></tr><tr><th>4</th><td>AMMATA</td><td>AMMATA</td><td>AMMATA71</td><td>71</td><td>134</td><td>15</td><td>1</td><td>0.42654</td><td>1.6068</td></tr><tr><th>5</th><td>AMAMBS</td><td>AMAMBS</td><td>AMAMBS71</td><td>71</td><td>136</td><td>15</td><td>1</td><td>0.452489</td><td>1.6458</td></tr><tr><th>6</th><td>BKSKYL</td><td>BKSKYL</td><td>BKSKYL71</td><td>71</td><td>138</td><td>19</td><td>1</td><td>0.450871</td><td>1.6224</td></tr><tr><th>7</th><td>BKLSAB</td><td>BKLSAB</td><td>BKLSAB71</td><td>71</td><td>141</td><td>19</td><td>1</td><td>0.564002</td><td>1.768</td></tr><tr><th>8</th><td>BKCNTU</td><td>BKCNTU</td><td>BKCNTU71</td><td>71</td><td>143</td><td>19</td><td>1</td><td>0.731368</td><td>1.768</td></tr><tr><th>9</th><td>BKELCT</td><td>BKELCT</td><td>BKELCT71</td><td>71</td><td>144</td><td>19</td><td>1</td><td>0.719014</td><td>1.816</td></tr><tr><th>10</th><td>BKRIVE</td><td>BKRIVE</td><td>BKRIVE71</td><td>71</td><td>145</td><td>19</td><td>1</td><td>0.728324</td><td>1.744</td></tr><tr><th>11</th><td>CDCALA</td><td>CDCALA</td><td>CDCALA71</td><td>71</td><td>146</td><td>19</td><td>1</td><td>0.732484</td><td>1.808</td></tr><tr><th>12</th><td>CDDEVI</td><td>CDDEVI</td><td>CDDEVI71</td><td>71</td><td>147</td><td>19</td><td>1</td><td>0.729387</td><td>1.808</td></tr><tr><th>13</th><td>CDELDR</td><td>CDELDR</td><td>CDELDR71</td><td>71</td><td>148</td><td>19</td><td>1</td><td>0.780749</td><td>1.776</td></tr><tr><th>14</th><td>CDFLTW</td><td>CDFLTW</td><td>CDFLTW71</td><td>71</td><td>149</td><td>19</td><td>1</td><td>0.716511</td><td>1.832</td></tr><tr><th>15</th><td>CVVEGA</td><td>CVVEGA</td><td>CVVEGA71</td><td>71</td><td>150</td><td>19</td><td>1</td><td>0.419385</td><td>1.122</td></tr><tr><th>16</th><td>CVNOVA</td><td>CVNOVA</td><td>CVNOVA71</td><td>71</td><td>151</td><td>19</td><td>1</td><td>0.487231</td><td>1.387</td></tr><tr><th>17</th><td>CVCHEV</td><td>CVCHEV</td><td>CVCHEV71</td><td>71</td><td>153</td><td>19</td><td>1</td><td>0.451713</td><td>1.5352</td></tr><tr><th>18</th><td>CVCAMA</td><td>CVCAMA</td><td>CVCAMA71</td><td>71</td><td>158</td><td>19</td><td>1</td><td>0.468649</td><td>1.41</td></tr><tr><th>19</th><td>CVMNTC</td><td>CVMNTC</td><td>CVMNTC71</td><td>71</td><td>160</td><td>19</td><td>1</td><td>0.702408</td><td>1.5732</td></tr><tr><th>20</th><td>CVBISC</td><td>CVBISC</td><td>CVBISC71</td><td>71</td><td>161</td><td>19</td><td>1</td><td>0.388532</td><td>1.736</td></tr><tr><th>21</th><td>CVBELA</td><td>CVBELA</td><td>CVBELA71</td><td>71</td><td>163</td><td>19</td><td>1</td><td>0.388532</td><td>1.736</td></tr><tr><th>22</th><td>CVIMPA</td><td>CVIMPA</td><td>CVIMPA71</td><td>71</td><td>165</td><td>19</td><td>1</td><td>0.385638</td><td>1.736</td></tr><tr><th>23</th><td>CVCAPR</td><td>CVCAPR</td><td>CVCAPR71</td><td>71</td><td>167</td><td>19</td><td>1</td><td>0.631188</td><td>1.736</td></tr><tr><th>24</th><td>CVCORV</td><td>CVCORV</td><td>CVCORV71</td><td>71</td><td>169</td><td>19</td><td>1</td><td>0.843223</td><td>1.2627</td></tr><tr><th>25</th><td>CRNEWP</td><td>CRNEWP</td><td>CRNEWP71</td><td>71</td><td>170</td><td>16</td><td>1</td><td>0.659314</td><td>1.8</td></tr><tr><th>26</th><td>CR300</td><td>CR300</td><td>CR30071</td><td>71</td><td>171</td><td>16</td><td>1</td><td>0.775283</td><td>1.8</td></tr><tr><th>27</th><td>CRNEWY</td><td>CRNEWY</td><td>CRNEWY71</td><td>71</td><td>172</td><td>16</td><td>1</td><td>0.77278</td><td>1.8</td></tr><tr><th>28</th><td>DGCOLT</td><td>DGCOLT</td><td>DGCOLT71</td><td>71</td><td>173</td><td>16</td><td>1</td><td>0.49505</td><td>1.0168</td></tr><tr><th>29</th><td>DGDART</td><td>DGDART</td><td>DGDART71</td><td>71</td><td>177</td><td>16</td><td>1</td><td>0.431034</td><td>1.379</td></tr><tr><th>30</th><td>DGCHLN</td><td>DGCHLN</td><td>DGCHLN71</td><td>71</td><td>179</td><td>16</td><td>1</td><td>0.413907</td><td>1.4784</td></tr><tr><th>&vellip;</th><td>&vellip;</td><td>&vellip;</td><td>&vellip;</td><td>&vellip;</td><td>&vellip;</td><td>&vellip;</td><td>&vellip;</td><td>&vellip;</td><td>&vellip;</td></tr></tbody></table>


