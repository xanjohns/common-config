# common-config

This is a preparatory repository for the creation of SymbiFlow's common-config repo.

SymbiFlow aims to produce a completely open source FPGA design toolchain. The organization has a large presence on github with many repositories, where each repository roughly corresponds to one project.  One of the challenges with such a large effort is imposing some order and uniformity on the various repositories so that they all use the same code formatting, copyright licensing, documentation style, etc.  One of the open issues on `symbiflow-ideas` relates to creating a single common configuration github repository which is then included into every other repository to provide the desired uniformity.  This project focuses on creating such a common configuration repository and modifying all other repositories to use it.

To learn more, see [Issue 51](https://github.com/SymbiFlow/ideas/issues/51) on the SymbiFlow Ideas repository.

---

## Table of Contents
[Progress](#progress)

[Auto-Formatting](#auto-formatting)

[Copyright/License](#copyright)

[Community Files](#community-files)

[Sphinx Setup](#sphinx)

[Integrating With Other Repositories](#integration)

---

### <a name="progress"/> Progress


This repository will hold the following items:

* [x] Items dealing with style formatting including;
  * [x] `.editorconfig` file 
  * [x] Copyright / license
    * [x] CI support
  * [x]  Auto-formatting tools - `clang-format`, `yapf`, `verible`, `mjson`
    * [x] CI support
* [ ] Documentation around policies
  * [x] Code of conduct
  * [x] Contribution guide
  * [x] Issue Templates
  * [x] Pull Request Templates
  * [ ] Common replies to things like missing DCO and stuff
    * [ ] CI support
* [ ] Documentation building and publishing scripts
  * [ ] The Sphinx documentation generation
    * [ ] CI support
  * [ ] ReadTheDocs publishing
    * [ ] CI support
* [ ] Useful infrastructure / CI scripts
  * [ ] Tools for handling the complexity of git submodules
    * [ ] CI support
  * [x] Tools for getting and setting up environments using conda (handled by make-env)

---

## <a name="auto-formatting"/> Auto-Formatting

Code formatting will be handled by [Restyled.io](restyled.io). Upon pull request, configured formatters will run on any changed files. You then have the option to merge the restyled pull request into yours. Currently configured formatters include:
* [Clang-format](../formatter-files/.clang-format)
* [Yapf](../formatter-files/.style.yapf)
* Prettier-json
* Verible

[EditorConfig](https://editorconfig.org/) has also been included to maintain consistency across editors and IDE's.

---

## <a name="copyright"/> Copyright/License

[SymbiFlow/actions/checks@main](https://github.com/SymbiFlow/actions/tree/main/checks) is used with Github Actions to check Third-Party license files, SPDX Identifiers, and basic Python header config.

---

## <a name="community-files"/> Community Files

[`CODE_OF_CONDUCT.md`](./CODE_OF_CONDUCT.md) and [`CONTRIBUTING.md`](./CONTRIBUTING.md) files are included in the `docs` directory, while the [`LICENSE`](../LICENSE) file is included in the root directory. This is done to make sure that Github recognizes the files in the `Insights/Community` tab.

---

### Templates

Currently included templates include:
* [Pull request template](../.github/pull_request_template.md)
* [Bug issue template](../.github/ISSUE_TEMPLATE/ISSUE_TEMPLATE-BUG.md)
* [Feature issue template](../.github/ISSUE_TEMPLATE/ISSUE_TEMPLATE-FEATURE.md)

These will be used automatically upon PR/Issue creation. Proper labels will also be applied.

---

## <a name="sphinx"/> Sphinx Setup

## <a name="integration"/> Integration With Other Repositories 

Adding `common-config` as a subtree to all other repositories will be handled with the `merger.sh` and `merger_help.py` scripts.

Updates to `common-config` files should be made to this repository, then pulled in to other repositories with `git subtree pull`.
