# nvim-rhymes Project Requirements

## Specifications

Goal: Neovim plugin which can analyse a text in terms of poetry analysis
and provide text tools to help writing poetry or lyrics.

### Technical

1. Nice integration into LazyVim (<https://github.com/LazyVim/LazyVim>)
2. Generate documentation for Neovim (see LazyVim and lazy.nvim for inspiration).
4. Picker (see snacks.nvim): when using pickers orientate on snacks.nvim (uses fzf-lua under the hood)
5. Use the best AI services which are available for free and provide
   configs for each service.
6. Use busted tests only
7. Do not use plenary or any other deprecated stuff. Think before or get
   an overview of the current best practices
8. Use `vim.fn.systemlist()` for HTTP requests

### Use Cases

I have included the key aspects for poetry analysis. Each section has a
sub section `Functionality` for implementing features

See: <https://www.masterclass.com/articles/how-to-analyze-poetry>

#### Theme

Poetry often conveys a message through figurative language. The central idea and the subject matter can reveal the underlying theme of a poem.

- Extract the theme of a text using AI

#### Language

1. Setting. The setting is the physical location of the story, and it can heavily inform a story’s mood. For instance, a story set during a sunny day will be predisposed to a happy or carefree mood, while a story set in a haunted house will be predisposed to a sense of tension or fear.

2. Tone. Tone and mood can be easily mistaken for another, but they’re slightly different things. While mood has to do with the feelings evoked in the reader, tone has nothing to do with the reader and everything to do with the point-of-view character (either first person or third person) of the story. In short, tone is the narrator’s attitude toward the events taking place. Tone can contribute to the mood of a story by helping evoke feelings in readers—for instance, a rude narrator may create a funny tone for a story.

3. Word choice. The choice of words for a story can help establish its mood. If a writer wants to create a jarring or frustrating mood, they can choose specific words that are harsh and staccato-sounding; if they want to create a dark mood, they can use words with negative connotations to conjure brooding feelings.

4. Theme. Mood isn’t established only by the way a writer writes—it is also determined by the subject matter the author uses. For instance, a story that talks a lot about death may be trying to create a sad mood, while a story whose theme centers around birthdays may have a more positive and upbeat mood.

#### Functionality

- provide a rhyme finder
- filter rhymes by word choice or tone

#### Sound and rhythm

The syllabic patterns and stresses create the metrical pattern of a poem.

#### Functionality

- provide analyzer for syllables

#### Structure

The framework of a poem’s structure affects how it is meant to be read. A poet sculpts their story around stanzas, line breaks, rhyme patterns, punctuation, and pauses.

#### Functionality

- provide templates for Neovim: Must be discussed first

#### Context

The who, what, where, when, and why of a poem can help explain its purpose. Look at these elements to discover the context of a poem.

#### Functionality

- TODO

## Coding Standards

Orientate yourself by looking at code from the developers

- <https://github.com/folke>
- <https://github.com/tjdevries>>

### Test

Test files are in the folder spec. Use busted for testing.

### Documentation

- VimDoc file: `doc/rhymes.txt` (for `:help rhymes`)
- Markdown `README.md` covering installation, config, and usage

<!-- vim: set filetype=markdown spell spelllang=de,en textwidth=72 formatoptions+=t : -->
