---
layout: page
title: Research
permalink: /research
nav_order: 2
---

## Publications

<div id="research">
  Something.
</div>


<!-- ## Working papers & work in progress

<div id="research">
<ul class="ul-research">
  {% assign research_sorted = site.research | sort:"pubdate" | reverse %}
  {% for item in research_sorted %}{% if item.pubstatus == 'wp' %}
    <li>
      <b><a href="{{ item.url }}">{{ item.title }}</a></b>
      {{ item.journal }}
      {% if item.coauthors %}
        <br/><b>with
        {% assign coauthors = item.coauthors | join: ',' | strip | split: ', ' %}
        {% for author in coauthors %}
          {{ author }}{% if forloop.rindex0 > 1 %},{% elsif forloop.rindex0 == 1 %} and{% endif %}
        {% endfor %}
        </b>
      {% endif %}
      <br/>{{ item.abstract }}
    </li>
    {% endif %}
  {% endfor %}
</ul>
</div> -->