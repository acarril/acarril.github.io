---
layout: post
comments: true
title:  "Extracting substrings"
categories: stata
permalink: /posts/extracting-substrings
public: false
---

Oftentimes we need to work with part of a string, or substring.

<pre class="sh_stata">
. sysuse bpwide, clear
. local controls sex agegrp
. reg bp_after bp_before `controls'
</pre>
