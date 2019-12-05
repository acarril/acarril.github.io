---
layout: page
title: Posts
permalink: /posts
nav_order: 3
search_exclude: true
---

<!-- {% for category in site.tags %}
  <h3>{{ category[0] }}</h3>
  <ul>
    {% for post in category[1] %}
      <li><a href="{{ post.url }}">{{ post.title }}</a></li>
    {% endfor %}
  </ul>
{% endfor %} -->

<ul>
  {% assign sorted-posts = site.posts | sort: 'post_date' %}
  {% for post in sorted-posts %}{% if post.draft != true %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
    </li>
  {% endif %}{% endfor %}
</ul>
