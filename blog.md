---
title: Blog
permalink: /blog/
---

<div class="content list">
  {% for post in site.posts %}
    {% if post.categories contains 'blog' %}
    <div class="list-item">
    <p class="list-post-title">
        <a href="{{ site.baseurl }}{{ post.url }}">- {{ post.title }}</a> (<small>{{post.date | date: "%m/%d/%y" }}</small>)
        </p>
    </div>
    {% endif %}
  {% endfor %}
</div>

<div class="home">
  <h1 class="page-heading">Posts</h1>

  <ul class="post-list">
{% capture categories %}{% for category in site.categories %}{{ category | first }}{% unless forloop.last %},{% endunless %}{% endfor %}{% endcapture %}
{% assign category = categories | split:',' | sort: 'last' %}
{% for item in (0..site.categories.size) %}{% unless forloop.last %}
{% capture word %}{{ category[item] | strip_newlines }}{% endcapture %}
<h2 class="category" id="{{ word }}">{{ word | upcase }}</h2>
<ul>
{% for post in site.categories[word] %}{% if post.title != null %}
{% unless post.draft %}
<li><span>{{ post.date | date: "%b %-d, %Y"}}</span> » <a href="{{ site.baseurl}}{{ post.url }}">{{ post.title }}</a></li>
{% endunless %}
{% endif %}{% endfor %}
</ul>
{% endunless %}{% endfor %}
  </ul>

</div>
