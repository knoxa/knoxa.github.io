# An example NLP Debate

Consider the [DEV-MUC3-0325](http://dstl.github.io/muc3/dev/DEV-MUC3-0325.xhtml) report. A named entity recognition (NER) agent can find mentions of people in text. For this example, we cheat by using a [list of MUC-3 person names](http://dstl.github.io/muc3/lists/name-person.txt) and doing some simple dictionary matching. We express the results as *locutions*, speakers making claims:

	NER1: "ROSA CHAVEZ" is a person
	NER1: "GREGORIO ROSA CHAVEZ" is a person
	NER1: "SALOMON ENRIQUE ROSA CHAVEZ" is a person
	NER1: "SALVADOR" is a person
	...

Each of these is a *mention*. The MUC-3 list has all mentioned names, including the shorter versions of names that refer to full names. Our simple dictionary matching approach finds the shorter version matching part of the longer version, making it easy to identify *co-reference* relationships between pairs of mentions:

	COREF1: "ROSA CHAVEZ" refers to "GREGORIO ROSA CHAVEZ"
	COREF1: "ROSA CHAVEZ" refers to "SALOMON ENRIQUE ROSA CHAVEZ"
	COREF1: "DUARTE" refers to "JOSE NAPOLEON DUARTE"

There are a couple of things wrong with the above arguments. Firstly, the mention of "SALVADOR" is part of the place name "SAN SALVADOR". It's not the mention of a person in this report. Secondly, we have "ROSA CHAVEZ" referring to two different people. This can't be right.

If our named entity recognizer is capable of assigning overlapping spans to two different entity types, or if we have a different named entity recognizer for places, we'll get an argument like:

	NER2: "SAN SALVADOR" is a place

If we're operating on the [Baleen linked data]((https://github.com/dstl/baleen/blob/master/baleen-rdf/src/test/resources/uk/gov/dstl/baleen/consumers/file/documentRelationsAsLinks.rdf)) then the overlap is explicit because a mention is a span with 'begin' and 'end' attributes. We can make an AIF argument that San Salvador as a place contradicts Salvador as a person.

Addressing the second issue, we can argue that "ROSA CHAVEZ" is ambiguous and use this argument to contradict each of the co-reference claims.

	CHK1: "ROSA CHAVEZ" is ambiguous.
	
A human agent can resolve this ambiguity:

	ANALYST: "ROSA CHAVEZ" refers to "GREGORIO ROSA CHAVEZ"
	
This claim can explicitly contradict the alternative co-reference claim in the AIF, or it can just be thrown into the debate. In the latter case the co-reference is still ambiguous, but there are now two votes to one (and a human decision) to indicate the 'correct' alternative.

## Critical questions

If one agent makes a claim, anotheragent in the dialogue might ask a question about it:

	NER1: "JOSE NAPOLEON DUARTE" is a person
	CHK1: Is this a known person?
	
This is modelled in AIF as a *transition* from the locution making the claim to a locution asking the question. Any answer can then be linked into the dialogue as a transition from the question. Answers might assert an indentity or that the person is unknown. Any unanswered questions will indicate where further investigation or analysis is needed.

	IDENT1: Yes, "JOSE NAPOLEON DUARTE" is José Napoleón Duarte

This is asserting *José Napoleón Duarte* as a unique identifier. Here, we're using DBpedia as a personalities database. DBpedia is constructed from Wikipedia, which is a set of entity-oriented documents with unique titles. The *rdfs:label* property for [an entity in DBpedia](https://dbpedia.org/resource/Jos%C3%A9_Napole%C3%B3n_Duarte) is the name of [the corresponding Wikipedia page](https://en.wikipedia.org/wiki/Jos%C3%A9_Napole%C3%B3n_Duarte), so is unique by virtue of the way Wikipedia works. We could make the identity more explicit, but less readable, by using a URI instead. We can do that in the Baleen RDF that backs this argument in any case.