# yannic-kilcher - Nao16-6l6dQ

Source: https://youtube.com/watch?v=Nao16-6l6dQ
Fetched: 2026-04-23T09:23:32.117020
Duration: 40:10
Published: 20251101
Views: 22528

---

[00:00] Hello there. Today we are looking at the
[00:03] free transformer from France Fur at
[00:07] Farret Meta. This transformer is
[00:10] extending the classic decoderbased
[00:13] transformer with uh a series of latent
[00:18] variables that can be used to kind of
[00:20] make underlying decisions about the
[00:22] sequence to be generated. So for example
[00:24] and that's the example that the paper
[00:26] gives. Let's say you want to train a
[00:28] movie review model. Now any given movie
[00:32] whether it's good or bad will have like
[00:35] good reviews and bad reviews and and
[00:38] just assume for now that these are
[00:40] distinct two groups right there are like
[00:42] I like this movie because of this and
[00:44] this and this and I don't like this
[00:46] movie because of this and this and this.
[00:47] Now if the movie is good you know most
[00:50] of the reviews will be good but some
[00:52] will be bad. If the movie is bad most of
[00:55] the you know reviews will be bad but
[00:58] some will be good. Um but nevertheless
[01:00] right whether your distribution looks
[01:03] like this or whether it looks like this
[01:08] it it really like okay this is this is
[01:11] movie goodness here. Um and this is how
[01:14] many reviews there are.
[01:16] No matter how there is this biodal
[01:19] distribution and now let's say you are
[01:21] training a transformer on uh movie
[01:25] reviews. So you take a whole bunch of
[01:27] movie reviews, right? So uh here is a
[01:29] movie review, here's a movie review
[01:31] across all movies. Um and maybe the
[01:35] prompt is the description of the movie.
[01:37] So you have the description of the movie
[01:39] and then you train to you know given a
[01:42] description generate a movie review. Now
[01:46] if you have a big enough transformer um
[01:48] and enough data the model will learn to
[01:53] generate these good and bad reviews in
[01:55] the correct proportions. Right? So um in
[01:58] the limit uh you will if you supply a
[02:01] good movie to your trained model uh and
[02:04] ask it to write a review it will come up
[02:06] with a good review in let's say 90% of
[02:10] the time and the bad review in 10% of
[02:13] the time. Now the question is how does
[02:15] it do that right how does it uh make its
[02:20] because you sample once right when you
[02:22] sample once you get a concrete answer
[02:24] and that concrete answer is like a good
[02:26] review or a bad review and that needs to
[02:29] be internally consistent right you you
[02:31] can say well I like this movie because
[02:34] and then there's reasons why it's good
[02:36] and if you say this movie is bad because
[02:39] that text that follows is a lot
[02:41] different uh than movies that you Like
[02:44] so how does a transformer model achieve
[02:48] from the same movie description if you
[02:52] sample enough times how does it achieve
[02:55] that it is going to give you like uh 90%
[02:59] good and 10% bad reviews and the answer
[03:03] is um it there's obviously a degree of
[03:06] randomness in the transformer and the
[03:09] answer is that randomness is always at
[03:11] the end at the token sampling step. So
[03:14] if you do have um assume that you have
[03:18] your tokens. So oh we use blue for that
[03:21] one. So assume that uh these here are
[03:25] the tokens of the movie description and
[03:28] then the um the initial tokens of the
[03:33] movie review, right? You keep sampling.
[03:36] So this is auto reggressive. So you
[03:38] sample this token, then you sample this
[03:39] token, then you sample this token,
[03:41] sample this token. And on top of this,
[03:44] you have your model. So several layers
[03:47] of transformer here. Uh layer layer
[03:51] layer. And the question is how do you
[03:54] generate the next token here? So somehow
[03:58] the next token needs to be generated.
[04:01] The way this is done is that um once you
[04:05] are through generating here you will not
[04:09] get a token directly but you'll get a
[04:11] big distribution over tokens
[04:12] specifically you'll get logits which you
[04:14] normalize but here is your whole
[04:17] vocabulary like a and
[04:21] uh and blah blah blah dog blah blah blah
[04:26] good like all the tokens you could
[04:28] generate and what you will get is a
[04:31] distribution. Okay, like a little bit of
[04:33] that. That makes no sense. Maybe that
[04:36] makes a lot of sense. No, dog doesn't go
[04:39] for the next token. Well, it depends,
[04:41] right? It depends what this text is, but
[04:43] the transformer is going to give you
[04:45] like a distribution
[04:47] over next tokens which you can then use
[04:50] to sample from. Okay, this is the only
[04:54] place where we have randomness in
[04:57] transformers. Now I'm overlooking here
[05:00] the randomness that comes from batch
[05:03] normalization and the randomness that
[05:05] comes from GPU error correction or not
[05:09] correction and the randomness that comes
[05:11] from quantum fluctuations in two
[05:13] nanometer processors like we'll keep it
[05:17] like this randomness here is is much
[05:20] bigger than those things. So we'll focus
[05:24] on this one. This is the only place
[05:26] where you have randomness. And so
[05:29] specifically, let's look at good and bad
[05:32] movie reviews. The the only thing that
[05:36] the trans that a classic transformer can
[05:38] do is effectively be self-consistent.
[05:41] And so let's say you again you got your
[05:44] movie your movie um description here and
[05:47] you started generating the tokens. at
[05:50] the at the point when you start
[05:51] generating the tokens you like it's you
[05:55] have all the possibilities right and so
[05:58] the first word might be this right this
[06:01] and then the second one might be movie
[06:06] is and now when you sample the next
[06:10] token right
[06:13] the let's say it's a good movie right
[06:16] the transformer will correctly tell you
[06:18] your token distribution ution good
[06:21] bad it will be like like so right like
[06:27] this will be nine times higher than this
[06:30] now you sample from this and once you
[06:34] sample so let's say it you sample the
[06:36] word good because that's way more likely
[06:39] um you place it here good then the next
[06:44] token that you generate needs to be
[06:46] consistent with everything before and
[06:48] the next token needs to be consistent
[06:50] with everything before. Now there is
[06:52] variation in these tokens but they need
[06:54] to be consistent and therefore what
[06:55] you'll get is probably a a a you know
[06:58] reasons why the movie is good. Whereas
[07:00] if here you know just by sampling from
[07:03] this distribution here you would have
[07:06] chosen the word bad you because of
[07:09] self-consistency you would get a movie
[07:11] review that's you know highlights why
[07:13] the movie isn't particularly good. Um
[07:17] now I'm not saying everything after this
[07:19] is fixed. All the tokens are obviously
[07:21] still sampled. Um but they the
[07:23] distribution that you sample from needs
[07:26] to be you know make sense in the context
[07:29] of what happened before. So up until
[07:32] this point here both good and bad movie
[07:35] reviews make sense as continuations. But
[07:38] once you make this sampling choice um
[07:41] once you flip the coin like the 9010
[07:44] coin um and one of the two comes up then
[07:48] you you place a token here and because
[07:52] this token is so deciding for kind of
[07:55] like whether you know this is a good or
[07:57] a bad movie review um the the rest of
[08:01] the of the thing needs to be consistent.
[08:04] Now this is not limited to when the
[08:06] starts with this movie is but this is
[08:08] just the most glaring example. So I hope
[08:09] you can see that sampling certain tokens
[08:13] is what ultimately decides you know this
[08:17] kind of from which bucket here you're
[08:20] going to get a the whole answer. So the
[08:24] whole answer is kind of dependent on
[08:26] these intermediate little uh sampling
[08:30] steps. Wouldn't it be and that's what
[08:33] this paper asks. Wouldn't it be better
[08:35] if here let's say let's say here at the
[08:40] beginning you make a choice and you make
[08:43] a choice and say well I would like to
[08:45] generate a good movie review and then
[08:49] every single token you generate from
[08:51] this point on can look so here you make
[08:54] a choice like good right this like I
[08:57] like this movie and every single token
[09:00] you generate can come and look at that
[09:03] choice
[09:04] and be informed by that choice. You will
[09:07] get simpler math. You will get um
[09:11] broader consistency, right? You don't
[09:13] have to start vague and and uh and and
[09:17] sort of incrementally decide on these
[09:19] things. So this transformer uh variant
[09:22] is specifically concerned with the cases
[09:24] when um the underlying data uh makes
[09:29] sense to have like some latent variables
[09:33] that it depends on. We call this a
[09:35] latent variable because it's just in
[09:37] your head. You're thinking like, "Okay,
[09:39] I like this movie." And then you express
[09:41] the movie review and the whole movie
[09:43] review is really um
[09:47] dependent on that latent choice and and
[09:49] and uh not on the not so much on the
[09:53] samplings of the tokens. So this
[09:55] transformer tries to model that. Now the
[09:59] bad part is during like in your training
[10:02] data you only have movie descriptions
[10:05] and movie reviews you do not have um you
[10:10] you don't you don't necessarily have uh
[10:12] these things here available right you
[10:16] don't have the latent variables and it's
[10:19] not so easy as it's just always like one
[10:22] sort of um classification one token that
[10:26] you shove in a particular ular place
[10:29] actually that exists and that's actually
[10:31] called reasoning like that's what people
[10:33] do with reasoning. So here like here's
[10:35] the prompt and then here they have a
[10:37] deliberate place to put explicit tokens
[10:40] that that uh weren't there during
[10:42] training right they appear during
[10:44] reinforcement learning um
[10:47] [clears throat]
[10:48] uh to to shove that in and then to
[10:50] condition the rest of the answer on
[10:52] these. So that already exists. It's
[10:54] called reasoning. But what we want to do
[10:56] here is we want to say okay let's
[10:59] introduce latent variables that can kind
[11:01] of make these choices um that are would
[11:04] usually just be handled by the random
[11:07] token sampling in the output tokens.
[11:10] Now I have already uh explained a whole
[11:14] bunch of of this first section right
[11:16] here. So we won't dive too much into the
[11:18] paper. Um but this this example here is
[11:22] quite illustrative uh looking at the the
[11:25] math of it. So they're saying okay
[11:27] consider
[11:29] um a random variable that is a Berni. So
[11:32] like half and half coin flip um and we
[11:37] want X1 through XT. So these are other
[11:40] random variables right T random
[11:42] variables to be equal to Z with
[11:45] independent flips of probability
[11:47] epsilon.
[11:48] Um so probability epsilon I I so I I
[11:53] first flip a coin and then I um flip my
[11:59] epsilon coins and uh if the epsilon hits
[12:03] then my xt is equal to epsilon and if
[12:06] the epsilon doesn't if the epsilon coin
[12:08] doesn't hit then it's the opposite.
[12:11] If I first decide what like if I if I
[12:15] explicitly factor out Z then my math
[12:19] looks like this right? So if I can
[12:21] condition on Z, uh my math looks like
[12:24] this. The probability that any given X
[12:26] is one. Um
[12:29] given that I know what Z is is this
[12:33] right here, right? Very very simple.
[12:36] However, if we um didn't know Z, right?
[12:41] If we had to express this
[12:43] ultraaggressively, so given um the other
[12:47] X's, what is my X? And the idea here is
[12:50] that well if I don't know Z I have to
[12:53] sort of you know I have to um infer it
[12:58] from the other X's. So I have to have to
[13:01] look at the past tokens to see well what
[13:04] could my random variable be. It's the
[13:06] same thing as saying like well if I
[13:08] generate tokens for my movie review I
[13:11] either look at my latent decision
[13:13] whether I want a good or a bad review or
[13:16] I look at all the previous tokens and
[13:18] somehow try to derive from them whether
[13:21] this is supposed to be a good or a bad
[13:23] review. Turns out unsurprisingly that if
[13:26] you have to look at all the previous
[13:28] tokens and infer that the math gets a
[13:32] lot more complex. Um
[13:35] so well this this is obviously the
[13:37] extreme example right here but you can
[13:39] see that um your expressions get a lot
[13:42] more tricky at that and this directly
[13:45] translates to well if you want a uh
[13:48] machine learning model to do this on
[13:51] your behalf then it has it it's
[13:54] [clears throat] going to have a much
[13:55] easier time learning this than learning
[13:59] this just like it's a lot or lot less
[14:04] complex function. So
[14:07] um they say that purely autogressive
[14:11] density models suffers from drawbacks
[14:14] unnecessarily comp complicated
[14:16] computation. Uh that means it requires
[14:19] greater capacity. The model needs to be
[14:21] bigger. Um it may be sent off track
[14:24] during the process. For example, if a
[14:26] few uh if a few tokens are generated
[14:29] erroneously like if a few tokens are you
[14:32] know like a mistake and that those
[14:36] tokens have a big big influence over the
[14:39] trajectory uh you might get off track
[14:42] and then lastly um the key concepts do
[14:45] not appear spontaneously due to the
[14:47] natural factorization. So if I if I just
[14:50] model my P of X1,
[14:54] X2
[14:55] and so on through XT. If I just model
[14:59] that as my P of XT given XT -1 through
[15:04] X1 sorry X1
[15:08] times my P of X -1 given you know like
[15:13] Xtus 2 and so on. If I simply model it
[15:17] my sequence auto reggressively like this
[15:21] um that's that's going to turn out way
[15:24] more complex than if I model my sequence
[15:27] and just say well these are effectively
[15:29] independent
[15:31] uh p of xi given z. Now the problem is
[15:37] um it's ultimately going to be a mix
[15:41] right like you even if you know the
[15:44] latent concept you still have to be
[15:46] consistent with the words at least from
[15:48] a linguistic perspective so what this is
[15:50] going to be is this is always going to
[15:52] be like this and Z this and Z right so
[15:58] um
[16:01] yeah that's that's that but I think the
[16:03] point still holds S if you know like if
[16:06] you have a lot of information here then
[16:08] the dependence on these variables can be
[16:11] a lot simpler maybe right maybe it's
[16:13] only you have to be linguistically
[16:15] constant uh consistent but not
[16:17] necessarily conceptually because that's
[16:19] already captured by Z.
[16:24] So they're
[16:26] they're saying here okay any latent
[16:29] random value uh whatever its statistical
[16:32] dependence with these tokens and other
[16:34] latent uh variables can be expressed
[16:36] under reasonable assumptions as a
[16:38] function of their [snorts] things that
[16:42] you know like the the tokens other
[16:45] latence and some randomly sampled uh
[16:50] value coming from a random generator. So
[16:53] if you have some source of randomness,
[16:55] you can model and shape this into
[16:57] whatever you want basically. Um so the
[17:00] goal is going to be to introduce that
[17:03] source of randomness to the transformer.
[17:06] Now what you what you might want to do
[17:11] is and uh this that now dives into the
[17:14] territory of like variational
[17:16] autoenccoders where this the free
[17:18] transformer effectively takes uh what a
[17:22] variational autoenccoder does and shoves
[17:24] it into the middle of a transformer to
[17:26] introduce these uh latent variables. So
[17:29] let's talk about let's talk about uh
[17:33] image generation for a while because
[17:35] that's where uh at least I encountered
[17:37] the VAE first and it's it's it's
[17:41] illustrative in a way. So let's assume
[17:45] um let's assume you have you're
[17:48] generating
[17:49] uh cats cat images right so on one hand
[17:54] cat image and on the other hand uh cat
[17:58] and let's say half the cats have
[18:00] sunglasses right so okay this cat has
[18:03] has big sunglasses okay um
[18:09] now what you want to do is you want to
[18:11] train a model to to generate this biodal
[18:14] distribution of of data so that uh you
[18:19] end up with a generative model that um
[18:22] so like a box and that box you can say
[18:25] please give me a cat and half the time
[18:27] it's going to be a cat without
[18:29] sunglasses and half the time that it's
[18:31] going to be a cat with sunglasses. This
[18:34] is exactly the same situation we're in
[18:36] with the movie reviews. Now what you
[18:38] might say is you might say oh well I'm
[18:40] just going to you know sample like
[18:43] sample a random variable here from a
[18:45] coin flip from a bernoli 1/2 and I'm
[18:49] going to enter it here right and because
[18:52] you know like it's it's going to you
[18:55] know if that's heads it's going to
[18:57] create this and if that's tails it's
[18:59] going to create this. That's fantastic.
[19:01] That that is a great idea. The question
[19:04] is how do you teach this model to take
[19:08] this variable into account and to map it
[19:11] like that. Right? So you and that that
[19:15] is that is actually the problem. How do
[19:18] you teach the model to consider even
[19:22] these random variables and to map them
[19:25] to the things that you want to map them?
[19:27] The second question um
[19:32] has no answer, right? Like how do you
[19:35] like let's say the model actually pays
[19:36] attention to your random variable that
[19:38] you feed in? How do you how do you make
[19:41] it such that it corrects the sunglasses
[19:44] when it's heads and the non- sunglasses
[19:46] when it's tails? That has no answer. Um
[19:49] because unless you have training data,
[19:52] right? Unless you can give it like give
[19:54] the the uh rand like unless you know
[19:59] which of the cats have sunglass and
[20:00] which don't and and in that case it's no
[20:03] longer a random variable. In that case
[20:04] you actually supply the label um in
[20:07] which case this comp becomes a
[20:08] conditional generative model
[20:11] then yes but other than that you are
[20:14] just relying on the sort of underlying
[20:17] disentanglement discovery mechanism.
[20:20] Right? If your data is really biodal and
[20:22] this is the biggest you know biggest
[20:25] variance like it's just every the cat
[20:28] there are super uniformly distributed
[20:30] except that half have no sunglasses and
[20:33] half do have sunglasses then you could
[20:36] reasonably expect that um any model that
[20:40] is actually paying attention to the
[20:42] random variable uh is going to map it
[20:45] like so. Um, but uh it's a bit more
[20:50] tricky. You have to kind of force it to
[20:53] learn that. You have to force it to to
[20:56] be like, "Oh, okay. I can pay attention
[20:58] to this random variable and I should
[21:01] probably I should probably make it so
[21:04] that it can help me."
[21:07] So the whole name of the game of
[21:09] variational autoenccoders is how can we
[21:11] make it so that during training the
[21:13] model learns that this here is helpful
[21:15] information because if during training
[21:18] it can learn its helpful information it
[21:20] will incorporate it into its process and
[21:23] by incorporating it into its process it
[21:26] it kind of start representing the data
[21:28] right and then during inference we can
[21:32] simply do the coin flip right during
[21:34] inference we can simply say okay now
[21:36] Let's flip a coin. Boom. We have uh
[21:39] heads. And because I supply heads and
[21:42] because during training the model has
[21:43] learned to associate heads with one of
[21:45] these two categories, we're good. So the
[21:48] name of the game is how during training
[21:50] do we teach a variational autoenccoder
[21:53] to pay attention to this latent variable
[21:57] that we don't have any training data
[22:00] for. And the answer is we cheat.
[22:04] The answer is called an encoder.
[22:07] So um like this is your training data,
[22:11] right? And what you train a variational
[22:14] autoenccoder to do is ultimately to
[22:16] reconstruct the training data, right?
[22:18] You want what comes out to be like what
[22:21] goes in. Now in a regular autoenccoder,
[22:24] you will simply take the data and
[22:27] compress it and learn the decoder learns
[22:30] to decompress it again. Now, that's
[22:33] fantastic as a compression tool, but
[22:35] it's not going to work as a generative
[22:37] model because when you want to generate
[22:39] something new, you don't have it to
[22:41] compress it. Okay? So, we need to be a
[22:44] bit smarter. Now, what we're what we're
[22:47] doing is we're also um we also create an
[22:51] encoder, but this encoder is simply
[22:54] generating this Z right here. It's not
[22:58] it's not generating the full thing. It's
[23:00] simply generating the Z. And
[23:03] this Z
[23:06] has some information about this sample
[23:11] right here. So you might say, well, why
[23:14] doesn't it fall into the same trap as
[23:16] the regular encoder? And that's because
[23:21] we it this we in addition to the
[23:24] reconstruction loss, right? We also
[23:28] really severely limit the amount of
[23:30] information that can be transmitted dur
[23:33] to via the Z. Okay. And because we
[23:36] severely limit the information that can
[23:38] be transmitted um we hope that we can
[23:43] get it just to the right amount so that
[23:46] it can transmit this one bit of
[23:48] information like one bit of information
[23:50] in this case. And because the data is so
[23:55] biodal and we train all of this, the
[23:59] most useful thing the model can do is to
[24:02] a learn to actually make this one bit of
[24:06] information to be about the sunglasses
[24:08] or the non- sunglasses and b the decoder
[24:12] will learn to then pay attention to this
[24:16] and map it into the sunglasses and the
[24:18] non- sunglasses. Right? So we want to
[24:20] limit the information just enough so
[24:22] that uh the most important things are
[24:25] captured in these latent variables and
[24:27] we limit the information in two ways.
[24:30] For one uh we can simply not make
[24:33] bandwidth available right like that Z if
[24:36] we make this literally one bit um then
[24:39] that's all that can be transmitted here.
[24:42] The second thing is we heavily
[24:43] regularize and that has an additional
[24:46] benefit. So we regularize the Z's that
[24:49] come out here to follow the distribution
[24:53] we ultimately want to sample from. So we
[24:57] may may want to say okay actually the in
[25:00] practice we want to have like a half and
[25:02] half distribution here. Um in practice
[25:06] you know at inference time we want to
[25:09] sample the Z from this distribution
[25:12] right here. Um what we have to do is
[25:15] make sure that during training the the
[25:18] Z's produced by the encoder follow that
[25:20] distribution because if not then during
[25:24] inference um we sample from a
[25:26] distribution that the encoder isn't
[25:28] familiar with and therefore we'll be
[25:30] mostly out of distribution uh sorry the
[25:33] decoder and therefore will be mostly out
[25:35] of distribution for the decoder. So all
[25:38] of this effectively um takes the form
[25:41] where we say a loss of a variational
[25:43] autoenccoder is the uh loss of
[25:47] reconstruction
[25:49] right uh plus the um like the KL
[25:54] divergence between the uh distribution Q
[25:59] which is what the encoder produces
[26:02] during training and P of Z which is the
[26:06] distribution that we would like to
[26:08] sample from. So we want these here uh to
[26:12] be close enough. So we force the encoder
[26:16] to only produce the disease in a
[26:21] distributional sense that align with the
[26:25] distribution we ultimately want to
[26:26] sample from. thereby teaching the
[26:30] decoder to kind of make sense out of
[26:33] this this distribution, not some other
[26:36] distribution, out of this distribution,
[26:38] which ensures that during inference we
[26:41] can actually sample from this
[26:42] distribution and get meaningful outputs.
[26:45] All the while um limiting the
[26:48] information so that um
[26:52] so that uh the the the encoder can't
[26:57] just cheat and and give everything to
[26:59] the decoder.
[27:01] That's essentially it. That's the free
[27:03] transformer. So on the left hand side
[27:05] you can see like a pure uh decoder
[27:07] transformer, right? I have my tokens
[27:10] here. I give it through a decoder only
[27:12] transformer and it gives me my next
[27:15] token or tokens during training. um uh
[27:19] obviously uh a causal transformer I can
[27:22] train jointly over the sequence.
[27:26] On B you see the ideal case during
[27:30] training uh during inference we simply
[27:32] sample a Z and then we produce tokens
[27:36] based on the token so far and the latent
[27:40] uh random variable and then the sampling
[27:44] here is what makes this latent decision
[27:47] during training. However, we don't
[27:50] supply the Z but we replace this by an
[27:52] encoder and the encoder gets to cheat.
[27:54] the encoder gets to look ahead in time.
[27:57] So here we have the whole like sequence.
[28:00] Now due to the causal mask during
[28:03] training of the of the of the decoder uh
[28:06] there's no look ahead, right? Like this
[28:09] is causally masked but the encoder gets
[28:11] to cheat. The encoder actually gets to
[28:12] look ahead at the whole thing, right?
[28:15] Like before, the encoder gets to look at
[28:17] the thing that should ultimately be
[28:18] reconstructed.
[28:20] And the encoder gets to encode that into
[28:23] a latent variable and supply that to the
[28:25] decoder. Because the encoder gets to
[28:28] cheat during training, the decoder
[28:30] learns to pay attention to what the
[28:31] encoder says. And so this here will be
[28:36] based not just on the tokens, but also
[28:39] on the encoder's uh uh cheated um
[28:43] encoding. And if we can manage if we can
[28:47] manage to limit the information that
[28:49] goes uh through the encoder and to make
[28:52] the encoder output um output outputs
[28:56] that follow
[28:58] overall in a distributional sense the
[29:00] way we want to sample Z during
[29:03] inference. Then we have ourselves a
[29:05] really nice variational autoenccoder.
[29:08] In practice, this paper does it a bit
[29:11] more sophisticated or a bit more
[29:14] resource um conscious whereas they split
[29:18] the whole transformer into two parts. Um
[29:22] so they just run the sequence during the
[29:25] first part and then they only have like
[29:27] one small block that is an encoder uh
[29:31] based on the decoder outputs right here.
[29:33] So what this means is you don't have to
[29:36] have like a full super big model uh for
[29:39] an encoder and you effectively share a
[29:42] whole a lot of the computation with the
[29:44] decoder right here. Now the decoder
[29:46] can't cheat, can't look ahead, right? So
[29:49] that you still have to do in this little
[29:51] encoder block based on the decoder
[29:53] outputs here. Um
[29:56] but um you save yourself a lot of
[29:59] computation. they put it into the middle
[30:02] because um if you put it too early then
[30:05] um the encoder doesn't have enough power
[30:08] right uh because it's it's dependent on
[30:11] this computation here. If you put it too
[30:13] late then there's not enough sort of
[30:15] layers to pay attention to the random
[30:17] variable to make actually good use of
[30:19] it. So they put it into the middle. If
[30:23] you want to go deeper here, um they have
[30:28] this kind of learned query vector uh a
[30:31] non-causal transformer block. That's
[30:33] where we cheat. Uh we do have like fully
[30:36] connected layer right here. Um that
[30:38] gives us a set of binary variables and
[30:42] then from those set of binary variables
[30:44] we we sample. Oh no, this here is I
[30:47] guess here is where we sample and then
[30:49] we have another fully connected layer
[30:51] and we add that back into the stream. So
[30:55] this here ultimately is where this Z
[30:58] during training comes from and during
[31:00] inference we simply sample from the
[31:03] distribution.
[31:05] So this is regular transformer block
[31:08] take take tokens
[31:11] you know push through blocks success and
[31:16] um this is a free transformer. So um
[31:22] during training we go through half the
[31:26] blocks and then we use the the encoder
[31:30] in order to determine the random
[31:33] variables here. And if we're not
[31:34] training, then we use the a uniform
[31:37] sampler right here or a one hot of a
[31:40] uniform sampler um
[31:44] and generate our our Z variable. Add
[31:47] this to the stream back and return.
[31:53] Um
[31:54] here it says train or prefill. And the
[31:57] the idea is well like when you're
[31:59] prefilling um it means you're kind of
[32:01] loading a KV cache and obviously you
[32:05] need to be like your Z variables from
[32:09] the past need to be consistent with the
[32:12] decisions that were made in the past.
[32:14] But since you're prefilling, you already
[32:16] know the tokens. So you can be
[32:19] consistent there. I guess I guess what
[32:22] you could also do is you could simply
[32:24] store the Z variables that you sampled
[32:28] and add them also to the cache. I'm not
[32:32] entirely sure honestly that that might
[32:36] need to be um
[32:41] yeah or is the preill is the prefilling
[32:44] the the part where I load in like the
[32:46] prompt or something? I'm not entirely
[32:49] sure I have to say here but I am not the
[32:52] best person on on talking about these
[32:54] kinds of things. So
[32:58] this stuff here not uh super important
[33:02] anymore. they do some experiments on
[33:05] synthetic data um where they construct
[33:09] the data set like this where uh you have
[33:12] kind of like at the beginning there is a
[33:14] letter and then there's a big underscore
[33:18] um big big length of underscores at some
[33:22] point um in this big thing uh there is a
[33:26] block of like eight recurring um
[33:29] instances of this character placed and
[33:31] then some places also randomly have this
[33:34] exclamation mark. So these some places
[33:36] they're kind of like the noise and then
[33:39] um and the latent decision is obviously
[33:41] kind of where to place that block of
[33:43] eight.
[33:45] Now if you now now if you we're playing
[33:50] with how how much how much information
[33:53] do we want to let through uh how much
[33:56] information do we want to let through to
[33:58] the uh through the encoder? And these
[34:02] experiments here show quite nicely. So
[34:04] what we have is um
[34:08] what we have is
[34:11] I believe the blue one is always like a
[34:15] regular transformer.
[34:19] Oh, [clears throat]
[34:20] sorry. Not a regular one, but it's it's
[34:22] a different Z per sequence in the blue
[34:25] box. And it's the same in each green
[34:29] box. is the same Z sampled. So on the
[34:33] top left you can see there's pretty much
[34:36] no difference, right? Um [laughter] so
[34:38] the blue box all they all have the um
[34:42] they all have uh uh sim uh different Z
[34:47] variables and here the Z variables are
[34:50] consistent like they're the same always
[34:52] and it's like yeah okay like it's what I
[34:56] like looks the same. So this here means
[35:00] that there's not enough information uh
[35:04] going through the encoder at all like it
[35:06] cannot actually transmit any
[35:08] information.
[35:09] If we let too much
[35:13] information through, which is the case
[35:15] here, you can see that it actually
[35:17] starts erroring, right? Like so this
[35:19] this is inference time here. This is
[35:22] inference time. And what it does is it
[35:25] starts erroring. It starts generating
[35:28] invalid sequences. They're no longer
[35:30] blocks of eight. And what this means is
[35:32] the model hasn't actually learned any
[35:34] like the decoder hasn't learned
[35:36] anything. it is fully relying on the
[35:38] like the encoder just encodes the
[35:39] sequence and the decoder is just like
[35:41] well whatever you say I'm going to copy
[35:43] right it doesn't need to learn anything
[35:45] because the encoder has so much capacity
[35:48] to transmit information to the decoder
[35:50] during training that the encoder simply
[35:53] tells the decoder the solution and the
[35:56] decoder never learns anything that's
[35:58] like if you if you copy your homework
[36:01] and and then you're asked to do the test
[36:04] you are the decoder
[36:07] However, in the middle is where it
[36:09] actually kind of works, right? So, here
[36:12] you can see, oh, all of these has have
[36:14] different Z and and and but within the
[36:16] green box here, they have the same Z. So
[36:19] you can see that the the the Z actually
[36:24] captures the position um in the sequence
[36:28] and it means that yes uh this
[36:31] transformer has actually learned that
[36:33] there is a there are latent variables it
[36:36] can make use of that and it has learned
[36:39] and that's the part where I said oh this
[36:41] has no answer um it has intrinsically
[36:44] simply associated
[36:46] the latent variable able with the
[36:49] position because that happened to be the
[36:52] most useful thing to do given the
[36:55] structure of the overall data. Right? So
[36:58] that's what we're relying on. We're
[37:00] relying on the structure of the overall
[37:02] data dictates how the decoder and
[37:05] encoder associate outcomes with latent
[37:09] variables. The only important thing is
[37:11] that we are actually um training latent
[37:14] variables that follow the distribution
[37:16] that we then want to sample because if
[37:19] we don't
[37:21] then um
[37:24] then we will always be out of
[37:26] distribution when we actually sample
[37:29] from our base distribution. We will
[37:31] always be like well the decoder is like
[37:32] well I've never seen anything like that.
[37:35] Like what am I supposed to do with this?
[37:38] All right. So, I don't want to go too
[37:41] much into the actual results right here
[37:44] because um [clears throat] benchmarks
[37:47] are just always so tricky to properly
[37:50] interpret. In this particular case, the
[37:52] free transformer does excel at things
[37:55] like uh coding and math. Uh it does not
[37:58] excel at things like question answering
[38:02] uh and knowledge. And I don't know, you
[38:04] make your own conclusions about why
[38:06] exactly why exactly that is.
[38:10] Now, that's about it what I had to say
[38:13] about this paper. Um, I do think this is
[38:16] definitely an interesting um
[38:19] investigation right here. Whether this
[38:22] is going to be a, you know, smash hit in
[38:26] the world of large language models, I'm
[38:29] not so sure. Um, and I'm saying that
[38:32] because it it is uh it's it's um we're
[38:37] effectively right introducing this
[38:39] cheating mechanism and then you have to
[38:41] tune exactly the hyperparameters.
[38:45] Um, and there's always a trade-off,
[38:47] right? Even if you limit the amount of
[38:49] information going through and you you
[38:52] penalize the KL divergence to your
[38:55] distribution, it still will not fully
[38:57] match your distribution of your like the
[38:59] distribution that you want to sample
[39:01] from. And you're still ending up with a
[39:04] bit of of cheating here and there,
[39:06] right? And all of that hurts at
[39:09] inference, right? Oh, you're not really
[39:11] sampling from the same distribution. Oh,
[39:14] your decoder has learned to rely on
[39:16] something that is now no longer there
[39:19] and and all of that hurts. So, while I
[39:22] can definitely see this helping for
[39:24] specific uh use cases where it's very
[39:27] clear that there is this kind of latent
[39:29] structure in the desired output
[39:32] distribution.
[39:33] I am a bit more bearish on this being
[39:38] like the the next big thing, but uh
[39:42] that's just my opinion. So, let me know
[39:44] your opinions. I'd be interested. Uh we
[39:48] do paper discussions almost every
[39:50] Saturday evening on Discord. Um you feel
[39:54] free to come listen in or if you want
[39:56] present uh your own paper or or some
[39:59] someone else's most people present
[40:01] someone else's paper. No requirement for
[40:03] you to actually have written it. That's
[40:06] it. Thank you very much. I'll see you
[40:07] around. Bye-bye.

---

## Metadata
- Channel: Yannic Kilcher
- Published: 20251101
- Duration: 40:10
- Views: 22528
- Video ID: Nao16-6l6dQ
