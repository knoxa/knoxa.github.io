# Georgian Army Officers

The [Georgian Army Officers database](https://www.georgianarmyofficers.org/) (GAO) makes a slice of history from The National Archive available to researchers and the wider public.
It's part of a wider effort that aims (among other things) to support citizen science, so here goes ...

## An overview

The [National Army Museum](https://www.nam.ac.uk/) are a partner in the GAO project.
They publicised the finished database to museums in their [Regimental Corps and Museum networks](https://www.nam.ac.uk/regimental-and-corps-museum-networks),
including the [Royal Hampshire Regiment Museum](https://www.royalhampshireregiment.org/), where I a volunteer, and the curator asked me to take a look.
I wrote [a brief review](https://tigersmuseum.github.io/history/docs/gao) for the museum's GitHub pages.
That has an overview of the project and how it might be used, and I'll update it with any useful historical information I come up with.

Hereafter, this document describes my experiments with the GAO data.

## Entity Linking

The source data for GAO is [Army Lists](https://en.wikipedia.org/wiki/Army_List).
An officer's service record appears across multiple lists, so collecting records to form a service history is an 'entity linking' problem.
The GAO database uses as statistical method to do this, but I've developed any alternative method that I want to try.
I've described my efforts [here](https://github.com/knoxa/linked-text/tree/master/projects/gao).

### Issues

I've made things easier for myself by limiting the data to just one regiment, but officers may move between regiments, so I can't claim I've created service records.

Some of the records just have a surname, and there are different people with the same surname in the regiment.
These records, as things stand, are genuinely ambiguous.
The GAO database linking method checks that records for an officer look sensible when ordered in time, rank should increase for example.
I'll need to do the same to resolve ambiguities.

Some officers have long careers in the regiment that cover large parts of the 1790-1820 timeframe, so produce lots of records.
Others produce few records.
Where few records appear, it might because the officer's career just clips the 1790-1820 window, or it might be that they join as an Ensign and soon move on promotion to another regiment, or they might come in at one promotion and move out on the next.
There's some information in the `annotations` field that might be used to find these moves between regiments.

## Identification

... To do

## Citizen Science

What can data providers do to help researchers, and what can researchers do to help data providers?

Data and derived results must be 'linkable'.
