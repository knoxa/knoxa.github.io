# Names

The name of the same person can be expressed in many different ways. Resolving which expressions are equivalent is _entity disambiguation_.

I can take a name and split it up into tokens. Each name is then associated with a set of tokens and similar names are related by intersections of
these sets. I can play around with options for generating tokens. For example, it might make sense to normalize the tokens in various ways: reduce everything
to lower case, remove diacritical marks, apply a phonetic encoding (such as [Soundex](https://en.wikipedia.org/wiki/Soundex)), and so on.
I can add one or modified tokens to each set in addition to the original tokens, or I can replace original tokens with the modified ones.
I can make a [stop list](https://en.wikipedia.org/wiki/Stop_word) of tokens that won't help me discriminate and discard them.
There are lots of options that might let me "tune" any follow-on analysis, but the result in any case is data structure consisting of a set of names,
with each name associated with a set of tokens. 

I could take this data and construct a graph of name nodes linked to token nodes.
Similar names will have nodes that are [structually equivalent](https://en.wikipedia.org/wiki/Similarity_(network_science)#Structural_equivalence) in this graph.
I could score for structural similarity and use these scores to decide if two names are eqivalent. However, [that's been done](https://github.com/dstl/muc3/wiki/Extracted-Information#people),
so instead I'll play with Formal Component Anaylsis.

## FCA

Formal Component Analysis gives insight into how _objects_ are related through shared _attributes_. I could treat each name as an object and each
token as an attribute. Instead, I'll do it the other way round: Objects are tokens, and the attributes of each token are all the names in which 
that token features. This choice makes it easy to eliminate tokens that aren't discrimantory by simply deleting the object. As we'll see later,
it makes possible to add objects to influence results.

## An example

This example is drawn from [World War I Chronology](https://tigersmuseum.github.io/history/docs/ww1.html). As far as tokenization is concerned,
I filter against a stop list of ranks and titles, and I apply both Soundex and Metaphone to each token and add these to the set.
To make it easier to follow, I restrict the input to this set of names:

    General Murray
    Lieut-General Sir A. J. Murray
    General Sir A. J. Murray
    Lieut.-General Sir A. J. Murray
    General Sir A. Murray
    Archibald Murray
    General Sir J. Wolfe Murray
    Sir A. Murray
    LieutGeneral Sir Archibald Murray
	
 These names cover two different people, [Sir Archibald James Murray](https://en.wikipedia.org/wiki/Archibald_Murray) and [Sir James Wolfe Murray](https://en.wikipedia.org/wiki/James_Wolfe_Murray).
 
 Applying FCA produces this concept lattice:
 
 ![A concept lattice from names](names-fca1.svg)
 
 This is the GraphML procuded by the FCA implementation in my [argumentation](https://github.com/knoxa/argumentation/tree/main) repository, loaded into yEd and exported as SVG.
 There isn't a layout method for lattice diagrams in yEd, so I've laid this out hierarchically, and made the edges directed so that they point "upward" towards the most common attribute.
 The attribute labels appear on the diagram beside concept nodes. The object labels aren't visible, but you'll see them if you open the image in a new tab and mouse over concept nodes.

What I'd like as output is a set of objects where each represents a distinct person, with the various representation of their names as attributes.
Ther are some things I can do:

1. Names are equivalent if they appear at the same concept node. I could make a person object from each concept node that has one or more attributes.

2. Attributes (names) towards the top of the lattice are associated with more objects (tokens) than attributes towards the bottom.
The top attributes are therefore "longer" names that tend to have more tokens.
I can argue that this makes them more likely to identify a specific individual. I could make a person
object from each of of these top objects. Further, all the tokens relating to the name(s) in the top concept are found in the set of concepts below.
Any name attributes associate with these concepts is constitent with the top name attribute in that it is formed from a subset of its tokens.

 