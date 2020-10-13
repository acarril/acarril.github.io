---
layout: page
title: Research
permalink: /research
nav_order: 1
---

## Publications

<div id="research">
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


## Working papers & work in progress

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
</div>

<!-- <div id="research">
<ul class="ul-research">
  {% assign research_sorted = site.research | sort:"pubdate" | reverse %}
  {% for item in research_sorted %}{% if item.pubstatus == 'wp' %}
    <li>
      <b><a href="{{ item.url }}">{{ item.title }}</a></b>
      {{ item.journal }}
      {% if item.coauthors %}
        <br/>With
        {% assign coauthors = item.coauthors | join: ',' | strip | split: ', ' %}
        {% assign last = coauthors | last %}
        {% for author in coauthors %}
          {% assign authordata = site.data.coauthors[author] %}
          {% if author != last %}
            {% if authordata.webpage %}
              <a href="{{ authordata.webpage }}">{{ author }}</a>,
            {% else %}
              {{ author | append:',' }}
            {% endif %}
          {% else %}
          {% if coauthors.size > 1 %}
            and
          {% endif %}
            {% if authordata.webpage %}
              <a href="{{ authordata.webpage }}">{{ author }}</a>
            {% else %}
              {{ author }}
            {% endif %}
          {% endif %}
        {% endfor %}
      {% endif %}
    </li>
    {% endif %}{% endfor %}
</ul>
</div> -->




