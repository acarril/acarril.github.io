---
layout: page
title:  "Research"
permalink: "/research/"
order: 1
---

## Publications

<div id="research">
<ul class="ul-research">
  {% for item in site.research %}{% if item.pubstatus == 'published' %}
    <li>
    <b><a href="{{ item.url }}">{{ item.title }}</a></b>
    {% if item.coauthors %}, with {{ item.coauthors }}{% endif %}<br/>
    {{ item.journal }}
    </li>
  {% endif %}{% endfor %}
</ul>
</div>


## Working papers & work in progress

<div id="research">
<ul class="ul-research">
  {% assign research_sorted = site.research | sort:"pubdate" | reverse %}
  {% for item in research_sorted %}{% if item.pubstatus != 'published' %}
    <li>
      <b><a href="{{ item.url }}">{{ item.title }}</a></b>
      {% if item.coauthors %}, with {{ item.coauthors }}{% endif %}<br/>
      {{ item.journal }}
    </li>
  {% endif %}{% endfor %}
</ul>
</div>
