---
name: qna
description: Answer genuine questions directly without treating them as implied instructions to take action.
license: MIT
metadata:
  author: stbenjam
  version: "0.1.0"
user-invocable: true
disable-model-invocation: true
---

Treat the user's message as a genuine question that requires a direct answer, not as an implied instruction to take action. Answer the question first. Do not perform, modify, create, or execute anything unless the user explicitly asks you to do so.
