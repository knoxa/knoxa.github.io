# Argument maps


The key dependency is the use of [Argument Interchange Format (AIF)](https://www.arg.tech/index.php/research/contributing-to-the-argument-interchange-format/) to model argument and dialogue. Arguments link through shared premises and conclusions to form *argument maps*. If different parties use the same identifier when they refer to the same claim, their respective lumps of AIF can be added together and the 'linked data' nature of AIF will make the connections. 

## Constructing AIF

1. I use [XHTML+RDFa](https://en.wikipedia.org/wiki/XHTML%2BRDFa) to create a 'workbook'. I apply [claims.xsl](https://github.com/knoxa/linked-text/blob/master/xsl/claims.xsl) to transform workbooks to AIF.

1. I draw AIF argument maps in [yEd Graph Editor](https://www.yworks.com/products/yed). This produces GraphML format, which I transform to AIF as described on the [Dstl eleatics](https://dstl.github.io/eleatics/argumentation/graphml/) web pages.

## Evaluating arguments

1. I use the Java code in my [argumentation](https://github.com/knoxa/argumentation) repository.

1. See [The Online Argument Structures Tool (TOAST)](http://toast.arg.tech/) for a browser-based evaluator. This include a REST API.

1. See also [TweetyProject](https://tweetyproject.org/doc/index.html). This includes libraries for the [Dung argumentation framework](https://dstl.github.io/eleatics/doc/dung-framework.html), the [ASPIC+ argumentation theory](https://dstl.github.io/eleatics/doc/dung-framework.html), and more.

## Models of dialogue and debate

I use the AIF-RDF specification [here](https://www.arg.tech/wp-content/uploads/AIF-RDF.owl).

AIF supports the idea of extension through *adjunct ontologies*, bits of model specification that can be used to extend the core AIF in interesting and useful ways. For example, [S-AIF](https://dl.acm.org/doi/10.1145/3007210) and [T-AIF](https://doi.org/10.48550/arXiv.1812.06745) let you model the speakers in a debate and their relationships, thereby bringing credibility and trust into argument evaluation. I'm not using these (for the moment at least), but I'm keeping the door open by doing things like using a [DOI](https://www.doi.org/), where possible, to link to the source of quoted arguments. Tools such as [Crossref](https://www.crossref.org/) can then be used to get information about authors.

### Diagrams
Diagrams are useful, but AIF argument maps become cluttered and complex very quickly. I'll use diagrams in explanation, but these are often going to be selected fragments of larger arguments maps. You'll be perfectly justified in treating these with suspicion: It's the AIF model itself that has authority, not any selective depiction.

To make a diagram, I generate GraphML from AIF using an XSLT stylesheet and load it into yEd to lay it out neatly. See the [Dstl eleatics wiki](https://github.com/dstl/eleatics/wiki/Argument-Maps) for details. I then export from yEd as SVG for use in web pages.

### Locution
L-node is a subclass of I-node, which means you can treat an L-node as an I-node if you want to. The distinction between the two becomes import when you want to model a dialogue; where there is more than one speaker, and the sequence of utterances and their illocutionary force might be important. These things are the province of the L-node.

I'm currently being a bit lax in making these distinctions. At the moment, I'm just generating I-nodes from the workbook XHTML. Whether these should really be L-nodes can be inferred from their relationship to TA-nodes and YA-nodes.

### Questions

It's useful to capture questions that are raised in a debate. I'm modelling these as locution that links from the locution that raises a question via a TA-node.

### Rewrites

AIF has an MA-node to support rewriting or rephrasing arguments. I can use it in the AI debate to assert an equivalence relationship between arguments expressed by different speakers. However. doing this needs thinking about: two arguments might be equivalent in some contexts, but not others; asserting equivalence is making a claim, and this ought to be defeasible.

## Argument mining
One aspect of this is NLP directed at constructed argument maps. Another aspect is NLP aimed at claims in multiple arguments to work out their relationships: Are they the same? Do they agree? Are they contradictory?

### Terminology
If we're joining argument from different sources together, we need to understand variations in terminology. Mapping terminology is something that would both help argument mining and be helped by argument mining.

