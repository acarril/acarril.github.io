---
layout: post
title: "Using Google Cloud Storage as a dataset repository"
draft: true
---

![](https://lp.google-mkto.com/rs/248-TPC-286/images/gcpstorage-d-cloud_platform@2x.png)

Both as an RA and in my own research I have to deal with lots of large datasets. In many cases these datasets contain sensitive information, or are the very least can't be publicly distributed. It is also common to re-use datasets across different projects. Many of these constraints can be met by storing your datasets in a server, but there is a great variety of server-side solutions.

<!--more-->

If you're lucky enough, you'll be working some projects in a server. For instance, I work using the [Research Computing Environment](https://projects.iq.harvard.edu/hmdc/book/research-computing-environment) from the Harvard-MIT Data Center, [ScienceCloud](https://www.s3it.uzh.ch/en/scienceit/infrastructure/sciencecloud.html) (University of Zurich) and several services provided by [Microsoft Azure Cloud Computing platform](https://azure.microsoft.com/en-us/). Obviously these services provide many advantages beyond data storing, but I'm focusing solely on that aspect.

On the other hand, there are many projects which are smaller (or have less budget) and are just handled locally. These kind of projects tend to be shared through [Dropbox](https://www.dropbox.com/), [Box](https://www.box.com/home) or some other service with "box" attached to its name. The following conversation ensues (just replace "cousin" with "colleague"):

![](https://imgs.xkcd.com/comics/file_transfer.png)

Even if you have a `.*box` service, 


# Google Cloud Storage

[Google Cloud Storage](https://cloud.google.com/storage/) is an online file storage web service for storing and accessing data on Google's infrastructure. It is meant for larger applications, but its pricing scales really nicely, so we can take advantage of its power and pay very little ---or up to a year, nothing--- for using it.

## Create a bucket

A **bucket** is a logical unit of storage in the Google Cloud Storage service, which are used to store objects, which are ([mostly](https://cloudian.com/blog/object-storage-vs-file-storage/)) equivalent to files. We can think of a bucket as a cloud drive which we can use to store and access datasets organized into a hierarchy.

1. Go to [https://cloud.google.com/]() and click on the "TRY IT FREE" button and create a Google Cloud account. You'll need to provide a credit card, but you won't be charged. In fact, they give you USD 300 in credit for the first year, which is pretty sweet.
2. Once subscribed, you'll need to [go to the Console](https://console.cloud.google.com/home/) and create a project. Project names don't need to be unique, so I named mine `datasets`.
3. Now access the menu by clicking on the <i class="fa fa-bars" aria-hidden="true"></i> button and go to the **Storage section**.
4. **Create a new bucket**, which has to have a unique name. For storage class you have several options, but I recommend selecting Regional Storage, or Nearline Storage if you plan to access your data less than once a month. [This page](https://cloud.google.com/storage/docs/storage-classes?hl=es_419&_ga=1.63529641.70402880.1495734767) has more information on storage classes. Regional location is not critical for our basic application, but bear in mind that the data will be stored in those jurisdictions.

Now your bucket is ready! You'll be taken to the bucket's Browser window, from where you can interactively manage its content. While you can upload files and do other changes from this window, we will first install a command-line utility to help us tweak the bucket.


## Google Cloud Shell and `gsutil`

Now that our bucket is set up, we may need to make some adjustments to its **access permissions**: who will be able to write into the bucket (ie. create, modify or delete datasets) and who will be able to read into the bucket (ie. access the datasets without making any changes).

For this purpose we need `gsutil`, a Python application that lets us access Cloud Storage from the command line. We can use `gsutil` to do a wide range of bucket and object management tasks, including:

- Creating and deleting buckets
- Uploading, downloading, and deleting objects
- Listing buckets and objects
- Moving, copying, and renaming objects
- **Editing object and bucket permissions.**

To start using `gsutil` there are two options. For some light usage, just fire up the Google Cloud Shell by clicking on the terminal icon (<i class="fa fa-terminal" aria-hidden="true"></i>) in the top right corner of your bucket console. You can also download and install the [Google Cloud SDK](https://cloud.google.com/sdk/docs/) directly to your machine, and then use `gsutil` commands from the terminal.

## Managing bucket access

Now that our bucket is set up, we may need to make some adjustments to its access permissions. These adjustments depend on the kind of usage you will give to your bucket. I've grouped these into two:

1. **Private repository**, managing granular access by specific people
2. **Public repository**, with public *read* permissions

There are various ways to achieve these two configurations, and also many more variations are possible. I believe these two cover a good deal of use cases, but be sure to check [Access Control Options](https://cloud.google.com/storage/docs/access-control/) learn more details.

### Private repository

In this scenario we want to use our bucket to back up datasets that should be available to us and some collaborators of our choosing. 



