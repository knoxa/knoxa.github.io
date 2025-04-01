# Places

See [tigersmuseum](https://tigersmuseum.github.io/history/docs/places.html)

I may want to:

* Locate an entity. If the entity can move, I want to locate it at a specific times and track its movements.

How precisely do I need to locate an entity?

Locations may be described relative to other locations:

	300 yards N of road junction ¼ mile N of E of LA HUTT<strong>E</strong>
	the S.E. side of the railway about 350 yards N.E. of level crossing N. of first E in L<strong>E</strong> TOUQUET

How 
 
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
	


### Geometry

Rivers and roads are lines rather than points.

A town or city isn't really a point, but we're used to sticking pins in maps to show where they are. By convention, a point in the centre of a town 
is that town's location.

A line may be described by reference to a point:

	main road through GUISCARD

In this case, if the information I want is that a unit passed through the point, I'm happy to record just the point.

## Many hands

I'm not going to be be rigourous about applying mark-up "rules"

If you don't want this mark-up, it's easy to strip out. 