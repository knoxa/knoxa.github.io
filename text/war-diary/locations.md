# Locations

A location is a point on a map. I want to take a text string that represents the label or description of a place and assign it geographic coordinates.

Before I can assign places to locations, I need a labelled locations from a Geographic Information System (GIS), in my case Google Earth.
I push pins into a map in Google Earth and export the results as [KML](https://developers.google.com/kml/documentation/kml_tut).

Given a set of independently created KML files, I may end up with multiple labels for the same location or multiple locations for the same label.
These issues can be avoided with painstaking care in creating and curating KML files, but doing that in a collaborative environment requires one of the
parties to assume an authorative role and effectively manage a GIS database. I'm not going to be that careful about it anyway. Instead, the approach 
I'll adopt is to allow for the possibility of mistakes creeping into the process of locating places mentioned in text.
I'll consider how those mistakes might be detected and corrected, or when they might be safely ignored.

An alternative approach to disambiguation considers _context_ when mapping from place labels as they appear in the source text through to locations. The preferred label map and geospatial data 
might be different in different contexts, and the context chosen to eliminate ambiguity. The issue is then one of defining and managing "context".

In outline:

1. I construct a set of strings from the place mentions: For each span element, I take the value of the _content_ attribute if set, or the text value of the span if not.

1. The same place may have different labels. Taking inspiration from SKOS, I consider one of these to be the _preferred label_ and the rest to be _alternate labels_.
I choose preferred labels to be the _Placemark_ names in my KML.

1. The next step is to map the set of places to a set of preferred labels.
This is a mapping function that takes a label _x_ to a preferred label _p(x)_, with the constraint that _p(p(x)) = p(x)_.

1. If the preferred names are unique they serve to identify the location. In general, they won't be. I therefore construct a map from preferred label to a set of locations.
If the returned set has one element the preferred place name is unique, if there is more that one element the name is ambiguous.

### Issues

A place may be the label of a specific, known location. A place may describe one location relative to another. A place may not be locatable.
The location may not be precise in any case.
My requirement for precision may vary.

The location may depend on a piece of contextual information known to the author and reader of the original document, but perhaps lost in time.
For example, locating 

	300 yards North of road junction ¼ mile North of E of LA HUTTE	

depends on having [the right map](https://digitalarchive.mcmaster.ca/islandora/object/macrepo:4152) to locate the "E" of "LA HUTTE".

### Geometry

A town or city isn't really a point, but we're used to sticking pins in maps to show where they are.
By convention, a point in the centre of a town is that town's location.
Rivers and roads are lines rather than points. Countries and administrative regions are polygons. If a general region has a geometry, then it too will be a polygon, but 
it might also be just a short-hand name covering a set of point locations without a geometry of its own. 

