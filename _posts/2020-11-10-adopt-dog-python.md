---
layout: post
title: Adopting a dog using Python
---

For a long time my wife and I wanted to adopt a dog, and during this summer we did so.
However, it was surprisingly hard to do so in the US, partly because of the surge in demand due to COVID.
After the approval process is over, you still need to be constantly paying attention to "the right" puppy to show up, and that's where Python comes in.
{: .fs-6 .fw-300 }

# Welcome to the U.S. of A. baby

Adopting a dog in the US is not easy.
Most rescues have very lengthy (i.e. costly) "approval" or "matching" phases which are not even guaranteed to end in a successful adoption.
The crux of the problem is not that the process is costly; if I had to pay this cost once, I'd be OK with it.
But with most rescues the process is "memoryless", meaning that you have to go through it all over again if you are not matched with the two or three pets you applied to.
We tried *many* different rescues around the Princeton area, but the one that took the crown of the *worst* experience was [MatchDog Rescue](https://www.matchdogrescue.org/).
Note that I'm not criticizing the work they do with the animals, but just the way they organize the adoption process.
Every time you want to apply for a dog, you have to fill out a (lengthy) form and pay something like $5.
The form asks for two or three references (e.g. friends), veterinary history, details about your daily routine, etc.
Once you fill out the form, in theory you just have to sit tight and they'll contact you.

Except that there's lots of unwritten rules for adoption that you learn over time.
At first we thought since we didn't have a pet history with a veterinary in the US (both my wife and I are foreigners), then we should just right NA or something.
Wrong! Reddit taught me that these guys expect you to contact a vet anyway, even though it is not easy to explain to a vet that you want them to answer a call on your behalf even when you don't have a dog to bring to them yet.
We learned that references are super important, and that both you and your references have to say stuff like "we immediately fell in love with corny-dog-name-generated-by-algorithm", although to me it sounds utterly stupid to say that given that I didn't *know* any of the dogs.
Apparently it's a contest of who seems more desperate to adopt.
We also learned that it's best to try to list as many dogs as possible in your application.

However, the most important missing bit of information is that you're actually expected to attend a "meet and greet" to have any real chances of being matched to a dog.
Since we were in COVID times (June-July 2020), these were held over Zoom.
In the case of MatchDog Rescue, they announced these meetings one or two days in advance only via Facebook, and they could happen at any day and time of the week.
The meetings themselves had you and other prospective adopters (not necessarily of the same dog(s)) taking turns to talk to two or three volunteers (they called them MatchMakers&#174;).
We quickly found out that there were "tiers" to these meetings, and as you advanced you met with more important MatchMakers&#174;.
After moving up a couple of tiers we made it to the "final" meet and greet with the top MatchMakers&#174;, but we were not done yet: now they told us that they would talk about the prospective adopters among themselves, and "hash it out".
They told us to sit tight and, in case we were selected, we were going to get a call.
After three or four times of getting to that last phase, we never got one.


# Rescues with pre-approval

The biggest issue with this system is that it was "memoryless", because we had to go through the form and the interviews all over again each time we were not matched to any of the three or four dogs we applied for.
Once I understood this (idiotic) feature of the market, I sought to find a rescue where the approval was persistent.
In my case, I was successful with [Justice Rescue](https://justicerescueadoptions.com/), a PA-based nonprofit which "rescues animals from abuse and neglect".
That sounds cool, but what sounds even cooler is that once they send you an email confirming you are approved to adopt, they tell you to wait for them to post a pet that might be a good fit.
Provided the pet is still available when you email them, you're pretty much guaranteed to get it.
The process to get pre-approved is similar to other rescues: fill out a form, pay a few dollars, your references get a call, etc.

Once we received an email confirming our pre-approval, my wife and I were excited to look (and wait) for a puppy that was a good fit.
We only had two requisites: we wanted a fairly small dog (because we anticipated moving a lot and possibly living in small apartments in the near future), and we wanted a puppy.
Since no dog with those characteristics was listed, we waited.
However, the waiting process quickly became too anxiety-inducing and time consuming for my wife.
She would be constantly refreshing the website, nervously checking if any new dogs were added.
This happened very infrequently (maybe once a week), so she soon ceased to check very often.
But the FOMO on a suitable puppy was getting to us.

I decided to automate the process.

# Enter Python

You know where I'm going now.
I needed to write a script that would scrape the website with the dog listings, create a dataset of the pets and their characteristics, and then compare it to a previous version of the same dataset.
I needed the script to run periodically to perform this comparison, and then send my wife and I an email if it found any new entries.



