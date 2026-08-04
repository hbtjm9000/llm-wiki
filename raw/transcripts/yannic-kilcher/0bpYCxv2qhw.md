# yannic-kilcher - 0bpYCxv2qhw

Source: https://youtube.com/watch?v=0bpYCxv2qhw
Fetched: 2026-04-23T09:23:38.160599
Duration: 13:19
Published: 20251019
Views: 9181

---

[00:00] Hello, this is in many ways a response
[00:03] video to Theo or T3 GGG's video called
[00:07] MCP is the wrong abstraction and it is
[00:10] also a video about this Cloudflare
[00:12] article which that video is about called
[00:15] code mode the better way to use MCP and
[00:18] I want to show you this article but also
[00:21] point out something that potentially is
[00:23] missed by uh either of these two uh
[00:27] article and the commentary. So here's
[00:30] the core idea of the article voiced by
[00:32] Theo. And that seems to be the direction
[00:34] Cloudflare is leaning into here. As they
[00:36] said, they're trying something
[00:37] different. Converting the MCP tools into
[00:39] Typescript APIs, then asking the LLM to
[00:42] write code to call those APIs instead.
[00:44] The results are striking. We found
[00:45] agents are able to handle many more
[00:47] tools and more complex tools when the
[00:49] tools are presented as a TypeScript API
[00:51] rather than directly. They don't know
[00:53] why this is, but their theories are that
[00:55] this is perhaps because LMS have an
[00:57] enormous amount of real world TypeScript
[00:58] in their training data, but only a small
[01:00] set of contrived examples of tool calls.
[01:03] Very likely. And then point two.
[01:06] So what's the idea here? Um, you just
[01:10] heard it. Let's not do tool calling in a
[01:13] way where we expose this to the LLMs and
[01:16] the LLMs has to in sort of
[01:19] conversational mode say I will use the
[01:21] tool and then emit some token and then
[01:23] emit some JSON for the uh tool calling
[01:26] itself and then we give it back the JSON
[01:29] of the response. rather than that um
[01:32] let's render the tools as an API then
[01:35] let the LLM write code and call that
[01:39] code execute that code and part of that
[01:41] code is actually the tool call right
[01:43] here this is what's called code mode and
[01:46] uh Cloudflare is advocating for it now
[01:50] in a sense this is really really great
[01:52] because as Cloudflare hypothesizes in
[01:55] the training data of LLMs there's very
[01:58] probably tons and tons and tons of code.
[02:01] So, tons of examples of uh someone
[02:06] wanting to call some API and stringing
[02:09] that together and doing that correctly.
[02:12] Um fitting the types and so on, that's
[02:15] probably super common. Whereas the LLM
[02:18] tool calling that we're doing nowadays,
[02:20] this is very probably a result of the
[02:23] postraining. So you do your pre-training
[02:26] and then on top of that you do the
[02:28] fine-tuning from human feedback,
[02:30] reinforcement learning and so on. Uh
[02:33] from these specific examples that the
[02:37] the mechanical Turks create for you.
[02:42] Very very big difference between the
[02:44] two. Whatever is in pre-training is kind
[02:46] of ingrained knowledge of the LLMs.
[02:49] Whatever is on top is just sort of
[02:50] tacked on. Uh the article here compares
[02:54] that to saying making an LLM perform
[02:57] tasks with tool calling is like putting
[02:59] Shakespeare through a month-long class
[03:01] in Mandarin and then asking him to write
[03:03] a play in it. It's just not going to be
[03:05] his best work here. Uh Shakespeare
[03:08] writing plays will be the pre-training
[03:10] sort of the ingrained knowledge and then
[03:12] you tack on a very brief Mandarin course
[03:16] and um ask Shakespeare to write a play
[03:19] in that. He can still write play it. He
[03:23] could still write the play but uh the
[03:26] the understanding of the language is
[03:28] just very rudimentary, clunky and a lot
[03:30] of things are going to go wrong.
[03:33] I agree with this stance. I agree with
[03:36] yes probably framing tool calls as APIs
[03:40] is a lot better and um as Theo also
[03:44] points out a lot of the providers are at
[03:47] least internally already doing this
[03:50] where I have a problem is when it is uh
[03:53] when it comes to that second point that
[03:55] the article makes right here let's
[03:57] listen to it two here the approach
[03:59] really shines when an agent needs to
[04:01] string together multiple calls with the
[04:03] traditional approach the output of Each
[04:05] tool call must feed into the LLM's
[04:06] neural network just to be copied over to
[04:09] the inputs of the next call, wasting
[04:11] time, energy, and tokens. When the LLM
[04:13] can write code, it can skip all that and
[04:15] only read back the final results that it
[04:17] needs. In short, LM are better at
[04:19] writing code to call MCP than they are
[04:21] at calling MCP directly. I totally
[04:25] Okay, this point is a bit more
[04:27] contentious in my opinion. So, the idea
[04:30] is let's say you want to know what you
[04:32] should wear today. Now the LLM needs to
[04:35] do two things. It needs to find out
[04:36] where you are and what the weather is
[04:39] today. So it does a first tool call and
[04:42] that first tool call is to the weather
[04:44] MCP server and get back. Okay, here's
[04:47] the weather. No, sorry. The first tool
[04:49] call is for the location or memory or
[04:52] whatnot. Just figure out where you are.
[04:55] Get back the location and then it needs
[04:57] to provide that to the to the weather uh
[05:00] MCP server. get back the weather and
[05:02] then reason what you should wear today.
[05:05] This is a stringing together of tool
[05:07] calls. And the way this works right now
[05:09] is that uh the results of the first tool
[05:12] call will get back into the context of
[05:14] the LLM. You call it again with that new
[05:17] context and then it can decide to do the
[05:19] second tool call. And in the point of of
[05:22] the article right here, this is this is
[05:24] uh clunky because it goes back to the
[05:27] LLM. It wastes tokens and so on.
[05:30] Wouldn't it be easier if all of this was
[05:33] an API? So if you had the API of the
[05:36] location service and the API of the
[05:38] weather service, you could just do get
[05:40] weather open parentheses get location uh
[05:45] closed like as an argument, right? So
[05:47] you directly say I want to get the
[05:49] location and then feed that into the
[05:51] weather server and that's a single
[05:54] execution. Um and you don't have to go
[05:57] back to the LLM intermittently. So the
[05:59] LLM could at priori tell you oh I have
[06:02] these five tools here is how I want to
[06:05] string them together and you execute all
[06:07] of that and you only get back the final
[06:09] result. Now this sounds appealing in
[06:13] theory. Um however I think it is missing
[06:17] a crucial point and that is that in um
[06:22] in in some cases this is going to work
[06:24] but it's only going to work if you have
[06:26] extremely deterministic tools extremely
[06:29] deterministic types and so on. So for
[06:32] example if the location is getting back
[06:34] um is getting back a determined type um
[06:38] and then you can feed that into the into
[06:41] the weather tool. However, it starts
[06:43] breaking down in most real world
[06:45] scenarios and that is because uh stuff
[06:49] is messy and the real world is messy and
[06:53] yeah that's that's where I think that
[06:54] the problems here come in. So what I
[06:57] mean by that is let's say your location
[07:00] uh service doesn't always give you back
[07:03] a GPS location. Sometimes it gives you
[07:06] back an address. Sometimes it gives you
[07:08] back a oh behind the house. Sometimes
[07:12] it's a I don't know. Sometimes it's a
[07:14] question back to the to the to the user,
[07:17] right? Like, hey, uh, give me your
[07:19] location. It's like, oh, I know
[07:21] yesterday you were in London. Um, I
[07:24] don't have any location data of today.
[07:27] Uh, did you take a train or something?
[07:30] I'm contriving this, but I hope you can
[07:32] see that the real world is messy and the
[07:35] output of a lot of tool calls is not so
[07:38] defined. I know people are trying to get
[07:40] around that with JSON mode and all of
[07:42] that. Um, but even with that, even you
[07:46] get back JSON mode, it is very likely
[07:50] that the next action will actually be
[07:53] dependent on the outputs of the last
[07:57] action in a nondeterministic
[08:00] way. What I mean by that is in a way
[08:02] that you have to reason. So what humans
[08:04] do when they string together different
[08:06] tools is they do exactly that. They call
[08:09] the first tool and then they look at the
[08:11] outputs of that and then they decide how
[08:15] to call the second tool. And I think
[08:17] that a lot of situations are like this
[08:20] and therefore it is not really going to
[08:23] be an advantage to string together tool
[08:26] calls by writing the code a priori. I
[08:28] can ask you this, right? If you have a
[08:30] very complex task and you make a
[08:32] detailed plan at the beginning, um, how
[08:36] well is that plan usually turning out? I
[08:39] predict it's not turning out well. I
[08:41] predict that in the middle somewhere,
[08:44] you'll have to adjust your plan as you
[08:46] go along. And that only works if you
[08:49] actually look at each of the outputs and
[08:52] redecide how you want to react to that
[08:54] output, whether your plan is still valid
[08:57] and how to pass how and if to pass that
[09:00] output on to the next tools. And so um
[09:05] and so
[09:07] that's where I have the the the trouble
[09:11] with because if we simply compose all
[09:13] these API calls together into one block
[09:15] of code and then say oh now we only need
[09:17] to read the output. That is effectively
[09:21] the same as saying yes my plans always
[09:23] work out 100% of the time. um and I
[09:26] don't ever need to, you know, nothing is
[09:28] ever actually dependent on the on the
[09:32] intermediate states in any meaningful uh
[09:35] non-deterministic way. So a that's a
[09:39] word of caution. Now
[09:41] I think that is code mode is still
[09:44] fantastic and I think it's going to to
[09:46] give us a lot of benefits. Um, but it
[09:49] might not get us the benefits in this
[09:51] more meaningful way when the tasks are
[09:54] complex and the the the tools are doing
[09:57] a bit more sophisticated things than you
[09:59] know calling the weather and um yeah so
[10:04] that was an appeal. Now what I do think
[10:06] is um
[10:09] there is actually an opportunity to get
[10:12] a lot of the benefits and that has to do
[10:13] with speculative decoding. So what we
[10:16] can actually do is let's say we compose
[10:20] all of this code together, right? Um and
[10:23] we do multiple tool calls. It's code,
[10:25] there's a loop and so on, but we record
[10:27] all the intermediate things. We record
[10:30] all of the outputs um from the
[10:33] intermediate states. Uh and then we just
[10:36] execute this all at once. And at the
[10:38] end, we don't just give the final output
[10:39] to the LLM, but we give all of the tool
[10:42] calls and all of the intermediate
[10:43] outputs to the LLM and effectively ask
[10:47] it whether any of these look sus, right?
[10:50] Like, hey, look, these were the
[10:52] intermediate outputs. Does any of this
[10:55] look suspicious? Does any of this look
[10:57] wrong to you? And if it doesn't, then
[11:01] you're perfectly fine taking the final
[11:03] output, right? uh because it's it's it's
[11:07] the LLM is effectively saying no all of
[11:09] this looks perfectly fine if you had
[11:11] given this to me during the execution I
[11:15] would have told you to move forward move
[11:18] along with the plan and if we can
[11:21] somehow get that or or let the LLM
[11:24] pinpoint where uh the
[11:27] deviation happens like oh no no no this
[11:29] output here or ah I would not have
[11:31] called the tool in this way had I known
[11:33] the outputs we skip a lot of these
[11:36] intermediate steps. So, let's call it
[11:39] speculative tool calling or something
[11:42] like this, which is you just call a
[11:44] bunch of tools ahead of time um because
[11:47] you estimate that that's something that
[11:50] might happen in a lot of cases. Uh tool
[11:53] calling isn't so expensive. um you might
[11:56] use a few extra tokens by doing all of
[11:59] this intermediate validation and but
[12:02] maybe we'll get a lot of speed out of
[12:04] it. All right, I still I invite you to
[12:07] read the article about code mode because
[12:09] it also talks about loading loading code
[12:12] into running agents uh using isolates
[12:14] and all of that. Very very cool. And I
[12:17] also invite you to uh watch Theo's video
[12:20] on the topic because uh is a lot of good
[12:23] comments about it. uh just this this one
[12:26] thing that I think is missed by both and
[12:29] that's that in the real world with
[12:32] complex tools and messy data um there
[12:36] will often be the case where
[12:37] intermittently you need to actually look
[12:40] at the intermediate output and decide
[12:43] what you want to do in a way that you
[12:45] couldn't have known at the beginning.
[12:49] General reminder that MCP isn't magic.
[12:51] MCP doesn't add any capabilities and MCP
[12:55] simply is a standard way of exposing
[12:58] APIs. I think that goes without saying
[13:00] if you've watched this channel for a
[13:02] while or are in the field, but for
[13:04] anyone else uh who's super hyping about
[13:07] MCP, it's not that big of a deal. It's
[13:10] cool, but uh it doesn't add anything
[13:13] new. Cool. That's it. Thank you very
[13:16] much, and I'll see you around. Bye-bye.

---

## Metadata
- Channel: Yannic Kilcher
- Published: 20251019
- Duration: 13:19
- Views: 9181
- Video ID: 0bpYCxv2qhw
