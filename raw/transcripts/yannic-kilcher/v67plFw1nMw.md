# yannic-kilcher - v67plFw1nMw

Source: https://youtube.com/watch?v=v67plFw1nMw
Fetched: 2026-04-23T09:23:28.082777
Duration: 32:30
Published: 20251214
Views: 22650

---

[00:00] [snorts] Hello. Today we're going to
[00:02] look at Titans learning to memorize at
[00:04] test time. This is a paper by Google
[00:06] research and has been pushed as part of
[00:08] their Nurips publications. So there's a
[00:11] blog post about it and people posted on
[00:14] social media about it and um I have to
[00:17] admit I just fell for the marketing. So
[00:20] here we are. I got interested in this
[00:22] paper and it is a good paper. uh it so
[00:26] it proposes a architecture of a um model
[00:32] u so think of like let's say a language
[00:34] model right that learns to memorize at
[00:37] test time so it can go beyond the
[00:39] current context you can go over a very
[00:42] very long piece of text for example you
[00:44] can slice that into parts and you can go
[00:47] over these parts and you can use this
[00:50] memory to connect to remember stuff from
[00:53] earlier parts and carry them to the next
[00:55] part thereby overcoming the context
[00:58] window limitations uh that are typically
[01:01] associated with something like
[01:02] transformers. So that is very very cool.
[01:06] However, I do find that sometimes they
[01:09] um kind of reinvent old things and um
[01:13] present them as maybe a bit more novel
[01:16] and then other times they just assign
[01:18] names to things to make them seem like
[01:21] they're a new thing. So, a lot of the
[01:23] things they call memory in this paper
[01:26] are
[01:28] basically things that already existed.
[01:31] Um, but we'll get to that. So, I'll say
[01:34] it's a 50/50 split of cool new stuff
[01:37] and, you know, maybe putting a bit the
[01:39] foot on the on that marketing pedal.
[01:43] So, let's dive in. the we're the paper
[01:47] is um also of a decent size and we're
[01:50] just going to tackle the what I feel are
[01:52] the important bits. Um but if you have a
[01:55] different view then um
[01:59] that's that's your right leave a comment
[02:01] and tell me about it. So the problem
[02:05] I've already outlined here in in the
[02:08] most models nowadays like either they
[02:11] are natural sequence model like an RNN
[02:14] an LSTM or something like this but these
[02:16] models have been largely surpassed by
[02:19] attentionbased models like transformers
[02:22] and uh the problem is that the
[02:24] transformer can only attend to things
[02:26] that's in the current context window um
[02:29] and that context window can become very
[02:31] large for some tasks. So think of things
[02:34] like video understanding or you know
[02:37] very long real world tasks right where a
[02:42] lot of things happen and you basically
[02:44] have to consider all of these things in
[02:46] order to make your next move. So the the
[02:50] problem is quite simple. you have some
[02:52] long piece of data and your model only
[02:56] has the capacity to look at maybe data
[02:59] that is you know this oopsie that is
[03:03] this long here. So let's say this is the
[03:07] size of the context window of your
[03:09] model. Now you can place that anywhere
[03:11] like you could place it here right you
[03:13] could place it here and so on. Um, but
[03:16] you cannot push everything into one
[03:19] context window. That would just blow
[03:21] your model out. Um, and so a lot of
[03:25] people have been trying to tackle this
[03:26] like back to the earliest variants um of
[03:30] that followed BERT. People have been
[03:32] trying to come up with u variants that
[03:35] would go to very long context. Um, some
[03:38] of the variants back then make explicit
[03:41] use of something that you might call
[03:43] nowadays memory. So where they say okay
[03:46] let's first consider this part right
[03:48] here and then at the end let's produce
[03:50] some artifact like something and usually
[03:53] that thing is just kind of the the the
[03:55] the key like the some kind of
[03:58] computation
[03:59] um during the last token here because
[04:02] the last token here naturally attends to
[04:04] the whole context right so it kind of
[04:06] integrates something here so let's just
[04:08] take that hidden state and kind of make
[04:10] it available to the next context window
[04:13] so that next context window. Um, when it
[04:16] produces this token here, it cannot
[04:18] attend. So, if it wants to attend to
[04:21] something here, it cannot do that. But
[04:23] it can attend to this thing here. And
[04:27] this thing here supposedly is kind of
[04:29] like a compressed variant of the whole
[04:31] context of here. And now obviously if
[04:33] this thing again has from the last chunk
[04:36] one such thing, then you kind of get a
[04:39] get this also in this. So it kind of
[04:42] acts like an RNN in that it has this
[04:45] kind of state that it passes on to the
[04:47] next thing. Whereas within the context
[04:50] window it acts like a transformer. These
[04:53] were like I don't know things like
[04:55] Xformer or something like a transformer
[04:58] X maybe or transformer XL. I don't
[05:02] remember the exact names but a lot of
[05:04] ideas like this were around. um other
[05:08] ideas and that's mainly the ones um the
[05:10] ones discussed here are ideas around
[05:13] linear transformers. So linear
[05:16] transformers uh there's obviously the
[05:18] basic variant where you just say well
[05:19] instead of doing all that softmax
[05:21] shenanigans let's just make linear
[05:23] operations but then there's also the bit
[05:26] more advanced things that you would find
[05:28] in things like I think like performer or
[05:31] reformer one of them um was was very
[05:35] prominent in that where basically you
[05:38] using kernel functions uh in the
[05:40] attention mechanism in order to um pull
[05:45] it apart. So the way this works is you
[05:47] have your your attention and I think
[05:48] they have
[05:50] down here somewhere, right? They have
[05:53] the formula for attention. Now um
[05:58] basically what what is what is this?
[06:00] Okay, you have your tokens and let's say
[06:02] you produce this next token right here.
[06:04] So you would say okay, I want to produce
[06:07] this token. let me um create the query
[06:10] from this token and let me
[06:13] multiply it by all the keys from these
[06:16] tokens right here. So you produce these
[06:18] queries and the keys and the query is
[06:19] just going to attend to all the keys
[06:22] meaning it's going to create the inner
[06:23] product of the query and the keys and um
[06:28] so the inner product of this query with
[06:30] each of the keys right that gives you
[06:33] basically how much the query matches
[06:36] with each of the keys and then you're
[06:38] going to normalize that using using a
[06:40] softmax operation. So, um, what you're
[06:43] going to end up with is kind of like
[06:45] this distribution, right? So, okay, like
[06:48] key 1 2 3 4 5 key one it matches this
[06:51] much, two this much, three this much and
[06:54] so on. Um,
[06:56] after the softmax, this all sums the sum
[06:59] of this is one, right? This is
[07:02] normalized. So now what you can do is
[07:05] you can use this as basically a waiting
[07:08] function for your values and the values
[07:11] are also computed from this right. Um so
[07:15] you can consider the attention mechanism
[07:17] kind of like this here actually gives
[07:19] you the weights that you use to
[07:21] aggregate the values and um so it's kind
[07:24] of like a um fully connected layer
[07:28] except the weights of the fully
[07:30] connected layer aren't fixed. They are
[07:32] data dependent. and they're sort of
[07:33] computed on the fly by this query key
[07:37] interaction. Um so the the problem here
[07:40] is actually this softmax uh this softmax
[07:43] is an operation that is nonlinear and
[07:46] you you cannot pull it apart right you
[07:49] cannot um if you have a long context you
[07:52] still need to compute everything inside
[07:54] uh because that softmax operation um is
[07:57] not like separable in an easy way. So
[07:59] it's not scalable in an easy way. Now
[08:01] things like fast uh sorry flash
[08:03] attention they manage to kind of trade
[08:06] off um some speed for memory or vice
[08:09] versa but there's no like um closed form
[08:14] nice reformulation you can do
[08:17] uh this isn't the ca so
[08:21] ish uh because because if you're
[08:25] familiar with uh kernelization and the
[08:27] whole kernel literature um you you will
[08:31] notice that okay let's generalize this
[08:33] and let's say okay there's just some
[08:35] nonlinear function here it doesn't need
[08:36] to be softmax just some nonlinear
[08:38] function uh that applies across these
[08:41] things and
[08:44] if under certain conditions right um
[08:49] this nonlinear function um if it is a a
[08:53] kernel this nonlinear function actually
[08:55] describes a distance between these
[08:58] things in this case it kind of does
[09:00] Right? I'm not sure how the
[09:01] normalization plays in here, but in this
[09:03] case, it kind of describes a distance
[09:05] between these two. And that means by the
[09:08] whole kernel literature, which I am not
[09:11] competent in, nor could I recite on the
[09:13] spot, but um if you if you are old
[09:17] school machine learner, you will have
[09:19] learned this at some point. Um then this
[09:22] kernel um well I believe actually this
[09:27] let's say this is like K instead of the
[09:29] soft max so K is just a general function
[09:33] um if that is a kernel that means you
[09:35] can actually like K of Q and K you can
[09:39] separate it into um separable function
[09:44] and this then becomes a true inner
[09:47] product between um 5 Q and five of k.
[09:51] Now what is phi obviously or s or
[09:55] whatever this theta whatever this letter
[09:58] is um what is this? This is a projection
[10:03] a into some a nonlinear projection
[10:06] possibly into some space and in this
[10:10] space um computing this kernel is
[10:13] equivalent to doing this inner product.
[10:15] Now usually we are interested in this
[10:17] direction. Usually we're interested in
[10:19] saying we would like to achieve this
[10:22] inner product between things. Um but you
[10:26] know that's way too high dimensional
[10:28] right sometimes these are infinite
[10:30] dimensional spaces. So why don't we
[10:32] rather just compute this kernel function
[10:35] um because that's you know we can
[10:37] actually evaluate this. However, in the
[10:39] linear transformers case, we're
[10:41] interested in the other direction saying
[10:42] like, hey, look, this soft max here, if
[10:46] we just compute it out, right, this
[10:47] gives us this quadratic blow up and so
[10:49] on. If we could if we knew what this
[10:53] function was for the soft max, right?
[10:56] And the space with where we have to send
[10:58] it to to make these inner products, we
[11:00] could just separately compute this of Q
[11:04] and this of K and then it's just an
[11:05] inner product. And then you know this
[11:08] this whole quadratic blow up we could
[11:10] just separate it because it's a linear
[11:12] operation. And so that's where that's
[11:14] how these linear transformers attack
[11:16] this. They basically I think we have it
[11:19] here. Yep. They basically say okay if we
[11:22] could separate this right and we can do
[11:26] so um under the assumptions that uh this
[11:29] function here is is a kernel then we
[11:33] could just pull this sum here that now
[11:35] goes across everything. Right? we have
[11:36] to first compute this and then do the
[11:38] sum and the normalization. Well, no. Now
[11:42] we can basically do the sum inside right
[11:47] here and only then multiply it by the Q
[11:52] and the normalization is also outside of
[11:56] this of the sum and so that becomes
[11:58] computationally feasible because
[12:01] effectively it's just a linear
[12:03] accumulation. You can see here the keys
[12:06] and values. That's your past, right?
[12:10] That's your that's the past. And you can
[12:13] just accumulate that. And if you if you
[12:15] go to the next token and you have the
[12:17] key and value, all you have to do is you
[12:20] only have to compute this thing here and
[12:23] then add it to the sum that you already
[12:25] have. And because you only need this sum
[12:29] here, you don't whereas with in your
[12:32] original attention,
[12:34] sure you can you can save the keys and
[12:37] the values, but you will still have to
[12:40] do all of this for all the past, right?
[12:43] You multiply the queries by every single
[12:46] one of the key. Then you do your
[12:48] nonlinear operation. Then only then can
[12:50] you multiply by the values. So that's
[12:53] the big thing here. You can multiply by
[12:56] the values first and just accumulate it
[13:00] into one sum and then you can multiply
[13:02] the sum by Q and that's ultimately what
[13:05] saves you all of that what avoids that
[13:07] quadratic blow up. Um only works because
[13:10] it's linear. So that's why they're
[13:12] called linear transformers. Um well okay
[13:16] I believe in history a lot of things
[13:18] were called linear transformers. Um
[13:23] uh Jurgen Schmid Huber is running around
[13:25] and saying that he invented transformers
[13:28] with an asterisk which is he invented
[13:31] unnormalized nonlinear transformers
[13:34] which just means inner products. Um and
[13:37] I'm pretty sure he did not invent inner
[13:39] products. However, this is the variant
[13:43] with linear transformers we uh worry
[13:45] about in this particular paper. Now what
[13:48] they're saying here is that okay
[13:50] actually linear transformers good in
[13:52] concept like good in principle however
[13:55] um I don't think the softmax has an
[13:57] actually computable function so these
[14:01] the the things that we can do are just
[14:03] kind of approximations to the softmax
[14:06] function and um turns out these
[14:09] approximations are actually not good uh
[14:12] because linear transformers aren't very
[14:14] performant nowadays like they're not
[14:16] very competitive
[14:18] Um, and the paper here says, well, the
[14:22] linear transformers do not show
[14:23] competitive performance as the kernel
[14:26] trick makes the model a linear recurrent
[14:28] network. That's what we just discussed
[14:31] in which the data is compressed into a
[14:33] mat into a matrix valued state. Um so
[14:37] they're saying okay because because all
[14:39] the data is compressed into one matrix
[14:41] value state is basically the same as an
[14:43] RNN where you have to compress the
[14:46] entire past into this one vector valued
[14:49] state and it's just impossible to kind
[14:52] of like a very long context cannot be
[14:55] compressed in a small vector valued or
[14:57] matrix valued state and because the
[15:00] transformer doesn't compress it keeps
[15:03] the whole history and then it always
[15:05] computes
[15:06] um the interaction with each of the
[15:08] history. It does not have this problem.
[15:11] This is the first part where I'm
[15:13] skeptical honestly because like I I
[15:16] think this is just a consequence, right?
[15:18] Like the linear transformers could also
[15:20] just keep the whole history and then
[15:22] compute all the interactions. It just
[15:24] turns out that it's formally the same as
[15:27] accumulating them. Right? There's
[15:29] nothing about accumulation that is the
[15:33] bad part here. It's about the the the
[15:36] like you're choosing a function that is
[15:39] worse um to do the interaction with the
[15:42] past. Likewise, if we if we could like
[15:46] if we knew the the kernel expansion
[15:48] function like the up projection for the
[15:50] softmax and we could do so accurately,
[15:53] we would absolutely do that. And then we
[15:55] would like compress like certainly there
[15:58] there is a way to compress the entire
[16:01] history um into a a matrix valued state
[16:06] even in a regular transformer. We just
[16:09] don't know how to do it. uh and then
[16:11] there is a way to interact with that
[16:13] matrix valued state in order to achieve
[16:15] some goal. We just don't know how to do
[16:18] it and um and it's going to be a
[16:20] nonlinear interaction right with that
[16:22] matrix valued state but if if we knew
[16:25] how to do it we would absolutely do it.
[16:27] So to me it's not necessarily about the
[16:29] fact that it compresses anything that is
[16:31] the problem here. Um, but this paper
[16:34] really wants to make this point because
[16:36] they're saying like, well, we shouldn't
[16:38] use matrix valued or vector valued
[16:41] memories. We should use actually a
[16:44] neural network as the memory. And that
[16:46] to me is not a bad idea, but um, so
[16:52] we're we're going to jump a whole bunch
[16:54] of things here because I want to want to
[16:56] get to the point. What they propose here
[17:00] is they're saying well let's just
[17:01] generalize all the architectures um and
[17:04] let's just say
[17:06] actually actually all of these things
[17:10] they basically just like you can see all
[17:13] of these architectures as being sort of
[17:15] having a memory at runtime. For example,
[17:18] a transformer the memory is just the
[17:21] keys and values of the sequence so far.
[17:24] So the memory grows over time, right? In
[17:26] an RNN, the memory is just the hidden
[17:29] state that's, you know, carried from one
[17:32] uh iteration to the next. And that to me
[17:35] is kind of like, okay, you can describe
[17:37] it like this. And then they're saying,
[17:39] let's make that memory more powerful.
[17:43] And so what they come up with, and I
[17:45] think it's best um described in this
[17:47] picture, is
[17:51] here. The memory is actually a neural
[17:55] network, right? The memory is a neural
[17:57] network and uh let me just draw it. So
[18:01] you're you're you have your sequence
[18:03] here, right? Doo and you produce your
[18:06] next token. And every time you have this
[18:09] other thing here called the the memory
[18:13] and every time when you compute this
[18:16] token here, right, you have your your
[18:18] query and you can attend to the current
[18:21] oopsie to the current context, but you
[18:24] can also go to the memory and the memory
[18:28] will give you back stuff. Now I'm
[18:31] deliberately saying stuff here like
[18:35] but the memory will give you back
[18:37] information about the more distant past
[18:41] than your current context window. I mean
[18:44] maybe it can also give you stuff about
[18:46] the current context window but the idea
[18:48] is that the memory gives you back stuff
[18:51] about the more distant past. So now when
[18:53] you do your your attention here you can
[18:56] um yeah you can attend currently but you
[18:59] can also um attend further back by going
[19:02] to the memory. Now if this memory is
[19:05] just as they say oh it's just a matrix
[19:07] valued memory right then what you would
[19:09] do is the way the memory would give you
[19:11] stuff is you just multiply the query by
[19:14] the memory and then that gives you the
[19:17] um or maybe also with the with the
[19:20] values. the memory is like the keys and
[19:22] the values. Um that would give you back
[19:25] your your data here. Um this is actually
[19:29] exactly what happens in the in the
[19:32] linear transformer, right? This is the
[19:34] memory is just the sum of the keys and
[19:36] values. You multiply the Q and you'll
[19:39] get back the result of that. So this is
[19:41] basically what happens in the linear
[19:43] transformer. Um if you yeah if you go if
[19:48] you think of of a real transformer and
[19:50] let's say you just have really long
[19:51] context the memory cannot be represented
[19:54] with a multiplication like this. So you
[19:56] need to do um something else and in
[20:00] general they're saying well the memory
[20:01] should just be like a function where you
[20:03] plug Q in and it gives you back that
[20:05] that data that you need from the past.
[20:08] So the memory is something you stick
[20:11] your query into and you get back data
[20:15] for your current inference. And now
[20:17] obviously the question is well how does
[20:19] that memory look like? And they say well
[20:20] it should be a neural network. It should
[20:22] be a neural network that kind of learns
[20:26] to at test time learns to kind of
[20:30] memorize and compress the data as you
[20:33] are processing it and keep it for a
[20:36] longer time than the current context
[20:39] window. And so let's say this token here
[20:42] goes out of context at some point. The
[20:44] memory, you know, as it was processing,
[20:47] it was learning from all of these
[20:49] tokens. the memory should still be able
[20:51] to tell you something about this token
[20:53] right here and that's the concept and so
[20:55] the memory in their case is like a like
[20:58] a two-layer neural network I think okay
[21:00] you have like your fully connect it's
[21:02] just an MLP these are fully connected
[21:05] layers right your Q goes in here and
[21:08] then your whatever value not referring
[21:11] to the values necessarily of
[21:13] transformers but whatever your resulting
[21:15] value um comes out the other end and So
[21:19] what does it mean to memorize in this
[21:22] paradigm? To memorize means to basically
[21:26] update the parameters of this neural
[21:29] network. Right? So we have an inner
[21:31] learning problem in this meaning at test
[21:34] time we kind of initialize for each
[21:37] let's say we're processing a really long
[21:39] sequence of text right at the beginning
[21:41] we would initialize this memory to some
[21:44] initialization
[21:45] um maybe random maybe fixed
[21:47] initialization and then as we are
[21:50] processing maybe we have a chunked um
[21:53] processing with a transformer as we are
[21:55] processing we're basically updating this
[21:58] memory meaning that we're training ing
[22:00] this neural network on the fly during
[22:03] test time so that later chunks can use
[22:06] it to retrieve stuff. And so the
[22:09] question is obviously yeah how do we how
[22:10] do we do this? And they basically
[22:12] propose to train it with the following
[22:15] loss function. Um
[22:20] they train it to just rem to just
[22:25] remember the associations between the
[22:27] keys and the values.
[22:30] And so they train it because as you are
[22:34] computing these you know individual
[22:36] tokens you always get a key and a value
[22:39] right and what you want is you want
[22:42] basically you want that um if the query
[22:46] is similar to the key it's it should
[22:49] spit out the value. That's what the
[22:51] traditional attention does, right? If
[22:53] the query and the key are very similar
[22:55] inner productwise, it it would spit out
[22:58] the value. And so it's quite natural to
[23:00] say, well, let's just train it at test
[23:03] time so that the if I stick in the key,
[23:06] I want to get out the value. So my loss
[23:09] function is basically that um the the x
[23:13] is the key and the y is the the value
[23:15] and I train it. And that means if I do
[23:17] this well, it means if I way later way
[23:20] later in the sequence have a query that
[23:23] is very similar to this particular key,
[23:25] it will give me this value right here.
[23:27] And so that's how I remember the past.
[23:30] Okay. Um
[23:33] and then they say well they arrive at
[23:36] this loss function um and they say well
[23:38] basically this is the loss function. So
[23:41] what we want to do is we want to train
[23:44] this neural network um um as a function
[23:47] of its surprise.
[23:49] meaning that oh if you know if if an
[23:53] event is very surprising it should
[23:55] remember it and they say well the
[23:59] surprise is measured by the gradient of
[24:01] this loss function right this loss
[24:03] function effectively like let's say you
[24:04] already associate this key with this
[24:06] value um you will have quite zero
[24:09] gradient like okay that's not
[24:11] interesting but um if you don't
[24:14] associate the key with the value yet
[24:16] that's that's kind of very surprising to
[24:19] you. So you want to learn from it and
[24:21] they say okay let's like you should
[24:23] update your memory and the memory here
[24:26] are just the weights of the neural
[24:27] network by this surprise thing. Um
[24:31] and they add to that and say well if
[24:34] maybe the first token is really
[24:36] surprising but then the next tokens
[24:38] aren't really that surprising anymore
[24:39] but you still want to remember that. So
[24:41] there should be kind of a lag in that.
[24:43] And so we're going to include this
[24:45] pasture prize. And then they're saying
[24:47] like, well, this formulation is similar
[24:50] to gradient descent with momentum. It's
[24:52] like, yeah, that's like you just
[24:55] describe regular gradient descent with
[24:57] momentum by like formulating it as
[25:00] surprise. Interestingly, they first say,
[25:04] oh, we want to train with surprise and
[25:06] so on. But I I'm not like you can
[25:10] literally describe any gradient descent
[25:13] procedure as this, right? Um to me that
[25:16] is one of the instances where they just
[25:19] formulate stuff more in accordance with
[25:21] this oh it's memory and all of that. Um
[25:24] where uh I feel like they could just say
[25:28] we train the memory to map the keys to
[25:30] the values and we do it we map it by
[25:33] gradient descent with momentum. And look
[25:36] there is this interpretation of gradient
[25:38] descent where you could say it's you
[25:40] know based on surprise. However, they do
[25:43] it the other way around where they say,
[25:44] "No, no, no. Because this is memory, we
[25:47] want really to it to be based on
[25:48] surprise because this is like very human
[25:51] inspired and so on, right?" And um
[25:56] and then it's like, "Oh, but that turns
[25:58] out to be the same as gradient descent
[26:00] and like well yeah so that this is a bit
[26:03] of of marketing I feel." In any case, so
[26:07] the way this works is as I said you are
[26:10] moving across your sequence. Um as you
[26:13] do so you every every inference time
[26:16] step right you do a little inner
[26:19] training loop or updating that neural
[26:22] network um that neural memory and um you
[26:26] kind of teach it about the current data
[26:28] point um before you [clears throat] go
[26:30] on and the every step also you pass the
[26:34] current query to that neural network and
[26:36] it will give you back basically an
[26:38] aggregate of the past as it refers to
[26:40] that query. So um that's how you train
[26:43] the memory and that's how you retrieve
[26:45] from the memory right so you have your
[26:47] your sequence here and you do attention
[26:50] over the current sequence over what you
[26:52] retrieved from the memory and then over
[26:54] this thing here which they call the
[26:56] persistent memory. So guess what the
[26:58] persistent memory is? It's like, oh, it
[27:01] encapsulates data about the current
[27:04] task. Um, and it's data independent and
[27:09] you can learn it during training. So
[27:12] like this is just parameters. Like this
[27:15] is literally like the fact that it goes
[27:18] here. Um, someone on our Discord said it
[27:21] correctly. This is just prefix tuning
[27:23] effectively, but static, right? So the
[27:26] fact that it goes here has no bearing.
[27:28] It could also be just encapsulated in
[27:30] any of the other parameters of the
[27:32] neural network and it would achieve
[27:34] exactly the same thing. So this to me is
[27:37] again a bit of marketing where they say
[27:39] oh see what you call parameters of a
[27:43] machine learning model. We take just
[27:46] five of them and we call that the
[27:48] persistent task memory that learns about
[27:51] the task which is data independent and
[27:54] you know learned during training. like
[27:56] cool that's you know that we we knew
[28:01] that that
[28:03] um and then they say like well look in
[28:05] transformers you also have these things
[28:08] called fully connected layers which are
[28:11] basically which are basically similar to
[28:14] attention weights but with data
[28:16] independent parameters. So you
[28:19] [laughter] yeah like we like this is
[28:22] literally just a fully connected layer.
[28:26] Um this is so they again they start from
[28:29] this a principle of persistent memory
[28:31] and they're like oh well look it's
[28:33] similar to this other thing we already
[28:35] knew where they could have just said um
[28:38] we learn parameters that's it. So this
[28:42] is my first I will rant for one more
[28:44] time here and um I don't want to I don't
[28:49] want to go through these different
[28:50] variants. They incorporate memory and so
[28:52] on. I feel to me feels that's
[28:54] implementation details and from the
[28:57] experiments it seems like some work here
[29:00] some work there and so on. Um but what I
[29:02] will say is this uh if you have this
[29:06] architecture right and you have this
[29:09] memory and you make a big deal out of
[29:11] the fact that this memory really like
[29:14] the vector valued memory and the matrix
[29:17] valued memory are really not good
[29:18] enough. You need this neural network
[29:21] memory. I disagree. I disagree because
[29:25] this is only valid if you say the way
[29:29] that you store in the memory and the way
[29:32] that you retrieve from the memory must
[29:34] be like linear operations or if you
[29:38] specify that your loss function here is
[29:41] specifically
[29:42] um this square distance right here. Um
[29:47] if I I can absolutely have a vector
[29:53] valued memory
[29:55] and it will do exactly equivalent to
[29:59] their neural networkbased memory if I
[30:02] can like the way I store stuff in the
[30:05] memory is arbitrarily nonlinear like
[30:08] this thing here is a super duper neural
[30:10] network and the way I retrieve from the
[30:12] memory is super duper non nonlinear
[30:16] right like it there's no like data is
[30:20] parameters and parameters is data so
[30:22] whether I store things in a simple
[30:24] vector but I make it very complex to
[30:26] retrieve and to store um to retrieve and
[30:29] to store from the memory or whether um
[30:33] the the retrieving and the storing is
[30:36] very simple um but I make the the the
[30:40] memory here quite complex those are just
[30:44] equivalent things. And so again, I feel
[30:46] like them making such a big deal and
[30:49] multiple times throughout the paper
[30:51] about all these other models, they only
[30:53] have vector valued memories. We have a
[30:56] neural networkbased memory. To me it
[30:58] feels like that is also kind of like um
[31:02] overdoing it with highlighting the
[31:05] differences here where like in practice
[31:08] if you um if you account for
[31:11] equivalences what you're doing is
[31:13] basically you have a bit more fancy way
[31:15] of retrieving and storing from the
[31:18] memory than the others. Um, and the fact
[31:21] you chose to implement this as the
[31:23] weights of a neural network rather than
[31:25] well ultimately you can simply say that
[31:27] the weights of the neural network and
[31:28] just align them in a vector and and and
[31:31] that's what my memory is. So that's it.
[31:34] Um, again I don't necessarily intend to
[31:38] go over the the rest of the paper here.
[31:40] Please read it if you're interested. is
[31:42] actually even though I rant about it is
[31:44] a quite a good paper but I just wanted
[31:46] to bring you sort of the core idea here
[31:49] and um I do believe I do believe
[31:52] memorizing at test time is an very very
[31:55] good idea and we absolutely will need
[31:58] models that do that uh because it's not
[32:00] conceivable to just push context sizes
[32:02] and and sort of huristically extend
[32:04] context sizes in the way that we do
[32:06] right now. So something that actively
[32:09] and purposefully learns to memorize at
[32:11] test time and learns to forget at test
[32:14] time is very necessary. So I think this
[32:18] is a really cool direction and the paper
[32:20] is really good and the models uh they
[32:22] perform well and all of that. Uh so that
[32:24] those are my my final words here. Thank
[32:27] you and I'll see you around. Bye-bye.

---

## Metadata
- Channel: Yannic Kilcher
- Published: 20251214
- Duration: 32:30
- Views: 22650
- Video ID: v67plFw1nMw
