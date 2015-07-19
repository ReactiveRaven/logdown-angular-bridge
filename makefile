SHELL=/bin/bash -o pipefail

RED=\033[0;31m
YELLOW=\033[1;33m
GREEN=\033[0;32m
BLUE=\033[0;34m
PURPLE=\033[0;35m
CYAN=\033[0;36m
BGRED=\033[0;41m
BGYELLOW=\033[1;33m
BGGREEN=\033[0;42m
BGBLUE=\033[0;44m
BGPURPLE=\033[0;45m
BGCYAN=\033[0;46m
NOCOLOR=\033[0m

.SILENT:

build: install test

install: npm-install bower-install

test: install
	echo -e "Now handing over to ${BLUE}gulp test${NOCOLOR}..."; \
    if node_modules/gulp/bin/gulp.js --color test | sed "s/^/    /g;"; \
    then \
        echo -e "Now handing over to ${BLUE}gulp test${NOCOLOR}...${GREEN}OK${NOCOLOR}"; \
    else \
        echo -e "Now handing over to ${BLUE}gulp test${NOCOLOR}...${RED}ERR${NOCOLOR}"; \
        echo -e "    ${BLUE}gulp test${NOCOLOR} failed."; \
    fi;

require-npm:
	@echo -en "Checking for NPM..."; \
    if hash npm 2>/dev/null; \
    then \
        echo -e "${GREEN}OK${NOCOLOR}"; \
    else \
        echo -e "${RED}ERR${NOCOLOR}"; \
        echo -e "    NPM is required to install node packages."; \
        echo -e "    NPM is packaged with NodeJS."; \
        echo -e "    Please install node first."; \
        exit 1; \
    fi;

bower-install: npm-install
	echo -en "Checking for missing bower packages..."; \
    MISSING_PACKAGES=0; \
    while read line; \
    do \
        if [ ! -d bower_components/$$line ]; \
        then \
            if [[ $$MISSING_PACKAGES -eq 0 ]]; \
            then \
                echo; \
            fi; \
            MISSING_PACKAGES=$$((MISSING_PACKAGES+1)); \
            echo -e "    Missing $$line"; \
        fi; \
    done < <( \
        node_modules/json/lib/json.js "devDependencies" "dependencies" -f bower.json | \
        node_modules/json/lib/json.js --merge -k -a \
    ); \
    if [[ $$MISSING_PACKAGES -gt 0 ]]; \
    then \
        echo -e "    triggering install..."; \
        if node_modules/bower/bin/bower install 2>&1 | sed "s/^/        /"; \
        then \
            echo -e "    triggering install...${GREEN}OK${NOCOLOR}"; \
        else \
            echo -e "    triggering install...${RED}ERR${NOCOLOR}"; \
            echo -e "        Could not install. Try 'bower install' to debug."; \
            exit 1; \
        fi; \
    else \
        echo -e "${GREEN}OK${NOCOLOR}"; \
    fi;

wark: 
	while read line; \
    do \
        echo -e "$$line"; \
    done < $$( echo -e "lol"; ) \

npm-install: require-npm 
	echo -en "Checking for missing node packages..."; \
    MISSING_PACKAGES=0; \
    if [ ! -f node_modules/json/lib/json.js ]; \
    then \
        echo; \
        echo -e "    Missing json"; \
        MISSING_PACKAGES=1; \
    else \
        while read line; \
        do \
            if [ ! -d node_modules/$$line ]; \
            then \
                if [ $$MISSING_PACKAGES -eq 0 ]; \
                then \
                    echo; \
                fi; \
                MISSING_PACKAGES=$$((MISSING_PACKAGES+1)); \
                echo -e "    Missing $$line"; \
            fi; \
        done < <( \
            node_modules/json/lib/json.js "devDependencies" "dependencies" -f package.json | \
            node_modules/json/lib/json.js --merge -k -a \
        ); \
    fi; \
    if [ $$MISSING_PACKAGES -gt 0 ]; \
    then \
        echo -e "    Triggering install..."; \
        if npm install 2>&1 | sed "s/^/        /g"; \
        then \
            echo -e "    Triggering install...${GREEN}OK${NOCOLOR}"; \
            echo -e "Checking for missing node packages...${GREEN}OK${NOCOLOR}"; \
        else \
            echo -e "    Triggering install...${RED}ERR${NOCOLOR}"; \
            echo -e "        Could not install. Try 'npm intall' to debug."; \
            exit 1; \
        fi; \
    else \
        echo -e "${GREEN}OK${NOCOLOR}"; \
    fi;
