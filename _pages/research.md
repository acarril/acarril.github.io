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
          and
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
</div>
