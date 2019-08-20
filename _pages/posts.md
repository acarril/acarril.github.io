---
layout: page
title: Posts
permalink: /posts
nav_order: 3
---

_Things are a bit messy here, some images might be messing from some posts. Please bear with me._

<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
    </li>
  {% endfor %}
</ul>
