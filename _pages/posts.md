---
layout: page
title: Posts
permalink: /posts
nav_order: 3
search_exclude: true
---

_I'm in the process of updating this website so some images might be missing from some posts.
Please bear with me._

<ul>
  {% assign sorted-posts = site.posts | sort: 'post_date' %}
  {% for post in sorted-posts %}{% if post.draft != true %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
    </li>
  {% endif %}{% endfor %}
</ul>
