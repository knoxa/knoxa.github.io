# Citizen Science

## Data

The essential points that make the Georgian Army Officers database a good resource are:

- It's possible to download the data, and a description of the data.
- Each record has a unique identifier.
- Each record includes a source reference that allows it to be checked against the historical record. 

These things are sufficient to allow third parties to process the data and relate results back to the original database or dataset.

## Data formats for feeedback and collaboration

It's difficult to design in advance exactly what data each researcher might capture.
A lowest common denominator format that all could use might help share the essential information, but the indiviudual researcher might want something richer and more tailored to their own need.
Generating data for the purpose of exchange can be onerous and prone to errors. It won't necessarily be updated.

Everyone can use whatever format best suits them if it's possible to convert from one format to another.
Natural language seems the way to go, with 'best practice' helping to make the data easier to manipulate, and the perhaps AI tools making the job of sharing the data simple in due course.

Many researchers will be interested in specific individuals, families or regiments.
Individually, their research generates pieces that could fit together to make a larger picture.

Some thought needs to be given as to how these pieces might join.
If there is freely available master data, suchs as an identities database, then it can be used to expressly link results.
However, such master data may not be available, or may not be known about.
We end up with another 'entity linking' problem when we want to join disparate results - but this time we hopefuly have more facts with which to link.

## Work

The [service history results](results.xhtml) express the outcome of data analysis together with question raised by the results.
A HTML `article` with claims against it could be considered a unit of work for further consideration.
The task would be to validate or contradict the claims.

## Agents and arguments

In the [service history results](results.xhtml), a claim made by an agent points to a mistake.
The mistake might be with the data or the algorithm drawing conclusions from the data, or it might be the agent itself mistakenly making the claim.
Any claim can be checked, and the results of that check can be expressed as another claim that supports or contradicts the first.
The result is an _argument_.

Im general, it should be possible for researchers to express their results as claims that can be critically reviewed, and that can be used support or contradict the claims made by others.
This is [argumentation](https://dstl.github.io/eleatics/doc/argumentation/).