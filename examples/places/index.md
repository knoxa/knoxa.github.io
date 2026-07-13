# Locating places

## Introduction

I need to identify the spans of text in a document that mention places.
I can do this manually or I can do it through some NLP process.
Either way, I choose to capture the results by marking-up mentions of place with HTML `<span>` elements.
I add a `class` attribute and use a CSS stylesheet to make my choices obvious.

A *mention* is a string of text at a specific position in a document. Its position gives it *context*.
The string describes a place, so is a *label* for that place.
The meaning of a label depends on its context.
A general label, such as "the village", can only be interpreted as a location on a map if its context is taken into account.
Other labels, such as proper names, may be locatable irrespective of context.

I can decide that two different mentions or labels refer to the same place.
This makes a place an abstract entity that is referred to by mentions and labels.
In other words, a mention or a label is not a place, it is a reference to a place.
Once I have a *place*, rather than a just a mention of a place or a label, it has an *identity*.
Identities are unique. If I can faithfully map a place to its identity, its trivial to link it to any
other information about the same identity, in particular its geospatial *location*.

## Assumptions and uncertainty

This all sounds reasonable, but there are various practical issues.
I'll detail these in the context of a worked example below, but is worth noting some general points here.

There are judgements to be made about what constitutes the mention of a place.
These judgements might legitimately be different in different circumstances.
They depend on what you want to do with the locations you extract.
They will also depend on the knowledge of a human agent, or the capabilities of a machine agent, 
that finds mentions in the first place.

Data management takes a lot of effort to do well.
A hobbyist like myself doesn't have access to a geospatial database and other enterprise tools that would help, or the time and effort (and inclination) to learn how to use them if I did.
Instead, I'll take a short-cut and treat a place's proper name as its identity.
This is wrong in general terms because place names aren't unique, but it usually works in a narrow context.
Rather than claim that a place is identified by its name, I say that I *assume* a place is identified by its name.
This is a subtle but important distinction. It means I should check that the assumption isn't invalid when I make claims about the location of a place.

Its easier, from the data management point-of-view, to deal with labels rather than mentions when collecting co-references to the same place.
Simplifying a set of mentions to a set of labels risks losing contextual information that might change the determination of the associated place.
Mistakes are always possible in any case, and I'll assume that operating on labels instead of mentions isn't going to add signficantly to the risk of misidentifying a place.
What will happen is that some places won't be identifiable from considering labels that might be identifiable through considering mentions.
I'll assume that these lapses aren't important.

Any "facts" I extract are not, in actual fact, facts, but are claims based on a set of assumptions.
These assumptions will usually be correct but won't always correct.
You should be able to test a claim by challenging underlying assumptions, and I should be able to justify the assumptions to defend it. 

## 11th Infantry Brigade movements in World War 1

I want to extract locations from [11<sup>th</sup> Infantry Brigade war diaries](https://knoxa.github.io/war-diary/11-Bde/).
But, what does this mean precisely?
If the place is a region, do I want a polygon of the region or a point in the centre of the region?
If the place is described as some distance in some direction from some other place, do I want to calculate a coordintate, or will just the location of the referent place do?
What level of granularity do I want? If the mention is of a neighbourhood within a city, do I want to pin down the neighbourhood, or am I happy with just the city?
I don't know the answers to these questions before I start, and I'd expect to make different choices in different circumstances.
I'll start by presuming the answer to questions like this are "it doesn't matter" and be prepared to "go round the loop" as my requirements change.

### August 1914

My starting point is the [August 1914 war diary](https://knoxa.github.io/war-diary/11-Bde/1914/1914-08-diary.xhtml).
The CSS stylesheet for this shows HTML spans with `@class="place"` in green.

### Mentions

These are edited into the XHTML by hand. I've made judgments as to what to mark up and how. For example, given the mention:

    positions respectively S.W. and S.E. of SOLESMES
	
Is this one place or two? 
Different people will make different judgements, so the answer to a question like this is usually "both".
I've dodged the issue in this particular case by deciding that its one place, and that I can get what I want (for the time being at least)
by just marking up `SOLESMES`.

I can be creative with the use of `span` elements. For example, to address the issue of one 
place being described in terms of another, I might do something like:

```
<span class="place">the high ground S of <span class="place">ST SAUVEUR</span></span>
```

This puts a mention of `ST SAUVEUR` in the context of the mention `the high ground S of ST SAUVEUR`.
I could use this stucture to explicitly map `the high ground S of ST SAUVEUR` to `ST SAUVEUR`,
which than maps to the location Saint-Sauveur.
Alternatively, I could get the same result if just have the outer span element and make the association to Saint-Sauveur through dictionary matching.
Choices choices, and I haven't tried too hard to be consistent in making them.

Another thing I can do is try and preserve some context for labels that would otherwise be unlocatable. For example:

```
<span class="place" content="a large wood between PONT L'ÉVÈQUE and LES CLOYES">a large wood</span>
<span class="place" content="to the E of the village of ST SAUVEUR">to the E of the village</span>
```

Here. I've added a `content` attribute to make the mention more explicit.
The idea is that the value of this attribute replaces the text in the body of the span.
I need to be very careful that I don't change the meaning of the text if I do this. Another assumption.

### The process

Firstly, I collect the set of string that are the span elements.
I've chosen to take the value of the `content` attribute in preference to the body of the span, and to ignore any nesting of spans.
The result is this [set of labels](labels.txt).

Next, I treat the labels as terms in a dictionary [cakes.nlp.dictionary](https://github.com/knoxa/cakes/tree/main/src/cakes/nlp/dictionary)
and apply the the dictionary to itself.
This finds shorter labels that are part of longer labels. The matching ignores diacritics.
The effect is similar to nesting one mention span inside another when marking up the document; a label that refers to a place in terms
of its relationship to a named place is mapped to the label of the named place.
This reduces the number of places I need to geolocate in the first instance. The result is this [label map](labels.xml).
This represents a function that takes a label as input and produces a set of contained labels as output.
Ideally, I want a single label as output. I check for this and find one label where this isn't true:

	Mulitple instances for key=a large wood between PONT L'ÉVÈQUE and LES CLOYES, values=[LES CLOYES, PONT L'ÉVÉQUE, PONT L'ÉVÈQUE]

This demonstrates two possible issues:

Firstly, I have two versions of `PONT L'EVEQUE` with different accenting, neither of which is necessarily correct.  I also have:

	<entry key="PONT L'ÉVÉQUE" value="PONT L'ÉVÉQUE"/>
	<entry key="PONT L'ÉVÈQUE" value="PONT L'ÉVÉQUE"/>

This is sufficient to assert that these two labels are equivalent.
I can do something about that at this stage if I want, but it's going to come out in the wash when I later map labels to names, so I can safely ignore this.

The other issue is that the label describes a location with reference to a pair of places rather than just one, so legitimately mentions two different proper names.
If I wish, I can edit the map so that the entries:

	<entry key="a large wood between PONT L'ÉVÈQUE and LES CLOYES" value="LES CLOYES"/>
	<entry key="a large wood between PONT L'ÉVÈQUE and LES CLOYES" value="PONT L'ÉVÉQUE"/>
	<entry key="a large wood between PONT L'ÉVÈQUE and LES CLOYES" value="PONT L'ÉVÈQUE"/>

become a single entry:

	<entry key="a large wood between PONT L'ÉVÈQUE and LES CLOYES" value="a large wood between PONT L'ÉVÈQUE and LES CLOYES"/>

This is saying that I want to treat `a large wood between PONT L'ÉVÈQUE and LES CLOYES` as the *name* of a place, not just a label for it, and be able to locate that name.
The 'problem' isn't going away this time, but I can let this slide for now and deal with it later.

Next, I want to treat the values of the [labels map](labels.xml) as places and identify them.
The name that I want to use as my identifier is the name associated with the location in my geospatial data.
I'll call this the *preferred name*. The same location might have several names to account for variations in spelling and the like.
Each of these is an *alternate name*. I need a map of alternate name to preferred name.
I could make this map in isolation, but since I will go on to map preferred name to location, I might as well construct or find my geospatial data now - and then I can harvest preferred names from that data and use these as the target value for an alternate to preferred name map.

I've made my reference geospatial data by spending time sitting down with Google Earth, war diary entries and WW1 maps (if I can find them).
The merged KML from this is [France1914.kml](France1914.kml).
I can create a map of alternate names to preferred name from this KML.
The values of this map will be KML placemark names (my choice for preferred name) and the keys will be preferred names and any alternate names in the KML (it's possible to use `ExtendedData` in a KML `PlaceMark` to add these).
This is the starting point for the *identity map* I want. I can edit it as I see fit.
One thing I do want to do is remove any entries where the key is not in the set of values generated by the [labels map][labels.xml].
I again ignore case and diacritics when matching a value from the labels map with a key (alternate name) in the identity map.
I save a version of the identity map that has label map values (alternate names) as key, and identity (preferred name) as value.
This is [191408-places.xml](https://knoxa.github.io/war-diary/11-Bde/1914/data/191408-places.xml).

Lastly, I use [191408-places.xml](https://knoxa.github.io/war-diary/11-Bde/1914/data/191408-places.xml) to create a corresponding [191408.kml](https://knoxa.github.io/war-diary/11-Bde/1914/data/191408.kml) file that includes the locations.
Hopefully, this is as simple as using the preferred names to select placemarks from [France1914.kml](France1914.kml).
In practise, this is where my assumption about a proper name identifing a place might break down.
There are instances in my KML where the same name applies to two different locations.
I can spot this easily enough because I get two locations for the name instead on one.
It might require careful analysis source documents and maps to distingush between the two.
I can capture the results of that analysis by editing [191408.kml](https://knoxa.github.io/war-diary/11-Bde/1914/data/191408.kml) accordingly.

The final result is a consistent set of data: [1914-08-diary.xhtml](https://knoxa.github.io/war-diary/11-Bde/1914/1914-08-diary.xhtml), [191408-places.xml](https://knoxa.github.io/war-diary/11-Bde/1914/data/191408-places.xml) and [191408.kml](https://knoxa.github.io/war-diary/11-Bde/1914/data/191408.kml).

### Note

I consider [France1914.kml](France1914.kml) as a working document.
I used it to construct a document specific KML file, but I don't much weight as a geospatial dataset in its own right.
One reason is that its becoming large and unweildy.
Another reason is that I'm checking the document-specific KML file against the source text - and fixing any
'geospatial' errors in that file.
In due course, I can throw away [France1914.kml](France1914.kml) and reconstruct an equivalent from a set of document-specific KML files.
Rather than use [France1914.kml](France1914.kml), I could make a scratch KML file in Google Earth for each source document I process, then throw it away once I've been
round the loop sufficient times to get a useful result.

### September 1914

Moving on to the [September 1914 war diary](https://knoxa.github.io/war-diary/11-Bde/1914/1914-09-diary.xhtml).