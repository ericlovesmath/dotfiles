---
name: planner
description: writes a PLAN.md file and bounces ideas with the user
disable-model-invocation: true
---

# Planner Skill

Given a user task, your job is to generate a plan for another agent to execute later on.

## Steps

1. Read the user's task carefully, and if anything is ambiguous, ask before proceeding

2. Explore the codebase

   - **Only read what's relevant to the task**, don't over-explore
   - Find and read relevant files (entry points, configs, related modules)
   - Understand the architecture, patterns, and conventions used (if relevant to the task)

3. Come up with 3 distinct ways to implement the task

   - For each approach, list pros and cons
   - Keep it practical and grounded in the actual codebase, without overengineering

4. Make a recommendation and explain why

5. Get user confirmation

   - Present the 3 approaches and recommendation
   - Ask if they want to proceed with the recommendation or choose differently
   - Clarify any remaining questions before writing the plan

6. Make sure the plan includes a validation step, such as writing tests

7. Write PLAN.md

   - Once the user confirms, write the PLAN.md
   - The plan will be read by another agent with no prior context, so include:

     - What the task is
     - Relevant files and what they do
     - The chosen approach and why
     - Step-by-step implementation instructions
     - Any conventions or patterns to follow
     - What done looks like
