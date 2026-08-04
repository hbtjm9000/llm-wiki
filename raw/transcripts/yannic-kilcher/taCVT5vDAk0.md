# yannic-kilcher - taCVT5vDAk0

Source: https://youtube.com/watch?v=taCVT5vDAk0
Fetched: 2026-04-23T09:23:24.030281
Duration: 47:02
Published: 20251227
Views: 19998

---

[00:00] Hello, today we're looking at TiDaR
[00:03] Thinking Diffusion Talk and
[00:04] Autoregression by researchers at Nvidia.
[00:07] And this is a really cool paper because
[00:09] it effectively um makes
[00:13] good you already observes that we don't
[00:16] have full GPU utilization during
[00:19] autoregressive large language model
[00:21] inference um because it's largely memory
[00:25] bound. So, there's going to be times
[00:26] when the GPU isn't fully utilized. And
[00:29] it asks itself how can we smartly
[00:31] [snorts]
[00:32] use that extra GPU capacity without
[00:35] having to do the tradeoffs that
[00:38] typically um other systems that are
[00:41] trying to do similar things have. So,
[00:43] this is kind of as close to a free lunch
[00:47] as one can get. Basically, you're just
[00:50] uh investing extra electricity um to do
[00:53] some computation, but you do not have
[00:56] to, you know,
[00:57] you don't have to the other tradeoffs
[00:59] that are usually involved to uh such as
[01:01] with speculative decoding um or block
[01:04] diffusion.
[01:05] We're going into the method in a bit, um
[01:09] but basically, this in summary, this
[01:11] model proposes like a hybrid
[01:13] autoregressive and diffusion language
[01:15] model architecture that nevertheless
[01:18] samples exactly as an autoregressive
[01:21] model would. So, um you get all the
[01:23] quality of an autoregressive model, but
[01:26] is able to achieve a significant speed
[01:28] up um by sort of pre-computing things uh
[01:33] like speculative decoding, but it does
[01:35] so using diffusion.
[01:36] And it does so explicitly using this
[01:40] extra capacity that's available in uh
[01:43] the GPUs.
[01:45] So, the paper starts out by saying, "As
[01:49] we move towards artificial general
[01:51] intelligence." Pretty strong opening
[01:53] statement from a paper right here. And
[01:56] um
[01:57] it's just it's an opener. Um a hook, so
[02:01] to say. And after that, they go very
[02:04] quickly into the methods here.
[02:06] So, um there are a couple of things we
[02:08] have to understand before understanding
[02:10] the method that this paper uses. And the
[02:13] two things that the paper is coming back
[02:15] to is the autoregressive models and the
[02:18] diffusion language models. Now, the
[02:20] autoregressive models is probably
[02:22] basically what you um know if you have
[02:25] learned about large language models,
[02:27] especially the GPT type models. So, um
[02:30] you're going to have a sequence.
[02:33] And what you're going to do is you're
[02:35] going to always condition on the what's
[02:39] called the prefix here, um sometimes
[02:41] also called the prompt. And um then
[02:44] you're going to produce the next token
[02:46] right here. Once you've produced the
[02:48] next token, you're going to condition on
[02:51] the new prefix and produce yet the next
[02:55] token. Once you've produced that token,
[02:57] and so on. So, you're basically um
[03:00] always considering the um the full
[03:02] prefix and and you're producing the very
[03:05] next token in the sequence right here.
[03:08] So, this could be a sentence, this could
[03:10] be a visual visual language model and
[03:14] whatnot, as long as it's tokenized, um
[03:16] you can do autoregressive decoding. Now,
[03:19] one
[03:20] thing here is that uh this is obviously
[03:23] quite slow to train
[03:25] uh bec- if you were to do this naively,
[03:28] because um
[03:31] you only get like you have to process in
[03:33] this case five tokens only to compute
[03:37] the loss for this token right here,
[03:39] right? And then you have to produ-
[03:40] compute you have to process six tokens
[03:43] only to compute the loss for this one
[03:45] right here. So, people have have
[03:48] um sped this up by parallelizing this.
[03:51] They're effectively saying, "Okay, let's
[03:53] during training, right? During
[03:54] inference, we produce one token by one,
[03:57] like one by one by one. But during
[03:58] inference, what we do is um
[04:02] like the naive way would be, "Okay, here
[04:04] is a full sentence of tokens." Um these
[04:08] circles represent uh tokens or words,
[04:11] so the naive way would be say, "Let's
[04:13] cut it off somewhere here, right?"
[04:16] And then this is the prefix and this is
[04:19] the target token. And then you have a
[04:21] classic machine learning problem, right?
[04:23] You have an X,
[04:24] you have a Y, and you're trying to
[04:27] predict Y from X.
[04:30] This is super inefficient. So, what you
[04:33] can do is you can actually construct um
[04:37] what how many do we have? We have eight
[04:38] tokens. You can construct eight
[04:40] different uh losses from this one thing
[04:44] in parallel by saying, "Okay, actually,
[04:49] I can construct a, you know, nothing
[04:52] um nothing is my X and then this here is
[04:56] my Y. And then this here is my X, right?
[04:59] And then this here is my target. And
[05:02] then this is my prefix and this is my
[05:04] target. And this is my prefix and this
[05:07] is my target. And you can do it all in
[05:09] parallel. And the only constraint you
[05:12] have is you have to um create a
[05:14] triangular attention mask, meaning that
[05:18] um
[05:19] this token here can only look back.
[05:23] Right? It can only look uh at the
[05:25] previous tokens.
[05:27] And then this token here can only look
[05:30] at the previous tokens. This is during
[05:32] attention computation.
[05:34] Um if you don't know what attention
[05:36] computation is, there's there's tons of
[05:38] videos available. I have one, too, um on
[05:41] Attention Is All You Need, but
[05:43] uh in this what is called causal
[05:46] attention masking, you're only allowing
[05:48] the tokens to look back. So, your
[05:50] attention mask is going to be sort of
[05:52] triangular. So, this one can only look
[05:55] at you have to imagine this same
[05:58] tokens to also be aligned along this
[06:00] side, and then this one can can look at
[06:04] all of the previous, well, I guess here.
[06:07] This one is filled out here.
[06:09] This one can look at all of the previous
[06:11] ones.
[06:13] And then this one can all look all of
[06:15] the previous ones except the last one,
[06:18] and so on. Now, you might think, "Oh,
[06:20] that's obvious. You Of course, you can
[06:22] only look back." However, what you're
[06:24] forgetting is that this now also in
[06:27] causal attention masking, this now also
[06:29] counts in at the intermediate stages.
[06:31] So, imagine you are in this situation,
[06:34] right? And you are computing this token
[06:36] right here.
[06:37] Now,
[06:39] as your signal moves through these
[06:41] layers right here,
[06:43] um
[06:44] all you need is you need to produce at
[06:47] the end you need to produce a
[06:48] distribution here over this token.
[06:52] And
[06:54] you can
[06:56] as you compute the intermediate signals
[06:58] here, basically anything is allowed from
[07:00] a theoretical standpoint, right? Like
[07:03] imagine you as a human look at this
[07:06] pieces of piece of words and are trying
[07:08] to infer this right here.
[07:10] You might very well read this one first,
[07:13] right? Because it's like, you know, the
[07:15] cat ate the dog or the cat chased the
[07:18] dog, right? You might actually, you
[07:21] know, read it and then you might
[07:22] actually put some attention on the on
[07:25] the nouns first, the the cat and the
[07:27] dog, right? And then, you know, from
[07:30] these you might look into the verb here,
[07:33] chased, right? So, your attention is
[07:36] going to jump around wildly um as you
[07:39] analyze this prefix before you come up
[07:41] with the distribution of the next token.
[07:44] However, this is not allowed in causal
[07:48] attention. In causal attention, even in
[07:50] intermediate processing, you are
[07:52] strictly only allowed to look back as
[07:55] you do that. So, it's a bit of a
[07:56] technical argument, but keep in mind
[07:59] that you are in fact doing a a tradeoff
[08:03] to train these things more effectively,
[08:05] because um
[08:07] that allows you that the same
[08:08] computation you're doing for this prefix
[08:11] are also valid for this prefix and are
[08:13] also valid for this prefix right here.
[08:16] I keep repeating this in videos because
[08:18] I do feel like it shouldn't go out of
[08:21] collective consciousness that we are
[08:24] doing a pretty serious tradeoff here
[08:27] when we are applying causal attention
[08:30] that is seriously restricting the um
[08:34] compu- like the what would be
[08:36] theoretically possible in terms of
[08:38] attention patterns.
[08:40] Nevertheless, um
[08:41] this causal attention, it basically
[08:43] reduces to to
[08:45] during inference time, um do one token
[08:48] at a time.
[08:49] There is another thing called diffusion
[08:51] language model. Now, in diffusion
[08:53] language model, what you're doing is you
[08:55] have a prefix, right? And
[08:58] you are again, there's layer, layer,
[09:01] layer, right? You you process the
[09:03] signal, yada yada yada, and
[09:05] and you are generating all of the future
[09:09] at once. Uh there's also different
[09:12] strategies where, you know, you you have
[09:14] different masking patterns and whatnot,
[09:17] um but you're basically just generating
[09:20] all of the future at once. So, you are
[09:23] going to come up
[09:24] at the end of this process here, you're
[09:26] going to come up for every token that
[09:29] you are interested in, right?
[09:31] For every future token, you are going to
[09:33] come up with a distribution over
[09:36] like over the vocabulary
[09:39] and
[09:40] jointly, right? So, in this case, let's
[09:43] say we predict uh four tokens,
[09:46] right? And you can hopefully observe
[09:48] that you're only getting marginals.
[09:51] You're only getting marginal
[09:52] distribution for each of the four
[09:53] tokens.
[09:54] Meaning that um if you now want to
[09:57] produce text, you're going to sample
[09:59] from this distribution for the first,
[10:01] uh, token or the fifth token, from this
[10:03] for the sixth, from this from the
[10:05] seventh, and from this for for the
[10:07] eighth. And that's bad because this
[10:10] completely disregards any interaction
[10:13] that these things might have, right?
[10:15] Like, whether or not here you actually
[10:17] sample a verb or an adverb, right? Which
[10:20] which would both be possible, but that's
[10:23] going to determine what should come back
[10:25] here. However,
[10:27] um,
[10:28] if you simply sample from the marginals,
[10:31] that that does not that doesn't happen.
[10:34] There's no, um,
[10:36] influence between these. There is
[10:38] definitely influence as you compute
[10:40] these tokens, but the sampling processes
[10:43] are, um,
[10:44] are
[10:46] distinct from from one another, and they
[10:48] don't consider you they don't consider
[10:50] you can't sample one and then compute
[10:53] the other one because that would be
[10:54] autoregressive, and that's exactly where
[10:56] you you're back to this situation right
[10:58] here.
[11:00] So, the diffusion language models, um,
[11:02] by the way, they're trained by you
[11:04] simply taking a full sentence and then
[11:06] just masking some stuff out and then
[11:09] trying to to predict those, um,
[11:13] to predict those things. If you've ever
[11:16] seen something like BERT,
[11:19] that's what that is.
[11:22] Uh, it's interesting that we're we're
[11:24] back to BERT for language, um, modeling
[11:27] a generative language modeling because I
[11:29] remember when BERT came out, like, the
[11:31] whole world was trying to do it, and it
[11:33] just kind of didn't work. Um, so, we've
[11:36] we've gotten better at a lot of stuff
[11:38] here, and it's interesting that a a
[11:40] method that was basically, you know,
[11:42] discarded being like, oh, no, it doesn't
[11:44] work with the masked language modeling,
[11:47] um, is now making a comeback.
[11:51] So,
[11:52] why
[11:53] the like, which one's better?
[11:55] Autoregressive one gives you better
[11:57] quality because it's principled, right?
[12:01] Like, it's basically says, "Okay, I'm
[12:03] going to produce one token based on all
[12:05] of the tokens that I know of, and then
[12:07] I'm going to sample it." And once I've
[12:09] determined the token, I'm going to
[12:11] produce the next token from all the ones
[12:14] that I know.
[12:15] Whereas, the diffusion language model is
[12:16] faster because it can generate many
[12:19] things at once. Um, however, uh, due to
[12:23] you only sampling from the marginals,
[12:26] uh, there it there is no interaction,
[12:29] and typically your performance degrades.
[12:33] Um, by the way, this distribution right
[12:35] here, yeah, it doesn't know, even if
[12:38] it's the perfect distribution, it
[12:39] doesn't know what you're going to sample
[12:41] here. So, it cannot it cannot it can
[12:44] only be based on the marginal
[12:47] distribution here. Uh, it can only it
[12:49] cannot be based on what you actually end
[12:52] up sampling, right?
[12:56] Okay.
[12:57] So,
[12:59] autoregressive is better. If possible,
[13:01] we would want to produce, uh, the
[13:03] sequence autoregressively, but diffusion
[13:05] is faster. So, how can we do these two?
[13:07] Now, the last thing that you need is,
[13:10] uh, to know is speculative decoding.
[13:12] Speculative decoding comes down here in
[13:16] related work somewhere. So, speculative
[13:18] decoding is a really interesting, um,
[13:21] technique, and, um,
[13:24] it comes back to this to this fact right
[13:26] here of parallelizing training in, um,
[13:31] in autoregressive models. So, why can't
[13:34] we just parallelize, um,
[13:37] the inference in the same way as we
[13:40] parallelize training in autoregressive
[13:42] models? Well, because during training,
[13:45] we know the whole future already, right?
[13:48] We know the whole future.
[13:50] So, we know all the tokens already, so
[13:52] we can compute everything in parallel.
[13:55] Whereas, during inference, we don't know
[13:57] the future. Like, legitimately, we don't
[13:59] know what's going to come next, and
[14:01] therefore, how could we compute, like,
[14:03] for this token right here, how could we
[14:04] compute because we don't know what's
[14:06] coming here?
[14:08] Okay. So,
[14:11] there is a solution here, and the
[14:13] solution is,
[14:14] um,
[14:16] is the following. Imagine for a moment
[14:18] that we're doing greedy sampling, right?
[14:20] We always take the we always take the
[14:23] token with the highest probability.
[14:27] If
[14:28] for some reason, if for some reason I
[14:31] had an oracle,
[14:34] right? I'm in I I need to produce some
[14:36] some, you know, three more tokens right
[14:38] here. I have an oracle here. And the
[14:42] oracle is going to tell me it's going to
[14:43] be B D A here. Right? Tokens B D A.
[14:51] Well, okay, if it's a true oracle, I can
[14:53] just take it, but let's assume that
[14:55] oracle, you know, sometimes it's not
[14:58] really it's kind of lying to me. But if
[15:01] it's if it's lying, um, it lies about
[15:05] all the tokens, and if it's truthful, it
[15:07] it doesn't lie. Like, it gives me the
[15:09] true truth. Um, well, if I have this
[15:12] suggestion, I can just check, right? I
[15:15] can simply, now because I know the
[15:17] future,
[15:20] I can simply check,
[15:21] um, all of these in parallel. Like,
[15:23] okay, given
[15:26] given this prefix, what's the likelihood
[15:29] of the B token? Given this prefix,
[15:31] what's the likelihood of the D token?
[15:33] And given this prefix, what's the
[15:35] likelihood of the A token?
[15:38] I can do all of this in parallel because
[15:40] of causal attention, like during
[15:42] training. So, I can compute all of them
[15:44] in parallel, and if it turns out that
[15:47] indeed the B token is the highest likely
[15:50] for this, um, given the prefix here, the
[15:54] D token is the highest likely for
[15:58] this prefix plus the B token, and the A
[16:01] token is the highest likely for this
[16:04] prefix right here, well, then I know
[16:07] that
[16:08] if I had sampled my sequence using
[16:12] autoregressive decoding, so if I had
[16:14] gone from here and used autoregressive
[16:17] decoding, right? And I had be like,
[16:20] "Okay, what's the most likely token?
[16:22] It's B."
[16:23] Right? Now, give from this prefix,
[16:26] what's the most likely token? It's D.
[16:28] From this prefix, what's the most likely
[16:30] token? It's A. Right? If I had done this
[16:32] autoregressively, I would have gotten
[16:34] the exact same result. So, if I have
[16:37] something that gives me a suggestion,
[16:40] and I can check, sort of compute that
[16:43] suggestion, um, or or check the
[16:46] suggestion,
[16:47] I can do so in parallel.
[16:49] And
[16:51] if it actually turns out that yes, um,
[16:54] had I done the computation in the
[16:57] regular way, I would have come out to
[16:58] the exact same result, then you can
[17:01] hopefully see how this is faster because
[17:03] I can check all of them in parallel.
[17:07] Now, why don't we always do this? Well,
[17:09] we don't always do this because, um,
[17:12] we don't have this oracle. And you might
[17:15] say, "Well, we could just guess, right?
[17:17] We could just take any tokens there."
[17:19] And that's fair, but vocabularies are
[17:21] 32,000 tokens, so the likelihood
[17:25] that you you even going to have the
[17:27] first token correct here is so small.
[17:31] And if you have the first token
[17:32] incorrect, all these computations for
[17:35] the rest, they don't matter because,
[17:37] right? Like, who cares if D is the most
[17:40] likely given
[17:41] the prefix that includes B if B wasn't
[17:45] the token that was actually sam that
[17:47] that was actually sampled. So, that's
[17:49] useless computation. Um, you can still
[17:52] do it in parallel, so you didn't pay
[17:54] really anything for it, but it's kind of
[17:56] useless. So, that's why we don't we
[17:58] don't usually do it.
[18:00] >> [snorts]
[18:00] >> So, what did people So, the whole game
[18:02] here is, can we,
[18:04] um,
[18:05] come up with a technique that gives us a
[18:08] suggestion
[18:09] for the future that is accurate enough
[18:13] so that in a lot of cases, it's actually
[18:16] going to be correct in that yes, um, we
[18:20] can we can quickly check of whether it
[18:23] would give us the same result as the
[18:25] autoregressive model in the first place.
[18:29] Um, and that's speculative decoding. So,
[18:31] what speculative decoding does is it
[18:33] basically goes and it says, "Oh, here
[18:36] you have this prefix, right? Let me use
[18:39] a small, very fast language model.
[18:42] That's kind of a distilled version, an
[18:44] approximation of the big one, and let me
[18:48] quickly produce, um, some tokens, and
[18:51] then let's use the large one to check."
[18:54] And that's
[18:56] um, how we speed up. So, if the time it
[18:59] takes me to do to compute the small
[19:01] model for,
[19:03] let's say,
[19:05] N tokens, um, plus the time it takes me
[19:10] to do the big model,
[19:12] um,
[19:14] to check N tokens, so that's just one
[19:17] token, right? If that is smaller
[19:21] than the time
[19:23] it does it takes me to do the big model
[19:26] for N tokens, then I win.
[19:30] But that's not all because I have to
[19:32] multiply by like some factor alpha right
[19:35] here, uh, because alpha is the
[19:37] likelihood that, um, the small model is
[19:40] actually correct. If the small model
[19:42] isn't correct, then it's probably like 1
[19:45] minus alpha, um,
[19:48] T the big model for N tokens, or I can
[19:52] make it more accurate like however many
[19:55] tokens the small model wasn't correct
[19:57] about, but I hope you get the point,
[19:59] right? Uh it all it's all a question of
[20:03] how uh
[20:05] how good is the small model in giving us
[20:08] accurate um things and how fast is it?
[20:12] Because if it's kind of slow and it
[20:15] doesn't give us that accurate guesses,
[20:17] then running the small model is actually
[20:20] nullifying all the gains that we make by
[20:23] the speculative decoding. It's actually
[20:25] could even hurt. Like if we always run
[20:27] the small model and it's always wrong
[20:29] and then we need need to use the big
[20:31] model anyway, then we've not gained
[20:33] anything. We've actually lost time
[20:35] because we also had to run the small
[20:37] model.
[20:38] So that's where this paper comes in.
[20:40] This paper finds a way to give us these
[20:43] suggestions
[20:45] basically for free.
[20:46] Um because it notices that we do have
[20:49] unused GPU capacity during
[20:52] auto-regressive decoding and that's um
[20:56] that that's basically that capacity that
[20:59] the model can use to compute the
[21:02] suggestions, what they call as a draft
[21:04] um for the next step.
[21:07] So that's the paper. That's this that's
[21:10] what this paper does. It's basically
[21:12] says
[21:14] um
[21:16] we have this architecture that enables
[21:19] parallel token computation from the
[21:21] marginal distribution via diffusion and
[21:24] high-quality sampling from the
[21:26] chain-factorized joint distribution via
[21:29] auto-regression.
[21:30] At each generation step, we partition
[21:33] the tokens into three sections. There
[21:35] are prefix tokens, tokens proposed in
[21:37] the previous step, and tokens
[21:39] pre-drafted for the next step.
[21:42] We reuse the KV cache of prefix tokens
[21:44] from the last step. Tokens proposed from
[21:47] the last steps are auto-regressively
[21:49] sampled via rejection sampling guided by
[21:51] the auto-regressive likelihood
[21:53] computed at the current step. And then
[21:56] they also pre-draft proposals um
[21:59] conditional all possible prefix outcomes
[22:01] of the rejection sampling.
[22:03] This uh this is going to be the topic of
[22:06] what we're going to look into next, but
[22:08] the the last thing I have to explain
[22:10] here is this re- what they call
[22:11] rejection sampling. That's simply so
[22:14] for now we've assumed in speculative
[22:16] decoding that there is like a right
[22:18] token um to sample because we've assumed
[22:21] that you always take the one that's most
[22:22] likely. Obviously, in practice you're
[22:24] not you're going to like sample from
[22:26] this marginal distribution right here.
[22:29] And so you have to imagine that um the
[22:31] situation isn't that
[22:33] the small model is telling you it's B
[22:36] and then the big model is telling you
[22:38] no, it's A and therefore this is wrong,
[22:41] right? Instead, the small model is going
[22:43] to give you some sort of distribution to
[22:46] tell you sorry, this this is a
[22:47] histogram.
[22:49] This is like a histogram that looks in
[22:51] this direction. I hope that's clear.
[22:53] This is the vocabulary on along this
[22:55] axis and then this is the likelihood or
[22:58] or a
[22:59] density or
[23:01] I guess probability for for a discrete
[23:03] distribution.
[23:05] Um and so the the small model will tell
[23:07] you this and the big model is going to
[23:09] give you a also a distribution. Now this
[23:12] distribution is might be similar,
[23:15] right? Like let's say the small model is
[23:17] really accurate, it means that um
[23:21] these distributions are, you know, might
[23:24] be similar uh but they're never
[23:26] obviously going to be exactly the same.
[23:28] Or if the small model is really bad,
[23:30] then these distributions might be
[23:32] dissimilar.
[23:34] So the question is basically um how can
[23:38] we achieve it such that um
[23:42] we can use a a this proposal, this small
[23:46] model, these distributions
[23:48] and still end up uh in a situation that
[23:52] is mathematically exactly the same as if
[23:54] we had used the large model to do
[23:56] auto-regressive sampling. And the answer
[23:58] is rejection sampling. So there is um a
[24:01] technique called rejection
[24:06] rejection sampling.
[24:09] Um by which you can
[24:12] um basically sample from I guess sample
[24:16] from this distribution and then use this
[24:18] distribution here like to compute an
[24:20] acceptance probability by considering
[24:22] the ratio of things. I'm not an expert
[24:25] on rejection sampling.
[24:27] But basically, you can um
[24:30] have a procedure to accept or reject a
[24:33] proposed
[24:35] a proposed sample from um this
[24:39] distribution considering that this
[24:42] distribution here is actually the one
[24:44] that you wanted to sample from in the
[24:46] first place. So that's why you can
[24:49] generate tokens with diffusion and the
[24:52] diffusion tokens are generated with
[24:54] these distributions and then you can use
[24:57] these distributions here in order to
[25:00] decide whether you want to accept them
[25:01] or not. That's just a bit more um
[25:04] involved way
[25:06] um rather than in the greedy case it it
[25:08] just degrades to
[25:10] if the big model sorry, if the big model
[25:14] tells you a different token from the
[25:16] small model, then you know, bad.
[25:20] But in principle is exactly the same
[25:22] thing. You use the large model to check
[25:24] the smaller model and um you can accept
[25:28] the tokens or you can reject the tokens
[25:31] and you always do that in order. So if
[25:33] you accept if you accept um B here
[25:37] um and you and then you reject D, you
[25:40] must also reject A, right? And then
[25:43] you've only accepted B and then from
[25:45] here you continue. And that's exactly
[25:48] the the gist here.
[25:50] So
[25:51] now we dive into the technique. They
[25:53] have a nice diagram here that explains
[25:55] things.
[25:57] Uh da da da da da da.
[25:59] There we go.
[26:01] So this is
[26:03] it's a bit it's a bit involved here, but
[26:06] I do think it actually explains things
[26:08] um quite well. So in this situation,
[26:10] imagine we do already have uh tokens A,
[26:13] B, and C already produced. So that's our
[26:16] prefix, right? We have a KV cache here
[26:19] which is just the KV cache contains the
[26:22] keys and values uh from the attention
[26:24] computation because the keys and values
[26:27] are going to be always the same for the
[26:29] same token at the same position. Um so
[26:32] during auto-regressive decoding, you can
[26:34] actually store them
[26:36] and that means you don't need to compute
[26:37] them again um during
[26:39] uh during the attention computation. You
[26:42] only need to uh compute the queries um
[26:45] from the next token that you consider.
[26:50] So
[26:52] now um
[26:54] imagine, okay,
[26:56] in this situation, yeah, everything's
[26:58] happening at once. Um
[27:02] Let's say we have ABC.
[27:06] And then we would need to produce the
[27:08] next token, okay? Now if we were to just
[27:11] auto-regressively sample here, um we
[27:13] would get D.
[27:15] And that's cool, right? And that's what
[27:17] we would normally already do.
[27:20] All the work that is done in addition to
[27:24] this and they call this free token slots
[27:27] here. All of this work happens in
[27:30] parallel to um the forward pass that
[27:34] samples D um and therefore is kind of
[27:38] free, so to say, because uh we don't
[27:41] waste any time because we're simply
[27:43] using extra capacity in the GPUs to do
[27:46] some.
[27:47] Now
[27:50] let's go back a bit and um
[27:54] say, okay. Let's say we have a we have a
[27:57] proposal.
[27:58] Our proposal is um
[28:02] D E
[28:05] F and we'll see where we get this
[28:07] proposal from.
[28:09] But
[28:10] okay, let's say we have a proposal. Now
[28:12] again, in the same forward pass as we
[28:15] would have simply sampled D
[28:18] auto-regressively, we can now use that
[28:20] forward pass to check D E F to check the
[28:23] sequence D E F following ABC using the
[28:27] auto-regressive model, right? A single
[28:29] forward pass is enough to check all
[28:31] three of them. So let's say, yes, that's
[28:35] good. We accept this. We accept this and
[28:37] this one, you know, the proposal got it
[28:39] wrong, right?
[28:41] But we've made a gain because we've now
[28:43] produced two tokens in one forward pass.
[28:46] So we're twice in this particular step,
[28:49] we're already twice as fast.
[28:51] Um so the question is where does this
[28:54] proposal come from? And that's exactly
[28:56] where um
[28:57] where the diffusion um comes from.
[29:00] Let's assume that I already know
[29:04] that um
[29:06] I already know that um
[29:11] Uh no, let's let's assume for a moment
[29:13] we accept all of them, right? All of
[29:15] them, yeah, correct. Three tokens for
[29:16] the price of one, super good, right?
[29:19] In the in the same forward pass
[29:22] we can do yet another thing. We can
[29:25] already produce the draft, the proposal
[29:29] for the next step.
[29:31] So
[29:32] in this case, we assume that
[29:35] this is the prefix. So the prefix that
[29:39] we have plus the proposal, that's all
[29:41] the prefix and we're going to use a
[29:43] diffusion language model to produce
[29:46] three more tokens, right?
[29:49] G
[29:51] H and I.
[29:54] I'm not even sure if that's the order of
[29:55] the alphabet.
[29:57] Yeah, it is. Okay. So,
[29:59] we're going to use these Now, these are
[30:01] diffused, right? These are Let's call
[30:04] make a small D right here.
[30:06] So, these are diffusion tokens. So, they
[30:11] are not as good as autoregressive
[30:13] tokens, but we can produce them at the
[30:15] same time. And we can do so in the same
[30:17] forward pass, right? So, in the same
[30:20] forward pass, we can use the
[30:21] autoregressive model
[30:24] to check the this draft, right? That's
[30:27] AR
[30:29] AR
[30:30] check.
[30:32] That's a fat marker.
[30:35] And
[30:36] in the same
[30:37] um
[30:38] in the same forward pass, we can use
[30:42] uh
[30:43] diffusion
[30:45] to produce
[30:48] this next draft.
[30:51] So, we're gambling a bit here. We're
[30:53] gambling. We're gambling that if
[30:56] the autoregressive model
[30:59] accepts all three tokens, then we
[31:03] already have this draft for the next
[31:06] step. So, in the next step, it will be
[31:09] Oh, we have A B C D E F and I already
[31:14] have a proposal here, you know, G H I. I
[31:18] already have that proposal right here
[31:21] because
[31:22] I've computed this proposal, this draft,
[31:24] on the basis that this is the prefix.
[31:28] So, the proposal is valid.
[31:30] However, if
[31:32] um
[31:33] let's say the autoregressive model
[31:35] rejects this F token right here. Well,
[31:38] then I have to discard my draft um
[31:40] because the draft is no longer valid
[31:42] because the draft is no longer modeled
[31:45] on um
[31:47] on the the draft's assumed prefix A B C
[31:51] D F isn't the true prefix of the next
[31:54] step. The prefix of the next step is
[31:56] only A B C D E
[31:59] because I've rejected F because
[32:02] um F was a bad
[32:04] choice. Uh the autoregressive model um
[32:08] The rejection sampling can only tell you
[32:10] whether
[32:11] F is is what the autoregressive model
[32:14] would have done or not. It cannot tell
[32:16] you, "Oh, I would have done this other
[32:19] thing." Uh so that you could substitute
[32:21] it. At least not to my knowledge. So,
[32:23] the rejection sampling simply rejects.
[32:25] Um
[32:27] >> [snorts]
[32:28] >> I think it can always produce at least
[32:30] one token. So, you you'll always get at
[32:32] least like it's it's not possible that
[32:34] it rejects D and then doesn't tell you
[32:36] what it wants, I believe at least. I
[32:39] think so, maybe.
[32:42] Maybe I'm wrong about this one. But in
[32:43] any case, I hope you can see that if the
[32:46] autoregressive model accepts
[32:49] the all the the entire draft, then we
[32:52] already can in the same forward pass
[32:54] compute the draft for the next step and
[32:57] go on and go on and go on. The only
[32:59] problem is if the autoregressive model
[33:01] um doesn't accept the whole draft.
[33:03] Well, what we can do is again, we we
[33:06] have some free capacity here. Couldn't
[33:09] we simply
[33:11] um compute all the possible future all
[33:14] the all drafts for all possible
[33:17] outcomes? So, we have A B C, that's the
[33:21] prefix, right? And now
[33:23] what's option one? Option one is we
[33:25] accept D
[33:28] but and accept E
[33:32] and accept F.
[33:34] Option two is we accept D and we accept
[33:37] E but not F. And option three is we only
[33:41] accept D.
[33:43] Or we produce D, right? Like we can
[33:45] always we can always we can always get
[33:47] at least one token out here from this
[33:50] procedure.
[33:52] Couldn't we simply
[33:54] compute the draft here, G
[33:57] H I
[33:58] and here
[33:59] F prime G
[34:02] H and here
[34:04] E double prime F double prime G double
[34:08] prime, right?
[34:09] We could use diffusion language models
[34:12] to compute all of these drafts at the
[34:15] same time. So, no matter what happens,
[34:17] no matter where we land in the rejection
[34:20] sampling
[34:21] we are always going to have a draft for
[34:24] the next step available. So, let's say
[34:27] we're in this situation. Well, the next
[34:29] prefix is A B C D.
[34:32] Well, look at that. I have a draft ready
[34:35] that actually used this as a prefix to
[34:38] compute the draft and therefore is a
[34:40] valid draft and therefore I can use to
[34:43] to check again.
[34:45] So, that's what tighter ultimately ends
[34:48] up doing and that's what this graphic
[34:49] ultimately proposes. So, you can see
[34:52] here
[34:53] we're doing autoregressive decoding in
[34:56] order to check the current draft, right?
[34:58] You can see
[35:00] um for D, the target is E. For E, the
[35:03] target is is F prime or the
[35:05] autoregressive decoding decoded F prime
[35:08] right here.
[35:09] Um
[35:10] so, we are
[35:13] we are
[35:15] So, D and E are accepted, but um since
[35:19] we the F is wrong, the autoregressive
[35:22] model um rather wanted F prime
[35:25] or wanted a different thing.
[35:27] Um we're rejecting F. But we're
[35:30] accepting D and E.
[35:32] Um at the same time, like the the
[35:36] this part here doesn't know yet that the
[35:38] autoregressive part decoded
[35:41] um the wrong thing. So, you have to
[35:42] imagine here
[35:45] here is the step boundary.
[35:48] This time goes like this.
[35:51] So, at the same time as we are doing
[35:53] this uh checking here
[35:56] against the drafts from the last step,
[35:58] we're also computing all the possible
[36:00] futures. So, we're saying, "Well, if
[36:03] we accept D
[36:06] then let's compute a proposal for the
[36:08] next step. But if we compute D and E,
[36:10] let's compute another proposal. And if
[36:12] we compute if we accept D E and F, let's
[36:15] compute another proposal." All at the
[36:17] same time, right? Single forward pass.
[36:20] We're computing all the possible drafts
[36:22] for all the possible futures. And then
[36:24] once we know how many we've accepted,
[36:27] Oh, look, we've accepted D and E. We're
[36:29] simply going to select the proposal that
[36:32] matches that and then we're going into
[36:35] the next step with that proposal.
[36:38] That's it. If you you can do all of that
[36:41] by sort of doing smart attention
[36:44] masking.
[36:46] You can see here this is inference. So,
[36:48] we have our prefix tokens which we're
[36:50] actually going to put at the end right
[36:52] here
[36:53] um so that we can reuse the same mask
[36:55] and simply shift this border right here
[36:58] depending on the length of the prefix.
[37:00] Like everything else stays the same.
[37:02] Then um
[37:04] you can see that we're we have like a a
[37:06] fixed a fixed length of um diffusion
[37:09] tokens here that we're going to
[37:12] um to produce. But you can see and this
[37:15] is three in this case.
[37:18] So, we have the prefix A B C tokens
[37:22] drafted from the last step, causal
[37:24] attention for those tokens, and then for
[37:26] producing the masks uh for producing the
[37:29] next draft you can see here
[37:32] this
[37:33] is the part where we assume only D is
[37:37] accepted. So, you have attention to D
[37:40] and you have full bidirectional
[37:42] attention like in is like diffusion
[37:45] language models have bidirectional
[37:46] attention.
[37:48] They are not subject to causal masking,
[37:50] which should be obvious.
[37:52] Um this part here is the part that
[37:54] assumes uh D and E are going to be
[37:57] accepted in the future.
[37:59] Uh and again, full bidirectional
[38:01] attention within the
[38:04] masked um within the draft. And then
[38:07] this part here assumes that D E and F
[38:10] are going to be accepted. Um you can see
[38:12] here
[38:13] this attention
[38:15] and
[38:16] and this attention They always
[38:18] everything can always attend to the
[38:21] prefix tokens, right? That's why they're
[38:23] over here.
[38:25] And so, if you structure your mask like
[38:28] this, then you can hopefully see that
[38:32] um
[38:34] you can compute everything at the same
[38:36] time.
[38:37] Right? All of this happens at the same
[38:39] time. Now, you might ask, "Wait a
[38:41] minute.
[38:42] Before
[38:43] I basically my my causal masked look,
[38:47] you know, I had this.
[38:49] Uh let's see. Different color. I had
[38:52] this here
[38:53] and this.
[38:55] That was That was before.
[38:57] Uh now I have like all of this and all
[39:00] of this. Won't this just blow up my you
[39:03] know, my memory basically? Like am I not
[39:07] just quadratically increasing something
[39:10] right here? And the answer is kind of
[39:12] no. Well, first of all, um you can see
[39:15] with
[39:16] more prefix tokens, it simply grows in
[39:18] this direction. So, all you're doing is
[39:20] you're kind of multiplying by a constant
[39:22] factor in in this size here, like
[39:26] three
[39:27] four. So, you just doing times four
[39:29] here. And the second thing is with
[39:31] things like flash attention, you can
[39:33] actually trade off um memory for
[39:36] compute. And that's exactly what we're
[39:38] what we need, right? We
[39:42] All of this is based on the fact that
[39:44] you we are currently not using all the
[39:47] compute available
[39:49] in the GPUs because we're memory bound.
[39:53] And so
[39:54] this is exactly a way to use that
[39:56] compute. I might be wrong in this
[39:58] actually. I'm just kind of assuming
[39:59] this.
[40:01] I haven't looked into the code. So I
[40:02] might be wrong on this one.
[40:05] But in any case
[40:08] Yeah, the whole point here is that we're
[40:09] using extra compute to compute all these
[40:12] other things, right? Which is basically
[40:15] we get for free because we don't also
[40:17] compute all of these masking
[40:20] sorry all of these drafts for the future
[40:22] which we basically get for free because
[40:24] that extra compute is just unused
[40:27] currently.
[40:28] During training
[40:31] it's pretty simple. We
[40:33] use block
[40:35] block diffusion. So we assume full
[40:38] prefix attention and then
[40:41] for
[40:42] we can use and you can see here
[40:44] hopefully in the position. This is 0 1 2
[40:48] 0 1 2 3 4 5 3 4 5
[40:52] So we're using the same tokens to do
[40:55] auto regressive loss function and masked
[41:00] language modeling loss function in in
[41:02] the block attention.
[41:04] So that it's not full diffusion masked
[41:07] language modeling everything can attend
[41:09] to everything. But it is
[41:12] block wise. So within the block
[41:15] diffusion and the block is exactly the
[41:17] same size that we want our drafts to be
[41:21] long in the future.
[41:23] So you can use the same forward pass not
[41:26] just during inference to compute all
[41:27] this stuff but also during training you
[41:29] can use the same forward pass to compute
[41:32] the loss function for the auto
[41:33] regressive model and you can you compute
[41:36] the loss function for the diffusion In
[41:38] fact, they can be the same model, right?
[41:42] And that's maybe the trade-off that
[41:43] we're doing right here in that
[41:46] um
[41:47] you now have to train the same model to
[41:49] do these two different things diffusion
[41:52] language modeling and auto regressive
[41:55] language modeling.
[41:57] I'm not sure how much how hurtful that
[41:59] is because ultimately they are doing the
[42:01] same task and they might even benefit
[42:03] from from each other's computation.
[42:06] But the same would be true. Like you can
[42:08] also imagine two parallel models here
[42:11] that train
[42:13] uh
[42:14] each of each of them has their own task.
[42:18] One is an auto regressive one is for
[42:20] auto regressive modeling and one is for
[42:21] diffusion modeling.
[42:23] Um that would just be some more
[42:25] parameters. So you have the freedom to
[42:27] shift these things around.
[42:29] That's basically it. They add these two
[42:31] losses together with factor of alpha and
[42:36] alpha is just one. So they they just add
[42:38] the losses together from the diffusion
[42:40] language modeling and the
[42:43] um auto regressive language modeling.
[42:46] And yeah, they say it has no no hyper
[42:49] parameters to tune during inference. And
[42:52] that's mainly because it doesn't do very
[42:54] fancy masking strategies. It just kind
[42:56] of always masks everything because when
[42:59] it produces a draft it wants to produce
[43:02] all the tokens of the draft at the same
[43:05] time, right? That that um because it's
[43:08] just a draft and you have the auto
[43:09] regressive model anyway.
[43:11] You don't have to have these fancy
[43:13] masking strategies or unmasking
[43:15] strategies
[43:17] that typically control the trade-off in
[43:19] diffusion models. However, it's not
[43:21] excluded. You could definitely imagine a
[43:23] world where you use some fancy demasking
[43:26] strategies there
[43:28] but invest a bit more time into the
[43:30] diffusion draft. Let's say you have to
[43:33] do a couple of you know forward passes
[43:35] but in each forward pass you uncover I
[43:37] don't know five tokens in some fancy
[43:39] masking strategy.
[43:41] You might still be better off
[43:44] doing that and then using the whole
[43:46] thing as a draft for the auto regressive
[43:48] model rather than you know using these
[43:50] forward passes to do auto regressive
[43:52] decoding. It all depends on how good
[43:55] the diffusion model is in giving you
[43:58] accurate suggestions.
[44:00] And in this particular case right here
[44:02] it it doesn't really because the compute
[44:05] is quote unquote free. That's the
[44:07] special case here.
[44:09] Because we produce all at the same time
[44:11] it's you can achieve that in a single
[44:13] forward pass and that can be the same
[44:15] forward pass that you're using anyway to
[44:18] auto regressively decode the next token.
[44:23] All [snorts] right.
[44:24] Experiments.
[44:26] You can see this section is relatively
[44:28] left blank by me and that's because I
[44:31] feel like that the um
[44:33] the
[44:36] the introduction here and the abstract
[44:37] already summarized the main experimental
[44:40] results quite well and that is that you
[44:44] get a similar performance than auto
[44:47] regressive models but you get a massive
[44:50] speed up
[44:51] because you are now
[44:53] um simply checking the drafts which is a
[44:56] lot faster. So
[44:58] that's this section right here
[45:01] saying um
[45:05] So they're they're using this at 1.5
[45:08] billion parameters scales. Thanks to
[45:10] parallel drafting and sampling as well
[45:11] as the exact KV cache support tighter
[45:14] out performs speculative decoding in
[45:15] measured throughput and surpasses
[45:18] diffusion models like Dream and Lada in
[45:20] both efficiency and quality.
[45:23] Most notably tighter is the first
[45:25] architecture to close the quality gap
[45:27] with auto regressive models while
[45:29] delivering four to five x or six x more
[45:32] tokens per second. That's pretty insane
[45:35] and again
[45:36] um
[45:38] they
[45:40] close the quality gap with auto
[45:41] regressive models meaning that it's well
[45:43] since you're mathematically equivalent
[45:46] than the auto regressive sampling the
[45:49] only downside you have really is that
[45:51] you are training your model with this
[45:54] auxiliary loss
[45:56] which is the diffusion
[45:58] loss rather than the pure next token
[46:01] prediction loss. And again since it's
[46:03] for the same task it might not be that
[46:06] much of a hindrance.
[46:07] But that's kind of the only trade-off
[46:09] you have versus pure auto regressive
[46:11] models. So it's not hard to believe that
[46:13] this model actually closes the gap. So
[46:16] is as good as auto regressive models
[46:19] while being
[46:20] a lot faster. And then against other
[46:23] diffusion models
[46:25] it's faster or also fast but is much
[46:30] higher in quality because at the end
[46:32] again it it samples like an auto
[46:35] regressive model.
[46:37] Cool. That was it for the paper. Again,
[46:40] I enjoyed this one. It's pretty cool.
[46:43] It's observes
[46:45] some
[46:46] some opportunity and
[46:49] it smartly uses it and yeah, pretty
[46:53] nice.
[46:56] Um that's all I have to say about the
[46:58] paper. Thanks so much for listening and
[46:59] I'll see you around. Bye-bye.

---

## Metadata
- Channel: Yannic Kilcher
- Published: 20251227
- Duration: 47:02
- Views: 19998
- Video ID: taCVT5vDAk0
