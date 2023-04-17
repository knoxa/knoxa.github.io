# Linked Text

NLP processing of text to create linked data.

Information extraction. Interpretation and linking. We want to get to the point where we can make claims about the world and cite reports as evidence. It should then be possible to mechanically check that evidence, tracking chains of inference back to the source reports.

The NLP is conducted by an ensemble of agents. Agents can operate directly on the text or they can operate on the output from other agents. Agents may specialize in a particular NLP task. One Agent might be doing the same thing as another. Agents have different capabilities. Agents may differ in the quality of correctness of what they produce. Some agents might be concerned with checking results rather than producing them. An individual agent doesn't have to be right.

The general picture is one of dialogue and debate between a bunch of AI agents attempting to make sense of a document. We will model this as [Argument Interchange Format (AIF)](https://arg-tech.org/index.php/research/contributing-to-the-argument-interchange-format/).

We will use this [Baleen OWL](https://github.com/dstl/baleen/blob/master/baleen-rdf/src/test/resources/uk/gov/dstl/baleen/consumers/file/documentRelationsAsLinks.rdf) for the results of NLP. 

NLP dialogues have a context. Where the dialgoue is about the information in a document, the scope of the arguments is a document. This is made explicit in the Baleen OWL, but not in the text arguments generated. We collect these arguments in a named graph. There is an implied "In document X," clause in each arguments. 

### URI

[Hash](https://github.com/dstl/eleatics/blob/master/xsl-utils/stringhash.xsl)

Agents may process the same text independently. Nevertheless, we need to be able to relate their results.

### Strings and spans

A string is a sequence of characters. A span is a string at a particular locuation in a document. The same string appearing at two different location in a document is two different spans. When we use Baleen OWL to express the results of NLP, we're dealing with spans. When we argue, we're dealing with strings. The assumption in taking this step is that the character sequence in the string means the same as that in the span it came from. In other words, we assume the character sequence has the same meaning wherever it might be used in the document. This will be true for proper names, and likely false for things pronouns. We won't worry much about this because arguments can still be made - and if they're ambigous or unclear, they can be criticized.

We can nevertheless construct arguments where the URI's of premises and conclusions are those of Baleen classes.

We make Baleen mentions and coreferences to capture claims made by NLP agents. We assign each of these a skos:definition attribute with text that summarizes the claim.

We express the outputs from NLP as OWL/RDF linked data. We treat these outputs as claims made by one or more NLP agents that can be reasoned over, contradicted or questioned by other agents. We construct Argument Interchange Format (AIF) dialogues for these purposes. This positions the NLP OWL/RDF ontology as an AIF *adjunct ontology*.

Examples here are drawn from the [MUC-3](https://github.com/dstl/muc3) corpus.

* [DEV-MUC3-0325](examples/DEV-MUC3-0325.md)

## Things we can do

- Find things by their relations to questions, taking whether or not questions are answered into account.
- Use unanswered questions to direct further work. Consider also questions that have been answered, but where the answers are not backed up supporting arguments. 