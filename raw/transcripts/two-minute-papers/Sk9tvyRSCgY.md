# two-minute-papers - Sk9tvyRSCgY

Source: https://youtube.com/watch?v=Sk9tvyRSCgY
Fetched: 2026-04-23T09:23:42.514791
Duration: 11:55
Published: 20260416
Views: 134521

---

[00:00] Google DeepMind gave an amazing gift to humanity. 
And it is full of surprises. Here’s why. Today,  
[00:08] we are living in the age of AI where these 
smart assistants and agents can do things  
[00:13] we could only dream of 10 years ago. But. 
Many of these solutions are proprietary,  
[00:20] require a subscription, and run in the cloud.
And then this happens. Yup, some OpenClaw users  
[00:28] reported losing access to their Claude 
AI subscription citing “heavy workloads”.
[00:33] Now, maybe they did something unsavory, I don’t 
know. I also understand you pay a fixed rate,  
[00:40] you can’t eat all you want. 
I respect that. However,  
[00:44] this is the point. We have to rely on the 
goodwill of these companies for our workflows.
[00:49] So this is why I keep saying over and over that we  
[00:53] should always look for options where you 
we own these AIs and run them on our own  
[00:58] systems for free, forever.
No one can take them away.
[01:02] NVIDIA came out with their Nemotron 3 Super,  
[01:06] which has super capabilities…but its 
hardware requirements are also super. 
[01:13] Not so much with Google DeepMind’s new AI, Gemma 
4. This is a free and open family of models,  
[01:20] and yes, finally, the smallest ones 
require only a few gigabytes of memory.
[01:27] No need for an expensive GPU. So much so that 
I wanted to wait a bit before publishing this  
[01:33] video to see how you Fellow Scholars use 
it in practice. And…look at that! It runs  
[01:41] on your phone without an internet connection. 
And folks are already using it in practice to  
[01:47] create offline translation and summarization 
apps. Also, real time image classification  
[01:54] running in your browser while talking like a 
bard? No problem. You can already fine tune it  
[02:01] with Matt’s work. It is so good, it has a little 
ecosystem around it already in just a few days.  
[02:11] Because of the brilliance of 
you Fellow Scholars. Nice work.
[02:16] But it gets better. You see, the smallest Gemma is 
so small, it runs on…oh my. Look…I love that. It  
[02:27] runs even on an old beat up nintendo switch, 
first generation. Not exactly something with  
[02:34] a lot of memory or processing power. Still 
runs the 2 billion parameter Gemma 4 model.
[02:39] Now that is a gift to humanity. But 
it gets really strange from here  
[02:45] on out. Here are 4 things that I found 
really surprising. Dear Fellow Scholars,  
[02:50] this is Two Minute Papers 
with Dr. Károly Zsolnai-Fehér.
[02:53] One, they also have a bigger, 31B 
model which was the #3 best open model,  
[03:00] and now hold on to your papers Fellow 
Scholars, because it beat some models  
[03:07] that are 10 times larger. And still 
competitive with some that are 20 times  
[03:13] larger. On some measurements. And it is a 
dense model. What? What is going on here?
[03:24] You see, many of the modern AI systems 
you encounter are what they call mixture  
[03:29] of experts models. MoE. These are 
huge AI models with many parameters,  
[03:36] and to make sure we don’t burn down all of our 
hardware using them, it splits up this big brain  
[03:41] into many small ones. If you have a biology 
question, it chops it up into small parts,  
[03:47] and routes them to the parts of the brain that 
it thinks are the best experts at processing it.  
[03:53] Typically, to the top 2 to 8 experts. Only 
ask them. Yes, with that, we only activate one  
[04:02] small part of a brain at a time. It makes 
sense, right? It’s not a simple process,  
[04:08] but it is possible. This enables us to create 
huge intelligent models that are still efficient.
[04:15] Dense models, however, just light up every 
parameter of the system. These are not new,  
[04:23] and in some ways, these are very 
inefficient. You light up all the  
[04:28] 31 billion parameters in the brain all 
the time, no matter how simple or complex  
[04:34] the question is. But this one…this 
one is somehow magically good. How?
[04:41] They did four amazing things: one, Google 
didn’t just dump half the internet into it  
[04:47] to learn about us. They apply super strict 
filters to give it only highly curated  
[04:53] training data. That is actually good advice 
for our thinking too. Don’t let everything in,  
[05:01] curate your information diet. There is lots of 
noise out there - ignore it. That is excellent.
[05:09] Two, they use an interesting attention 
mechanism that has a sliding window and  
[05:15] also global attention at the same time. What 
does that mean? Well, when you read a book,  
[05:23] you read it line by line to finish a page. That is 
a local sliding window. With that, you get all the  
[05:31] details. But sometimes you want to zoom out and 
ask, okay, what book are we reading? Which chapter  
[05:39] is this? That is global attention. Here, they use 
both, and call the mechanism hybrid attention.
[05:47] Three, it is better at understanding images. 
You know, Gemma 3 had weird glasses on,  
[05:54] and its image understanding was kind of 
a lie. If you gave it a landscape image,  
[06:00] it squished it back to a square image before 
processing it, losing some information. It  
[06:06] squishes everything into its own preconceived box. 
Not good. Gemma 4 understands the image as-is,  
[06:15] and the difference really shows on any 
benchmark that has to do with images.
[06:20] Four, it has a shared KV-cache. 
KV-cache is short term memory for  
[06:26] what you are currently talking with it, 
documents, questions. Now the layers of  
[06:31] this neural network like to recompute their 
fresh memory from scratch. This one doesn’t,  
[06:37] it essentially borrows the memory already computed 
by earlier layers. Less work, nearly the same  
[06:45] result. This is one of those ideas where we are 
wondering why we didn’t always do it like this.
[06:52] Okay, and all this was just part of my first 
surprise. Second surprise. It is fantastic at  
[07:00] agentic workflows. This is where we don’t just 
have an AI assistant that spits out a bunch of  
[07:06] text, this is when we give it arms and legs and 
ask it to do stuff. Tool use, local coding, and  
[07:14] a ton more. Plug it into OpenClaw and it can book 
a plane ticket. Look for news and summarize it  
[07:21] in a more unbiased way. Or write silly emails to 
Károly from Two Minute Papers. That sort of thing.  
[07:30] It is really good at that. So when any company 
decides that you can’t use their system anymore,  
[07:38] that’s alright. Just plug in Gemma 4, and you 
are good to go. For free. People find that if  
[07:44] you give it custom instructions, sometimes you 
don’t even notice the difference. That is huge.
[07:51] Surprise number three, the context window was 
improved to 256k, twice as big as Gemma 3 had.  
[07:59] This is pretty expensive to compute, so don’t 
take it for granted. Here, you are not going  
[08:05] to chuck gigabytes of movies into it, but for 
a few long documents, it is perfectly fine.
[08:11] Four, the license. Oh my, the license. This 
one gets overlooked so much. Gemma 3 came with  
[08:20] a Gemma license. In other words, it comes with 
strings attached. The model comes with handcuffs,  
[08:28] if you will. If you use it to create training data 
for a derivative model. Yup, that one inherits the  
[08:36] handcuffs too. But, with Gemma 4, not anymore. 
Look, Apache 2.0 license. Now we’re talking,  
[08:48] yes! This license is true to the open 
source spirit. You can modify it,  
[08:52] sell it, deploy it commercially with 
almost zero friction. Make derivative  
[08:57] models, do a ton of stuff with far fewer 
restrictions. This is huge. Thank you so much!
[09:07] Now, not even this technique is perfect. 
For instance, the model does not have a  
[09:12] live database. Without an agent harness, it 
cannot browse or look up stuff. Meaning? Well,  
[09:20] meaning that it can be confidently incorrect. 
The internet special. Also for highly complex,  
[09:29] open-ended tasks - it’s not great at that. Or,  
[09:33] when you have images with lots of high-frequency 
visual details, thin structures, blades of grass,  
[09:40] or a fence from far away. Not great at that, 
it’s going to need even better glasses.
[09:47] But, adding this all up, this is an amazing 
gift to humanity, one that cannot be taken from  
[09:54] us. This is not for Mr moneybags, this 
is for the little man, and it is free,  
[09:59] for all of us, forever. Hugely appreciated. 
Absolutely loving it. What a time to be alive!  
[10:09] Also, I waited with this video because I did 
not just want to take the marketing messaging  
[10:14] and copy-paste it to you. I wanted to see how 
you Fellow Scholars are actually using it in  
[10:20] practice. Read through your experiences 
with it. Does it really work in practice?  
[10:25] Super important. That’s what we are here 
for, not the copy-pasted media headlines.
[10:32] That needs time. Trying to explain all this in 
simple words also takes time. I don’t have a  
[10:39] team here, I do everything from the writing to 
recording, video editing. I am trying my best  
[10:47] here. But it gives you more accurate information, 
and that is the most important for me.
[10:54] So, now, after 10 million downloads in the 
first week and more thorough testing. My  
[11:00] opinion is that yes, this thing rocks. I would 
like to send a big thank you to every single  
[11:07] scientist who worked on this! And hold on to 
this one for dear life because a frontier model  
[11:14] just got locked down for a few select clients. 
You know, it’s a big club. And we ain’t in it.
[11:21] If you enjoyed this, consider 
subscribing and hitting that bell.

---

## Metadata
- Channel: Two Minute Papers
- Published: 20260416
- Duration: 11:55
- Views: 134521
- Video ID: Sk9tvyRSCgY
