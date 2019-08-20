---
layout: page
title: Posts
permalink: /posts
nav_order: 3
---

** Things are a bit messy here, some images might be messing from some posts. Please bear with me. **

<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url }}">{{ post.title }}</a>
    </li>
  {% endfor %}
</ul>
