# SKILL.md

This document defines the specific skills and operational actions the AI agent can perform in this repository, along with instructions on how to execute them.

## 1. Skill: Run Code Generation
**Description:** Regenerates Riverpod, Freezed, and Isar generated files.
**Execution:**
1. Open the terminal.
2. Execute exactly this command: `dart run build_runner build --delete-conflicting-outputs`
   **When to trigger:** Automatically after you create or modify any file containing `@riverpod`, `@freezed`, or `@collection` annotations, or if `dart analyze` reports missing `.g.dart` or `.freezed.dart` files.

## 2. Skill: Create Conventional Commit
**Description:** Commits staged changes using strict Conventional Commits formatting.
**Execution:**
1. Analyze the staged changes to determine the type of work.
2. Format the commit message strictly as: `<type>: <description>`
    - Allowed types: `feat` (new feature), `fix` (bug fix), `docs` (documentation), `refactor` (code restructuring), `chore` (maintenance, dependencies).
    - The description must be in the imperative mood, lowercase (e.g., "add voice manager" not "added voice manager").
3. Execute the commit in the terminal.

## 3. Skill: Draft Pull Request (PR)
**Description:** Generates a structured and readable Pull Request description for code reviews.
**Execution:**
Draft the PR description using the following markdown template:
- **Title:** `[<type>] <Short, descriptive title>`
- **Description:** - **What:** 1-2 sentences explaining what this PR does.
    - **Why:** The reason for the change (e.g., fixing a specific bug or fulfilling a requirement).
    - **Key Changes:** A bulleted list of the most important technical changes made.

## 4. Skill: Diagnose Dart Errors
**Description:** Investigates and identifies the root cause of Flutter/Dart compilation issues.
**Execution:**
1. Run `dart analyze` in the project root.
2. Identify the specific file and line number of the error.
3. If the error is `Undefined name XSchema` or missing `part` directives, cross-reference the file with its corresponding generated file before proposing a code rewrite.

## 5. Skill: Clean & Rebuild
**Description:** Performs a deep clean of the Flutter project to resolve ghost errors or cached build issues.
**Execution:**
Run the following commands in sequence:
1. `flutter clean`
2. `flutter pub get`
3. `dart run build_runner build --delete-conflicting-outputs`