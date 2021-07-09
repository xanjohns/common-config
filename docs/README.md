# common-config

This is a preparatory repository for the creation of Symbiflow's common-config repo.

Symbiflow aims to produce a completely open source FPGA design toolchain.  They have a large presence on github where they have many repositories (73 to be exact), where each repository roughly corresponds to one project.  One of the challenges is with such a large effort is imposing some order and uniformity on the various repositories so that they all use the same code formatting, copyright licensing, documentation style, etc.  One of the open issues they have relates to creating a single common configuration github repository which is then included into every other repository to provide the desired uniformity.  This project focuses on creating such a common configuration repository and modifying all other repositories to use it.

To learn more, see [Issue 51](https://github.com/SymbiFlow/ideas/issues/51) on the Symbiflow Ideas repository.

## Table of Contents
[Progress](#progress)

[Auto-Formatting](#auto-formatting)

[Copyright/License](#copyright)

[Community Files](#community-files)

[Sphinx Setup](#sphinx)

---

### <a name="progress"/> Progress


This repository will hold the following items:

* [ ] Stuff around style formatting including;
  * [x] `.editorconfig` file 
    * [ ] Fully implemented
  * [x] Copyright / license
    * [x] Fully implemented
  * [x]  Auto-formatting tools - `clang-format`, `yapf`, `verible`, `mjson`
    * [x] Fully implemented
* [ ] Documentation around policies
  * [x] Code of conduct
    * [ ] Fully implemented
  * [x] Contribution guide
    * [ ] Fully implemented
  * [x] Issue Templates
    * [ ] Fully implemented
  * [x] Pull Request Templates
    * [ ] Fully implemented
  * [ ] Common replies to things like missing DCO and stuff
    * [ ] Fully Implemented
  * [ ] etc
* [ ] Documentation building and publishing scripts
  * [ ] The Sphinx documentation generation
    * [ ] Fully Implemented
  * [ ] ReadTheDocs publishing
    * [ ] Fully Implemented
* [ ] Useful infrastructure / CI scripts
  * [ ] Tools for handling the complexity of git submodules
    * [ ] Fully Implemented
  * [x] Tools for getting and setting up environments using conda (handled by make-env)
  * [ ] etc

Full implementation includes setting up github actions to check them and bots to merge them into projects where this is a submodule.

---

## <a name="auto-formatting"/> Auto-Formatting

Code formatting will be handled by [Restyled.io](restyled.io). Upon pull request, configured formatters will run on any changed files. You then have the option to merge the restyled pull request into yours. Currently configured formatters include:
* [Clang-format](../formatter-files/.clang-format)
* [Yapf](../formatter-files/.style.yapf)
* Prettier-json
* Verible

[EditorConfig](https://editorconfig.org/) has also been included to maintain consistency across editors and IDE's.

## <a name="copyright"/> Copyright/License

[SymbiFlow/actions/checks@main](https://github.com/SymbiFlow/actions/tree/main/checks) is used with Github Actions to check Third-Party license files, SPDX Identifiers, and basic Python header config.

## <a name="community-files"/> Community Files

[`CODE_OF_CONDUCT.md`](./CODE_OF_CONDUCT.md) and [`CONTRIBUTING.md`](./CONTRIBUTING.md) files are included in the `docs` directory, while the [`LICENSE`](../LICENSE) file is included in the root directory. This is done to make sure that Github recognizes the files in the `Insights/Community` tab.

### Templates

Currently included templates include:
* [Pull request template](../.github/pull_request_template.md)
* [Bug issue template](../.github/ISSUE_TEMPLATE/ISSUE_TEMPLATE-BUG.md)
* [Feature issue template](../.github/ISSUE_TEMPLATE/ISSUE_TEMPLATE-FEATURE.md)

These will be used automatically upon PR/Issue creation. Proper labels will also be applied.

## <a name="sphinx"/> Sphinx Setup
