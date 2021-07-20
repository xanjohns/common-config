# The top directory where environment will be created.
TOP_DIR := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))

# You can set these variables from the command line.
SPHINXOPTS    =
SPHINXBUILD   = sphinx-build
SPHINXAUTOBUILD   = sphinx-autobuild
SPHINXPROJ    = ProjectX-Ray
SOURCEDIR     = .
BUILDDIR      = _build

# A pip `requirements.txt` file.
# https://pip.pypa.io/en/stable/reference/pip_install/#requirements-file-format
REQUIREMENTS_FILE := requirements.txt

# A conda `environment.yml` file.
# https://docs.conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html
ENVIRONMENT_FILE := environment.yml

include third_party/make-env/conda.mk

help:
	@$(IN_CONDA_ENV) $(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(0)

# Example make target which runs commands inside the conda environment.
test-command: | $(CONDA_ENV_PYTHON)
	@$(IN_CONDA_ENV) echo "Python is $$(which python)"
	@$(IN_CONDA_ENV) python --version
	@$(IN_CONDA_ENV) conda list

livehtml: | $(CONDA_ENV_PYTHON)
	@$(IN_CONDA_ENV) $(SPHINXAUTOBUILD) -b html --ignore \*.swp --ignore \*~ $(SPHINXOPTS) "$(SOURCEDIR)" "$(BUILDDIR)/html"

.PHONY: livehtml help Makefile
