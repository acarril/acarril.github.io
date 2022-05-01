---
layout: page
title: Research
permalink: /research
nav_order: 2
---

# Research

## Publications

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

## Work in progress

<div class="research">
  <ul class="ul-research">
    {% for item in site.research %}{% if item.pubstatus != 'published' %}
      <li>
      <b><a href="{{ item.url }}">{{ item.title }}</a></b> ({{ item.pubdate | date: "%b %Y" }})
      <!-- Determine date diff to add a "NEW" button -->
      {% assign pubepoch = item.pubdate | date: "%s" %}
      {% assign nowepoch = "now" | date: "%s" %}
      {% assign difepoch = nowepoch | minus: pubepoch %}
      {% if difepoch < 31536000 %}<span class="label label-default">new!</span>{% endif %}
      {% if item.coauthors %}<br/> with {{ item.coauthors }}{% endif %}
      <br/><b>Abstract:</b> {{ item.abstract }}
      </li>
    {% endif %}{% endfor %}
  </ul>
</div>