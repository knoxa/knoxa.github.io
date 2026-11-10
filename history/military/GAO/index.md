# Georgian Army Officers

The [Georgian Army Officers database](https://www.georgianarmyofficers.org/) (GAO) makes a slice of history from The National Archive available to researchers and the wider public.
It's part of a wider effort that aims (among other things) to support citizen science, so here goes ...

## An overview

The [National Army Museum](https://www.nam.ac.uk/) are a partner in the GAO project.
They publicised the finished database to museums in their [Regimental Corps and Museum networks](https://www.nam.ac.uk/regimental-and-corps-museum-networks),
including the [Royal Hampshire Regiment Museum](https://www.royalhampshireregiment.org/), where I a volunteer, and the curator asked me to take a look.
I wrote [a brief review](https://tigersmuseum.github.io/history/docs/gao) for the museum's GitHub pages.
That has an overview of the project and how it might be used, and I'll update it with any useful historical information I come up with.

I want to identify individual officers, collect their entries across army lists that mention them, and build a _service record_ for each.

## Entity Linking

The source data for GAO is [Army Lists](https://en.wikipedia.org/wiki/Army_List).
An officer's service record appears across multiple lists, so collecting records to form a service history is an 'entity linking' problem.
The GAO database uses as statistical method to do this, but I've developed any alternative method that I want to try.
I've described my efforts [here](https://github.com/knoxa/linked-text/tree/master/projects/gao).

### Issues

1. I've made things easier for myself by selecting data for a single regiment (67th Foot), but officers may move between regiments, so I can't claim I've created complete service records.

1. Some of the GAO records just have a surname and there are different people with the same surname in the regiment.
These records, as things stand, are genuinely ambiguous.
I end up with multiple copies of these records in my output.

1. Some officers have long careers in the regiment that cover large parts of the 1790-1820 timeframe, so produce lots of records.
Others produce few records.
Where few records appear, it might because the officer's career just clips the 1790-1820 window, or it might be that they join as an Ensign and soon move on promotion to another regiment, or they might come in at one promotion and move out on the next.
I will need to take moves between regiments into account if I want to build complete service histories.
Sometimes there's information in the `annotations` field that can help find these moves.

The GAO database linking method checks that records for an officer look sensible when ordered in time; rank should increase for example.
I'll need to do something similar to resolve ambiguities.

I have sets of records that I believe belong to the same officer, but I can't be sure of that.
It's likely that those sets of records don't represent the full service history of the officer.

### Corroboration

I can look for War Office notices in The Gazette.
I've selectively transcribed bits of them, and I'd like to make this data re-usable, so I'm capturing [Gazette transcripts](gazette.xhtml) as XHTML with semanitc mark-up.

One problem with searching the Gazette is that it's text index relies on OCR which is not always reliable.
The name you're searching for might appear in an issue of the Gazette but not be identified by the system.

- **To do**: Think about how selective transcript data can be made reusable.

## Identification

I need to _identify_ each set with a specific person.

I can address ambiguity in entity linked sets as described above, and I can check the sequence of records makes sense as all or part of a service history. 
At the end of this process, I can assume that each set of linked records really does represent a person.
The collected information in the set is a form of identity.
I may be able to condense the information in the set to produce an equivalent set of attributes that represent an individual: names and a list of promotions and appointments.
I can do this with Soldiers XML.



## Identifiers

The GAO database defines explicit identifiers for officers.
I can assign one of these identifiers to each set, but the problem is that my entity linking results do not necessarily match those in the GAO database.
I might not find a matching GAO identifer, and I might find more than one matching identifier.

DBpedia has [categories for British  Army officers](https://en.wikipedia.org/wiki/Category:British_Army_officers).
These can be used in SPARQL queries to find officers in a particular regiment. For example, this query: 
[67th Regiment of Foot officers](https://dbpedia.org/sparql?default-graph-uri=http%3A%2F%2Fdbpedia.org&qtxt=%20select%20distinct%20%3Fperson%20%3Fname%20%3Fbirth%20%3Fdeath%20%3Fpage%20WHERE%20%7B%0A%20%0A%20%20%20%3Fperson%20dct%3Asubject%20dbc%3A67th_Regiment_of_Foot_officers.%0A%20%20%20%3Fperson%20dbp%3Aname%20%3Fname.%0A%20%20%20%3Fperson%20foaf%3AisPrimaryTopicOf%20%3Fpage.%0A%0A%20%20%20OPTIONAL%20%7B%20%20%20%0A%20%20%20%20%20%3Fperson%20dbp%3AbirthDate%20%3Fbirth.%0A%20%20%20%20%20%3Fperson%20dbp%3AdeathDate%20%3Fdeath.%0A%20%20%20%7D%0A%20%0A%20%20%20FILTER%20(%20LANGMATCHES(LANG(%3Fname)%2C%20%22en%22)%20)%0A%20%7D&format=text%2Fhtml&timeout=30000&signal_void=on&signal_unconnected=on).

[The Gazette](https://www.thegazette.co.uk/)

## Dialogue

Different entity linking methods will have different strengths and weakness.
My method divides names into sets of tokens, then works on the similarity between those sets.
The GAO method compares names with an 'edit distance' similarity metric that will catch cases that I might miss.
For example, GAO matches "R B Harrison" and "R B H arrision", but I don't make this match because I get 3 tokens in one case and 4 in the other, and they only overlap with the "R" and "B".

I see my entity linking method as making claims that need [checking](checking.md).
Each claim is a set of GAO records that are asserted as belonging to the same officer.
I can construct a 'GAO claim' by selecting records from the row data that have the same value in the `person` field, but it seems that some of GAO work on entity linking postdates the dataset.
There is a download option from a person record in the web application that would give the latest results, but download format is PDF.
The information is there, but needs parsing. The option for a (more) machine readable format would be nice.


## Feedback

How t oreturn results?


## identity



## Stories

[The Marquis of Huntly](https://en.wikisource.org/wiki/Dictionary_of_National_Biography,_1885-1900/Gordon,_George_(1770-1836))


## References

1. Atkinson, C. T. (1950). _The Royal Hampshire Regiment: Regimental History_ (Vol. 1). Regiment.

- **To do**: Ambiguous surnames are apparent in the FCA results from entity linking, for example [Dwyer](dwyer.md) and [Cassidy](cassidy.md).
I need develop some methodology to select corresponding records and draw the sort of conclusions outlined above.
