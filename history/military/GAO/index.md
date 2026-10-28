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

1. I've made things easier for myself by limiting the data to just one regiment, but officers may move between regiments, so I can't claim I've created service records.

1. Some of the records just have a surname, and there are different people with the same surname in the regiment.
These records, as things stand, are genuinely ambiguous.
I end up with multiple copies of these records in my output.

1. Some officers have long careers in the regiment that cover large parts of the 1790-1820 timeframe, so produce lots of records.
Others produce few records.
Where few records appear, it might because the officer's career just clips the 1790-1820 window, or it might be that they join as an Ensign and soon move on promotion to another regiment, or they might come in at one promotion and move out on the next.
I will need to take moves between regiments into account if I want to build complete service histories.
There's some information in the `annotations` field that might be used to find these moves.

The GAO database linking method checks that records for an officer look sensible when ordered in time; rank should increase for example.
I'll need to do something similar to resolve ambiguities.

I have sets of records that I believe belong to the same officer, but I can't be sure of that.
It's likely that those sets of records don't represent the full service history of the officer.
I need to _identify_ each set with a specific person.

## Ambiguous names

I end up with 3 officers named **Dwyer**:

- **James Dwyer** appears in [65-52-10-006018](https://www.georgianarmyofficers.org/record/65-52-10-006018) (1802).
- **John Dwyer** appears in [65-52-10-006022](https://www.georgianarmyofficers.org/record/65-52-10-006022) (1802) and [65-55-10-005968](https://www.georgianarmyofficers.org/record/65-55-10-005968) (1805).
- **M. B. Dwyer** appears in [65-55-35-000380](https://www.georgianarmyofficers.org/record/65-55-35-000380) (1805).

and there are lots of records for "\_\_\_\_ Dwyer".

As things stand, the records for just "Dwyer" are ambiguous and appear in all 3 sets of records.
I want to try and identify which Dwyer each belongs to, and apportion them accordingly.

I can look at the `reg_rank` and `reg_date` fields.
If both are set, then this is the date the officer attained the rank.
I compare ranks and dates in the ambiguous records with ranks and dates in the unambigous (fully named) records.
There are 3 ranks amongst all the Dwyer records: Ensign, Lieutenant and Captain.
The Ensign date is always 1797-07-06 and the Lieutenant date is always 1797-08-02.
There is no date on the Captaincy.

The Captain is **M. B. Dwyer**. This name and rank only appears on the [65-55-35-000380](https://www.georgianarmyofficers.org/record/65-55-35-000380) record.
This is straightforward enough.
The problem is that the Lieutenant is both **James Dwyer** (65-52-10-006018) and **John Dwyer** (65-55-10-005968).
I can't resolve this with just the GAO data, so I go back to the source and download the 1802 and 1805 Army Lists from TNA.

I notice that in all 3 cases for "John" or "James", the name in the source is actually "\_\_\_\_ Dwyer".
It seems that the transcriber has treated "\_\_\_\_" as a ditto, and assigned the given name that appears in the entry above.
A further confusion is that "\_\_\_\_ Dwyer" appears as both Ensign and Lieutenant in the 1802 list.
However, the Ensign entry has the handwritten annotation "promoted" next to it.

I think there is actually just **M. B. Dwyer**, and that he was only an Ensign for a month before being promoted to Lieutentant.

There are also three Cassidy's: **John Cassidy**, **James Cassidy** and **Kirkwood Cassidy**.
If I apply the same sort of analyis as above, I get three different Lieutenant dates, which suggest there really are three officers.
Furthermore, if I collect records of the same rank and date, I get at most one given name in each set, which supports the case.
However, two of the Lieutenant dates differ by exactly a year, and one of them appears in only one record, and is the only mention of "John".
There is the possibilty of a typo here. The record is in the 1805 list. Tracing it back to source, the entry is actually "\_\_\_\_ Cassidy",
with "John Gelling" above. The "1796" isn't clear, and is plausibly "1795".
I think "John Cassidy" actuall "James Cassidy", so there are only two Cassidy's.
There's some work needed to distribute ambiguous "Cassidy" records among them.

- **To do**: Ambiguous surnames are apparent in the FCA results from entity linking.
I need develop some methodology to select corresponding records and draw the sort of conclusions outlined above.

### Corroboration

I can look for War Office notices in The Gazette.
I've selectively transcribed bits of them, and I'd like to make this data re-usable, so I'm capturing [Gazette transcripts](gazette.xhtml) as XHTML with semanitc mark-up.

- **To do**: Think about how selective transcript data can be made reusable.

## Identification

I can address ambiguity in entity linked sets as described above.
At the end of this process, I can assume that each set of linked records really does represent a person.
The collected information in the set is a form of identity.

The GAO database defines explicit identifiers for officers.
I can assign one of these identifiers to each set, but the problem is that my entity linking results do not necessarily match those in the GAO database.
I might not find a matching GAO identifer, and I might find more than one matching identifier.

DBpedia has [categories for British  Army officers](https://en.wikipedia.org/wiki/Category:British_Army_officers).
These can be used in SPARQL queries to find officers in a particular regiment. For example, this query: 
[67th Regiment of Foot officers](https://dbpedia.org/sparql?default-graph-uri=http%3A%2F%2Fdbpedia.org&qtxt=%20select%20distinct%20%3Fperson%20%3Fname%20%3Fbirth%20%3Fdeath%20%3Fpage%20WHERE%20%7B%0A%20%0A%20%20%20%3Fperson%20dct%3Asubject%20dbc%3A67th_Regiment_of_Foot_officers.%0A%20%20%20%3Fperson%20dbp%3Aname%20%3Fname.%0A%20%20%20%3Fperson%20foaf%3AisPrimaryTopicOf%20%3Fpage.%0A%0A%20%20%20OPTIONAL%20%7B%20%20%20%0A%20%20%20%20%20%3Fperson%20dbp%3AbirthDate%20%3Fbirth.%0A%20%20%20%20%20%3Fperson%20dbp%3AdeathDate%20%3Fdeath.%0A%20%20%20%7D%0A%20%0A%20%20%20FILTER%20(%20LANGMATCHES(LANG(%3Fname)%2C%20%22en%22)%20)%0A%20%7D&format=text%2Fhtml&timeout=30000&signal_void=on&signal_unconnected=on).

[The Gazette](https://www.thegazette.co.uk/)


... To do

## Citizen Science

What can data providers do to help researchers, and what can researchers do to help data providers?

Data and derived results must be 'linkable'.
