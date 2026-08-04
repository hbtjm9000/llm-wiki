# two-minute-papers - ssbHkYB0jYM

Source: https://youtube.com/watch?v=ssbHkYB0jYM
Fetched: 2026-04-23T09:23:54.649159
Duration: 10:42
Published: 20260307
Views: 72180

---

[00:00] This absolutely incredible paper from the 
Google DeepMind lab promises something that  
[00:05] sounds like science fiction. Full 4 dimensional 
reconstruction of scenes. Hmm. Does this mean that  
[00:13] things disappear into another spatial dimension 
like in this game called Miegakure? No. No,  
[00:21] because this game is in the works and it has 
been for more than 11 years now. Wow. Okay,  
[00:27] I won’t say anything because I also worked on 
this research paper called Gaussian Material  
[00:32] Synthesis that took me 3,000 work hours 
to finish. And while I was working on it,  
[00:38] no papers appeared and people thought I was dead.
[00:42] God, I haven’t even started the episode and we’ve 
gone off the rails already. Okay, Károly, focus.
[00:48] Okay, so what is this 4D thing? Well, 3 
spatial dimensions, and 1 dimension that  
[00:54] is time. It’s not crazy wormholes, it’s 
worse! It’s like building IKEA furniture,  
[01:00] but as you start tightening the 
screws, the cabinet is running away.
[01:05] Okay, so what the heck is this crazy person 
talking about. So in goes a video of a scene  
[01:12] of your choice. And out comes a virtual version 
of it in the form of a point cloud. However,  
[01:18] the catch is that things are allowed 
to move around as they please.
[01:23] And this is fantastic, I mean look at 
these highly dynamic judo scenes and all  
[01:28] kinds of craziness, and it understands how 
these points are moving around over time. 
[01:34] I am always fascinated by the fact 
that an AI can look at a 2D photograph,  
[01:40] and understand the underlying spatial reality. 
This is just a bunch of numbers for them,  
[01:46] yet they understand what is close and what is 
far away. Crazy. We humans are good at that,  
[01:53] but we have a brain that evolved for that for 
millions of years. And this is just a bunch  
[01:59] of sand that learned to think. So that 
is already amazing. But it gets better.
[02:05] DeepMind says it could have 
unlimited applications, yes,  
[02:10] unlimited power! Woo-hoo! Károly. Ok, ok.
[02:15] Now performing this is really tough. 
Previous techniques could do this kind  
[02:20] of 4D reconstruction, but you needed a bunch 
of specialized models for it. You’d have one  
[02:26] AI for depth, another for motion, and a third 
for camera angles. And then you have to glue  
[02:33] all of these together into an abomination. 
Using the abomination requires a technique  
[02:39] called test-time optimization. Yes. Here, 
your computer sits there sweating for minutes,  
[02:46] trying to make the different models agree with 
each other so the geometry doesn't fall apart.
[02:52] Now this new technique doesn’t do that. This 
is called D4RT, if you want to sound cool,  
[02:59] pronounce it as dart. Now this one uses one 
AI technique. Just one transformer. Everything  
[03:06] that you see here in the middle is just part of 
one thing. And this one thing can handle depth,  
[03:12] motion, and camera pose simultaneously 
without needing them to talk to each other.
[03:18] But it gets better. A lot better. It can even 
track through occlusion. It is able to guess  
[03:25] where these points are, even if it doesn’t 
see them. How on Earth is that possible? Well,  
[03:31] these points we have seen before, 
and will see again, so it is able  
[03:36] to make an educated guess as to where they 
are, even if it doesn’t see them. Crazy.
[03:43] And it can reconstruct massive scenes by  
[03:46] just briefly looking through 
them. Absolutely incredible.
[03:50] Now hold on to your papers Fellow Scholars, 
because as a result, it is incredibly fast. I  
[03:56] mean, wow. Look at how it compares to previous 
techniques. Depending on what you compare to,  
[04:02] it is up to 300 times faster. That is mind 
blowing. I’ll tell you in a moment how it works.
[04:11] Now, wait wait wait. Hold the phone. we 
can represent scenes in other ways too,  
[04:17] not just with point clouds. Most games 
and animation movies use 3D mesh geometry,  
[04:22] and Gaussian Splats are also the new 
rage. How does this relate to those?
[04:28] It is better and also worse in 3 ways.
[04:32] First, it excels at handling motion. While 
meshes and splats often struggle with ghosting,  
[04:38] leaving behind artifacts as objects move, 
D4RT treats movement as a core part of  
[04:44] the math. Second, it is up to 300x faster 
than previous methods. It skips the slow,  
[04:51] iterative optimization loops that Gaussian 
splats usually require. Third, the model  
[04:56] recovers depth, tracks, and camera parameters 
simultaneously. These are incredibly appealing.
[05:03] However, let’s not overstate things here. Now 
come the bad news. 3 things it is not so good  
[05:09] at. Because it outputs a point cloud, the data 
is let’s say unintelligent. It’s just a bunch  
[05:16] of dots. You can't 3D print it or use it for 
physics collisions without an extra meshing step.  
[05:23] It is also not meant to look pretty. 
Meshes and Gaussian Splats remain the  
[05:29] kings of photorealistic reflections while D4RT 
focuses strictly on geometric accuracy. Finally,  
[05:36] it is worse for editing, because 
without the structured faces of a mesh,  
[05:41] you can't exactly hop into Blender 
and sculpt it like digital clay.
[05:46] Okay, so how is all this incredible work possible? 
How do we assemble that cabinet that wants to  
[05:52] run away? Dear Fellow Scholars, this is Two 
Minute Papers with Dr. Károly Zsolnai-Fehér. 
[05:57] First, the encoder. This is a master 
carpenter. This looks at the scene and  
[06:03] tries to understand the past and the 
present of the furniture. Understand  
[06:09] what it’s about. This they call 
a global scene representation.
[06:13] Then, we get the decoder. These are the magic 
elves. Now let’s build. Here comes the genius  
[06:20] part. Instead of trying to build the whole 
cabinet at once, which is heavy and slow. Yes,  
[06:28] we all know that from building IKEA furniture. 
How the heck can this box have 100 screws? No  
[06:35] one knows. Okay, so the carpenter just 
points to a spot and yells at a tiny  
[06:41] elf: “Hey YOU! Yes, you! Where is 
this specific screw at timestamp 10?"
[06:46] The elf, which is the query grabs the info 
and zaps the screw into existence. Now here  
[06:53] comes the genius part. Elves don’t 
need to talk to each other. Oh yes,  
[06:59] finally! So because of that, you can have 10 
elves or 1,000,000 elves doesn’t matter. Yes,  
[07:06] the technique is completely parallelizable! That 
is the other reason why it is so bloody fast.
[07:13] And here is the kicker. The decoder, so the elves 
see in a way that is a bit blurry. They have  
[07:20] terrible eyesight, so the objects they are working 
on become a bit blurry. So scientists say, let’s  
[07:27] give them magic glasses. How? Well, by feeding 
the technique the original, high-resolution video  
[07:34] pixels back into the decoder. So this is what 
they saw before, and this is what they see now.  
[07:42] That is insane, because now it can reconstruct 
details finer than the AI's own internal brain!
[07:49] But I haven’t explained the part where the cabinet 
wants to run away. How do we handle that? Well,  
[07:55] in a normal 3D scan, if the camera 
can't see the leg of the cabinet,  
[08:00] the computer just gives up. Incomplete 
information and moving things cannot be  
[08:05] handled well. They just leave a giant 
hole in your geometry. Total disaster.
[08:10] But remember, our master carpenter is not 
looking at just one photo. He has watched  
[08:17] the entire video tape from start to finish. He 
has seen the past, and the present. So when the  
[08:23] cabinet leg disappears behind the sofa, 
the elf cries out, "Master! The screw is  
[08:29] gone! I cannot build what I cannot see!" 
I do not know why an elf has this voice.
[08:35] Now, the wise carpenter smiles and says: 
"Relax. I saw that screw five seconds ago,  
[08:41] and I see it pop out the other side 
five seconds later. Based on that,  
[08:46] right now, it is hiding... exactly here!”
And boom! The elf is now suddenly able to assemble  
[08:54] the cabinet. In other words, this is how it tracks 
through occlusion and disappearing information.
[09:01] Now surprisingly, there is more to learn 
here. Listen. The elves build the scene  
[09:06] 300x faster because they do not talk 
to each other. That is excellent life  
[09:12] advice. Sometimes collaboration has a tax. 
Sometimes instead you need to create a few  
[09:19] hours of zero-communication deep work blocks 
where you are unreachable. Whenever I do that,  
[09:26] I am often surprised by how much 
I can get done in little time.
[09:30] This is a collaboration between the wizards 
at Google DeepMind, University College London,  
[09:35] and University of Oxford. These are the 
people inventing the power tools of the  
[09:41] future and giving it away for all of us for 
free. Thank you so much! What a time to be alive!
[09:48] So, here you go. A glimpse of the future and 
how digital worlds could be created soon.  
[09:54] A really advanced paper described in simple words 
anyone can understand. If you appreciate that,  
[10:01] make sure to subscribe, hit the bell and 
leave a kind comment. So you’ll get more  
[10:06] videos like this. Don’t worry about 
it, we are all paper addicts here.

---

## Metadata
- Channel: Two Minute Papers
- Published: 20260307
- Duration: 10:42
- Views: 72180
- Video ID: ssbHkYB0jYM
