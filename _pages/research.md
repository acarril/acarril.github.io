---
layout: page
title: Research
permalink: /research
nav_order: 2
---

# Research

### Publications

<div class="research">
  <ul class="ul-research">
    {% for item in site.research %}{% if item.pubstatus == 'published' %}
      <li>
      <b><a href="{{ item.url }}">{{ item.title }}</a></b>
      {% if item.coauthors %}, with {{ item.coauthors }}{% endif %}<br/>
      <b>{{ item.journal }}</b>
      <br/>{{ item.abstract }}
      </li>
    {% endif %}{% endfor %}
  </ul>
</div>

### Work in progress

<div class="research">
  <ul class="ul-research">
    {% for item in site.research %}{% if item.pubstatus != 'published' %}
      <li>
      <b><a href="{{ item.url }}">{{ item.title }}</a></b>
      {% if item.coauthors %}, with {{ item.coauthors }}{% endif %}
      <br/>{{ item.abstract }}
      </li>
    {% endif %}{% endfor %}
  </ul>
</div>