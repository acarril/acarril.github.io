---
layout: post
title: Adopting a dog using Python
draft: false
last_modified_date: 2020-12-23
---

For a long time my wife and I wanted to adopt a dog, and during this summer we did so.
However, it was surprisingly hard to accomplish in the US, maybe partly because of the surge in demand due to COVID.
After the approval process is over, you still need to be constantly paying attention to "the right" puppy to show up, and that's where Python comes in.
{: .fs-6 .fw-300 }

![](/assets/images/cali_andI.jpg)

# Welcome to the U.S. of A.

Adopting a dog in the US is not easy.
Most rescues have very lengthy (i.e. costly) "approval" or "matching" phases which are not even guaranteed to end up in a successful adoption.
The crux of the problem is not that the process is costly; if I had to pay this cost once, I'd be OK with it.
But with most rescues the process is "memoryless", meaning that you have to go through it all over again if you are not matched with the two or three pets you applied to.
We tried *many* different rescues around the Princeton area, but the one that took the crown of the *worst* experience was [MatchDog Rescue](https://www.matchdogrescue.org/).
Note that I'm not criticizing the work they do with the animals, but just the way they organize the adoption process.
Every time you want to apply for a dog, you have to fill out a (lengthy) form and pay something like $5.
The form asks for two or three references (e.g. friends), veterinary history, details about your daily routine, etc.
Once you fill out the form, in theory you just have to sit tight and they'll contact you.

Except that there's lots of unwritten rules for adoption that you learn over time.
At first we thought since we didn't have a pet history with a veterinary in the US (both my wife and I are foreigners), then we should just right NA or something.
Wrong! Reddit taught us that these rescues expect you to contact a vet anyway, even if you have never had a pet before.
We learned that references are super important, and that both you and your references have to say stuff like "we immediately fell in love with corny-dog-name-generated-by-algorithm", although to me it sounds utterly stupid to say that given that I didn't *know* any of the dogs.
Apparently it's a contest of who seems more desperate to adopt.
We also learned that it's best to try to list as many dogs as possible in your application.

However, the most important missing bit of information is that you're actually expected to attend a "meet and greet" to have any real chances of being matched to a dog.
Since we were in COVID times (June-July 2020), these were held over Zoom.
In the case of MatchDog Rescue, they announced these meetings one or two days in advance only via Facebook, and they could happen at any day and time of the week, including work hours or weekends.
The meetings themselves had you and other prospective adopters (not necessarily of the same dog(s)) taking turns to talk to two or three volunteers (they called them MatchMakers&#174;).
We quickly found out that there were "tiers" to these meetings, and as you advanced you met with more important MatchMakers&#174;.
After moving up a couple of tiers we made it to the "final" meet and greet with the top MatchMakers&#174;, but we were not done yet: now they told us that they would talk about the prospective adopters among themselves, and "hash it out".
They told us to sit tight and, in case we were selected, we were going to get a call.
After three or four times of getting to that last phase, we never got one.


# Rescues with pre-approval

As I mentioned, the biggest gripe with this system is that it was "memoryless", because we had to go through the form and the interviews all over again each time we were not matched to any of the three or four dogs we applied for.
Once I understood this (idiotic) feature of the market, I sought to find a rescue where the approval was persistent and separate from the matching process.
In my case, I was successful with [Justice Rescue](https://justicerescueadoptions.com/), a PA-based nonprofit which "rescues animals from abuse and neglect".
That sounds cool, but what sounds even cooler is that once they send you an email confirming you are approved to adopt, they tell you to wait for them to post a pet that might be a good fit.
Provided the pet is still available when you email them, you're pretty much guaranteed to get it.
The process to get pre-approved is similar to other rescues: fill out a form, pay a few dollars, your references get a call, etc.

Once we received an email confirming our pre-approval, my wife and I were excited to look (and wait) for a puppy that was a good fit.
We only had two requisites: we wanted a fairly small dog (because we anticipated moving a lot and possibly living in small apartments in the near future), and we wanted a puppy.
Since no dog with those characteristics was listed, we waited.
However, the waiting process quickly became too anxiety-inducing and time consuming for my wife.
She would be constantly refreshing the website, nervously checking if any new dogs were added.
The rescue listed new pets very infrequently (maybe once a week), so she soon ceased to check very often.
But the FOMO on a suitable puppy was too much for her.
I decided to automate the process.

# Enter Python

You know where I'm going now.
I needed to write a script that would scrape the website with the dog listings, create a dataset of the pets and their characteristics, and then compare it to a previous version of the same dataset.
I needed the script to run periodically to perform this comparison, and then send my wife and I an email if it found any new entries.
Below I explain step by step how I achieved these two goals.

## The `pup-notifier` script

First we'll need the `requests` library to get the content of the URL we want to scrape.
Then we need `bs4`'s `BeautifulSoup` function to parse the html in that requested URL, and finally we select the DIV that contains the pets themselves.

```python
#!/usr/local/bin/python3
import requests
import bs4
import pandas as pd
pd.set_option('display.max_colwidth', None)
import smtplib, ssl
import sys
import datetime

###############################################################################
# Part 1: Process current dataset of dogs
###############################################################################

### Get the soup
URL = 'https://ws.petango.com/webservices/adoptablesearch/wsAdoptableAnimals.aspx?species=All&gender=A&agegroup=All&location=&site=&onhold=A&orderby=ID&colnum=3&css=https://ws.petango.com/WebServices/adoptablesearch/css/styles.css&authkey=l58f55ob4wogpb5omhan8ioon7mgqpin47uxdxx1rljbth2hpx&recAmount=&detailsInPopup=No&featuredPet=Include&stageID='
getPage = requests.get(URL)
pageSoup = bs4.BeautifulSoup(getPage.text, 'html.parser')
dogContainers = pageSoup.select('.list-animal-info-block')
```

The next step is just to initialize lists to store the different characteristics of each listing, and then loop through all the listings, populating said lists.
I then created a new `pandas` dataframe to collect the information in these lists, but I'm sure this is not strictly necessary. 

```python
### Collect data
ids = []
names = []
species = []
genders = []
breeds = []
ages = []

for dog in dogContainers:
    # ID
    id = int(dog.find('div', class_ = 'list-animal-id').text)
    ids.append(id)
    # Name
    name = dog.find('div', class_ = 'list-animal-name').text
    names.append(name)
    # Species
    spec = dog.find('div', class_ = 'list-anima-species').text # not a typo
    species.append(spec)
    # Gender
    gender = dog.find('div', class_ = 'list-animal-sexSN').text
    genders.append(gender)
    # Breed
    breed = dog.find('div', class_ = 'list-animal-breed').text
    breeds.append(breed)
    # Age
    age = dog.find('div', class_ = 'list-animal-age').text
    ages.append(age)

### Create dataframe with newly collected data data
dfNew = pd.DataFrame({
    'id': ids,
    'name': names,
    'gender': genders,
    'age': ages,
    'breed': breeds,
    'species': species
})
```

Now we have to check whether there are any new pets, or if pets that were previously listed are now removed (we wanted to keep track of ins and outs).
This part assumes you have already run the script and created a dataset of current pets called `currentPups.csv`.
We also create objects that will be emailed (list of new dogs, URLs, etc).

```python
###############################################################################
# Part 2: Check if there are new and/or gone dogs
###############################################################################

### Read current (now 'old') data
df = pd.read_csv('currentPups.csv')

### Check if there are differences and exit if there aren't
diffs = list(set(dfNew.id) ^ set(df.id))

### Report execution with no updates and exit
if len(diffs) == 0:
    now = datetime.datetime.now()
    date_time = now.strftime('%m/%d/%Y %H:%M:%S')
    sys.stdout.write(date_time + '\n')
    sys.exit()

### Compute sets of added and removed IDs, create corresponding dataframes (email)
added = list(set(dfNew.id) - set(df.id))
gone  = list(set(df.id) - set(dfNew.id))
dfGone = df[df['id'].isin(gone)]
dfAdded  = dfNew[dfNew['id'].isin(added)]
baseURL = 'https://ws.petango.com/webservices/adoptablesearch/wsAdoptableAnimalDetails.aspx?id='
dfAdded['url'] = baseURL + dfAdded['id'].astype(str)
```

The last important part is to send an email if there are any changes.
This is the part I struggled with the most, mostly because I (unsuccessfully) tried to make it more secure.
In the end I opted for writing the sender's password in plain text, given that this script was only going to live in my local machine.

```python
###############################################################################
# Part 3: Send report
###############################################################################

### Specify the sender’s and receivers’ email addresses
sender = "sender@gmail.com"
receiver1 = "receiver1@gmail.com"
receiver2 = "receiver2@gmail.com"

### Email body
if len(added) > 0:
    subject = 'ALERTA DE PERRO(S) NUEVOS!'
else:
    subject = 'Alerta de perro bajado.'


message = f"""\
Subject: {subject}
From: {sender}

Perros nuevos!
{dfAdded.drop(['url'], axis = 1)}
{dfAdded['url']}

Perros que se fueron :(
{dfGone}
"""

### Server parameters
port = 465
login = "sender@gmail.com"
smtp_server = "smtp.gmail.com"
password = "redacted"
context = ssl.create_default_context()

### Send message
with smtplib.SMTP_SSL(smtp_server, port, context=context) as server:
    server.login(login, password)
    server.sendmail(sender, receiver1, message)
    server.sendmail(sender, receiver2, message)
```

The script wraps up by updating the `currentPups.csv` dataset and reporting some output to the terminal, which was useful for debugging the `cron` setup.

```python
###############################################################################
# Part 4: Wrapping up
###############################################################################

### Update current dataset with new entries
fileName = 'currentPups.csv'
dfNew.to_csv(fileName, index = False)

### Report execution with updates
now = datetime.datetime.now()
date_time = now.strftime("%m/%d/%Y %H:%M:%S")
sys.stdout.write(date_time + ' Run with updates!\n')
```

## Running the script periodically with `cron`

Recently I discovered the power of [cron](https://man7.org/linux/man-pages/man8/cron.8.html), a job scheduler that allows you to run scripts or other programs periodically, at fixed times or intervals.
This is exactly what I needed for `pup-notify.py`, where the script itself runs in less than half a second, but I want to execute it every 10 minutes.
One possible solution was to do it via Python, either via `time.sleep` or via the `schedule` library (or others, like `gevent`).
However, these solutions require that the program will be continuously running, which seemed a bit inelegant.
It also doesn't resume automatically if, for any reason, the Python process halts (e.g. if I restart my machine).

Using `cron` is very simple with the aid of `crontab`, which is a utility program to maintain lists of tasks that are run by `cron` itself.
You can add, modify or remove (i.e. edit) tasks by running
```bash
crontab -e
```
This will open up a (probably) empty text file where you can write lines describing different jobs and their schedules.
You then have to 
```bash
*/10 * * * *  cd ~/Repos/pup-notifier && /usr/local/bin/python3 pup-notifier.py >> ~/Repos/pup-notifier/cronOUT.txt 2>> ~/Repos/pup-notifier/cronERR.txt
```

Lets break this expression down.
The first part with five asterisks is a *cron schedule expression*, which is basically a way of writing down the details of a scheduled task.
For example,
```bash
# At 04:05 on Sunday
5 4 * * sun

# At 22:00 on every day-of-week from Monday through Friday
0 22 * * 1-5

# At every 30th minute on every day-of-week from Saturday through Sunday
*/30 * * * 6-7
```
You can play with these expressions in [`crontab guru`](https://crontab.guru/), which breaks down how to build them and interprets any input in natural language (which is what I used for these examples).
For my particular application, I wanted the program to run every ten minutes, so the cron schedule expression is
```bash
*/10 * * * *
```

That's the only tricky part.
The rest of the line is a series of shell commands that run the script, defining a text file (`cronOUT.txt`) that contains the output, and a second one (`cronERR.txt`) to log any errors.
This made it easy to check whether the script was running successfully or not.