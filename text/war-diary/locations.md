# Places

See [tigersmuseum](https://tigersmuseum.github.io/history/docs/places.html)

I may want to:

* Locate an entity. If the entity can move, I want to locate it at a specific times and track its movements.

How precisely do I need to locate an entity?

Locations may be described relative to other locations:

	300 yards N of road junction ¼ mile N of E of LA HUTTE
	the S.E. side of the railway about 350 yards N.E. of level crossing N. of first E in LE TOUQUET

How

The advantage of semantic mark-up is that it captures analysis of natural language text in the context of the text itself. Further, the original text is recoverable 
by simply stripping out the mark-up. This means you can critically assess the process that created it in deciding whether to use it, or you can simply ignore it. 
 
When do you need precise locations? I can search for any placenames in an general area that interests me and the
reference locations (LE TOUQUET and LA HUTTE) will let me find these reports. If I need a precise point, I can work that out for myself as part of
subsequent analysis. Alternatively, I might want to search for locations in a polygon. If the point of referenece is outside that polygon,
but the point itself is inside, I won't find it.
 
I might be more interested in the reference points used to describe a place than the place itself
 
Is a precise location even possible?
Because places are located by map labels, the above examples depend on having [the right map](https://digitalarchive.mcmaster.ca/islandora/object/macrepo:4152).
 
The location may not be precise in any case
 
## Semantic mark-up
 
I enclose mentions of places in HTML _span_ elements with _class_ set to "place". A CSS stylesheet colours these green. I'm happy to nest one place inside another.
For example, 
 
* 300 yards N of road junction ¼ mile N of E of LA HUTTE
* road junction ¼ mile N of E of LA HUTTE
* LA HUTTE

The idea is that the outermost span for a place represents text that could be substitued for a reference to the concept of place, with the remaining
(and now simpler) text still making sense. So, for example,

	Col Le Marchant marched to PONT L'ÉVÈQUE via main road through GUISCARD, and bivouaced there.

becomes

	Col Le Marchant marched to [PLACE] via [PLACE], and bivouaced [PLACE].
	
The word "there" is an anapahor for "PONT L'ÉVÈQUE" in this sentence. I can its meaning explicit in the HTML by setting a _content_ attribute:

	... <span class="place" content="PONT L'ÉVÈQUE">there</span> ...

I might do this, eventually, if I think that information is worth recording, or I might just not bother 
### Geometry

Rivers and roads are lines rather than points.

A town or city isn't really a point, but we're used to sticking pins in maps to show where they are. By convention, a point in the centre of a town 
is that town's location.

A line may be described by reference to a point:

	main road through GUISCARD

In this case, if the information I want is that a unit passed through the point, I'm happy to record just the point.

## Many hands

I'm not going to be be rigourous about applying mark-up "rules". I'm probably not going to be comprehensive either.
I'll focus my efforts on the documents that interest me. I'll develop and extend mark-up iteratively as I explore the documents.
How I use semantic mark-up will may change as I explore.

Information extraction from text should there be view as being enabled by semantic mark-up rather than depending on it. 
If you don't want this mark-up, it's easy to strip out. If you do want this mark-up (or you're prepared to give it a go) then you want to be able
to assess it critically.


Extract the place labels as a set of strings: For each span element, take the value of the _content_ attribute if set, or the text value of the element if not.

The same place may have different labels. Taking inspiration from SKOS, I'll consider one of these to be the _preferred label_ and the rest to be _alternate labels_.

The next step is to map the set of extracted labels to a set of preferred labels.
This is a mapping function that takes a label x to a preferred label p(x), with the constraint that p(p(x)) = p(x).

I have collected some geospatial data as [KML](https://developers.google.com/kml/documentation/kml_tut) files. The KML includes
_Placemarks_ which associate a name with a geographic location. I can choose preferred labels from the set of Placemark names, and thereby
map preferred label to coordinates.

This assumes that Placemark names are unique. In general, they won't be. I therefore map from preferred label to a set of locations. If the returned
set has one element the place name is unique, if there is more that one element the name is ambigusous.


One approach to disambiguation would be to enforce unique preferred labels (which is what Wikipedia does) for each location, but this has an overhead in
managing and enforcing the uniqueness in the geospatial data, and it requires care in mapping to preferred label. Instead, I'm happy to live with 
mistakes caused by erroneous assumptions provided there are ways of detecting and correcting them, or perhaps determining they have little impact on conclusions and ignoring them.
An alternative approach would be to consider _context_ when mapping from place labels as they appear in the source text through to locations. The preferred label map and geospatial data 
might be different in different contexts, and chosen to eliminate ambiguity.



