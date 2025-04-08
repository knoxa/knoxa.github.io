# Locations

A location is a point on a map. I want to take a text string that represents the label or description of a place and assign it geographic coordinates.

Before I can assign places to locations, I need a labelled locations from a Geographic Information System (GIS), in my case Google Earth.
I push pins into a map in Google Earth and export the results as [KML](https://developers.google.com/kml/documentation/kml_tut).

Given a set of independently created KML files, I may end up with multiple labels for the same location or multiple locations for the same label.
These issues can be avoided with painstaking care in creating and curating KML files, but doing that in a collaborative environment requires one of the
parties to assume an authorative role and effectively manage a GIS database. I'm not going to be that careful about it anyway. Instead, the approach 
I'll adopt is to allow for the possibility of mistakes creeping into the process of locating places mentioned in text.
I'll consider how those mistakes might be detected and corrected.


1. Extract the place labels as a set of strings: For each span element, take the value of the _content_ attribute if set, or the text value of the element if not.

1. The same place may have different labels. Taking inspiration from SKOS, I'll consider one of these to be the _preferred label_ and the rest to be _alternate labels_.
I choose preferred labels to be the f_Placemark_ names in my KML.

1. The next step is to map the set of extracted labels to a set of preferred labels.
This is a mapping function that takes a label x to a preferred label p(x), with the constraint that p(p(x)) = p(x).

1. This assumes that Placemark names are unique. In general, they won't be. I therefore map from preferred label to a set of locations. If the returned
set has one element the place name is unique, if there is more that one element the name is ambiguous.

### Issues

A place may be the label of a specific, known location. A place may describe one location relative to another. A place may not be locatable.
The location may not be precise in any case.
 
Because places are located by map labels, the above examples depend on having [the right map](https://digitalarchive.mcmaster.ca/islandora/object/macrepo:4152).

My requirement for precision may vary. If I don't know where the Cafe Royal is in Ploegsteert. It may, or may not, be good enough just to stick a pin in the centre of Ploegseert instead.
I might be more interested in the reference points used to describe a place than the place itself


### Geometry

Rivers and roads are lines rather than points.

A town or city isn't really a point, but we're used to sticking pins in maps to show where they are. By convention, a point in the centre of a town 
is that town's location.

A line may be described by reference to a point:

	main road through GUISCARD

In this case, if the information I want is that a unit passed through the point, I'm happy to record just the point.

One approach to disambiguation would be to enforce unique preferred labels (which is what Wikipedia does) for each location, but this has an overhead in
managing and enforcing the uniqueness in the geospatial data, and it requires care in mapping to preferred label. Instead, I'm happy to live with 
mistakes caused by erroneous assumptions provided there are ways of detecting and correcting them, or perhaps determining they have little impact on conclusions and ignoring them.
An alternative approach would be to consider _context_ when mapping from place labels as they appear in the source text through to locations. The preferred label map and geospatial data 
might be different in different contexts, and chosen to eliminate ambiguity.



