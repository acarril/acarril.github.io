---
layout: page
title: Research
permalink: /research
nav_order: 2
---

# Research

{% assign sorted = site.research | reverse %}

## Publications

<div class="research">
  <ul class="ul-research">
    {% for item in sorted %}{% if item.pubstatus == 'published' %}
      <li>
        <!-- Item title and update date -->
        <h3><a href="{{ item.url }}">{{ item.title }}</a><span style="color:grey"> &#124; {{ item.date | date: "%b %Y" }}</span>
        <!-- Determine date diff to add a "NEW" button -->
        {% assign pubepoch = item.date | date: "%s" %}
        {% assign nowepoch = "now" | date: "%s" %}
        {% assign difepoch = nowepoch | minus: pubepoch %}
        {% if difepoch < 31536000 %}<span class="label label-default">new</span>{% endif %}
        <!-- Determine if there are coauthors and list them -->
        {% if item.coauthors %}<br/> with <b>{{ item.coauthors }}</b>{% endif %}</h3>
        <b>{{ item.journal }}</b>
        <p><div class="outer"><div class="inner">{{ item.abstract }}</div></div></p>
      </li>
    {% endif %}{% endfor %}
  </ul>
</div>

## Work in progress

<div class="research">
  <ul class="ul-research">
    {% for item in sorted %}{% if item.pubstatus != 'published' %}
      <li>
        <!-- Item title and update date -->
        <h3><a href="{{ item.url }}">{{ item.title }}</a><span style="color:gray"> &#124; {{ item.date | date: "%b %Y" }}</span>
        <!-- Determine date diff to add a "NEW" button -->
        {% assign pubepoch = item.date | date: "%s" %}
        {% assign nowepoch = "now" | date: "%s" %}
        {% assign difepoch = nowepoch | minus: pubepoch %}
        {% if difepoch < 31536000 %}<span class="label label-default">new</span>{% endif %}
        <!-- Determine if there are coauthors and list them -->
        {% if item.coauthors %}<br/> with <b>{{ item.coauthors }}</b>{% endif %}</h3>
        <p><div class="outer"><div class="inner">{{ item.abstract }}</div></div></p>
      </li>
    {% endif %}{% endfor %}
  </ul>
</div>