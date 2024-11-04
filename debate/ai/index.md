# Arguing about Artificial Intelligence

## Introduction
This is an exercise in capturing debate on a suitably large and interesting topic to demonstrate and further develop ideas about collecting, evaluating and explaining arguments. It's [argumentation](https://dstl.github.io/eleatics/doc/argumentation/). This document provides a running commentary on the debate. I'll discuss the [technical details](technical.md) separately. 

## Existential threat
Let's start with the [singularity claim](singularity.xhtml) workbook. This grounds *the singularity claim* in essays by Good and Vinge. Next, Bostrom defines a [superintelligence](superintelligence.xhtml#superintelligence) and a case for it potentially threatening humanity. So far, there is no contention.

[Müller and Cannon](both-ways.xhtml) reconstruct the existential risk argument and attack its validity. This is an undercut, which is expressed in AIF by attacking an RA-node. Something to think about here is that the restated existential threat argument isn't exactly the one expressed by Bostrom: It uses *the singularity claim* as a premise instead of a singleton, and it doesn't use the *instrumental convergence thesis*. This doesn't affect the validity of the undercutting argument, but it does mean that there are two RA-nodes that conclude *humanity quickly becomes extinct*, and only one of them is undercut:  

![Undercutting the extinction argument](images/extinction.svg)

We need to consider whether these two arguments are really different, or whether one is some restatement (or weaker form) of the other. If the two arguments are different, undercutting one of them leaves the conclusion valid via the other route. We'll know the undercutter is there because it will force an extension in which it is acceptable - but that extension won't materially affect the conclusions you can draw from the argument map. There's a point to make that evaluating an argument map shouldn't just be a one-shot exercise to get a final answer; it should be an iterative process that helps you assess, develop and explore argument.

In this particular case, we might need to understand the differences between 'general intelligence' and 'instrumental intelligence' - which will probably lead to asking 'what is intelligence anyway?' and 'how do you measure it?'. Alternatively, we can claim that the orthogonality thesis holds irrespective of whether the AI is generally or instrumentally intelligent, so the instrumental convergence thesis is irrelevant to the existential threat argument. I'll set those issues aside for the moment.

The other question is whether 'the technical singularity' and 'a singleton' mean the same thing, in this context at least. At this point, I extented [superintelligence](superintelligence.xhtml#later) to capture Bostrom distancing himself slightly from 'the singularity' as a broad term, but embracing the intelligence explosion aspects of it. Others use the term *the technological singularity* to refer specifically to a superintelligent AI. Later, I may decide to make 'the technological singularity' and 'a singleton' equivalent, and think about how to model this in AIF with a MA-node.

## The singularity
The argument for existential threat depends on the singularity claim, which in turn builds on the premise of an "intelligence explosion" over a short time scale, "perhaps in the blink of an eye". In his book [The Singularity is Near](https://en.wikipedia.org/wiki/The_Singularity_Is_Near), Ray Kurzweil develops [the law of accelerating returns](accelerating-returns.xhtml) in support of this premise. Some arguments against the singularity, such as [the complexity brake](complexity-brake.xhtml), question the exponential nature of the intelligence explosion.

David Chalmers published [a philosophical analysis of the singularity](chalmers.xhtml) that constructs and discusses the argument for the singularity and potential defeaters. This provides a useful framework for assessing arguments for and against. It too raises questions about what is meant by 'intelligence'.

We need to consider the [terminology](technical.md#terminology) used by different parties in the debate and decide when different terms mean the same thing. For example, Chalmers considers three classes of artificial intelligence: AI, AI+ and AI++. The first is human-level intelligence (meaning Artificial General Intelligence, AGI), the second is greater than human intelligence (of the sort that triggers the intelligence explosion), and the third is the singularity (or artificial superintelligence, ASI). 

... *work-in-progress*