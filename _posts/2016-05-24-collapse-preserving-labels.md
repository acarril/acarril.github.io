---
layout: post
title:  "Preserve labels when collapsing"
categories: stata
published: true
---

When collapsing a dataset with the [`collapse`](http://www.stata.com/help.cgi?collapse) command, all variable [labels](http://www.stata.com/help.cgi?label) are replaced by <code>(<i>stat</i>) <i>varname</i></code>. This short post describes how to preserve variable labels and restore them after collapsing.

First we **save all variable labels in locals**. I create locals for variables which don't have label in order to avoid pasting empty labels later on.

```stata
foreach v of var * {
  local l`v' : variable label `v'
	if `"`l`v''"' == "" {
		local l`v' "`v'"
	}
}
```

After collapsing the data, we need to **restore variable labels** using

```
foreach v of var * {
	label var `v' "`l`v''"
}
```
