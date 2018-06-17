---
layout: page
title:  "Research"
permalink: "/research/"
order: 1
---

### Publications

<ul class="ul-research" style="list-style-position: outside;">
  {% for item in site.research %}
    <li>
      <b><a href="{{ item.url }}">{{ item.title }}</a></b><br/>
      {{ item.journal }}
    </li>
  {% endfor %}
</ul>


### Working papers & work in progress

- "What goes in, must come out? Initial Academic Achievement, College Value Added and Teacher Quality", with [Sebastián Gallegos](https://sites.google.com/site/sebastiangallegos/) and [Christopher Neilson](https://econphilomath.github.io/)
- "Inverse probability weighting for subgroup analysis in RD settings", with Andre Cazor, Maria Paula Gerardino, Stephan Litschig and Dina Pomeranz ([NBER working paper](http://www.nber.org/papers/w23978) that uses our proposed methodology)
- "What’s the Value of the Teacher? Mechanisms and Impacts of Teacher Absenteeism on Student Achievement", with Andreas Aron and [Valentina Paredes](https://sites.google.com/a/fen.uchile.cl/vparedes/home)
