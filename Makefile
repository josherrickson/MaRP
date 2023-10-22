# prepare the package for release
PKGNAME := $(shell sed -n "s/Package: *\([^ ]*\)/\1/p" DESCRIPTION)
PKGVERS := $(shell sed -n "s/Version: *\([^ ]*\)/\1/p" DESCRIPTION)
PKGSRC  := $(shell basename `pwd`)

# What R command should we run?
RCMD=R -q -e

all: check clean

deps:
	@Rscript -e\
   'depstring <- packageDescription(pkg = ".",\
																		lib.loc = ".",\
																		fields = c("Depends", "Imports"));\
		depstring <- Reduce(paste, Filter(\(x) !is.na(x), depstring));\
		if (!is.null(depstring)) {\
			deps <- gsub("^R \\\(>= [0-9.]+\\\)", "", depstring);\
			deps <- gsub(",\\n", ",", deps);\
			deps <- strsplit(trimws(deps), ",")[[1]];\
			for (d in deps) {\
				if (!require(d, quietly = TRUE)) {\
					cat(paste("Installing", d, "\n"));\
					install.packages(d)\
				} else {\
					cat(paste(d, "already installed\n"))\
				}\
			}\
		} else {\
			cat("No dependencies\n")\
		}'

document:
	@$(RCMD) "roxygen2::roxygenize()"

build:
	cd ..;\
	R CMD build --no-manual $(PKGSRC)

build-cran:
	cd ..;\
	R CMD build $(PKGSRC)

test:
	@$(RCMD) "tinytest::build_install_test('.')"

install: build
	cd ..;\
	R CMD INSTALL $(PKGNAME)_$(PKGVERS).tar.gz

check: build-cran
	cd ..;\
	R CMD check $(PKGNAME)_$(PKGVERS).tar.gz --as-cran

vignettes:
	@echo NYI

### Uncomment to enable these features
# .PHONY:coverage
# coverage:
# 	@$(RCMD) "covr::report(file = 'coverage.html', browse = TRUE)"

# .PHONY:goodpractice
# goodpractice:
# 	@$(RCMD) "goodpractice::gp('.')"

# .PHONY:check_win_old
# check_win_old:        # Check & build on win-builder old release
# 	@echo NYI

# .PHONY:check_win
# check_win:            # ... on win-builder release
# 	@echo NYI

# .PHONY:check_win_dev
# check_win_dev:        # ... on win-builder dev
# 	@echo NYI

.PHONY:clean
clean:
	cd ..;\
	$(RM) -r $(PKGNAME).Rcheck/
