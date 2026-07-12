# Locating places

I need to identify the strings in a document that *mention* places.
I can do this manually, or I can do it through some NLP process.
Either way, I choose to capture the results by marking-up mentions of place with HTML `<span>` elements.
I can set a class element and use a CSS stylesheet to make my choices obvious.

Next I need to decide when two different mentions refer to the same place.
How I do this might depend on how I intend to use the data as well as the data itself.
For instance, I might only be interested in the city or town rather than its neighbourhoods.
I'm asserting that two *mentions* are co-references to the same *place*.

Once I have a place, rather than a just a mention of a place, it has an *identity*.
If I had a geospatial database then I could use it to store places and their identity.
I don't have that though, and it wouldn't be of any use to you if I did.
I there were a geospatial database be could all share, then I might use that, but it won't have 
all the places I'm likely to come across in war diaries.

Instead, I'll treat the place name as its identity.
This wrong in general terms because place names aren't unique, but it usually works in the context of a single document.
Rather than say that a place is identified by its name, I say that I *assume* a place is identified by its name.
This is a subtle but important distinction.
It says I need to be sure that the assumption isn't invalid when I make claims about the location of a place.

    positions respectively S.W. and S.E. of SOLESMES
	
Is this one place or two? 
Different people will make different judgements, so the answer to a question like this is usually "both".
From the "pass it round first, cut it up afterwards" point-of-view, it doesn't matter - you should be able 
to make sense of either choice, and come back and make the alternate choice if that suits you better.

A mention is a string of text at a specific location in a document.
The location gives it context, and the context informs the meaning of the string.
It may be that the string has useful meaning out of context. For example, if it's the proper name of a place.

I want to geolocate the places covered by span elements.
I collect the set of string that are the span elements.

I'll call the string that are mentions of an entity after the entity, so the string are places.
I want to gelocate the mentions, but what I actually do is geolocate the strings, and assume that the location related to a string is the location of the mention.

There's some interpretation need in deciding what it means to geolocate a place. 

If the place is a region, do I want a polygon of the region or a point in the centre of the region?
If the place is described as some distance in some direction from some other place, do I want to calculate a coordintate, or will just the location of the referent place do?

As usual, I'll dodge all these questions and try and arrange things so that it doesn't matter in the first instance because you're not precldued from making 
different choices in different circumstances. I can even hedge my betes bo doing something like:

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