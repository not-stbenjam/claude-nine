---
name: lmk
description: Spawn a subagent to perform the research task, then report back with the answer.
license: MIT
metadata:
  author: stbenjam
  version: "0.1.0"
user-invocable: true
disable-model-invocation: true
---

Delegate the user's research task to a subagent rather than investigating it in the main conversation. Spawn one agent with a self-contained prompt that states the question, the relevant context, and the shape of answer expected, then let it do the digging. Do not duplicate its research yourself while it runs. When it completes, relay a direct answer to the user's question — lead with the finding, keep the supporting detail brief, and note anything the subagent could not determine.
