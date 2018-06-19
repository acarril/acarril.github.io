import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

#%%
df = pd.read_csv('https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv', delimiter=';')

df


df.columns = [x.strip().replace(' ', '_') for x in df.columns]

sns.countplot(x='quality', data=df)
plt.show()
