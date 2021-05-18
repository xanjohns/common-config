# common-config

This is a preparatory repository for the creation of Symbiflow's common-config repo.

---

Symbiflow aims to produce a completely open source FPGA design toolchain.  They have a large presence on github where they have many repositories (73 to be exact), where each repository roughly corresponds to one project.  One of the challenges is with such a large effort is imposing some order and uniformity on the various repositories so that they all use the same code formatting, copyright licensing, documentation style, etc.  One of the open issues they have relates to creating a single common configuration github repository which is then included into every other repository to provide the desired uniformity.  This project focuses on creating such a common configuration repository and modifying all other repositories to use it.

Completing the project will require you to become educated on github and git to a deep level (specifically regarding git subtrees), coding standards, tools for formatting code in various languages, python environments, etc.  And, much of this standardization will be enforced via continuous integration tools (like discussed yesterday at the beginning of the Prof Goeders’ talk on Github Actions although Symbiflow uses a different CI framework).   In this work you will end up working with other members of the open source community both at Google as well as others around the world.  

The end product of your work will be a standardizaton of the symbiflow github repositories with regards to .editorconfig files, copyright/license checking tools, auto-formatting tools, code of conduct, contribution guides, documentation, and python environments.  You can read more about this at  https://github.com/SymbiFlow/ideas/issues/51.

---

This repository will hold the following items.

* [ ]  Stuff around style formatting including;
  * [ ]  `.editorconfig` file
  * [ ]  Copyright / license checking tools (plus Travis CI support for checking them)
  * [ ]  Auto-formatting tools - `clang-format`, `yapf`, etc (plus Travis CI support for checking them)
* [ ]  Documentation around policies
  * [ ]  Code of conduct
  * [ ]  Contribution guide
  * [ ]  Issue templates
  * [ ]  Common replies to things like missing DCO and stuff
  * [ ]  etc
* [ ]  Documentation building and publishing scripts
  * [ ]  The Sphinx documentation generation
  * [ ]  ReadTheDocs publishing
* [ ]  Useful infrastructure / CI scripts
  * [ ]  Tools for handling the complexity of git submodules
  * [ ]  Tools for getting and setting up environments using conda (handled by make-env)
  * [ ]  etc
