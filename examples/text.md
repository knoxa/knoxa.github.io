# Locating places

## Introduction

I need to identify the spans of text in a document that mention places.
I can do this manually, or I can do it through some NLP process.
Either way, I choose to capture the results by marking-up mentions of place with HTML `<span>` elements.
I can set a class element and use a CSS stylesheet to make my choices obvious.

A *mention* is a string of text at a specific position in a document. Its position gives it *context*.
The string describes a place, so is a *label* for that place.
The meaning of a label depends on its context.
A general label, such as "the road", can only be interpreted as a location on a map if its context is taken into account.
Other labels, such as proper names, may be locatable irrespective of context.

I can decide that two different mentions or labels refer to the same place.
This makes a place an abstract entity that is referred to by mentions and labels.
In other words, a mention or a label is not a place, it is a reference to a place.
Once I have a *place*, rather than a just a mention of a place or a label, it has an *identity*.
Identities are unique. If I can faithfully map a place to its identity, its trivial to link it to any
other information about the same identity, in particular its geospatial *location*.

## Assumptions and uncertainty

This all sounds good, but there are various practical issues.
I'll detail these in the context of a worked example below, but is worth noting some general points here.

There are judgements to be made about what constitutes the mention of a place.
These judgements might legitimately be different in different circumstances.
They depend on what you want to do with the locations you extract.
They will also depend on the skills of a human agent, or the capabilities of a machine agent, 
that finds mentions in the first place.

Data management takes a lot of effort to do well.
A hobbyist, like myself, doesn't have access to a geospatial database and other enterprise tools that would help, or the time and effort (and inclination) to learn how to use them if I did.
Instead, I'll take a short-cut and treat a place's proper name name as its identity.
This wrong in general terms because place names aren't unique, but it usually works in the context of a single document.
Rather than claim that a place is identified by its name, I say that I *assume* a place is identified by its name.
This is a subtle but important distinction. It says I need to be sure that the assumption isn't invalid when I make claims about the location of a place.

Its easier, from the data management point-of-view, to deal with labels rather than mentions when collecting co-references to the same place.
Simplifying a set of mentions to a set of labels risks losing contextual information that might change the determination of the associated place.
Mistakes are always possible in any case, and I'll assume that operating on labels instead of mentions isn't going to add signficantly to the risk of misidentifying a place.
What will happen is that some places won't be identifiable from considering labels that might be identifiable through considering mentions.
I'll assume that these lapses aren't important.

Any "facts" I extract are not, in actual fact, facts, but are claims based on a set of assumptions.
These assumptions will usually be correct but wont't always correct.
You should be able to test a claim by challenging the assumptions, and I should be able to justify the assumptions to defend it. 

## 11th Infantry Brigade movements in World War 1

I want to extract locations from [11<sup>th</sup> Infantry Brigade war diaries](https://knoxa.github.io/war-diary/11-Bde/).
But, what does this mean precisely?. 
If the place is a region, do I want a polygon of the region or a point in the centre of the region?
If the place is described as some distance in some direction from some other place, do I want to calculate a coordintate, or will just the location of the referent place do?
What level of granularity do I want? If the mention is of a neighbourhood within a city, do I want to pin down the neighbourhood, or am I happy with just the city?
I don't know the answers to these questions before I start, and I'll make different choices in different circumstances.
I'll start by presuming the answer to questions like this are "it doesn't matter" and be prepared to "go round the loop" as my requirements change.

My starting point is the [August 1914 war diary](https://knoxa.github.io/war-diary/11-Bde/1914/1914-08-diary.xhtml).
The CSS stylesheet for this shows HTML spans with @class="place" in green.

### Markup

I've made judgments as to what to mark up and how. For example, there are choices to be made about text:

    positions respectively S.W. and S.E. of SOLESMES
	
Is this one place or two? 
Different people will make different judgements, so the answer to a question like this is usually "both".
I've dodged the issue in this particular instances by deciding that its one place, and that I can get what I want (for the time being at least)
by just marking up `SOLESMES`.

I want to geolocate the places covered by span elements.
I collect the set of string that are the span elements.

I'll call the string that are mentions of an entity after the entity, so the string are places.
I want to gelocate the mentions, but what I actually do is geolocate the strings, and assume that the location related to a string is the location of the mention.


```
<span class="place">the high ground S of <span class="place">ST SAUVEUR</span></span>
```

This puts a mention of `ST SAUVEUR` in the context of the mention `the high ground S of ST SAUVEUR`.

Ignoring this structure, I get two strings, and dictionary matching identifies both of them as location `Saint-Sauveur`.
If I don't want to use dictionary matching, I could use this stucture to explicitly map `the high ground S of ST SAUVEUR` to `ST SAUVEUR`,
which than maps to the location `Saint-Sauveur`. Choices choices.

In practical terms the problem comes down to matching the place to a a geometry in a reference geospatial dataset.
I will use KML files as my source of geospatial data. I'll takl about creating and manipulating these elsewhere.

A geospatial object in my reference data is a PlaceMark. I will assume that the PlaceMark name is the identity.
I treat this name as a preferred name, and construct a map of alternate names to preferred name to handle alternative spellings and variations.
It will be the case that two different locations sometimes have the same name.
I allow for this by making the map return a set of names for each place.
If the place names are unique the values will always be a set containing only one name. Ambiguity is obvious if the map returns more than one name. 

I then compare each place string from the input document with the keys of this map.
If the
If I already have geolocated `HAVRE` I might be have to have `Rest Camp at HAVRE` at the same location.
I can make this association explicit in my map of places to located places. 
Alternatively, I can be lazy and use the map to make a dictionary of locations, link place strings
to dictionary entries they contain, and then use the dictionary hit to index the location.
I'll take the lazy option but use the results to update the map rather than take the location directly.
I then have the option of altering the map if I wish.

A worked example with the [11<sup>th</sup> Brigade war diary for August 1914](https://knoxa.github.io/war-diary/11-Bde/1914/1914-08-diary.xhtml).

The spans of text that I judge to be places are green.

```
<span class="place" content="a large wood between PONT L'ÉVÈQUE and LES CLOYES">a large wood</span>
<span class="place" content="to the E of the village of ST SAUVEUR">to the E of the village</span>
```


## Issues

* Dealing with ambiguous place names