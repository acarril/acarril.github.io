---
layout: default
title: Archive
---

# Archive
<hr>
<div>
<section class="archive_list">
  {% for post in site.posts %}
  {% unless post.hidden %}{% unless post.draft %}
  <div class="post_title hang">
    <a class="nodeco" href="{{ post.url | prepend: site.baseurl }}">{{ post.title}}</a>
    <span class="post_date">{{ post.date | date: "%-d %b, %Y" }}</span>
  </div>
  {% endunless %}{% endunless %}
  {% endfor %}
</section>
</div>

