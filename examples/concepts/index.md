# Formal concept analysis

This example draws on data published by the [Royal Hampshire Regiment Museum](https://tigersmuseum.github.io/history/). The starting point is a file called [ships.txt](https://tigersmuseum.github.io/history/events/ww1/ships.txt), which is a list of noun phrases about ships taken from the WW1 chronologies mentioned on the [World War I](https://tigersmuseum.github.io/history/docs/ww1.html) page. The chronologies are machine-readable XHTML. The proper names of any ships mentioned are inside HTML *span* elements with a *class* attribute set to *vessel*. This makes it easy to create a dictionary of ship names from the chronologies. I've also hand-crafted a dictionary of nationalities, and a dictionary covering the types of ship mentioned in the noun phrases.

Noun phrases concerning a common entity type will contain adjectives and nouns that can be considered attributes of the entity. In [ships.txt](https://tigersmuseum.github.io/history/events/ww1/ships.txt) example there are proper names, the classes of ship, and nationalities.

[Formal concept analysis (FCA)](https://en.wikipedia.org/wiki/Formal_concept_analysis) is a method that takes objects and attributes and constructs a *concept lattice*. Each node in the lattice represents a *concept* associated with zero or more objects and zero or more attributes. Each object and attribute appears in the lattice only once. The lattice is constructed so that links between nodes encode a partial order by set inclusion. In a lattice diagram, an object attached to a concept node is associated with all the attributes reachable by moving up the diagram, and an attribute attached to a concept node is associated with all the objects reachable by moving down the diagram.

I can treat each noun phrase in [ships.txt](https://tigersmuseum.github.io/history/events/ww1/ships.txt) as an object, and hits in the ship name, ship type, and nationality dictionaries as attributes. More interestingly, I can use the ship names dictionary to collect all noun phrases that mention the same ship and make each of these an object. Hits on the ship type and nationality dictionaries are the attributes. This assumes that all mentions of the same name are about the same ship, and it means that an attribute, such as nationality, need only appear in one of the phrases to be associated with that ship. I can then apply FCA to make the following lattice:

![A concept lattice from noun phrases about WW1 vessels](vessels-lattice.svg)

Note, this is the GraphML procuded by the FCA implementation in my [argumentation](https://github.com/knoxa/argumentation/tree/main) repository, loaded into yEd and exported as SVG. There isn't a layout method for lattice diagrams in yEd, so I've laid this out hierarchically, and made the edges directed so that they point "upward" towards the most common attribute. The attribute labels appear on the diagram beside concept nodes. The object labels aren't visible, but you'll see them if you open the image in a new tab and mouse over concept nodes.

There's a lot of information in the above diagram, but it isn't easy to pick out. What we can do is reduce the clutter by considering the nationality and ship type attributes separately. With the same objects (sets of phrases that mention the same proper name), and nationality as the only possible attribute, I get:

![A concept lattice from noun phrases about WW1 vessels - nationality](vessels-nationality.svg)

If I take ship type as the only attribute I get:

![A concept lattice from noun phrases about WW1 vessels - nationality](vessels-type.svg)


